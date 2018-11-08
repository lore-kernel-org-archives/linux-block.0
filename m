Return-Path: <axboe@kernel.dk>
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i8-v6sm1391185iom.47.2018.11.08.07.42.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 07:42:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Add queue_is_busy helper
Date: Thu,  8 Nov 2018 08:42:14 -0700
Message-Id: <20181108154216.23853-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

DM currently uses atomic inc/dec to maintain a busy count of
IO on a given device. For the dm-mq path, we can replace this
with helper that just checks the state of the tags on the device.

First patch is a prep patch that allows the iteration helpers
to return true/false, like we support internally in sbitmap.
For a busy check we don't care about how many requests are
busy, just if some are or not. Hence we can stop iterating
tags as soon as we find one that is allocated.


 block/blk-mq-debugfs.c |  4 +++-
 block/blk-mq-tag.c     |  4 ++--
 block/blk-mq.c         | 38 +++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq.h |  6 ++++--
 4 files changed, 42 insertions(+), 10 deletions(-)

-- 
Jens Axboe
