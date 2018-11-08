Return-Path: <axboe@kernel.dk>
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g8-v6sm1821959iof.11.2018.11.08.08.06.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:06:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/2] Add queue_is_busy helper
Date: Thu,  8 Nov 2018 09:06:06 -0700
Message-Id: <20181108160609.27568-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

DM currently uses atomic inc/dec to maintain a busy count of
IO on a given device. For the dm-mq path, we can replace this
with helper that just checks the state of the tags on the device.

First patch is a prep patch that allows the iteration helpers
to return true/false, like we support internally in sbitmap.
For a busy check we don't care about how many requests are
busy, just if some are or not. Hence we can stop iterating
tags as soon as we find one that is allocated.

Changes since v1:

- Remember to check if the queue matches, otherwise we could be
  returning false positive for shared tag sets.

 block/blk-mq-debugfs.c |  4 +++-
 block/blk-mq-tag.c     |  4 ++--
 block/blk-mq.c         | 42 +++++++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq.h |  6 ++++--
 4 files changed, 46 insertions(+), 10 deletions(-)

-- 
Jens Axboe
