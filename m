Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] cfq-iosched: Fixes for conversion from jiffies to ns
Date: Tue, 28 Jun 2016 09:03:58 +0200
Message-Id: <1467097442-5400-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hi,

Commit 9a7f38c42c2b (cfq-iosched: Convert from jiffies to nanoseconds)
introduced couple of issues into cfq io scheduler. Most notably our QA
runs within SUSE uncovered a regression in bonnie++ rewrite performance
due to a broken condition detecting starved sync IO and further review
unveiled other three mostly cosmetic issues (but still worth fixing).

Jens, please queue these patches to avoid regressions when the above
mentioned commit gets merged in the next merge window. If you want to
fold them into the above commit, I'm fine with that as well. Thanks!

							Honza
