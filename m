Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA6C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E8520883
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P+IVhFr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfARQ2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:28:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45316 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfARQ2L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:28:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6268448pgc.12
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f6cCCQODb5rfwRaQi4TVJZ+SrvLPj0pjKtJ1XtxpsCY=;
        b=P+IVhFr3DMTwBk30/B9oAY1xraQkDKvPOutW4i2hJPEmsgQJ9Te4HU7bn3GtcdU9T+
         +1gescgNHch5E74NxSCxH87mx9xBcSbbt/oKGUu7WUDga14e4JyGK+cUOIRDluOIjBpj
         jCWkDPfckYbh0cuLYWqzgBH9tBsRUXegIDQQ8ozdYCCpy4oMF046RcnX1G5XyGm0/h2V
         XT+FIbYNCStxfYuKv/HN2iN2Y76hMGRpUl18qzwIiZsrDtq4Av3cceN5Is4HQTC/HHGa
         mABsUBNnJcZGPMOyThuMiBfCgN3Ikm65U8In5hdycsTSZSGhLzSjs6rdnHdzzlw1PKjw
         5pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6cCCQODb5rfwRaQi4TVJZ+SrvLPj0pjKtJ1XtxpsCY=;
        b=Xbdc9Xp/Q03NXeQJkxNCeBmKmsUThePDGu1oudxL/yJFdCB1PvY6VZD3TOeEHVOhGg
         JyYnlM01diaKskhZO0NH4lxcfmOypmwc0OOTKza6HmjEy4TkcPgYuLdOe72ou1GIPhVZ
         kXcK4quzsJOtgcMUpJ4vPpuwvxqUwPT35YHLI3YO4Hi1X8FCViFugYvBYo5PDErkgnC9
         Ar4wTHsIIYOLBJQ2bWqGuvdSYJ3e9vlEpZWtgYyCy0Z5pPRWdCednvrui2SU0pKxjTYz
         CW3dG0e/VqEaZV8Yzrt/jvvsfmZKgs9oUYvglLVhT2/HPaYcQWSSSQ1tswZQXkbIDzzi
         Th4w==
X-Gm-Message-State: AJcUukcLPjPnDEe3uHYlwVvkk+Es3byL51OUEU/ptfANOjQBfOKnlnBS
        3RFqNn+eZwE67keEsraCEQTm18v9COUGSA==
X-Google-Smtp-Source: ALg8bN7rER3ScN1M/q0XEgfSJmh5VkkYqzHmj2n/5zzScEEdKT7DBxbsbx6swi8kcM1U7KUOAy/dkw==
X-Received: by 2002:a63:7306:: with SMTP id o6mr17990164pgc.343.1547828889953;
        Fri, 18 Jan 2019 08:28:09 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x186sm6914404pfb.59.2019.01.18.08.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:28:08 -0800 (PST)
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight
 counter
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
 <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk>
 <20190118162117.zqdwjkq74wzsaxn3@macbook-pro-91.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c9fed816-cea1-33f1-017b-10f86df0b8a8@kernel.dk>
Date:   Fri, 18 Jan 2019 09:28:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118162117.zqdwjkq74wzsaxn3@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 9:21 AM, Josef Bacik wrote:
> On Fri, Jan 18, 2019 at 05:58:18AM -0700, Jens Axboe wrote:
>> On 1/14/19 12:21 PM, Liu Bo wrote:
>>> Our test reported the following stack, and vmcore showed that
>>> ->inflight counter is -1.
>>>
>>> [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
>>> [ffffc9003fcc3958] schedule at ffffffff8173de26
>>> [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
>>> [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
>>> [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
>>> [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
>>> [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
>>> [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
>>> [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
>>> [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
>>> [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
>>> [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
>>> [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
>>> [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
>>> [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
>>> [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
>>> [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
>>> [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
>>> [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
>>>
>>> The ->inflight counter may be negative (-1) if
>>>
>>> 0) blk-throttle had been enabled when the IO was issued, so its bio
>>> has a associated blkg,
>>>
>>> 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
>>> in this blkg was not available by then,
>>>
>>> 2) blk-iolatency was enabled before this IO reached its endio, so that
>>> iolatency_grp became available when the IO did the endio.
>>>
>>> 3) the ->inflight counter is decreased from 0 to -1.
>>>
>>> This uses atomic_dec_is_positive() instead to avoid the negative
>>> inflight counter.
>>
>> The problem with that is that it'll hide a lot of other issues, too.
>> Any way we can either track if this rqw is in flight, and only dec
>> if it is, or quiesce when enabling?
>>
> 
> I worried about this too, but really the side-effect of allowing more through
> because of mis-counting means we just let more IO through.  I think maybe we add
> a debug option that we can turn on to see if we're messing up accounting, but in
> general I don't see a problem with this approach.

The problem is that a problem in accounting elsewhere (like missing increment)
will now go unnoticed, which could completely screw it up. An occasional
blip like the one described is totally fine, but that's not guaranteed to be
the case.

> The problem we're running into here is there's not really a good way to tag a
> bio as "seen by io.latency."  We just have to assume if we're on and there's a
> bi_blkg associated that we saw it at submit time.  We can't just add a flag for
> every io controller that starts tracking inflight io's, so for now I think this
> is a reasonable solution.  Thanks,

Can we quiesce instead when enabling/disabling?

-- 
Jens Axboe

