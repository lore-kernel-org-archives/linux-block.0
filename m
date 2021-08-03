Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F1C4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D3260F70
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 07:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhHCHNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234020AbhHCHNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Aug 2021 03:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627974781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTfRzO0Fs69Ni1fmJ1gOV3/2oxiDXn4sWJEwS1/+vBM=;
        b=Lnrzz3/qNwmmPBaCY+c7NLw8VrM0Gft7Bk7WgYoYd19dEh3GlTdOn2+GPD1pjR9X4a8eT6
        TP8T6mL/Su3hM9e0kd7w9gqELGi2fOwoP9QWlr2ZJebYZu2uxmejbNBBEr11o/PVpjA0eJ
        jwrIxuBbaFzc7oTwtSqEiJQ6p9sHPiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Oux1BptMOY6YqtQTpLbKyg-1; Tue, 03 Aug 2021 03:13:00 -0400
X-MC-Unique: Oux1BptMOY6YqtQTpLbKyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DBC801E72;
        Tue,  3 Aug 2021 07:12:59 +0000 (UTC)
Received: from T590 (ovpn-13-115.pek2.redhat.com [10.72.13.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AD736789B;
        Tue,  3 Aug 2021 07:12:48 +0000 (UTC)
Date:   Tue, 3 Aug 2021 15:12:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        CKI Project <cki-project@redhat.com>
Subject: Re: WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe
 (bio_associate_blkg_from_css+0x3e5/0x650 pool_map+0x23/0x70)
Message-ID: <YQjseFGCNjjlFoJp@T590>
References: <CA+QYu4rzz6079ighEanS3Qq_Dmnczcf45ZoJoHKVLVATTo1e4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4rzz6079ighEanS3Qq_Dmnczcf45ZoJoHKVLVATTo1e4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 02, 2021 at 05:11:08PM +0200, Bruno Goncalves wrote:
> Hello,
> 
> We've hit the issue below twice during our tests on kernel 5.14.0-rc3.
> Unfortunately, we don't have a reliable reproducer.
> 
> [  496.176739] =====================================================
> [  496.182844] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> [  496.189471] 5.14.0-rc3 #1 Not tainted
> [  496.193152] -----------------------------------------------------
> [  496.199252] systemd-udevd/12979 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [  496.206399] ffff995b358dc5a0 (&q->queue_lock){....}-{2:2}, at:
> bio_associate_blkg_from_css+0x3e5/0x650
> [  496.215726]
>                and this task is already holding:
> [  496.221563] ffff995b081d0ad8 (&pool->lock#3){..-.}-{2:2}, at:
> pool_map+0x23/0x70 [dm_thin_pool]
> [  496.230282] which would create a new lock dependency:
> [  496.235344]  (&pool->lock#3){..-.}-{2:2} -> (&q->queue_lock){....}-{2:2}
> [  496.242059]
>                but this new dependency connects a SOFTIRQ-irq-safe lock:
> [  496.249988]  (&pool->lock#3){..-.}-{2:2}
> [  496.249993]
>                ... which became SOFTIRQ-irq-safe at:
> [  496.260111]   lock_acquire+0xb5/0x2b0
> [  496.263785]   _raw_spin_lock_irqsave+0x48/0x60
> [  496.268240]   overwrite_endio+0x46/0x70 [dm_thin_pool]
> [  496.273393]   clone_endio+0xb9/0x1e0
> [  496.276979]   clone_endio+0xb9/0x1e0
> [  496.280565]   blk_update_request+0x25b/0x420
> [  496.284846]   blk_mq_end_request+0x1c/0x130
> [  496.289041]   blk_complete_reqs+0x37/0x40
> [  496.293071]   __do_softirq+0xde/0x485
> [  496.296744]   run_ksoftirqd+0x3a/0x70
> [  496.300427]   smpboot_thread_fn+0xf2/0x1c0
> [  496.304534]   kthread+0x143/0x160
> [  496.307863]   ret_from_fork+0x22/0x30
> [  496.311538]
>                to a SOFTIRQ-irq-unsafe lock:
> [  496.317037]  (&blkcg->lock){+.+.}-{2:2}
> [  496.317041]
>                ... which became SOFTIRQ-irq-unsafe at:
> [  496.327243] ...
> [  496.327244]   lock_acquire+0xb5/0x2b0
> [  496.332680]   _raw_spin_lock+0x2c/0x40
> [  496.336443]   ioc_weight_write+0x153/0x260
> [  496.340551]   kernfs_fop_write_iter+0x134/0x1d0
> [  496.345095]   new_sync_write+0x10b/0x180
> [  496.349030]   vfs_write+0x26a/0x380
> [  496.352530]   ksys_write+0x58/0xd0
> [  496.355944]   do_syscall_64+0x5c/0x80
> [  496.359616]   entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  496.364776]
> 
> More logs are available on
> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/29/345042572/build_x86_64_redhat%3A1463074774/tests/lvm_snapper_test/

The following patch should fix the warning:

https://lore.kernel.org/linux-block/20210803070608.1766400-1-ming.lei@redhat.com/T/#u


Thanks,
Ming

