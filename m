Return-Path: <prvs=673f59626=adam.manzanares@wdc.com>
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	bcrl@kvack.org
Cc: tglx@linutronix.de,
	mingo@kernel.org,
	pombredanne@nexb.com,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	bigeasy@linutronix.de,
	jack@suse.cz,
	darrick.wong@oracle.com,
	rgoldwyn@suse.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-api@vger.kernel.org,
	hch@infradread.org,
	jmoyer@redhat.com,
	Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 5/5] fs: iomap dio set bio prio from kiocb prio
Date: Tue, 22 May 2018 08:07:37 -0700
Message-Id: <20180522150737.9893-6-adam.manzanares@wdc.com>
In-Reply-To: <20180522150737.9893-1-adam.manzanares@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
List-ID: <linux-block@vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

Now that kiocb has an ioprio field copy this over to the bio when it is
created from the kiocb during direct IO.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index afd163586aa0..65aae194aeca 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -919,6 +919,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_iter.bi_sector =
 			(iomap->addr + pos - iomap->offset) >> 9;
 		bio->bi_write_hint = dio->iocb->ki_hint;
+		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-- 
2.15.1
