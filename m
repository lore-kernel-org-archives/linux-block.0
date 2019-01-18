Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2182C5AC81
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFA520896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="q2YTYHAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfARTq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:46:57 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45978 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbfARTq4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 14:46:56 -0500
Received: by mail-yb1-f194.google.com with SMTP id n78so4779970yba.12
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MFkcxqAcXhot3Os245eF1rc0vQAiphWw86ob1UWQ9h0=;
        b=q2YTYHAAegi5ptaW78J05ZOkXWPUaP3nvoYIDGyPcsUcbCbJg8idaTsTUpijPRP+bV
         9cAqUzZqRV1rI/m2somnCk2rleXm8+UkiSLvbuQzucLY4IdhjwoPWQVnKSwPrjOwFKpH
         tnI5aiz4RsJKcBxDcjqxh/EzebqevKOWpnBOhH21Fq7msty5LD8IhF8/yY7PTXqW5kXG
         1SwMZOax2F3rU+4mKAQ+7W3nHxJoTOd5XTEsZriHJdoAm1/uRRLRp/3SG4dVIv7nEItv
         Fp0P/RfxDYt9ofH3FdC9nVL3bxUqLrb/82KXRUCP4A3mcu68SaTSA6H3v3gT+n0BXmyh
         xQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MFkcxqAcXhot3Os245eF1rc0vQAiphWw86ob1UWQ9h0=;
        b=tXFOrux+dEnnU+iKB6ocnN99jOWTgZ+iEWn8qzQF7G1gCZQ1bWcdMdqrXua4XE3Ito
         exfz3oI60FhRCn/Zu85f79DFGuhYygCiA8AdmjN1UWLNpy4A5NclTaSxwE6PQ7YcbZdR
         g2fN78qJ79cwe8R48rb/C1MiAdrfWzDRhiVnXDZHVfG+6CHKaOwzjLkQeQ1LyYVdgHoU
         yDT0FZ4qNFsNmDBQ7AcY3dLBS5ezhDBiN2GfqfKY+1wUW0V029DDHPYsnqOC0kfdecx5
         ji1PpR9DswpxGSLFrmO++xGRB8L7R5OdXWxyi8rqGoLRCThwePBH+srtoJ24vMTi4+sC
         Hc6w==
X-Gm-Message-State: AJcUukeNxL1yLiptuPR2Q+VEdxwGifuBGz06Of19FLXnJlZyP1LU2TsT
        fp7VwGd+4Lx4/fFTbK0Kh9VlpQ==
X-Google-Smtp-Source: ALg8bN6m9pyw019l3NyFDRtB3Jbj1HQTOZmWtGGhk7w7RzDYhpY1hoQXXRnmzRkQj5dAq7ZLd61nyA==
X-Received: by 2002:a5b:986:: with SMTP id c6mr7783379ybq.444.1547840815335;
        Fri, 18 Jan 2019 11:46:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:45d9])
        by smtp.gmail.com with ESMTPSA id s35sm2380502ywa.19.2019.01.18.11.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:46:54 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:46:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190118194652.gg5j2yz3h2llecpj@macbook-pro-91.dhcp.thefacebook.com>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <20190118184403.GB1535@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118184403.GB1535@xps-13>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 07:44:03PM +0100, Andrea Righi wrote:
> On Fri, Jan 18, 2019 at 11:35:31AM -0500, Josef Bacik wrote:
> > On Fri, Jan 18, 2019 at 11:31:24AM +0100, Andrea Righi wrote:
> > > This is a redesign of my old cgroup-io-throttle controller:
> > > https://lwn.net/Articles/330531/
> > > 
> > > I'm resuming this old patch to point out a problem that I think is still
> > > not solved completely.
> > > 
> > > = Problem =
> > > 
> > > The io.max controller works really well at limiting synchronous I/O
> > > (READs), but a lot of I/O requests are initiated outside the context of
> > > the process that is ultimately responsible for its creation (e.g.,
> > > WRITEs).
> > > 
> > > Throttling at the block layer in some cases is too late and we may end
> > > up slowing down processes that are not responsible for the I/O that
> > > is being processed at that level.
> > 
> > How so?  The writeback threads are per-cgroup and have the cgroup stuff set
> > properly.  So if you dirty a bunch of pages, they are associated with your
> > cgroup, and then writeback happens and it's done in the writeback thread
> > associated with your cgroup and then that is throttled.  Then you are throttled
> > at balance_dirty_pages() because the writeout is taking longer.
> 
> Right, writeback is per-cgroup and slowing down writeback affects only
> that specific cgroup, but, there are cases where other processes from
> other cgroups may require to wait on that writeback to complete before
> doing I/O (for example an fsync() to a file shared among different
> cgroups). In this case we may end up blocking cgroups that shouldn't be
> blocked, that looks like a priority-inversion problem. This is the
> problem that I'm trying to address.

Well this case is a misconfiguration, you shouldn't be sharing files between
cgroups.  But even if you are, fsync() is synchronous, we should be getting the
context from the process itself and thus should have its own rules applied.
There's nothing we can do for outstanding IO, but that shouldn't be that much.
That would need to be dealt with on a per-contoller basis.

> 
> > 
> > I introduced the blk_cgroup_congested() stuff for paths that it's not easy to
> > clearly tie IO to the thing generating the IO, such as readahead and such.  If
> > you are running into this case that may be something worth using.  Course it
> > only works for io.latency now but there's no reason you can't add support to it
> > for io.max or whatever.
> 
> IIUC blk_cgroup_congested() is used in readahead I/O (and swap with
> memcg), something like this: if the cgroup is already congested don't
> generate extra I/O due to readahead. Am I right?

Yeah, but that's just how it's currently used, it can be used any which way we
feel like.

> 
> > 
> > > 
> > > = Proposed solution =
> > > 
> > > The main idea of this controller is to split I/O measurement and I/O
> > > throttling: I/O is measured at the block layer for READS, at page cache
> > > (dirty pages) for WRITEs, and processes are limited while they're
> > > generating I/O at the VFS level, based on the measured I/O.
> > > 
> > 
> > This is what blk_cgroup_congested() is meant to accomplish, I would suggest
> > looking into that route and simply changing the existing io controller you are
> > using to take advantage of that so it will actually throttle things.  Then just
> > sprinkle it around the areas where we indirectly generate IO.  Thanks,
> 
> Absolutely, I can probably use blk_cgroup_congested() as a method to
> determine when a cgroup should be throttled (instead of doing my own
> I/O measuring), but to prevent the "slow writeback slowing down other
> cgroups" issue I still need to apply throttling when pages are dirtied
> in page cache.

Again this is just a fuckup from a configuration stand point.  The argument
could be made that sync() is probably broken here, but I think the right
solution here is to just pass the cgroup context along with the writeback
information and use that if it's set instead.  Thanks,

Josef
