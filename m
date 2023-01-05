Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9539C3DA7A
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 18:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjAESQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 13:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjAESQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 13:16:02 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0B4FCCD;
        Thu,  5 Jan 2023 10:16:01 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z7so20245141pfq.13;
        Thu, 05 Jan 2023 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10MvpkF8hXViHIKUuerudV+3cNcQupsLf0iIclwjeuI=;
        b=mDKbKL18L6Yd5hBjaPEGurxQHiGZ2QprTXgY6J+gn1R/D59qzgwp4N7Qf5/UZAKIsp
         C2u400b2V9e9lP22Om/tb4J7ZCbPOJICOjCz13gDvws+CEOY3IbD+u4rjmIM+0y6UjG8
         8MaydimNcLplCMzjqwEgjACpsHqxM2FZbMkYDVUaZk3LuDZkYDRgH91gBDnkzGVD2T8G
         1AGLR/v+JBHE0wZu+XHdokFy9Iip0QkaoyUYRcsIqqgn1qYULy5UTI0eRdzlbGCUtaPk
         KIk4e49p8PKWdSjOwb1VV52Uok/5HQfeMJcbOKErdEdvO0z7MTStlD1DAWQBmXJWz3fa
         onZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10MvpkF8hXViHIKUuerudV+3cNcQupsLf0iIclwjeuI=;
        b=1/TQhTpKy2U1YhWEnEsIDTADcglbTmlRpqG7EAFAcdY9W9Ei7h2q0BAuxulCEZ/lPn
         ALgjuebCczfinsAv2HlOR2mX/7Y7vH7SjwbpWgMIZxZWCQWd+MSy94LzOJDLHfDT/w8V
         caoDvejLNC2ARKJZMhkkhIQzHBZK5Qw1R4RJU0nS5g1bAIa+USQemin24PzG0iDHCvKR
         c9Pj/MowUAIghe1DtN8yUIYkg9RsuixmzBmDb/fYwjaj7S4d+gotQsWXKkRCks6Qvh5E
         H99cWVjayp9eWQ1I1MhJrRPaGhbFqa/ewTaSfZqpA6Np5kXUDV4CVK5PPNwwzh6c6do7
         svag==
X-Gm-Message-State: AFqh2kpcrwrBOrCuUZh31nIWBUtwS7UKpmbVQnleYuAuCcyxXdAK7jNo
        eF/58GbA3dSoe5Jy1lLazbg=
X-Google-Smtp-Source: AMrXdXs6Vr1TqAuaUz8B4kLHvB5Nfz5G7o5pmtNMyRy77ZCCDEM7Hal0z7Q/kNdXFVKQcnFxxAErKQ==
X-Received: by 2002:aa7:99cb:0:b0:580:d188:f516 with SMTP id v11-20020aa799cb000000b00580d188f516mr50716268pfi.19.1672942560272;
        Thu, 05 Jan 2023 10:16:00 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p5-20020a622905000000b005749f5d9d07sm25419078pfp.99.2023.01.05.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:15:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 08:15:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v7 0/7] Improve libata support for FUA
Message-ID: <Y7cT3SSssHzBYqU4@slm.duckdns.org>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <Y7WuEqMgySOCCTqy@slm.duckdns.org>
 <79260c74-92dd-2cdf-ad71-e70d9fa0f8a9@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79260c74-92dd-2cdf-ad71-e70d9fa0f8a9@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Jan 05, 2023 at 12:43:06PM +0900, Damien Le Moal wrote:
> > These optional features tend to be broken in various and subtle ways,
> 
> FUA is not optional for any drive that supports NCQ. The FUA bit is a
> mandatory part of the FPDMA READ/WRITE commands. The optional part is
> support for the non-ncq WRITE FUA EXT command.

Optional in the sense that it isn't essential in achieving the main function
of the device, which means that most don't end up using it.

> > especially the ones which don't show clear and notable advantages and thus
> > don't get used by everybody. I'm not necessarily against enabling it by
> > default but we should have better justifications as we might unnecessarily
> > cause a bunch of painful and subtle failures which can take a while to sort
> > out.
> 
> Avoiding regressions is always my highest priority. I know that there
> are a lot of cheap ATA devices out there that have questionable ACS spec
> compliance.

A lot of historical devices too which don't get much scrutiny or testing but
can still cause significant griefs for the users.

> > * Can the advantages of using FUA be demonstrated in a realistic way? IOW,
> >   are there workloads which clearly benefit from FUA? My memory is hazy but
> >   we only really use FUA from flush sequence to turn flush, write, flush
> >   sequence into flush, FUA-write. As all the heavy lifting is done in the
> >   first flush anyway, I couldn't find a case where that optimization made a
> >   meaningful difference but I didn't look very hard.
> 
> The main users in kernel are file systems, when committing
> transactions/metadata journaling. Given that this is generally not
> generating a lot of traffic, I do not think we can measure any
> difference for HDDs. The devices are too slow to start with, so saving
> one command will not matter much, unless the application is fsync()
> crazy (and even then, not sure we'll see any difference). Even for SATA
> SSDs it likely will be hard to see a difference I think.

On a quick glance, there are some uses of REQ_FUA w/o REQ_PREFLUSH which
indicates that there can be actual gains to be had. However, ext4 AFAICS
always pairs PREFLUSH w/ FUA, so a lot of use cases won't see any gain while
taking on the possible risk of being exposed to FUA commands.

> Then we have applications using the drive block device file directly.
> For these, it is hard to tell how much it matters. Enabling it by
> default with a drive correctly supporting it will very much likely not
> hurt though.
> 
> Maciej,
> 
> May be you did some experiments before asking for enabling FUA by
> default ? Any interesting performance data you can share ?
> 
> > * Do we know how widely FUA is used now? IOW, is windows using FUA by
> >   default now? If so, do we know whether they have a blocklist?
> 
> You mean "blacklist" ? I do not have any information about Windows, but

The PC thing to say now seems to be allowlist / blocklist instead of
whiltelist / blacklist, not that I mind either way.

> I can try to find out, at least for my employer's devices. But that will
> not be very useful as I know these drives behave correctly.

So, AFAIK, windows doesn't issue FUA for SATA devices, only SAS, but I could
be wrong. It'd be really useful to find out.

> More than Windows or the kernel, I think that looking at SAS HBAs is
> more important here. SATA HDDs are the most widely used type of devices
> with these, by far. These may have a SAT translating FUA scsi writes to
> FUA NCQ FPDMA writes, resulting in FUA being extensively used. Modulo a
> blacklist that results in the same as the kernel with a
> flush/write/flush sequence. Hard to know as HBA's FW are not open. A bus
> analyzer could tell us that though, but again I can look at that only
> with the drives I have, which I know are working well with FUA.
> 
> I am OK with attempting enabling FUA by default for the following reasons:
> 1) The vast majority of drives in libata blacklist (all features) are
> old models that are not sold anymore.

The context here is that we promptly found all of these devices struggle
with FUA (like locking up and dropping off the bus) shortly after we enabled
FUA by default, so the list is by no means exhaustive and is more an
indication that there at least were a whole lot of devices which choke on
FUA. On top, devices not sold anymore are even harder to debug and pay
attention to while being able to cause a lot of pain to configurations which
have been stable and happy for a long time.

> 2) We are restricting FUA support to drives that also support NCQ, that
> is, modern-ish ones that are supposed to process the FUA NCQ read/write
> commands correctly, per specs.

NCQ is really old now and our previous attempt at FUA was after NCQ was
widely available, so I'm not sure this holds.

> 3) For HDDs, which is the vast majority of ATA devices out there these
> days, all recent drives I have tested are OK. Even older ones with NCQ
> support that I have access to are fine.
> 4) We are at rc2, which gives us time to revert patch 7 if we see too
> many bug reports.

This sort of problems especially if affecting mostly old devices can be very
difficult to suss out and will definitely take way longer than a single
release cycle.

> One thing we could add to the patch series is an additional restriction
> to enabling FUA by default to drives that support a recent standard. Say
> ACS-4 and above. That will restrict this to recent devices, thus
> reducing the risk of hitting bad apples. Thoughts ?

Yeah, that'd help and also if SAS HBA SAT's have been issuing FUA's which
would be a meaningful verification of the feature, at least for rotating
hard disks.

I feel rather uneasy about enabling FUA by default given history. We can
improve its chances by restricting it to newer devices and maybe even just
hard disks, but it kinda comes back to the root question of why. Why would
we want to do this? What are the benefits? Right now, there are a bunch of
really tricky cons and not whole lot on the pro column.

Thanks.

-- 
tejun
