#ifndef FeatureMatchAC_FeatureMatchAC_H
#define FeatureMatchAC_FeatureMatchAC_H

#include "opencv2/opencv.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/core.hpp"
#include "opencv2/features2d.hpp"
#include "opencv2/imgcodecs.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/calib3d.hpp"

#include <vector>
#include <string>
#include <iostream>
#include <cmath>
#include <tuple>

namespace amani {
	struct Coordinates
	{
		cv::Point top_left;
		cv::Point bottom_right;
	};
	struct Result
	{
		cv::Mat Image;
		std::string document_class;
		bool cropped;
		bool blurred;
		bool glared;
	};
	class FeatureMatchAC {
		cv::FileStorage models;
		std::string modelPath;
		cv::Ptr<cv::AKAZE> detector = cv::AKAZE::create();
		cv::Ptr<cv::DescriptorMatcher> matcher = cv::DescriptorMatcher::create(cv::DescriptorMatcher::BRUTEFORCE_HAMMING);

	private:				
		cv::Mat getPerspective(cv::Mat image, std::vector<cv::Point2f> corners);
	public:
		FeatureMatchAC(std::string modelPath) { models = cv::FileStorage(modelPath, cv::FileStorage::READ); }
		~FeatureMatchAC() = default;
		static Coordinates drawDocumentRectangle(cv::Mat frame, std::string document_type);
		Result process(cv::Mat image, std::string document_type);
		void loadModels(std::string modelsPath);
	};
	class BlurDetection {
	public:
		BlurDetection() = default;
		~BlurDetection() = default;

		bool detectBlur(cv::Mat frame);
	};
	class GlareDetection {
	public:
		GlareDetection() = default;
		~GlareDetection() = default;

		bool detectGlare(cv::Mat image);
	private:
		int getLargestArea(std::vector<std::vector<cv::Point> > contours);
	};
	class GenericAutocapture {
	private:
		cv::Mat toBinary(cv::Mat grayFrame);
	public:
		GenericAutocapture() = default;
		~GenericAutocapture() = default;
		Result process(cv::Mat frame, std::string document_type);
	};
	
	
}
#endif // !FeatureMatchAC_FeatureMatchAC_H

