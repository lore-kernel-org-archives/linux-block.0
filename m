Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19B9C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 10:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45E16100B
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 10:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhDNKmv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhDNKmq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 06:42:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5FC061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 03:42:25 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t11so6480547qtr.8
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=it7beu+V716TuKFhyV8hqmBlSb5FQZ9jlON89XHSgiQ=;
        b=cBogAfx3149yeFpVIN+ca2TM+XZcZ5Gds8A/of06bHECzj1M64pSqbTSckizPUORmc
         ASPUs4TtXPoImYfcKq6qwCSXjo3ZMd7RQQi+BCb6K8VUFIzS7ek1Gp/pRRTJpmQHmwC7
         DjFSEPOpTOpIgNYu4uQzKBPnPgraSchZ8yU0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=it7beu+V716TuKFhyV8hqmBlSb5FQZ9jlON89XHSgiQ=;
        b=ViUUmdfXPiOsXaSl+Q/H4ZeKEVGAuLGfLTdDLT1V04eT5bgXo5iTG6p9W/glPbfWbd
         mE3hhJmVwtw5SYyNxPd8RKQrRz+GttxWrOUXu1WTUlj75vosDrriQVNq2zt6wa1V7v8p
         mRPFkhPvSW/2cA/frUsji+1BLT9pKklOrSL1GkaNOootGVd8yJJmQ89yNIvjCdnlmgAU
         LfEK4QZmCYixz4i4AXTlZyFvC6I/4MacT9KfjlJ/4xXcUHjyDkv3Ph4gRb1q+8e0wsO6
         yzSso0UgoZJ/aNZKXqNhsNXbTMaE7P1I54RNqIhLLUsckX9ogyW06ZysxmrQoXxE3lmi
         77VQ==
X-Gm-Message-State: AOAM532FnykqX0ktFxNGTK2zJwVYBK87kD38AlNQ5thaxSEEUBItsX1r
        HYIJH5LSBt2rBO1lDpUNDyOOY5elLf/JuzFliZVfQJ8azdpG0w==
X-Google-Smtp-Source: ABdhPJwb7445FBUTc//UXf+9jX66ptGEfJu9+5Eh04aCCPHJztA6wA/cod9a/4v3fvZD3inTlebPr2csEp/ucHd9uzg=
X-Received: by 2002:ac8:57d0:: with SMTP id w16mr14378475qta.190.1618396944319;
 Wed, 14 Apr 2021 03:42:24 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <YHaez6iN2HHYxYOh@T590> <9a6145a5-e6ac-3d33-b52a-0823bfc3b864@huawei.com>
In-Reply-To: <9a6145a5-e6ac-3d33-b52a-0823bfc3b864@huawei.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHvM4xIklkXT4m1nLiQOVtWtLHGaQF/MHX/qnfSwkA=
Date:   Wed, 14 Apr 2021 16:12:22 +0530
Message-ID: <cb326d404c6e0785d03a7dfadc42832c@mail.gmail.com>
Subject: RE: [bug report] shared tags causes IO hang and performance drop
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fe757a05bfec6698"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000fe757a05bfec6698
Content-Type: text/plain; charset="UTF-8"

> Hi Ming,
>
> >
> > It is reported inside RH that CPU utilization is increased ~20% when
> > running simple FIO test inside VM which disk is built on image stored
> > on XFS/megaraid_sas.
> >
> > When I try to investigate by reproducing the issue via scsi_debug, I
> > found IO hang when running randread IO(8k, direct IO, libaio) on
> > scsi_debug disk created by the following command:
> >
> > 	modprobe scsi_debug host_max_queue=128
> submit_queues=$NR_CPUS
> > virtual_gb=256
> >
>
> So I can recreate this hang for using mq-deadline IO sched for scsi debug,
> in
> that fio does not exit. I'm using v5.12-rc7.

I can also recreate this issue using mq-deadline. Using <none>, there is no
IO hang issue.
Also if I run script to change scheduler periodically (none, mq-deadline),
sysfs entry hangs.

Here is call trace-
Call Trace:
[ 1229.879862]  __schedule+0x29d/0x7a0
[ 1229.879871]  schedule+0x3c/0xa0
[ 1229.879875]  blk_mq_freeze_queue_wait+0x62/0x90
[ 1229.879880]  ? finish_wait+0x80/0x80
[ 1229.879884]  elevator_switch+0x12/0x40
[ 1229.879888]  elv_iosched_store+0x79/0x120
[ 1229.879892]  ? kernfs_fop_write_iter+0xc7/0x1b0
[ 1229.879897]  queue_attr_store+0x42/0x70
[ 1229.879901]  kernfs_fop_write_iter+0x11f/0x1b0
[ 1229.879905]  new_sync_write+0x11f/0x1b0
[ 1229.879912]  vfs_write+0x184/0x250
[ 1229.879915]  ksys_write+0x59/0xd0
[ 1229.879917]  do_syscall_64+0x33/0x40
[ 1229.879922]  entry_SYSCALL_64_after_hwframe+0x44/0xae


I tried both - 5.12.0-rc1 and 5.11.0-rc2+ and there is a same behavior.
Let me also check  megaraid_sas and see if anything generic or this is a
special case of scsi_debug.

>
> Do you have any idea of what changed to cause this, as we would have
> tested
> this before? Or maybe only none IO sched on scsi_debug. And normally 4k
> block size and only rw=read (for me, anyway).
>
> Note that host_max_queue=128 will cap submit queue depth at 128, while
> would be 192 by default.
>
> Will check more...including CPU utilization.
>
> Thanks,
> John
>
> > Looks it is caused by SCHED_RESTART because current RESTART is just
> > done on current hctx, and we may need to restart all hctxs for shared
> > tags, and the issue can be fixed by the append patch. However, IOPS
> > drops more than 10% with the patch.
> >
> > So any idea for this issue and the original performance drop?
> >
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c index
> > e1e997af89a0..45188f7aa789 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -59,10 +59,18 @@
> EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
> >
> >   void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> >   {
> > +	bool shared_tag = blk_mq_is_sbitmap_shared(hctx->flags);
> > +
> > +	if (shared_tag)
> > +		blk_mq_run_hw_queues(hctx->queue, true);
> > +
> >   	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
> >   		return;
> >   	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> >
> > +	if (shared_tag)
> > +		return;
> > +
> >   	/*
> >   	 * Order clearing SCHED_RESTART and list_empty_careful(&hctx-
> >dispatch)
> >   	 * in blk_mq_run_hw_queue(). Its pair is the barrier in
> >
> > Thanks,
> > Ming
> >
> > .
> >

--000000000000fe757a05bfec6698
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPvaPaPoRgzIiAwcfSr1xd61dEnJ
D3yxwB+Qb38FiT6/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQxNDEwNDIyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA6XZ/k1G+VTiETh/rfV0rmYgmFP6nOL5NX56ha+JaYe8fW
1ibEk+B7wbae07Nqmnak9JFTaAaOSTyxViAul3nTPBb1RVitfMMPiFwHafVqhmtjVPZvcMJLbYnq
RWf37PN6mdD5DivRz53LrlBmbpg/4PBkr+SzD87K74pOTRqmJmUPV0J2fafPhBBytGA55HgPocCJ
WSSv4QjWcNmYzING5LNUUqujwo0ad+nMFrsRHWobbUsaUx9B+Q8OajkG22nwgPu7gQVdC3jc+C/C
LjSdRiILnrzD3ug54lnjn95MhTDZhF7icNccmqjwsygYHPF8Com+QhCOLsGHQK4LvkcH
--000000000000fe757a05bfec6698--
