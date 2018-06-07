Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: snitzer@redhat.com,
	kent.overstreet@gmail.com,
	liwang@redhat.com,
	vrbagal1@linux.vnet.ibm.com,
	chuhu.ncepu@gmail.com
Subject: [PATCH 0/2] Fix bio_set copy
Date: Thu,  7 Jun 2018 14:45:39 -0600
Message-Id: <20180607204541.13491-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

After a recent change, dm ends up doing a straight copy of a
bio_set. This breaks for various items in that bio_set,
most notably lists. Provide a proper helper for it, and use it.

-- 
Jens Axboe
