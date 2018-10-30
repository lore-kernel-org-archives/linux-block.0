Return-Path: <evgreen@chromium.org>
Return-Path: <evgreen@chromium.org>
From: Evan Green <evgreen@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Alexis Savery <asavery@chromium.org>,
	Evan Green <evgreen@chromium.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] loop: Better discard for block devices
Date: Tue, 30 Oct 2018 16:06:22 -0700
Message-Id: <20181030230624.61834-1-evgreen@chromium.org>
List-ID: <linux-block@vger.kernel.org>

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.


Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 75 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.16.4
