Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFA8C433DF
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495BD2073B
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 16:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goDmTWmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEZQUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEZQUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 12:20:16 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B6C03E96D
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 09:20:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e7so12144414vsm.6
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1lFxIAJ9dpaucvsxWY6az6Xo7utzX7wkq2rEO3BC1Y=;
        b=goDmTWmfSUcurp0dgIS0zO6w//UllpIncUVrLajyRx7m1Ye6kvllVJXNjph7nNQx9C
         mWRxpo4fRan7W+Y12VHWbYRBQFrCJ7q34UDLgwhjMbxS2wCHruXFJ2AjCen2PZldsLXU
         dYpqRqcb/gIcABsL4FVPoCrMhmvf2EYF/UCv6Kpf7vRpyrZGs4LV3Qkxnz/0K2RSHR0R
         kU936UnqQ/xk6niArDCuSu2mXD3jO/ilxW7ivh9HN5hOl8JuQ8gMI1UUv6dfFbFPe27q
         1RKJjQdKn0UAqzJa/GtWC4fKjvSrBnd5PlJTyv5d00fbOQYjnNmlZnLrPXSa51AOCOVt
         hP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1lFxIAJ9dpaucvsxWY6az6Xo7utzX7wkq2rEO3BC1Y=;
        b=DUN9EaLDKBPmBFC+6sbtg6wM321IBCya2RrssJ47cG7MAJ0dBisyxYLnL4H+xASPCJ
         MhNyzcApGc4x0fCG0l5iV5H67S4KrAfAe6HnK0kXAfB5NZFwXi69axd6hvxuklJ5ZdTj
         Q7d97JkI9VCe+qI5jr1Z7/hw5sjg6HK5l8uvmHBU4h8T7CRLKwD3fzpKI+cg59RsZl/A
         JhmWaZ3R8fZPBsQn1AHbq3VXKj22gIrtK1q8btp5BX8oxlnr/UN1IL6u8dxqDevmujJz
         Xa8bBdTWUpHGftwD0qQJfUWlSGrCXNjv3kenn0Xe+PeN9t5JlK1JW/o1jPSJkNe9zYkb
         PvEQ==
X-Gm-Message-State: AOAM530jNpuXKka/6t8nzuwDCYtQVKyuduRduZX0FBJV1S6FlW9AX2KD
        UpZNCPqaMAbo0LsZ5SGDXoBr2PtV
X-Google-Smtp-Source: ABdhPJxVbjLI1xbehMbsY/N/slH7uHIGHc6YcymwZG/7jpRYUbo7/lmL01ViN0Vou/xNrxsPhnLfKg==
X-Received: by 2002:a67:f557:: with SMTP id z23mr1637751vsn.32.1590510015536;
        Tue, 26 May 2020 09:20:15 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id n17sm25736vkn.29.2020.05.26.09.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:20:14 -0700 (PDT)
Date:   Tue, 26 May 2020 16:20:13 +0000
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     dennisszhou@gmail.com, linux-block@vger.kernel.org
Subject: Re: question about the usage of avg_lat in io latency controller
Message-ID: <20200526162013.GA37786@google.com>
References: <CAAJeciW0LHV5=Fsq4RSxVWBtJKu7Y3-B5Lh06nZ-yhCfzXfSCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJeciW0LHV5=Fsq4RSxVWBtJKu7Y3-B5Lh06nZ-yhCfzXfSCw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue, May 26, 2020 at 07:27:34PM +0800, xiaohui li wrote:
> hi Dennis Zhou and other who are familiar with io latency controller :
> 
> i have a question about the io latency controller :
> how to configure the min latency value of a blk cgroup ?
> using the avg_lat value may be not right.
> 
> from the Documentation/admin-guide/cgroup-v2.rst, i know we can do
> configuring work in this way:
> -------------------
> Use the avg_lat value as a basis for
> your real setting, setting at 10-15% higher than the value in io.stat
> -------------------
> 
> but when i have found  the avg_lat value is the total sum of running
> average of io latency in the past time, and it can't reflect the
> average time cost of per single IO request.
> but whether one thread can be throttled depends on the compare result
> of stat.mean and iolat->min_lat_nsec.
> and stat.mean can reflect the average time cost of per single IO request.
> 
> so from above analysis, if do the configuring min io latency value
> work of a blk group, use the avg_lat may not be appropriate, because
> it is the total sum of running average.
> why not make use of the stat.mean to do the configuring min io latency
> value work ?
> 

The logic isn't perfect. The idea is that you only care about this
metric when the device under some constant load. For spinning disks,
it's calculated by contributing the average latency of an interval
cur_win_nsec's long to an exponential moving average. See
iolat_update_total_lat_avg().

> one experiment on my device:
> cat io.stat
> 8:0 rbytes=586723328 wbytes=99248033792 rios=143243 wios=331782
> dbytes=0 dios=0 use_delay=12 delay_nsec=0 depth=1 avg_lat=11526
> win=800
> 
> so the avg_lat value 11526(ns) is so big, it can't be the average time
> cost of per single IO request on our device.
> so it can not be used for do the configuring min io latency value work.
> 

Yeah so I can't remember if this change preceeded the other change, but
timing is now calculated based on issue time which comes the time marked
before it enters the block layer. This means it includes any delays that
have been incurred. But from the output, you can see that you're at
depth=1 and use_delay=12 meaning it is in play iirc.

To get the value you're looking for, we'd have to plumb through
rq->io_start_time_ns. There is an inherent mismatch here as
blk-iolatency works at the bio layer and not the request layer.

However, blk-iolatency is meant to protect a single cgroup from the
system. In this case, it seems like given your workload, workload + the
workload on the system is saturating the disk. Meaningfully, someone
else is throttling you as their iolatency is being violated. I'd
consider switching to iocost for a proportional io controller.

> Maybe I'm not familiar with the io latency controller code.
> If any mistake exist in my above analysis, welcome to add your suggestions.

Thanks,
Dennis
