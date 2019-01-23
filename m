Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1DC282C2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28E217D4
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 17:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="dx7A2Lej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfAWR0W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:26:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32856 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWR0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 12:26:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id d15so1566064qkj.0
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dmBIJlvcwx9LAc9fTcMJxfkcfPHsHDKooJbWeD8SzoA=;
        b=dx7A2LejYtatfTeOIYWElFoOxjxEQTpuF+TiCe9pcJYGR16BGWAwQwZa/GZOOfF80p
         0qTGAB+OOyalkDQq7JVpiEC7XQuQrBln4lj80TtFk68Haf4BzOQletudvY1eJOu7rt45
         Y8QoT0bNaX3shIR65blKJU7/ZsY/IY83JZtmi/Jwmz8mx2e2pz2bJhXhpYecLopdtWR9
         8pkbR+pYuT8fH9T8nx3Xxj8qhQOhjY3eYd8iE3BOwgX9EgWd3JFbEcbVxQ5W1XoRhCh/
         +7FrQjwXrhWiWmrqnayUJ7lty/uZl3LWj6o+Sm3FgX0nNiqkJq2tJJFQciWeH38dGb80
         bnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dmBIJlvcwx9LAc9fTcMJxfkcfPHsHDKooJbWeD8SzoA=;
        b=sL4iG0WEBn6An+LGDZDXkGW15fndF2NIoevcArBwJPVnfpUArysX1ofUBXjMSphJ1B
         eN0pIFd/80qLVwW2d+19DD2fEBfkhOlBkyh56ecdxkwsXZKEKjNrX4sE8WWnO7mzlrQs
         MkhFR2exFDFVAmTxoIrEzURnXQrf892tyIw8xdm3Dd0SnTNbYCDvv9XYv1MruvQsDmNX
         I0YQyoUkcrVz4faov3zbPYUbwuf8YRnf/SIHCINSlWZYfC5nVRvWznHk3iSQug2/jsLc
         Im0Dmko3AMRqaJhSFQuUPssv99IJY8Slz6TrkyMlrMPTPK5ZMxLCUC4Hw6oxM/Xeb/tM
         Xy7g==
X-Gm-Message-State: AJcUukeDNUP8JAF3ATftuTz+q25cvq534inxm6/3RjfFzDlmrPgrafCK
        O00fNIyzUdpthKgHbniHwBsq5A==
X-Google-Smtp-Source: ALg8bN4tkGqLfzNuQ+3jqEQW4fBam6380izyKUrc6B+9NUimiyvOAiEVVTvItD9KAOgDrdgZ/73KAw==
X-Received: by 2002:a37:79c5:: with SMTP id u188mr2464299qkc.259.1548264380582;
        Wed, 23 Jan 2019 09:26:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o48sm71253456qtb.87.2019.01.23.09.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:26:19 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:26:18 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Liu Bo <obuil.liubo@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight
 counter
Message-ID: <20190123172612.pv6veqhedoal7wmu@MacBook-Pro-91.local>
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
 <16ab732a-6537-3627-52ed-05013188a3f5@kernel.dk>
 <20190118162117.zqdwjkq74wzsaxn3@macbook-pro-91.dhcp.thefacebook.com>
 <c9fed816-cea1-33f1-017b-10f86df0b8a8@kernel.dk>
 <20190118164312.muk7zdcb5yqn7fdp@macbook-pro-91.dhcp.thefacebook.com>
 <CANQeFDDv=0FNNW_-HyQVTyeaJu4Y6SWbWii1CKNHtux9=VhNjQ@mail.gmail.com>
 <e590d46a-32ec-6531-0618-875ebf1d7bf8@kernel.dk>
 <CANQeFDAtcbmXTe=uad5Vqk=Z83T8Lh9No+xHXSgKJwcKemRiQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQeFDAtcbmXTe=uad5Vqk=Z83T8Lh9No+xHXSgKJwcKemRiQw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 11:52:06PM -0800, Liu Bo wrote:
> On Fri, Jan 18, 2019 at 5:51 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 1/18/19 6:39 PM, Liu Bo wrote:
> > > On Fri, Jan 18, 2019 at 8:43 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > >>
> > >> On Fri, Jan 18, 2019 at 09:28:06AM -0700, Jens Axboe wrote:
> > >>> On 1/18/19 9:21 AM, Josef Bacik wrote:
> > >>>> On Fri, Jan 18, 2019 at 05:58:18AM -0700, Jens Axboe wrote:
> > >>>>> On 1/14/19 12:21 PM, Liu Bo wrote:
> > >>>>>> Our test reported the following stack, and vmcore showed that
> > >>>>>> ->inflight counter is -1.
> > >>>>>>
> > >>>>>> [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
> > >>>>>> [ffffc9003fcc3958] schedule at ffffffff8173de26
> > >>>>>> [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
> > >>>>>> [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
> > >>>>>> [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
> > >>>>>> [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
> > >>>>>> [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
> > >>>>>> [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
> > >>>>>> [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
> > >>>>>> [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
> > >>>>>> [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
> > >>>>>> [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
> > >>>>>> [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
> > >>>>>> [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
> > >>>>>> [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
> > >>>>>> [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
> > >>>>>> [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
> > >>>>>> [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
> > >>>>>> [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
> > >>>>>>
> > >>>>>> The ->inflight counter may be negative (-1) if
> > >>>>>>
> > >>>>>> 0) blk-throttle had been enabled when the IO was issued, so its bio
> > >>>>>> has a associated blkg,
> > >>>>>>
> > >>>>>> 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
> > >>>>>> in this blkg was not available by then,
> > >>>>>>
> > >>>>>> 2) blk-iolatency was enabled before this IO reached its endio, so that
> > >>>>>> iolatency_grp became available when the IO did the endio.
> > >>>>>>
> > >>>>>> 3) the ->inflight counter is decreased from 0 to -1.
> > >>>>>>
> > >>>>>> This uses atomic_dec_is_positive() instead to avoid the negative
> > >>>>>> inflight counter.
> > >>>>>
> > >>>>> The problem with that is that it'll hide a lot of other issues, too.
> > >>>>> Any way we can either track if this rqw is in flight, and only dec
> > >>>>> if it is, or quiesce when enabling?
> > >>>>>
> > >>>>
> > >>>> I worried about this too, but really the side-effect of allowing more through
> > >>>> because of mis-counting means we just let more IO through.  I think maybe we add
> > >>>> a debug option that we can turn on to see if we're messing up accounting, but in
> > >>>> general I don't see a problem with this approach.
> > >>>
> > >>> The problem is that a problem in accounting elsewhere (like missing increment)
> > >>> will now go unnoticed, which could completely screw it up. An occasional
> > >>> blip like the one described is totally fine, but that's not guaranteed to be
> > >>> the case.
> > >>>
> > >>
> > >> Yeah I agree it's kind of shitty.
> > >>
> > >>>> The problem we're running into here is there's not really a good way to tag a
> > >>>> bio as "seen by io.latency."  We just have to assume if we're on and there's a
> > >>>> bi_blkg associated that we saw it at submit time.  We can't just add a flag for
> > >>>> every io controller that starts tracking inflight io's, so for now I think this
> > >>>> is a reasonable solution.  Thanks,
> > >>>
> > >>> Can we quiesce instead when enabling/disabling?
> > >>
> > >> Actually that's not a bad idea, you want to look into that Liu?  That way we can
> > >> make sure everything is correct always.  Thanks,
> > >>
> > >
> > > Just to confirm, does "quiesce when enabling/disabling" mean "waiting
> > > for inflight IOs to complete when enabling/disabling iolatency"?
> >
> 
> So it might not be an easy thing to quiesce queue because...
> 
> iolatency_set_limit()
>    blkg_conf_prep() // return with rcu and queue's lock
> 
> neither freeze_queue nor quiesce_queue is allowed in rcu reader side context.
> 
> If we do it outside of blkg_conf_prep/finish(), I feel like the
> overhead is more than it worths.

I had to do this for io.weight yesterday, I just put it in
blkg_conf_prep/finish.  I don't think that's unreasonable, it's not like we mess
with settings a lot, it'll get setup on cgroup creation before something is
really doing IO, and saves us if things are running currently.  Thanks,

Josef
