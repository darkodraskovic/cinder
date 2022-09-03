#include "cinder/app/App.h"

using namespace ci::app;

// We'll create a new Cinder Application by deriving from the App class.
class BasicApp : public App {
 public:
  void mouseDrag(MouseEvent event) override;

  void keyDown(KeyEvent event) override;

  void draw() override;

  void setup() override;

 private:
  std::vector<ci::vec2> mPoints;
  float red_ = 0.0f;
};
