Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21DC07E9D
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 01:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiI1BD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 21:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiI1BDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 21:03:44 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B71E0C4D
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 18:03:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQtdSE5_1664327018;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQtdSE5_1664327018)
          by smtp.aliyun-inc.com;
          Wed, 28 Sep 2022 09:03:40 +0800
Date:   Wed, 28 Sep 2022 09:03:38 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 0/4] brd: implement discard
Message-ID: <YzOdau9e5HYcjQKf@B-P7TQMD6M-0146.local>
Mail-Followup-To: Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <YyqfHfadJvxbB/JC@B-P7TQMD6M-0146.local>
 <alpine.LRH.2.02.2209271006590.28431@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209271006590.28431@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 10:09:04AM -0400, Mikulas Patocka wrote:
> 
> 
> On Wed, 21 Sep 2022, Gao Xiang wrote:
> 
> > On Tue, Sep 20, 2022 at 01:52:38PM -0400, Mikulas Patocka wrote:
> > > Hi
> > > 
> > > Here I'm sending second version of the brd discard patches.
> > 
> > That is quite interesting.
> > 
> > btw, something out of topic, I once had some preliminary attempt
> > to add DAX support to brd since brd works as ramdisk and brd-dax
> > could have the following benefits:
> > 
> >  - DAX can be tested without PMEM devices;
> >  - ramdisk fses can be accessed without double page cache;
> >  - initrd use cases then can work well without extra page cache
> >    and maybe it can perform better than initramfs (without unpack
> >    process).
> > 
> > I wrote some hack stuff but don't have more time working on it...
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/initrd-fsdax
> > 
> > I'm not sure if others are interested in topic though.
> > 
> > It would be helpful to get rid of all brd page->index use cases
> > first.
> > 
> > Thanks,
> > Gao Xiang
> 
> Hi
> 
> Ramdisk DAX was there in the past, but it was removed in the kernel 4.15.

Hi Mikulas!

Thanks for pointing out! I didn't realize that, although I think if we really
use brd driver in production, enabling DAX support for brd is much better to
remove double caching so that ramdisk can become a real ramdisk for most
regular files.

I have no idea how other people think about ramdisk DAX, or brd is just a
stuff for testing only now.  If it behaves like this, sorry about the
noise.

Thanks,
Gao Xiang

> 
> Mikulas
