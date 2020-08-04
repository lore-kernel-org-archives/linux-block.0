Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2699EC433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F88F20781
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 06:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVPG/W6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHDGB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:01:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726398AbgHDGB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Aug 2020 02:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596520885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4dl57V9q2yiP+41UN3CJxteaxRRkuTjWgxVEwyMXTo=;
        b=JVPG/W6xGlfe1Jf4ipzKn1Hpg8U++Z7bPTBrwRcgz2gc860XznQf826cn5HtrRZ+yBJzqB
        ApQcaf88iMLp/WEHNwfh7/bIGNOZG3SRZRGBXyDsN888QLrrDQHaPAlgegOtjJPGmjdPoR
        CNjg+SPYkd9sBqYbX1JlJKBJiPsS+cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328--ZtAjv-4OaeiZnbW_GDxeQ-1; Tue, 04 Aug 2020 02:01:20 -0400
X-MC-Unique: -ZtAjv-4OaeiZnbW_GDxeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4745918C63C7;
        Tue,  4 Aug 2020 06:01:19 +0000 (UTC)
Received: from T590 (ovpn-13-169.pek2.redhat.com [10.72.13.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE14D60F96;
        Tue,  4 Aug 2020 06:01:12 +0000 (UTC)
Date:   Tue, 4 Aug 2020 14:01:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Coly Li <colyli@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Xiao Ni <xni@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: loop: set discard granularity and alignment for
 block device backed loop
Message-ID: <20200804060108.GA1872155@T590>
References: <20200804041508.1870113-1-ming.lei@redhat.com>
 <26b64ecb-53ed-9caf-a447-ce795fbba132@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b64ecb-53ed-9caf-a447-ce795fbba132@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 04, 2020 at 12:29:07PM +0800, Coly Li wrote:
> On 2020/8/4 12:15, Ming Lei wrote:
> > In case of block device backend, if the backend supports discard, the
> > loop device will set queue flag of QUEUE_FLAG_DISCARD.
> > 
> > However, limits.discard_granularity isn't setup, and this way is wrong,
> > see the following description in Documentation/ABI/testing/sysfs-block:
> > 
> > 	A discard_granularity of 0 means that the device does not support
> > 	discard functionality.
> > 
> > Especially 9b15d109a6b2 ("block: improve discard bio alignment in
> > __blkdev_issue_discard()") starts to take q->limits.discard_granularity
> > for computing max discard sectors. And zero discard granularity causes
> > kernel oops[1].
> > 
> > Fix the issue by set up discard granularity and alignment.
> > 
> > [1] kernel oops when use block disk as loop backend:
> > 
> > [   33.405947] ------------[ cut here ]------------
> > [   33.405948] kernel BUG at block/blk-mq.c:563!
> > [   33.407504] invalid opcode: 0000 [#1] SMP PTI
> > [   33.408245] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0-rc2_update_rq+ #17
> > [   33.409466] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedor4
> > [   33.411546] RIP: 0010:blk_mq_end_request+0x1c/0x2a
> > [   33.412354] Code: 48 89 df 5b 5d 41 5c 41 5d e9 2d fe ff ff 0f 1f 44 00 00 55 48 89 fd 53 40 0f b6 de 8b 57 5
> > [   33.415724] RSP: 0018:ffffc900019ccf48 EFLAGS: 00010202
> > [   33.416688] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88826f2600c0
> > [   33.417990] RDX: 0000000000200042 RSI: 0000000000000001 RDI: ffff888270c13100
> > [   33.419286] RBP: ffff888270c13100 R08: 0000000000000001 R09: ffffffff81345144
> > [   33.420584] R10: ffff88826f260600 R11: 0000000000000000 R12: ffff888270c13100
> > [   33.421881] R13: ffffffff820050c0 R14: 0000000000000004 R15: 0000000000000004
> > [   33.423053] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
> > [   33.424360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   33.425416] CR2: 00005581d7903f08 CR3: 00000001e9a16002 CR4: 0000000000760ee0
> > [   33.426580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   33.427706] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   33.428910] PKRU: 55555554
> > [   33.429412] Call Trace:
> > [   33.429858]  <IRQ>
> > [   33.430189]  blk_done_softirq+0x84/0xa4
> > [   33.430884]  __do_softirq+0x11a/0x278
> > [   33.431567]  asm_call_on_stack+0x12/0x20
> > [   33.432283]  </IRQ>
> > [   33.432673]  do_softirq_own_stack+0x31/0x40
> > [   33.433448]  __irq_exit_rcu+0x46/0xae
> > [   33.434132]  sysvec_call_function_single+0x7d/0x8b
> > [   33.435021]  asm_sysvec_call_function_single+0x12/0x20
> > [   33.435965] RIP: 0010:native_safe_halt+0x7/0x8
> > [   33.436795] Code: 25 c0 7b 01 00 f0 80 60 02 df f0 83 44 24 fc 00 48 8b 00 a8 08 74 0b 65 81 25 db 38 95 7e b
> > [   33.440179] RSP: 0018:ffffc9000191fee0 EFLAGS: 00000246
> > [   33.441143] RAX: ffffffff816c4118 RBX: 0000000000000000 RCX: ffff888276631a00
> > [   33.442442] RDX: 000000000000ddfe RSI: 0000000000000003 RDI: 0000000000000001
> > [   33.443742] RBP: 0000000000000000 R08: 00000000f461e6ac R09: 0000000000000004
> > [   33.445046] R10: 8080808080808080 R11: fefefefefefefeff R12: 0000000000000000
> > [   33.446352] R13: 0000000000000003 R14: ffffffffffffffff R15: 0000000000000000
> > [   33.447450]  ? ldsem_down_write+0x1f5/0x1f5
> > [   33.448158]  default_idle+0x1b/0x2c
> > [   33.448809]  do_idle+0xf9/0x248
> > [   33.449392]  cpu_startup_entry+0x1d/0x1f
> > [   33.450118]  start_secondary+0x168/0x185
> > [   33.450843]  secondary_startup_64+0xa4/0xb0
> > [   33.451612] Modules linked in: scsi_debug iTCO_wdt iTCO_vendor_support nvme nvme_core i2c_i801 lpc_ich virtis
> > [   33.454292] Dumping ftrace buffer:
> > [   33.454951]    (ftrace buffer empty)
> > [   33.455626] ---[ end trace beece202d663d38f ]---
> > 
> > Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
> > Cc: Coly Li <colyli@suse.de>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Xiao Ni <xni@redhat.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/loop.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index d18160146226..6102370bee35 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -890,6 +890,11 @@ static void loop_config_discard(struct loop_device *lo)
> >  		struct request_queue *backingq;
> >  
> >  		backingq = bdev_get_queue(inode->i_bdev);
> > +
> > +		q->limits.discard_granularity =
> > +			queue_physical_block_size(backingq);
> > +		q->limits.discard_alignment = 0;
> > +
> >  		blk_queue_max_discard_sectors(q,
> >  			backingq->limits.max_write_zeroes_sectors);
> >  
> > 
> 
> Hi Ming,
> 
> I did similar change, it can avoid the panic or 0 length discard bio.
> But yesterday I realize the discard request to loop device should not go
> into __blkdev_issue_discard(). As commit c52abf563049 ("loop: Better
> discard support for block devices") mentioned it should go into
> blkdev_issue_zeroout(), this is why in loop_config_discard() the
> max_discard_sectors is set to backingq->limits.max_write_zeroes_sectors.

That commit meant REQ_OP_DISCARD on a loop device is translated into
blkdev_issue_zeroout(), because REQ_OP_DISCARD is handled as
file->f_op->fallocate(FALLOC_FL_PUNCH_HOLE), which will cause
"subsequent reads from this range will return zeroes".

> 
> Now I am looking at the problem why discard request on loop device
> doesn't go into blkdev_issue_zeroout().

No, that is correct behavior, since loop can support discard or zeroout.

If QUEUE_FLAG_DISCARD is set, either discard_granularity or max discard
sectors shouldn't be zero.

This patch shouldn't set discard_granularity if limits.max_write_zeroes_sectors
is zero, will fix it in V2.

> 
> With the above change, the discard is very slow on loop device with
> backing device. In my testing, mkfs.xfs on /dev/loop0 does not complete
> in 20 minutes, each discard request is only 4097 sectors.

I'd suggest you to check the discard related queue limits, and see why
each discard request just sends 4097 sectors.

Or we need to mirror underlying queue's discard_granularity too? Can you
try the following patch?

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d18160146226..661c0814d63c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -878,6 +878,7 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	u32 granularity, max_discard_sectors;
 
 	/*
 	 * If the backing device is a block device, mirror its zeroing
@@ -890,11 +891,10 @@ static void loop_config_discard(struct loop_device *lo)
 		struct request_queue *backingq;
 
 		backingq = bdev_get_queue(inode->i_bdev);
-		blk_queue_max_discard_sectors(q,
-			backingq->limits.max_write_zeroes_sectors);
 
-		blk_queue_max_write_zeroes_sectors(q,
-			backingq->limits.max_write_zeroes_sectors);
+		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
+		granularity = backingq->limits.discard_granularity ?:
+			queue_physical_block_size(backingq);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -903,23 +903,26 @@ static void loop_config_discard(struct loop_device *lo)
 	 * useful information.
 	 */
 	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
-		q->limits.discard_granularity = 0;
-		q->limits.discard_alignment = 0;
-		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_max_write_zeroes_sectors(q, 0);
+		max_discard_sectors = 0;
+		granularity = 0;
 
 	} else {
-		q->limits.discard_granularity = inode->i_sb->s_blocksize;
-		q->limits.discard_alignment = 0;
-
-		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+		max_discard_sectors = UINT_MAX >> 9;
+		granularity = inode->i_sb->s_blocksize;
 	}
 
-	if (q->limits.max_write_zeroes_sectors)
+	if (max_discard_sectors) {
+		q->limits.discard_granularity = granularity;
+		blk_queue_max_discard_sectors(q, max_discard_sectors);
+		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
-	else
+	} else {
+		q->limits.discard_granularity = 0;
+		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
+	}
+	q->limits.discard_alignment = 0;
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)

Thanks,
Ming

