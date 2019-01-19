Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC18C5AE5E
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 01:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61EA2086D
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 01:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUjCRtKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfASBjd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:39:33 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36840 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfASBjd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 20:39:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so17367983qtn.3
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 17:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9htbo1D3Iv9YTAoWKo6Buh8+Z8JAdU1zzHJ507l/Q6k=;
        b=ZUjCRtKdUwMX3AHvveJAyYruluIExCbHkjmjEXYy7G6H1lQtoVxtTJL9z/bg+bqTfx
         ZOS0jdRirtny5TYL975woP148+zseHlj/QZ+ypA2DFXtC/Qa6ZREm5CQtffNUTbwnt9d
         kRt7J8vCi/n3KYeD95Pmb72GmtBqQEqpcC3hZmKeaeV9d+3TS0J8RKRirTmKAKO1twuz
         k3XMLR/nyksBFXrN03YMk95B9nI7b6dB6heGv3ZgsoEyHwxfzwAJrhfpMw8A96FrD90k
         SHNZGLrDsOYCf4KxTE+z2jUvrmwHmEv1iGF5iaKyQMvLVXo271sUfqQcDClemiLa5EUy
         qIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9htbo1D3Iv9YTAoWKo6Buh8+Z8JAdU1zzHJ507l/Q6k=;
        b=fa4Zg0PyG/ND27F6AG1TGIrSU21vVPIaW9VKh1pujEYq6v4ZBgAo8vKe4sNePROYq7
         7N9Z6vwwRCpVEx597guXqQB1Z1p3gY4t8HEZJ+8cIG2VdJdzUbIKV8m72OO3QKoJl6Cm
         VkpwMzs9hRdosCYMUMOFrfAup94B+uQlHopOVJ59EqVwOwAkYE/A4s/7ctQe5RSZw4Bf
         F1/KV6Axxb7hpreWgB1xcRbP3zWul/6Oez/WXIt2d7q9vWT0hdIrmei14rFGIrvZZ+O4
         /1XEewNaB0vN6gAIz8ljPMCTzwPt7tdncDJYi72daR2pBv0gwGAQW8SVMCR8OPKRrQE1
         d+Dg==
X-Gm-Message-State: AJcUukfIn3FUPv+IQsGyj71YekM4tV50+F24oEU7SL5LLypP39NzjeU6
        XEs9WUgSAPKKBFdCI68uHdKQWDd9osZIPmVjqQisi9z8
X-Google-Smtp-Source: ALg8bN78J95HG9yEZhvL6Mgkava8Q9BeluOGIRgdzlvCfaPMFBMX7/c8p25vOUSZbf5DEVg6sv8XAcgp1JO8QnM+kkI=
X-Received: by 2002:a0c:a326:: with SMTP id u35mr18014086qvu.190.1547861971860;
 Fri, 18 Jan 2019 17:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
 <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk> <20190118162117.zqdwjkq74wzsaxn3@macbook-pro-91.dhcp.thefacebook.com>
 <c9fed816-cea1-33f1-017b-10f86df0b8a8@kernel.dk> <20190118164312.muk7zdcb5yqn7fdp@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190118164312.muk7zdcb5yqn7fdp@macbook-pro-91.dhcp.thefacebook.com>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Fri, 18 Jan 2019 17:39:20 -0800
Message-ID: <CANQeFDDv=0FNNW_-HyQVTyeaJu4Y6SWbWii1CKNHtux9=VhNjQ@mail.gmail.com>
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight counter
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Liu Bo <bo.liu@linux.alibaba.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 8:43 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, Jan 18, 2019 at 09:28:06AM -0700, Jens Axboe wrote:
> > On 1/18/19 9:21 AM, Josef Bacik wrote:
> > > On Fri, Jan 18, 2019 at 05:58:18AM -0700, Jens Axboe wrote:
> > >> On 1/14/19 12:21 PM, Liu Bo wrote:
> > >>> Our test reported the following stack, and vmcore showed that
> > >>> ->inflight counter is -1.
> > >>>
> > >>> [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
> > >>> [ffffc9003fcc3958] schedule at ffffffff8173de26
> > >>> [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
> > >>> [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
> > >>> [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
> > >>> [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
> > >>> [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
> > >>> [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
> > >>> [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
> > >>> [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
> > >>> [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
> > >>> [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
> > >>> [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
> > >>> [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
> > >>> [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
> > >>> [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
> > >>> [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
> > >>> [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
> > >>> [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
> > >>>
> > >>> The ->inflight counter may be negative (-1) if
> > >>>
> > >>> 0) blk-throttle had been enabled when the IO was issued, so its bio
> > >>> has a associated blkg,
> > >>>
> > >>> 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
> > >>> in this blkg was not available by then,
> > >>>
> > >>> 2) blk-iolatency was enabled before this IO reached its endio, so that
> > >>> iolatency_grp became available when the IO did the endio.
> > >>>
> > >>> 3) the ->inflight counter is decreased from 0 to -1.
> > >>>
> > >>> This uses atomic_dec_is_positive() instead to avoid the negative
> > >>> inflight counter.
> > >>
> > >> The problem with that is that it'll hide a lot of other issues, too.
> > >> Any way we can either track if this rqw is in flight, and only dec
> > >> if it is, or quiesce when enabling?
> > >>
> > >
> > > I worried about this too, but really the side-effect of allowing more through
> > > because of mis-counting means we just let more IO through.  I think maybe we add
> > > a debug option that we can turn on to see if we're messing up accounting, but in
> > > general I don't see a problem with this approach.
> >
> > The problem is that a problem in accounting elsewhere (like missing increment)
> > will now go unnoticed, which could completely screw it up. An occasional
> > blip like the one described is totally fine, but that's not guaranteed to be
> > the case.
> >
>
> Yeah I agree it's kind of shitty.
>
> > > The problem we're running into here is there's not really a good way to tag a
> > > bio as "seen by io.latency."  We just have to assume if we're on and there's a
> > > bi_blkg associated that we saw it at submit time.  We can't just add a flag for
> > > every io controller that starts tracking inflight io's, so for now I think this
> > > is a reasonable solution.  Thanks,
> >
> > Can we quiesce instead when enabling/disabling?
>
> Actually that's not a bad idea, you want to look into that Liu?  That way we can
> make sure everything is correct always.  Thanks,
>

Just to confirm, does "quiesce when enabling/disabling" mean "waiting
for inflight IOs to complete when enabling/disabling iolatency"?

thanks,
liubo
