Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: hch@lst.de
Subject: [PATCHSET 0/2] sync discard
Date: Mon, 30 Apr 2018 09:32:50 -0600
Message-Id: <1525102372-8430-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We recently had a pretty severe perf regression with the XFS async
discard. This small series add a SYNC issue discard flag, and also
limits the chain size for sync discards. Patch 2 adds support for
reverting XFS back to doign sync discards.

-- 
Jens Axboe
