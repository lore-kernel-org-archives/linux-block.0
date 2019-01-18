Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE65C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CC120823
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="lDaTJIzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfARQnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:43:16 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41482 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfARQnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:43:16 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so5459790ywc.8
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/rbqmFxUW5AGB51KEkqoQk239k0ilO0NXCEVsw93X0=;
        b=lDaTJIzsguEc3tzzO2D2jpcR3Jn4OiP1IxXwTQVKfvf+L+2VP3+DxnUFVIMXIDqDiB
         Td92ly6MPOY9ftE7PPtr2E80wgvB8iZNDMIENmeRg6+eH9WX2KJFKPz9HF6o1hCldszi
         BwTEpJUTK4US6h42SlUPk9uh3MY6x0j20lwORInnADtpgzh3yNPYEcsPgRculjN3RFZ/
         5f7no/6lwYxtI9RqvYol4cSLyGV9jQCaiffMVdEpu6p0i05qpUkERY93s2pmeoaQdeLs
         72nLtKouONqfcJFeDB2Ja7SKAAgxsnarjzIKurRaoOTfjrOdy7Zel/SWMKfQ7H+ioUcy
         kJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/rbqmFxUW5AGB51KEkqoQk239k0ilO0NXCEVsw93X0=;
        b=AazPfevYj4ZM7y7FdDt9xiVZGDs06Aa3Hp4LitWIXCMyORv1eZgiyrJZP9WI0yNDvP
         Og9wOCkCyoxoaByZVJDxheV4oZrxLVD7N0C3jRaZHZ1bQDdTYJOAyXBs3NKlGRWXA+Zb
         dcFxQ22y2wedYbl78oIipkgHyhGefJDEGqtxZcKTeRk9j5h0onLFWK0qI4+YFn6t/tuX
         PkYt9MnhCC0FBM7hy8aQukBXecp29bte7JQEc/mCpbiGGM/I5KWlZEMQFBDEc5gk9QZW
         YFa8saFgGMTWwfZ2uBWmBaDHogb7FDVxYy/AAqf/nbg8mfNpbiC/vox1F6Es8C2ET4MH
         3RWQ==
X-Gm-Message-State: AJcUukcpTKlMoGm768hVV8LHc+o7ydV3b2+iakwNTWnzvGeg+uKU3LXi
        nEB2cqnV/Y/e0XRNfrN2Dcw4BQ==
X-Google-Smtp-Source: ALg8bN6yNkpnsc/8CmSXnW8t+0AV6nPh3kl1b91PyK2FMOFfujW2TSflXrtUIkQ3c5ZP9FJmyEBFWQ==
X-Received: by 2002:a0d:fd83:: with SMTP id n125mr16460923ywf.193.1547829794908;
        Fri, 18 Jan 2019 08:43:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:e09e])
        by smtp.gmail.com with ESMTPSA id f67sm3842290ywa.93.2019.01.18.08.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:43:14 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:43:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight
 counter
Message-ID: <20190118164312.muk7zdcb5yqn7fdp@macbook-pro-91.dhcp.thefacebook.com>
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
 <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk>
 <20190118162117.zqdwjkq74wzsaxn3@macbook-pro-91.dhcp.thefacebook.com>
 <c9fed816-cea1-33f1-017b-10f86df0b8a8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fed816-cea1-33f1-017b-10f86df0b8a8@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 09:28:06AM -0700, Jens Axboe wrote:
> On 1/18/19 9:21 AM, Josef Bacik wrote:
> > On Fri, Jan 18, 2019 at 05:58:18AM -0700, Jens Axboe wrote:
> >> On 1/14/19 12:21 PM, Liu Bo wrote:
> >>> Our test reported the following stack, and vmcore showed that
> >>> ->inflight counter is -1.
> >>>
> >>> [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
> >>> [ffffc9003fcc3958] schedule at ffffffff8173de26
> >>> [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
> >>> [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
> >>> [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
> >>> [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
> >>> [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
> >>> [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
> >>> [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
> >>> [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
> >>> [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
> >>> [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
> >>> [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
> >>> [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
> >>> [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
> >>> [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
> >>> [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
> >>> [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
> >>> [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
> >>>
> >>> The ->inflight counter may be negative (-1) if
> >>>
> >>> 0) blk-throttle had been enabled when the IO was issued, so its bio
> >>> has a associated blkg,
> >>>
> >>> 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
> >>> in this blkg was not available by then,
> >>>
> >>> 2) blk-iolatency was enabled before this IO reached its endio, so that
> >>> iolatency_grp became available when the IO did the endio.
> >>>
> >>> 3) the ->inflight counter is decreased from 0 to -1.
> >>>
> >>> This uses atomic_dec_is_positive() instead to avoid the negative
> >>> inflight counter.
> >>
> >> The problem with that is that it'll hide a lot of other issues, too.
> >> Any way we can either track if this rqw is in flight, and only dec
> >> if it is, or quiesce when enabling?
> >>
> > 
> > I worried about this too, but really the side-effect of allowing more through
> > because of mis-counting means we just let more IO through.  I think maybe we add
> > a debug option that we can turn on to see if we're messing up accounting, but in
> > general I don't see a problem with this approach.
> 
> The problem is that a problem in accounting elsewhere (like missing increment)
> will now go unnoticed, which could completely screw it up. An occasional
> blip like the one described is totally fine, but that's not guaranteed to be
> the case.
> 

Yeah I agree it's kind of shitty.

> > The problem we're running into here is there's not really a good way to tag a
> > bio as "seen by io.latency."  We just have to assume if we're on and there's a
> > bi_blkg associated that we saw it at submit time.  We can't just add a flag for
> > every io controller that starts tracking inflight io's, so for now I think this
> > is a reasonable solution.  Thanks,
> 
> Can we quiesce instead when enabling/disabling?

Actually that's not a bad idea, you want to look into that Liu?  That way we can
make sure everything is correct always.  Thanks,

Josef
