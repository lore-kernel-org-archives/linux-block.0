Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE4C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76521655
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdFYNx5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfLLQPt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:15:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34190 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLQPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 11:15:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so1392479pgf.1;
        Thu, 12 Dec 2019 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=68gsX21jtww7BTikHhzN0eWHN8+olb+7I9zctus38OA=;
        b=fdFYNx5VvbRzbMylzz0W2hyLknNtYLVLuq9VVIYIN/ammuCZG4BusZ5TKn4lYkLd9N
         LywSfQARrv/gSZse1tUoK7YSqwUcP0dDpiuFwNXZTvcwc7o81ZTw2z9Y5EMVLiBmeY/u
         5hqNuqPHA2/k3hd6YXb+yRRis8flHe/GeI8PjXu01/h5YYUPIEhaUrhbW7ZuVvicnmSm
         JltOuqzl0owoerYQ3Ir23td2KzFNk6yVDKXwyiQxfi750v0W9eYiYiswt92X+I4Bfgyb
         cM55S2Wtvoruq/CFIV+EI1Q6dwPnUJ9Ury3N3rlyRCdqMw4FAPIqm5Kw+mKTpy5/9EzX
         hrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=68gsX21jtww7BTikHhzN0eWHN8+olb+7I9zctus38OA=;
        b=n5B9M3L/hpf2p1/zhDonBb4pGAaYBHoSIZjigoUen1ObkBNqP8cnSa+LOLq2HBXZTe
         CXhTfR5oL703XhfygB0cy2x8WEfnRDWyhnJtYwRRxRRsdkOXr+uCYF9Z5ZXHnqpJWJhP
         vvCG/3Iqq4sd2g5p+LjfdxvGmun0K3crYtnb1oWEhexyJJBgvzgqzmVbHPx95/OqF/g/
         62x37nxaX2QOI10zsU+u5WvflOjcjGv/2VnfCzN1zSgaKjfiQP91Yx1D+8cggOeIBcxw
         MNEYu3PxYXsoUJeCJP3/tM6GYlSjd6NdjPLV7NqF2yoAxlb5xbWPelRU+YK73l7Ym6EK
         OUkQ==
X-Gm-Message-State: APjAAAWCRZ2HN6NXWK2kxVhzAYBmFKGETEODvrT7pW9KlCLMQkkJZWyS
        HrJ00vuBXwu5maNzNEh+4cA=
X-Google-Smtp-Source: APXvYqzAhBSsqgXIB3EREPb06Ubmyza9cZ//120noUYsHwdj8039lOqC3PCyzCpO/LKrVcBD667fqw==
X-Received: by 2002:a63:9d85:: with SMTP id i127mr10794603pgd.186.1576167348060;
        Thu, 12 Dec 2019 08:15:48 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id i4sm6459079pjd.19.2019.12.12.08.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 08:15:47 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     jgross@suse.com, axboe@kernel.dk, sjpark@amazon.com,
        konrad.wilk@oracle.com, pdurrant@amazon.com,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Thu, 12 Dec 2019 17:15:37 +0100
Message-Id: <20191212161537.10756-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191212152317.GE11756@Air-de-Roger> (raw)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 12 Dec 2019 16:23:17 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> > On Thu, 12 Dec 2019 12:42:47 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> > > > On the slow block device
> > > > ------------------------
> > > > 
> > > >     max_pgs   Min       Max       Median     Avg    Stddev
> > > >     0         38.7      45.8      38.7       40.12  3.1752165
> > > >     1024      38.7      45.8      38.7       40.12  3.1752165
> > > >     No difference proven at 95.0% confidence
> > > > 
> > > > On the fast block device
> > > > ------------------------
> > > > 
> > > >     max_pgs   Min       Max       Median     Avg    Stddev
> > > >     0         417       423       420        419.4  2.5099801
> > > >     1024      414       425       416        417.8  4.4384682
> > > >     No difference proven at 95.0% confidence
> > > 
> > > This is intriguing, as it seems to prove that the usage of a cache of
> > > free pages is irrelevant performance wise.
> > > 
> > > The pool of free pages was introduced long ago, and it's possible that
> > > recent improvements to the balloon driver had made such pool useless,
> > > at which point it could be removed instead of worked around.
> > 
> > I guess the grant page allocation overhead in this test scenario is really
> > small.  In an absence of memory pressure, fragmentation, and NUMA imbalance,
> > the latency of the page allocation ('get_page()') is very short, as it will
> > success in the fast path.
> 
> The allocation of the pool of free pages involves more than get_page,
> it uses gnttab_alloc_pages which in the worse case will allocate a
> page and balloon it out issuing one hypercall.
> 
> > Few years ago, I once measured the page allocation latency on my machine.
> > Roughly speaking, it was about 1us in best case, 100us in worst case, and 5us
> > in average.  Please keep in mind that the measurement was not designed and
> > performed in serious way.  Thus the results could have profile overhead in it,
> > though.  While keeping that in mind, let's simply believe the number and ignore
> > the latency of the block layer, blkback itself (including the grant
> > mapping), and anything else including context switch, cache miss, but the
> > allocation.  In other words, suppose that the grant page allocation is only one
> > source of the overhead.  It will be able to achieve 1 million IOPS (4KB *
> > 1MIOPS = 4 GB/s) in the best case, 200 thousand IOPS (800 MB/s) in average, and
> > 10 thousand IOPS (40 MB/s) in worst case.  Based on this coarse calculation, I
> > think the test results is reasonable.
> > 
> > This also means that the effect of the blkback's free pages pool might be
> > visible under page allocation fast path failure situation.  Nevertheless, it
> > would be also hard to measure that in micro level unless the measurement is
> > well designed and controlled.
> > 
> > > 
> > > Do you think you could perform some more tests (as pointed out above
> > > against the block device to skip the fs overhead) and report back the
> > > results?
> > 
> > To be honest, I'm not sure whether additional tests are really necessary,
> > because I think the `dd` test and the results explanation already makes some
> > sense and provide the minimal proof of the concept.  Also, this change is a
> > fallback for the memory pressure situation, which is an error path in some
> > point of view.  Such errorneous situation might not happen frequently and if
> > the situation is not solved in short time, something much worse (e.g., OOM kill
> > of the user space xen control processes) than temporal I/O performance
> > degradation could happen.  Thus, I'm not sure whether such detailed performance
> > measurement is necessary for this rare error handling change.
> 
> Right, my main concern is that we seem to be adding duck tape so
> things don't fall apart, but if such cache is really not beneficial
> from a performance PoV I would rather see it go away than adding more
> stuff to it in order to workaround corner cases like memory
> starvation.

Right, if the cache is really giving no benefit, it would be much better to
simply remove it.  However, as mentioned before, I'm not sure whether it is
useless at all.  Maybe we could do some more detailed test to know that, but it
would be an out of scope of this patch.

> 
> Anyway, I guess we can take such change, but long term we need to look
> into fixing grants to not use ballooned pages, and figure out if the
> blkback free page cache is really useful or not.

Totally agreed.


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
