Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1592E3E5;
	Thu,  6 Jun 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655263; cv=none; b=R2ukA0cat5VwjsNywTdiCReqn7ZdGnkB+P5Vd5rKxG9dgkaylvRT0uD+4HdHNoxA2v79sH4Lh99VfbRydBVf/mFtHZVYxIK43D/tcaH53a8AVabgBvWW2IICnJRfdYRHiX9BfK/x6KanLfjGGffWb1rMOgBdmA7I3GmUPV5KQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655263; c=relaxed/simple;
	bh=VdLJkVUrOXVXeMvr//H+2daYj3psYGBQ/AWWezkYvt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eN9ZFKvGTWhaR6HoQUshw/6j3rZlmXu+QmIMjdYtzRko1tEI90KL426FeJ52wCaUkBzh5FUBQrVOXIGZCXrBjstuOM+yCxHppK0okhW3bjHMXejZFP8C9qG2o77+8CJNFFlwniEpzIgNBwDbwvj8I1PqwntE5FVgwupH2rjrAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VvvWj3rS1z4f3jtj;
	Thu,  6 Jun 2024 14:27:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DCAFB1A018A;
	Thu,  6 Jun 2024 14:27:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHWVmFm7ZfTOg--.40699S4;
	Thu, 06 Jun 2024 14:27:35 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.lei@redhat.com,
	Ye Bin <yebin10@huawei.com>
Subject: [PATCH] block: bio-integrity: fix potential null-ptr-deref in bio_integrity_free
Date: Thu,  6 Jun 2024 14:26:55 +0800
Message-Id: <20240606062655.2185006-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHWVmFm7ZfTOg--.40699S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1xWr4kArW7XFWkZr1DWrg_yoW7Jw4xpr
	43KF45Kr4xXF17CanrAF1rAF48KwsrAF1UGrsxZr15JFn8C34qqr1DGryjqF15Gr4ruryU
	Xrn8t3409w1DJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's a issue as follows when do format NVME with IO:
BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
PGD 101727f067 P4D 1011fae067 PUD fbed78067 PMD 0
Oops: 0000 [#1] SMP NOPTI
RIP: 0010:kfree+0x4f/0x160
RSP: 0018:ff705a800912b910 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0d06d30000000000 RCX: ff4fb320260ad990
RDX: ff4fb30ee7acba40 RSI: 0000000000000000 RDI: 00b04cff80000000
RBP: ff4fb30ee7acba40 R08: 0000000000000200 R09: ff705a800912bb60
R10: 0000000000000000 R11: ff4fb3103b67c750 R12: ffffffff9a62d566
R13: ff4fb30aa0530000 R14: 0000000000000000 R15: 000000000000000a
FS:  00007f4399b6b700(0000) GS:ff4fb31040140000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000001014cd4002 CR4: 0000000000761ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 bio_integrity_free+0xa6/0xb0
 __bio_integrity_endio+0x8c/0xa0
 bio_endio+0x2b/0x130
 blk_update_request+0x78/0x2b0
 blk_mq_end_request+0x1a/0x140
 blk_mq_try_issue_directly+0x5d/0xc0
 blk_mq_make_request+0x46b/0x540
 generic_make_request+0x121/0x300
 submit_bio+0x6c/0x140
 __blkdev_direct_IO_simple+0x1ca/0x3a0
 blkdev_direct_IO+0x3d9/0x460
 generic_file_read_iter+0xb4/0xc60
 new_sync_read+0x121/0x170
 vfs_read+0x89/0x130
 ksys_read+0x52/0xc0
 do_syscall_64+0x5d/0x1d0
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Assuming a 512 byte directIO is issued, the initial logical block size of
the state block device is 512 bytes, and then modified to 4096 bytes.
Above issue may happen as follows:
         Direct read                    format NVME
__blkdev_direct_IO_simple(iocb, iter, nr_pages);
  if ((pos | iov_iter_alignment(iter)) & (bdev_logical_block_size(bdev) - 1))
	-->The logical block size is 512, and the IO issued is 512 bytes,
	   which can be checked
    return -EINVAL;
  submit_bio(&bio);
                                      nvme_dev_ioctl
                                        case NVME_IOCTL_RESCAN:
                                          nvme_queue_scan(ctrl);
                                             ...
                                            nvme_update_disk_info(disk, ns, id);
                                              blk_queue_logical_block_size(disk->queue, bs);
                                                --> 512->4096
     blk_queue_enter(q, flags)
     blk_mq_make_request(q, bio)
       bio_integrity_prep(bio)
	 len = bio_integrity_bytes(bi, bio_sectors(bio));
	   -->At this point, because the logical block size has increased to
	      4096 bytes, the calculated 'len' here is 0
         buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
	   -->Passed in len=0 and returned buf=16
         end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
         start = ((unsigned long) buf) >> PAGE_SHIFT;
         nr_pages = end - start;  -->nr_pages == 1
         bip->bip_flags |= BIP_BLOCK_INTEGRITY;
         for (i = 0 ; i < nr_pages ; i++) {
           if (len <= 0)
              -->Not initializing the bip_vec of bio_integrity, will result
		 in null pointer access during subsequent releases. Even if
		 initialized, it will still cause subsequent releases access
		 null pointer because the buffer address is incorrect.
             break;

Firstly, it is unreasonable to format NVME in the presence of IO. It is also
possible to see IO smaller than the logical block size in the block layer for
this type of concurrency. It is expected that this type of IO device will
return an error, so exception handling should also be done for this type of
IO to prevent null pointer access from causing system crashes.
The root cause of this issue is the concurrency between the write process
and the block size update process. However, this concurrency does not exist
in actual production environments. To solve above issue, Verify if the
segments of BIO are aligned with integrity intervals.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/bio-integrity.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961e..00a0d1bafe06 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -431,7 +431,7 @@ bool bio_integrity_prep(struct bio *bio)
 	void *buf;
 	unsigned long start, end;
 	unsigned int len, nr_pages;
-	unsigned int bytes, offset, i;
+	unsigned int bytes, offset, i, intervals;
 
 	if (!bi)
 		return true;
@@ -457,7 +457,13 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	/* Allocate kernel buffer for protection data */
-	len = bio_integrity_bytes(bi, bio_sectors(bio));
+	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
+	if (unlikely((bio->bi_vcnt && intervals < bio->bi_vcnt) ||
+		     (!bio->bi_vcnt && intervals < bio_segments(bio)))) {
+		printk(KERN_ERR"BIO segments are not aligned according to integrity interval\n");
+		goto err_end_io;
+	}
+	len = intervals * bi->tuple_size;
 	buf = kmalloc(len, GFP_NOIO);
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
-- 
2.31.1

