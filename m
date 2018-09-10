Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	kernel-team@fb.com,
	linux-block@vger.kernel.org
Subject: [PATCH 0/6] blk-iolatency: Fixes and tweak the miss algo for ssds
Date: Mon, 10 Sep 2018 16:49:26 -0400
Message-Id: <20180910204932.14323-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Testing on ssd's with the current iolatency code wasn't working quite as well.
This is mostly because ssd's don't behave like rotational drives, they are more
spikey which means that using the average latency for IO wasn't very responsive
until the drive was extremely over taxed.  To deal with this I've reworked
iolatency to use a p(90) based approach for ssd latencies.  I originally
intended to use this approach for both ssd's and rotational drives, but p(90)
was too high of a bar to use.  By the time we were exceeding p(90) things were
already pretty bad.  So to keep things simpler just use p(90) for ssd's since
their latency targets tend to be orders of magnitude lower than rotational
drives, and keep the average latency calculations for rotational drives.

This testing also showed a few issues with blk-iolatency, so the preceding
patches are all fixing issues we saw in testing.  Using q->nr_requests instead
of blk_queue_depth() is probably the most subtle and important change.  We want
to limit the IO's based on the number of outstanding requests we can have in the
block layer, not necessarily how many we can have going to the device.  So make
this explicity by using nr_requests directly.  These patches have been in
production for a week on both our rotational and ssd tiers and everything is
going smoothly.  Thanks,

Josef
