Return-Path: <gedwards@ddn.com>
From: Greg Edwards <gedwards@ddn.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Dmitry Monakhov <dmonakhov@openvz.org>, "Greg
 Edwards" <gedwards@ddn.com>
Subject: [PATCH] block: reset bi_iter.bi_done after splitting bio
Date: Thu, 26 Jul 2018 14:39:37 -0400
Message-ID: <20180726183937.23814-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: gedwards@ddn.com
List-ID: <linux-block@vger.kernel.org>

After the bio has been updated to represent the remaining sectors, reset
bi_done so bio_rewind_iter() does not rewind further than it should.

This resolves a bio_integrity_process() failure on reads where the
original request was split.

Fixes: 63573e359d05 ("bio-integrity: Restore original iterator on verify stage")
Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
Simple test case:

  # modprobe scsi_debug.ko dif=1 dix=1 guard=0 dev_size_mb=1024 sector_size=4096
  # echo 512 > /sys/block/<device>/queue/max_sectors_kb
  # dd if=/dev/<device> of=/dev/null bs=1M iflag=direct count=1

 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 67eff5eddc49..f33a030b9dad 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1866,6 +1866,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
+	bio->bi_iter.bi_done = 0;
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
-- 
2.17.1
