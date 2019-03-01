Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A60C43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BD12085A
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 10:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfCAKHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:07:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38158 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbfCAKHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 05:07:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so4661026wmf.3
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2019 02:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dNyRfuVJyEfPaZdjKe6H6F+atvqnTYUCX9VrFSpggQ0=;
        b=Hw8amqAk6wP/92LU6bHH9pMhgSb+OV5sIQHvR6tNVZfOscpgibZELKb35251xQD5e5
         by7fl+Go7Mknwd/OZE37l+/puZ44bgr48Epw1XWZ5GtmfFQKMOCuyVWCSc1lFEKX7nv/
         t7LmrD/P5eQJUS3QTtWnjdiWqp2Tv0QamdmCS+ASFpYk/Tspjmax7AJ6XuJTU9OtUUpR
         t7AdNd7Bu0kM9t6dRXFiY9z4AqGs2Pu0TbfHE9yVStuqhtpWstr1FCk1/ggXmF4HT0OL
         3K/mUPklSLCSPgOAZrqacaPsJBlqQSvmicnh/g/98GM/gyiC2Lfqw4yL0HKEGcgwe4TB
         cj6Q==
X-Gm-Message-State: AHQUAuZ+bVud2jmzAwVDp5ieI/2qDDB/mrbAplM35zVsLvCjMeAa0L6q
        SsrR0UPaDj5OE8ig8sqngvZxvg==
X-Google-Smtp-Source: APXvYqwUiZ48fQ/ERonfMNFwq1+EtalCARF63jcPoi78PsK0bVCE/CEmuxx9eU8seGBjly11BlwRrg==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr2652750wme.125.1551434857392;
        Fri, 01 Mar 2019 02:07:37 -0800 (PST)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id e193sm16401182wmg.18.2019.03.01.02.07.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 01 Mar 2019 02:07:36 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:07:34 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        tom.leiming@gmail.com
Subject: Re: [PATCH V2] fs: fix guard_bio_eod to check for real EOD errors
Message-ID: <20190301100734.rcu6a274j67wi6xl@pegasus.maiolino.io>
References: <20190226105150.10717-1-cmaiolino@redhat.com>
 <961fc518-616e-f13d-2acf-c78807109a6e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961fc518-616e-f13d-2acf-c78807109a6e@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 28, 2019 at 02:00:17PM -0700, Jens Axboe wrote:
> On 2/26/19 3:51 AM, Carlos Maiolino wrote:
> > guard_bio_eod() can truncate a segment in bio to allow it to do IO on
> > odd last sectors of a device.
> > 
> > It already checks if the IO starts past EOD, but it does not consider
> > the possibility of an IO request starting within device boundaries can
> > contain more than one segment past EOD.
> > 
> > In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
> > underflow bvec->bv_len.
> > 
> > Fix this by checking if truncated_bytes is lower than PAGE_SIZE.
> > 
> > This situation has been found on filesystems such as isofs and vfat,
> > which doesn't check the device size before mount, if the device is
> > smaller than the filesystem itself, a readahead on such filesystem,
> > which spans EOD, can trigger this situation, leading a call to
> > zero_user() with a wrong size possibly corrupting memory.
> > 
> > I didn't see any crash, or didn't let the system run long enough to
> > check if memory corruption will be hit somewhere, but adding
> > instrumentation to guard_bio_end() to check truncated_bytes size, was
> > enough to see the error.
> > 
> > The following script can trigger the error.
> > 
> > MNT=/mnt
> > IMG=./DISK.img
> > DEV=/dev/loop0
> > 
> > mkfs.vfat $IMG
> > mount $IMG $MNT
> > cp -R /etc $MNT &> /dev/null
> > umount $MNT
> > 
> > losetup -D
> > 
> > losetup --find --show --sizelimit 16247280 $IMG
> > mount $DEV $MNT
> > 
> > find $MNT -type f -exec cat {} + >/dev/null
> > 
> > Kudos to Eric Sandeen for coming up with the reproducer above
> > 
> > Changelog:
> > 
> > 	V2: Compare truncated_bytes agains bvec->bv_len instead of
> > 	    PAGE_SIZE
> 
> Applied - note I snipped your changelog, that should go below the ---
> lines to not end up in the commit message.
> 

Thanks Jens, and my apologies, I'll make sure to add the Changelog below the
cutting line next time.

> -- 
> Jens Axboe
> 

-- 
Carlos
