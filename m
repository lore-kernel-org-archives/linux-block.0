Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541174532.196084.146.camel@acm.org>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
From: Bart Van Assche <bvanassche@acm.org>
To: Gwendal Grignou <gwendal@chromium.org>, evgreen@chromium.org
Cc: axboe@kernel.dk, asavery@chromium.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 02 Nov 2018 09:02:12 -0700
In-Reply-To: <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com>
References: <20181030230624.61834-1-evgreen@chromium.org>
	 <1540943443.196084.131.camel@acm.org>
	 <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
	 <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-11-01 at 15:44 -0700, Gwendal Grignou wrote:
+AD4 On Thu, Nov 1, 2018 at 11:15 AM Evan Green +ADw-evgreen+AEA-chromium.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
+AD4 +AD4 +AD4 +AD4 This series addresses some errors seen when using the loop
+AD4 +AD4 +AD4 +AD4 device directly backed by a block device. The first change plumbs
+AD4 +AD4 +AD4 +AD4 out the correct error message, and the second change prevents the
+AD4 +AD4 +AD4 +AD4 error from occurring in many cases.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Hi Evan,
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Can you provide some information about the use case? Why do you think that
+AD4 +AD4 +AD4 it would be useful to support backing a loop device by a block device? Why
+AD4 +AD4 +AD4 to use the loop driver instead of dm-linear for this use case?
+AD4 +AD4 +AD4 
+AD4 +AD4 
+AD4 +AD4 Hi Bart,
+AD4 +AD4 In our case, the Chrome OS installer uses the loop device to map
+AD4 +AD4 slices of the disk that will ultimately represent partitions +AFs-1+AF0. I
+AD4 +AD4 believe it has been doing install this way for a very long time, and
+AD4 +AD4 has been working well. It actually continues to work, but on block
+AD4 +AD4 devices that don't support discard operations, things are a tiny bit
+AD4 +AD4 bumpy. This series is meant to smooth out those bumps. As far as I
+AD4 +AD4 knew this was a supported scenario.
+AD4 +AD4 
+AD4 +AD4 -Evan
+AD4 +AD4 +AFs-1+AF0 https://chromium.googlesource.com/chromiumos/platform/installer/+-/master/chromeos-install
+AD4 
+AD4 The code has moved to
+AD4 https://chromium.googlesource.com/chromiumos/platform2/+-/master/installer/chromeos-install
+AD4 but the idea is the same. We create a loop device to abstract the
+AD4 persistent destination. The destination can be a block device or a
+AD4 file. The later case is used for creating master images to be flashed
+AD4 on memory chip before soldering on the production line.
+AD4 It is handy when the final device is 4K block aligned but the builder
+AD4 is using 512b block aligned device, we can mount a device over a file
+AD4 that will behave like the real device we will flash the image on.

Hi Evan and Gwendal,

Since this is a new use case for the loop driver you may want to add a test
for this use case to the blktests project. Many block layer contributors run
these tests to verify their own block layer changes. Contributing a blktests
test for this new use case will make it easier for others to verify that
their changes do not break your use case.

Bart.
