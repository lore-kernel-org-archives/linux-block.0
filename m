Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFD6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 20:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiI2Usd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiI2Usb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 16:48:31 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33080155402
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 13:48:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VR.8PdO_1664484505;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VR.8PdO_1664484505)
          by smtp.aliyun-inc.com;
          Fri, 30 Sep 2022 04:48:27 +0800
Date:   Fri, 30 Sep 2022 04:48:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 0/4] brd: implement discard
Message-ID: <YzYEmZH7GKlw3QoP@B-P7TQMD6M-0146.local>
Mail-Followup-To: Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <YyqfHfadJvxbB/JC@B-P7TQMD6M-0146.local>
 <alpine.LRH.2.02.2209271006590.28431@file01.intranet.prod.int.rdu2.redhat.com>
 <YzOdau9e5HYcjQKf@B-P7TQMD6M-0146.local>
 <alpine.LRH.2.02.2209291600540.7875@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209291600540.7875@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 04:05:43PM -0400, Mikulas Patocka wrote:
> 
> 
> On Wed, 28 Sep 2022, Gao Xiang wrote:
> 
> > > Hi
> > > 
> > > Ramdisk DAX was there in the past, but it was removed in the kernel 4.15.
> > 
> > Hi Mikulas!
> > 
> > Thanks for pointing out! I didn't realize that, although I think if we really
> > use brd driver in production, enabling DAX support for brd is much better to
> > remove double caching so that ramdisk can become a real ramdisk for most
> > regular files.
> > 
> > I have no idea how other people think about ramdisk DAX, or brd is just a
> > stuff for testing only now.  If it behaves like this, sorry about the
> > noise.
> > 
> > Thanks,
> > Gao Xiang
> 
> Hi
> 
> See the message for the commit 7a862fbbdec665190c5ef298c0c6ec9f3915cf45 
> for the reason why it was removed.

I've already seen that commit after you told me, yet I think the reasons
listed inside are not fundamental reasons why ramdisk cannot support DAX
in principle (although I know there are issues as listed to handle.)

IMHO, reserving ZONE_DEVICE memory to emulate pmem for ramdisk DAX-like
use is inflexible on my side since currently such reserved memory cannot
be used for other uses later even the ramdisk actually use little space
in practice regardless of its capacity.

Thanks,
Gao Xiang

> 
> Mikulas
