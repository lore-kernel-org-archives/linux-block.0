Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B25C32771
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 05:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIUFUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIUFUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 01:20:37 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F0386B4
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 22:20:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQMUhZC_1663737630;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQMUhZC_1663737630)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 13:20:32 +0800
Date:   Wed, 21 Sep 2022 13:20:29 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 0/4] brd: implement discard
Message-ID: <YyqfHfadJvxbB/JC@B-P7TQMD6M-0146.local>
Mail-Followup-To: Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 01:52:38PM -0400, Mikulas Patocka wrote:
> Hi
> 
> Here I'm sending second version of the brd discard patches.

That is quite interesting.

btw, something out of topic, I once had some preliminary attempt
to add DAX support to brd since brd works as ramdisk and brd-dax
could have the following benefits:

 - DAX can be tested without PMEM devices;
 - ramdisk fses can be accessed without double page cache;
 - initrd use cases then can work well without extra page cache
   and maybe it can perform better than initramfs (without unpack
   process).

I wrote some hack stuff but don't have more time working on it...
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/initrd-fsdax

I'm not sure if others are interested in topic though.

It would be helpful to get rid of all brd page->index use cases
first.

Thanks,
Gao Xiang

> 
> Mikulas
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
