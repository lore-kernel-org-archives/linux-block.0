Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/3] blk-iolatency related ref counting fixes
Date: Tue, 31 Jul 2018 12:39:01 -0400
Message-Id: <20180731163904.21856-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

These are three ref counting issues we found in testing.  They are pretty
straightforward, the first two don't really happen in practice but need to be
fixed, but the last one fixes a real panic we saw pretty regularly in our stress
testing.  They've been running on our test boxes internally under stress tests
and seem to have fixed the remaining issues we were seeing.  Thanks,

Josef
