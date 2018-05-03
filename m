Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: dchinner@redhat.com,
	hch@lst.de
Subject: [PATCHSET 0/3] Add throttling for discards
Date: Thu,  3 May 2018 09:20:40 -0600
Message-Id: <1525360843-6504-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

I implemented support for discards in blk-wbt, so we treat them like
background writes. If we have competing foreground IO, then we may
throttle discards. Otherwise they should run at full speed.

-- 
Jens Axboe
