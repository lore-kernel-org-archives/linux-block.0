Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/4] nbd fixes for this cycle
Date: Fri, 24 Mar 2017 14:08:25 -0400
Message-Id: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

These 4 patches are to fix up various regressions and problems in NBD.  The
ERESTARTSYS is the biggest patch but has been pretty well tested with a debug
patch that forced the behavior to happen.  Everything else is relatively small,
and the queue timeout patch is a regression from last cycle.  Thanks,

Josef
