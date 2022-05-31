Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC8AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 18:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347132AbiEaS6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 14:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbiEaS6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 14:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2018562E2
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654023484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZwBUxD+HAKTfHzGCfHc48R2UG+TruS6Hm9n7l6mk6m0=;
        b=KKxHqR1Tn5xXYsBYxoVDbMwKdx1gMCPeXY6wUPpMemNbYK0kI33pBgZa0gWq/ZP8nqKRyV
        0O+AWH09FIuWEtVWmDlQYf2AGvoiWaDouMuWVUmsUzVKqq+xbK49kJWmXmw5MoubDk/mhm
        rPS5XhtaOmOvCc1rYr/gM49OUtaeEuY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-g-lleK6tNrCVbTnRY5vsbg-1; Tue, 31 May 2022 14:58:03 -0400
X-MC-Unique: g-lleK6tNrCVbTnRY5vsbg-1
Received: by mail-qk1-f197.google.com with SMTP id br42-20020a05620a462a00b006a5b92ed7b2so10691163qkb.19
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 11:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwBUxD+HAKTfHzGCfHc48R2UG+TruS6Hm9n7l6mk6m0=;
        b=I3ny65t90gMwxLaPMMvwW45IAzag1oHB/1qVVsMe3Sy1kfpdUAac/eEpj7eDhIMoJ3
         h5UDhRLx2L/xQ6Yv/lWo32BUP1FID1g0U6lpkUVrlwSaPNrvjUmgxF8b543XWwINKVjX
         XszJbunddBY6siV0Kr6lVyNFRWlD3p4zLgkgdRFwd81LhgaLBpcyjNkZ0rLgGUVTLiGZ
         sAqHU1kTOi5HHJH1D+R9Gm4sUQ3rzmUE2PKCZeMAz6xH6PRRzRYmCrioDV2P4HXbXvKc
         GKRkiEQLWBpgfPCaMLA6O1ccsA7Q6ChPFegdefMLSB6CzGUrM4524nXpA1k3skJV2oZ5
         nQ8Q==
X-Gm-Message-State: AOAM530eu9WWzYHe3URe4MX8Y5+50bXvwel40QE6VeHygTXNRsVX9Am5
        5xpcr4X5D8oXK6bkSjJWTQGSJ+WSYl0zoAQygXVEIOiDE1XVgGB7e0IqV7NDIzVmt8mYjMI8wg1
        hzvMAp7eJqZeXw/ZSA2CO/Q==
X-Received: by 2002:a05:620a:4553:b0:6a0:5280:defd with SMTP id u19-20020a05620a455300b006a05280defdmr41426509qkp.165.1654023482526;
        Tue, 31 May 2022 11:58:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywtGr5TfVM3IJLgFhd4aw9tM0zg2t5E+FzL7TL7ndYSdB8DOvNEaa+v7WhTy4OmqK/cAratA==
X-Received: by 2002:a05:620a:4553:b0:6a0:5280:defd with SMTP id u19-20020a05620a455300b006a05280defdmr41426494qkp.165.1654023482240;
        Tue, 31 May 2022 11:58:02 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z7-20020ac87f87000000b0030379c46299sm4765950qtj.49.2022.05.31.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:58:01 -0700 (PDT)
Date:   Tue, 31 May 2022 14:58:00 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
Subject: Re: bioset_exit poison from dm_destroy
Message-ID: <YpZlOCMept7wFjOw@redhat.com>
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 29 2022 at  8:46P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 5/28/22 6:17 PM, Matthew Wilcox wrote:
> > Not quite sure whose bug this is.  Current Linus head running xfstests
> > against ext4 (probably not ext4's fault?)
> > 
> > 01818 generic/250	run fstests generic/250 at 2022-05-28 23:48:09
> > 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> > 01818 EXT4-fs (dm-0): unmounting filesystem.
> > 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> > 01818 EXT4-fs (dm-0): unmounting filesystem.
> > 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> > 01818 Buffer I/O error on dev dm-0, logical block 3670000, async page read
> > 01818 EXT4-fs (dm-0): unmounting filesystem.
> > 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
> > 01818 EXT4-fs (dm-0): unmounting filesystem.
> > 01818 general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
> > 01818 CPU: 0 PID: 1579117 Comm: dmsetup Kdump: loaded Not tainted 5.18.0-11049-g1dec3d7fd0c3-dirty #262
> > 01818 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> > 01818 RIP: 0010:__cpuhp_state_remove_instance+0xf0/0x1b0
> > 01818 Code: a0 f8 d7 81 42 3b 1c 28 7f d9 4c 89 e1 31 d2 89 de 89 7d dc e8 01 fd ff ff 8b 7d dc eb c5 49 8b 04 24 49 8b 54 24 08 48 85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 c7 c7
> > 01818 RSP: 0018:ffff888101fcfc60 EFLAGS: 00010286
> > 01818 RAX: dead000000000100 RBX: 0000000000000017 RCX: 0000000000000000
> > 01818 RDX: dead000000000122 RSI: ffff8881233b0ae8 RDI: ffffffff81e3b080
> > 01818 RBP: ffff888101fcfc88 R08: 0000000000000008 R09: 0000000000000003
> > 01818 R10: 0000000000000000 R11: 00000000002dc6c0 R12: ffff8881233b0ae8
> > 01818 R13: 0000000000000000 R14: ffffffff81e38f58 R15: ffff88817b5a3c00
> > 01818 FS:  00007ff56daec280(0000) GS:ffff888275800000(0000) knlGS:0000000000000000
> > 01818 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 01818 CR2: 00005591ad94f198 CR3: 000000017b5a0004 CR4: 0000000000770eb0
> > 01818 PKRU: 55555554
> > 01818 Call Trace:
> > 01818  <TASK>
> > 01818  ? kfree+0x66/0x250
> > 01818  bioset_exit+0x32/0x210
> > 01818  cleanup_mapped_device+0x34/0xf0
> > 01818  __dm_destroy+0x149/0x1f0
> > 01818  ? table_clear+0xc0/0xc0
> > 01818  dm_destroy+0xe/0x10
> > 01818  dev_remove+0xd9/0x120
> > 01818  ctl_ioctl+0x1cb/0x420
> > 01818  dm_ctl_ioctl+0x9/0x10
> > 01818  __x64_sys_ioctl+0x89/0xb0
> > 01818  do_syscall_64+0x35/0x80
> > 01818  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > 01818 RIP: 0033:0x7ff56de3b397
> > 01818 Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 da 0d 00 f7 d8 64 89 01 48
> > 01818 RSP: 002b:00007ffe55367ef8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> > 01818 RAX: ffffffffffffffda RBX: 00007ff56df31a8e RCX: 00007ff56de3b397
> > 01818 RDX: 000055daad7cab30 RSI: 00000000c138fd04 RDI: 0000000000000003
> > 01818 RBP: 00007ffe55367fb0 R08: 00007ff56df81558 R09: 00007ffe55367d60
> > 01818 R10: 00007ff56df808a2 R11: 0000000000000206 R12: 00007ff56df808a2
> > 01818 R13: 00007ff56df808a2 R14: 00007ff56df808a2 R15: 00007ff56df808a2
> > 01818  </TASK>
> > 01818 Modules linked in: crct10dif_generic crct10dif_common [last unloaded: crc_t10dif]
> 
> I suspect dm is calling bioset_exit() multiple times? Which it probably
> should not.
> 
> The reset of bioset_exit() is resilient against this, so might be best
> to include bio_alloc_cache_destroy() in that.
> 
> 
> diff --git a/block/bio.c b/block/bio.c
> index a3893d80dccc..be3937b84e68 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -722,6 +722,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
>  		bio_alloc_cache_prune(cache, -1U);
>  	}
>  	free_percpu(bs->cache);
> +	bs->cache = NULL;
>  }
>  
>  /**

Yes, we need the above to fix the crash.  Does it also make sense to
add this?

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 49eff01fb829..f410c78e9c0c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -681,7 +681,7 @@ struct bio_set {

 static inline bool bioset_initialized(struct bio_set *bs)
 {
-	return bs->bio_slab != NULL;
+	return (bs->bio_slab != NULL || bs->cache != NULL);
 }

 #if defined(CONFIG_BLK_DEV_INTEGRITY)

FYI, DM's unique use of bioset_init_from_src() is the primary reason
why this stale pointer is biting us.

I dug into this issue further and have queued this patch:

From: Mike Snitzer <snitzer@kernel.org>
Date: Tue, 31 May 2022 12:16:49 -0400
Subject: [PATCH] dm table: fix dm_table_supports_poll to return false if no data devices

It was reported that the "generic/250" test in xfstests (which uses
the dm-error target) demonstrates a regression where the kernel
crashes in bioset_exit().

Since commit cfc97abcbe0b ("dm: conditionally enable
BIOSET_PERCPU_CACHE for dm_io bioset") the bioset_init() for the dm_io
bioset will setup the bioset's per-cpu alloc cache if all devices have
QUEUE_FLAG_POLL set.

But there was an bug where a target that doesn't have any data devices
(and that doesn't even set the .iterate_devices dm target callback)
will incorrectly return true from dm_table_supports_poll().

Fix this by updating dm_table_supports_poll() to follow dm-table.c's
well-worn pattern for testing that _all_ targets in a DM table do in
fact have underlying devices that set QUEUE_FLAG_POLL.

NOTE: An additional block fix is still needed so that
bio_alloc_cache_destroy() clears the bioset's ->cache member.
Otherwise, a DM device's table reload that transitions the DM device's
bioset from using a per-cpu alloc cache to _not_ using one will result
in bioset_exit() crashing in bio_alloc_cache_destroy() because dm's
dm_io bioset ("io_bs") was left with a stale ->cache member.

Fixes: cfc97abcbe0b ("dm: conditionally enable BIOSET_PERCPU_CACHE for dm_io bioset")
Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-table.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index a37c7b763643..0e833a154b31 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1005,7 +1005,7 @@ bool dm_table_request_based(struct dm_table *t)
 	return __table_type_request_based(dm_table_get_type(t));
 }
 
-static int dm_table_supports_poll(struct dm_table *t);
+static bool dm_table_supports_poll(struct dm_table *t);
 
 static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *md)
 {
@@ -1027,7 +1027,7 @@ static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *
 			per_io_data_size = max(per_io_data_size, ti->per_io_data_size);
 			min_pool_size = max(min_pool_size, ti->num_flush_bios);
 		}
-		poll_supported = !!dm_table_supports_poll(t);
+		poll_supported = dm_table_supports_poll(t);
 	}
 
 	t->mempools = dm_alloc_md_mempools(md, type, per_io_data_size, min_pool_size,
@@ -1547,9 +1547,20 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
 	return 0;
 }
 
-static int dm_table_supports_poll(struct dm_table *t)
+static bool dm_table_supports_poll(struct dm_table *t)
 {
-	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
+	struct dm_target *ti;
+	unsigned i = 0;
+
+	while (i < dm_table_get_num_targets(t)) {
+		ti = dm_table_get_target(t, i++);
+
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti, device_not_poll_capable, NULL))
+			return false;
+	}
+
+	return true;
 }
 
 /*
-- 
2.15.0

