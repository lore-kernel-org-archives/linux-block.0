Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E1C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 12:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EF420823
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 12:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZGA3vA8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfARM6Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:58:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45697 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfARM6X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 07:58:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so6019751pgc.12
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=La4xuNGy3TBKj3iIaP7RqSo6LwMxUU9aoIHLDKtG+Ws=;
        b=ZGA3vA8n3fX/ThuJTQgHC4udM8nzDIuW9JVnkznOnR4L8iuHADN9JpzhphKeIQ4sMZ
         BZ3JlZJfuEzVjsPOFIM0N69lCDRYDYc75o+fOnEgYfItIDgYH0pb+AKdRiJ+x9cCh/ud
         TMIrfkOMaATQTijvYeo/OsaY4IGjRe5GL99nBWL4l7p5/6qwjGGgkGrzo6ZgYO7O5tqd
         d9YXFCUerwGiGt9AJhkSYT+RDsH4Ur0WA3kHgr2UjQALP7egIaSjJYaIGc9WtPttGZF3
         P4vRbyIF/XNiEZLQ6SHL9DkNX0QMB0yD+LtJMDd8ar4I8ttoPYL0/uhgPc3rsp/oPngx
         48pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=La4xuNGy3TBKj3iIaP7RqSo6LwMxUU9aoIHLDKtG+Ws=;
        b=cG8nVUGXM5kl5FvQv4xr11nU0N0fX7xTfTzikz1z2zDmEhy9hRVyggMBb+CN4KE4GO
         vkel1WyKcJqq8/1SEuc1Gi7VKAK0Yas9HykIE55MiOI/nQrWupD4ufrcnnjYEbYBspY7
         iKSJWMBDSRg3pi/EQJprSZ0fG+easQfFl2GIgi4mpP65HtdB327fDqQDfbzlBDwkdU3W
         y+3RWSOn78+xnfl07vauBZ2Wstnkcp0FtlxW/jKI9wM21l5U2VZWRp5H+giH7NVUPV8h
         kmP0AcunkWkzntXlkkUGK+yxwwGZppoWYtWshPU2Y9O3/OadwmSyKiVhrqGa1REJ4P7+
         KWZQ==
X-Gm-Message-State: AJcUukcjwBiSIS9aPaL4Uasxo8nhLwjHQDiS3PXJbPoYAlFc06ygpj9F
        qKcmBxRXWpPPCTPvySG1dhbTB7qjJvsfGQ==
X-Google-Smtp-Source: ALg8bN4kI56R1k+qmKv7FWidBGPh7cNK+PbytMpv+Kpah5TFJep0AYhedbX8uKfVQUpc3xek7xAcsQ==
X-Received: by 2002:a62:6408:: with SMTP id y8mr19104367pfb.202.1547816302508;
        Fri, 18 Jan 2019 04:58:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l5sm10300593pgu.86.2019.01.18.04.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 04:58:21 -0800 (PST)
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight
 counter
To:     Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk>
Date:   Fri, 18 Jan 2019 05:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/14/19 12:21 PM, Liu Bo wrote:
> Our test reported the following stack, and vmcore showed that
> ->inflight counter is -1.
> 
> [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
> [ffffc9003fcc3958] schedule at ffffffff8173de26
> [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
> [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
> [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
> [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
> [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
> [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
> [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
> [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
> [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
> [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
> [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
> [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
> [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
> [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
> [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
> [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
> [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
> 
> The ->inflight counter may be negative (-1) if
> 
> 0) blk-throttle had been enabled when the IO was issued, so its bio
> has a associated blkg,
> 
> 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
> in this blkg was not available by then,
> 
> 2) blk-iolatency was enabled before this IO reached its endio, so that
> iolatency_grp became available when the IO did the endio.
> 
> 3) the ->inflight counter is decreased from 0 to -1.
> 
> This uses atomic_dec_is_positive() instead to avoid the negative
> inflight counter.

The problem with that is that it'll hide a lot of other issues, too.
Any way we can either track if this rqw is in flight, and only dec
if it is, or quiesce when enabling?

-- 
Jens Axboe

