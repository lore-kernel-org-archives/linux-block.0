Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D12C433E1
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007F32072E
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zb0a4IXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFDH2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgFDH2r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 03:28:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80474C05BD1E
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 00:28:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so4873318wru.12
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 00:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcR+p2aqynDC6hdpbjatYKqB7lnaf2TVTcZxrW9wkJ8=;
        b=Zb0a4IXzLUSWE7c899RieIrz2yAeS7PSFSlKymHYfU6bYWdWQ4N/biWdxEFx320+Lu
         Tm2SwDP3Zf3dT++Y45bxahozjksznuodBEVCDX3ty4vYumG0MjH5rhcZf7dQ81Bnzc/J
         SUdbNZ9d7/H4Q7YOE1kd2VefVYRBii3eihoKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PcR+p2aqynDC6hdpbjatYKqB7lnaf2TVTcZxrW9wkJ8=;
        b=qDf1aO35RvEFqSRkWBkcjO87XO+9HA3gUPbLrC9R2+R1kb/r9h0Hr8OEB7xdxidN6H
         TKfTrYEJgXFyh37mriED2w9s/H/RKaBQ8Ltn9ND+r9Xmvm2hWiFDyb1GobQjjtp2r/VX
         h/EO8x6VTMGggo1hjstcvkJecUIiwcogI+uxnKsJU08Jl4nsqePspHKekziZfFd+51GN
         yJvOeyFe2tZlmupvYHHVPLVyQUe7qc3JTuBFCtjCrJtQIPmYP9zOe9zbKVBkzdhv9FcI
         +LwBhJW9HjgG9jjyBekP9BsXl9beY6SZnmFKbH/vYohLWZAfq7l68zf1T1X6v/FdRfce
         Tl5w==
X-Gm-Message-State: AOAM532eUrfpLc4jPcRtygbh4e2gycZxtd7pUdsLKN4ee1UEuqquEBCb
        43iCdduOeSFWaNr/6G1CtENIHg==
X-Google-Smtp-Source: ABdhPJzR++BcxQdCdbYMaFBVBu37Z3AiOCBNnPIbstbCVZxnXHdyEel0ruVeUnaQJ43wOmRp2FlHew==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr3056955wrm.34.1591255725227;
        Thu, 04 Jun 2020 00:28:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b8sm6876269wrs.36.2020.06.04.00.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:28:44 -0700 (PDT)
Date:   Thu, 4 Jun 2020 09:28:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/6] seqlock: seqcount_t call sites bugfixes
Message-ID: <20200604072841.GR20149@phenom.ffwll.local>
Mail-Followup-To: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603144949.1122421-1-a.darwish@linutronix.de>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 03, 2020 at 04:49:43PM +0200, Ahmed S. Darwish wrote:
> Hi,
> 
> Since patch #7 and #8 from the series:
> 
>    [PATCH v1 00/25] seqlock: Extend seqcount API with associated locks
>    https://lore.kernel.org/lkml/20200519214547.352050-1-a.darwish@linutronix.de
> 
> are now pending on the lockdep/x86 IRQ state tracking patch series:
> 
>    [PATCH 00/14] x86/entry: disallow #DB more and x86/entry lockdep/nmi
>    https://lkml.kernel.org/r/20200529212728.795169701@infradead.org
> 
>    [PATCH v3 0/5] lockdep: Change IRQ state tracking to use per-cpu variables
>    https://lkml.kernel.org/r/20200529213550.683440625@infradead.org
> 
> This is a repost only of the seqcount_t call sites bugfixes that were on
> top of the seqlock patch series.
> 
> These fixes are independent, and can thus be merged on their own. I'm
> reposting them now so they can at least hit -rc2 or -rc3.

I'm confused on what I should do with patch 6 here for dma-buf. Looks like
just a good cleanup/prep work, so I'd queue it for linux-next and 5.9, but
sounds like you want this in earlier. Do you need this in 5.8-rc for some
work meant for 5.9? Will this go in through some topic branch directly?
Should I apply it?

Patch itself lgtm, I'm just confused what I should do with it.
-Daniel

> 
> Changelog-v2:
> 
>   - patch #1: Add a missing up_read() on netdev_get_name() error path
>               exit. Thanks to Dan/kbuild-bot report.
> 
>   - patch #4: new patch, invalid preemptible context found by the new
>               lockdep checks added in the seqlock series + kbuild-bot.
> 
> Thanks,
> 
> 8<--------------
> 
> Ahmed S. Darwish (6):
>   net: core: device_rename: Use rwsem instead of a seqcount
>   net: phy: fixed_phy: Remove unused seqcount
>   u64_stats: Document writer non-preemptibility requirement
>   net: mdiobus: Disable preemption upon u64_stats update
>   block: nr_sects_write(): Disable preemption on seqcount write
>   dma-buf: Remove custom seqcount lockdep class key
> 
>  block/blk.h                    |  2 ++
>  drivers/dma-buf/dma-resv.c     |  9 +------
>  drivers/net/phy/fixed_phy.c    | 26 ++++++++------------
>  drivers/net/phy/mdio_bus.c     |  2 ++
>  include/linux/dma-resv.h       |  2 --
>  include/linux/u64_stats_sync.h | 43 ++++++++++++++++++----------------
>  net/core/dev.c                 | 40 ++++++++++++++-----------------
>  7 files changed, 56 insertions(+), 68 deletions(-)
> 
> base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
> --
> 2.20.1

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
