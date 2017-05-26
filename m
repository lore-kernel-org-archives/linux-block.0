Return-Path: <mka@google.com>
Return-Path: <mka@google.com>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/3] cfq-iosched: Fix warnings about unused functions
Date: Fri, 26 May 2017 14:22:34 -0700
Message-Id: <20170526212237.103525-1-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

This patch series fixes a bunch of 'unused-function' warnings raised by
clang.

Matthias Kaehlcke (3):
  cfq-iosched: Mark cfq_clear_cfqq_*() as __maybe_unused
  cfq-iosched: Fix warning about unused dummy functions
  cfq-iosched: Delete unused function min_vdisktime()

 block/cfq-iosched.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

-- 
2.13.0.219.gdb65acc882-goog
