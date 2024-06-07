Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD11363
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719257; cv=none; b=n3ZgMi3K54fjRceaAB7NMLiYtBJzm1gsCiFwY6em9g1vwFkL2fBXB+rRDe+rSAyN9lVC5/kSitwJU6WcZ9rqGxDS2AEK7csnL8K9vpo9sMmuIQ9sUZMDviqB4iRMSIOtWnm5C3jQwCNcLlJlYUzYXPE9fwa5gzKLTO9ESxIuPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719257; c=relaxed/simple;
	bh=cz/WSYZefge7JLd6rJjUy0yylRFzp/5WcmyiF4yVJro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afZ9AvRrYHw5r4zAL+QuwhEbSn0Lo6Z3t+tTJYwgjpyZtCE4Lzn7rbBjZUyZdpqMgBFSopkxiPRTJygoCJs7fU2xryUcs1wtj/hScvOBbtOMugpMocmxC6J7ahJuPBaUfgxs9VMhvar8QL4+lHbzN0SBs/cYjbQbSBh81eJ9Jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMRRYd31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMRRYd31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717719254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkfyuvv9vDVw/cqs2UH7xmbKAyB/rqBIdNxcdAHyFbs=;
	b=bMRRYd31dGKhcm3B17d2ummn2i0rdY3G9RvwlhDu9xf0qEW8Xb6VMejHJwkMXCQnd4BYw5
	jft6hHa+mB8eu7UJUDO2bAVyd6FdO4jTn730TZT3rL4BvE1TxGmqOTmocseDvNxRobooZz
	19UJIJKq28ZMswJ4EsBGUm3Ahv74EBQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-d8vQ8XsiNw2PzHD9gwOo-A-1; Thu,
 06 Jun 2024 20:14:03 -0400
X-MC-Unique: d8vQ8XsiNw2PzHD9gwOo-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED4EC3801FE6;
	Fri,  7 Jun 2024 00:14:02 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 223C210C5622;
	Fri,  7 Jun 2024 00:13:58 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:13:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
	ming.lei@redhat.com
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmJQwvBXfm3zw+Xs@fedora>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606062655.2185006-1-yebin@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Jun 06, 2024 at 02:26:55PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's a issue as follows when do format NVME with IO:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> PGD 101727f067 P4D 1011fae067 PUD fbed78067 PMD 0
> Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:kfree+0x4f/0x160
> RSP: 0018:ff705a800912b910 EFLAGS: 00010247
> RAX: 0000000000000000 RBX: 0d06d30000000000 RCX: ff4fb320260ad990
> RDX: ff4fb30ee7acba40 RSI: 0000000000000000 RDI: 00b04cff80000000
> RBP: ff4fb30ee7acba40 R08: 0000000000000200 R09: ff705a800912bb60
> R10: 0000000000000000 R11: ff4fb3103b67c750 R12: ffffffff9a62d566
> R13: ff4fb30aa0530000 R14: 0000000000000000 R15: 000000000000000a
> FS:  00007f4399b6b700(0000) GS:ff4fb31040140000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 0000001014cd4002 CR4: 0000000000761ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  bio_integrity_free+0xa6/0xb0
>  __bio_integrity_endio+0x8c/0xa0
>  bio_endio+0x2b/0x130
>  blk_update_request+0x78/0x2b0
>  blk_mq_end_request+0x1a/0x140
>  blk_mq_try_issue_directly+0x5d/0xc0
>  blk_mq_make_request+0x46b/0x540
>  generic_make_request+0x121/0x300
>  submit_bio+0x6c/0x140
>  __blkdev_direct_IO_simple+0x1ca/0x3a0
>  blkdev_direct_IO+0x3d9/0x460
>  generic_file_read_iter+0xb4/0xc60
>  new_sync_read+0x121/0x170
>  vfs_read+0x89/0x130
>  ksys_read+0x52/0xc0
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Assuming a 512 byte directIO is issued, the initial logical block size of
> the state block device is 512 bytes, and then modified to 4096 bytes.
> Above issue may happen as follows:
>          Direct read                    format NVME
> __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>   if ((pos | iov_iter_alignment(iter)) & (bdev_logical_block_size(bdev) - 1))
> 	-->The logical block size is 512, and the IO issued is 512 bytes,
> 	   which can be checked
>     return -EINVAL;
>   submit_bio(&bio);
>                                       nvme_dev_ioctl
>                                         case NVME_IOCTL_RESCAN:
>                                           nvme_queue_scan(ctrl);
>                                              ...
>                                             nvme_update_disk_info(disk, ns, id);
>                                               blk_queue_logical_block_size(disk->queue, bs);
>                                                 --> 512->4096
>      blk_queue_enter(q, flags)
>      blk_mq_make_request(q, bio)
>        bio_integrity_prep(bio)
> 	 len = bio_integrity_bytes(bi, bio_sectors(bio));
> 	   -->At this point, because the logical block size has increased to
> 	      4096 bytes, the calculated 'len' here is 0
>          buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
> 	   -->Passed in len=0 and returned buf=16
>          end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>          start = ((unsigned long) buf) >> PAGE_SHIFT;
>          nr_pages = end - start;  -->nr_pages == 1
>          bip->bip_flags |= BIP_BLOCK_INTEGRITY;
>          for (i = 0 ; i < nr_pages ; i++) {
>            if (len <= 0)
>               -->Not initializing the bip_vec of bio_integrity, will result
> 		 in null pointer access during subsequent releases. Even if
> 		 initialized, it will still cause subsequent releases access
> 		 null pointer because the buffer address is incorrect.
>              break;
> 
> Firstly, it is unreasonable to format NVME in the presence of IO. It is also
> possible to see IO smaller than the logical block size in the block layer for
> this type of concurrency. It is expected that this type of IO device will
> return an error, so exception handling should also be done for this type of
> IO to prevent null pointer access from causing system crashes.

Actually unaligned IO handling is one mess for nvme hardware. Yes, IO may fail,
but it is observed that meta buffer is overwrite by DMA in read IO.

Ye and Yi, can you test the following patch in your 'nvme format' & IO workload?


diff --git a/block/blk-core.c b/block/blk-core.c
index 82c3ae22d76d..a41ab4a3a398 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -336,6 +336,19 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	return 0;
 }
 
+static bool bio_unaligned(struct bio *bio)
+{
+	unsigned int bs = bdev_logical_block_size(bio->bi_bdev);
+
+	if (bio->bi_iter.bi_size & (bs - 1))
+	        return true;
+
+	if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1))
+	        return true;
+
+	return false;
+}
+
 int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 {
 	while (!blk_try_enter_queue(q, false)) {
@@ -362,6 +375,15 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 			   test_bit(GD_DEAD, &disk->state));
 		if (test_bit(GD_DEAD, &disk->state))
 			goto dead;
+		/*
+		 * Not like other queue limits, logical block size is one
+		 * fundamental limit which can't be covered by bio split.
+		 *
+		 * Device reconfiguration may happen and logical block size
+		 * is changed, so fail the IO if that is true.
+		 */
+		if (bio_unaligned(bio))
+			goto dead;
 	}
 
 	return 0;

Thanks, 
Ming

