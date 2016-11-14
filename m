Return-Path: <prvs=0126aabdb8=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hch@infradead.org>
Subject: [PATCHSET] Add support for simplified async direct-io
Date: Mon, 14 Nov 2016 10:28:37 -0700
Message-ID: <1479144519-15738-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This is on top of for-4.10/dio, which has Christophs simplified sync
O_DIRECT support and the IO poll bits.

The restriction on 4 inline vecs is removed on the sync support, we
just allocate the bio_vec array if we have to. I realize this negates
parts of the win of the patch for sync, but it's still a lot leaner
than the old code. And it means we use the same path for any type
of sync O_DIRECT, instead of potentially bouncing between the two.

Second patch is adding async support for the code base. Lightly
tested. Performance results, from fio:

Before patch:

Treads x QD	IOPS		usr	sys
=============================================
1x1		113K		19.8%	24.6%
1x4		321K		30.9%	65.9%
4x4		759K		19.9%	42.2%

After patch:

Treads x QD	IOPS		usr	sys
=============================================
1x1		116K		21.8%	20.2%
1x4		365K		25.3%	72.9%
4x4		818K		20.7%	42.3%

-- 
Jens Axboe
