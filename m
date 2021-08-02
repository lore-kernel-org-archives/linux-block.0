Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547CFC4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E860FC2
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhHBPLb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234729AbhHBPLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Aug 2021 11:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627917081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KChr5F+A06up14FC1+oGT4a8o6kptF7s/8rLuPeEoh8=;
        b=ELtO8R4g3jpanaig0bTnVQXxbnKDFTyE1NTFnHsfisd0WfEMGQSCbNQZyIKXl6LeT5b/bq
        kGZhbduYY1eguVPPdMgxf9q3FbkZnPp7CbWtnLCgeaARMCRN4myGZiykP6QLchkzZvJptM
        owUG5TmZLuSmSOOE/iF/S1mDyLgQ4go=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Rt8c3iN1PDaT5IF-dLkU5w-1; Mon, 02 Aug 2021 11:11:20 -0400
X-MC-Unique: Rt8c3iN1PDaT5IF-dLkU5w-1
Received: by mail-ot1-f69.google.com with SMTP id i18-20020a9d62520000b02904ccb7285c38so8171613otk.14
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 08:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KChr5F+A06up14FC1+oGT4a8o6kptF7s/8rLuPeEoh8=;
        b=rTNBxtZuCwCKYwl97c+6eO3lvm+bheKkqncUH/NuKCU+/yWrqgN1MjPzIJFyL7hUm3
         Q/uZGu6ZHLX8BKAIE+rPTWk3BYHTZKPib5O+MWgPeTpaNfPyIoKRF3m68B5QKaEBfuM6
         LY/eevrog/0Zh2ZxJwSrlqHi8foQpMFo0dnOVSa3u9kn6Sbaiq6tBXpmE9V6oIrwwyrb
         ycqKwnIqbW+/iSd/uqvj07lwoCBb8KHx8Em1OZlTWK+W9gTTk54W7YOOa7sJrXh6BxJn
         OidKvXrscmKPYjo0DGTzcVRwZoG9CumYyiSeGJKuFvXviNk8l4zbFQDX8cD8zKwnn/ko
         9Ybg==
X-Gm-Message-State: AOAM531qwHD7/2houoj6l8tips5I38HQTpZwAISpFR5bH9WzNJbIYPCS
        whYNw/tTj2fAGyhL+YAWdfbP/Su++ZMlbGgp+hP6KBdRv8Ii+C/V26ArFxz0O3lK/K6bT+sETLj
        Zpuf98tO+VxRzMfiSoqE+B9peweJEXsIAd04XQqE=
X-Received: by 2002:a9d:4682:: with SMTP id z2mr11943165ote.189.1627917079220;
        Mon, 02 Aug 2021 08:11:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf54nxR+hA2GVEExuK3iQAqlAF48UFi6aDqYplaCSsxN0a9vTThvFko24IlELSqPlpmlIqxVWJes/RsF8KcOg=
X-Received: by 2002:a9d:4682:: with SMTP id z2mr11943154ote.189.1627917078970;
 Mon, 02 Aug 2021 08:11:18 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Mon, 2 Aug 2021 17:11:08 +0200
Message-ID: <CA+QYu4rzz6079ighEanS3Qq_Dmnczcf45ZoJoHKVLVATTo1e4Q@mail.gmail.com>
Subject: WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe (bio_associate_blkg_from_css+0x3e5/0x650
 pool_map+0x23/0x70)
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

We've hit the issue below twice during our tests on kernel 5.14.0-rc3.
Unfortunately, we don't have a reliable reproducer.

[  496.176739] =====================================================
[  496.182844] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[  496.189471] 5.14.0-rc3 #1 Not tainted
[  496.193152] -----------------------------------------------------
[  496.199252] systemd-udevd/12979 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  496.206399] ffff995b358dc5a0 (&q->queue_lock){....}-{2:2}, at:
bio_associate_blkg_from_css+0x3e5/0x650
[  496.215726]
               and this task is already holding:
[  496.221563] ffff995b081d0ad8 (&pool->lock#3){..-.}-{2:2}, at:
pool_map+0x23/0x70 [dm_thin_pool]
[  496.230282] which would create a new lock dependency:
[  496.235344]  (&pool->lock#3){..-.}-{2:2} -> (&q->queue_lock){....}-{2:2}
[  496.242059]
               but this new dependency connects a SOFTIRQ-irq-safe lock:
[  496.249988]  (&pool->lock#3){..-.}-{2:2}
[  496.249993]
               ... which became SOFTIRQ-irq-safe at:
[  496.260111]   lock_acquire+0xb5/0x2b0
[  496.263785]   _raw_spin_lock_irqsave+0x48/0x60
[  496.268240]   overwrite_endio+0x46/0x70 [dm_thin_pool]
[  496.273393]   clone_endio+0xb9/0x1e0
[  496.276979]   clone_endio+0xb9/0x1e0
[  496.280565]   blk_update_request+0x25b/0x420
[  496.284846]   blk_mq_end_request+0x1c/0x130
[  496.289041]   blk_complete_reqs+0x37/0x40
[  496.293071]   __do_softirq+0xde/0x485
[  496.296744]   run_ksoftirqd+0x3a/0x70
[  496.300427]   smpboot_thread_fn+0xf2/0x1c0
[  496.304534]   kthread+0x143/0x160
[  496.307863]   ret_from_fork+0x22/0x30
[  496.311538]
               to a SOFTIRQ-irq-unsafe lock:
[  496.317037]  (&blkcg->lock){+.+.}-{2:2}
[  496.317041]
               ... which became SOFTIRQ-irq-unsafe at:
[  496.327243] ...
[  496.327244]   lock_acquire+0xb5/0x2b0
[  496.332680]   _raw_spin_lock+0x2c/0x40
[  496.336443]   ioc_weight_write+0x153/0x260
[  496.340551]   kernfs_fop_write_iter+0x134/0x1d0
[  496.345095]   new_sync_write+0x10b/0x180
[  496.349030]   vfs_write+0x26a/0x380
[  496.352530]   ksys_write+0x58/0xd0
[  496.355944]   do_syscall_64+0x5c/0x80
[  496.359616]   entry_SYSCALL_64_after_hwframe+0x44/0xae
[  496.364776]

More logs are available on
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/07/29/345042572/build_x86_64_redhat%3A1463074774/tests/lvm_snapper_test/

Thank you,
Bruno

