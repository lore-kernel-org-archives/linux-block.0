Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4751FC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 20:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26196613BC
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 20:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhD0Utw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhD0Uts (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 16:49:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A8C061760
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 13:49:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s15so71619848edd.4
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
        b=qEfkSh7MGE8PVxlqCWGjjSgsiEnsnVBnvrjRNNxqQEj5HU0k4aWay+siPtJdTOW5Xf
         zVOpXzCXY0HakOzD/zAOFn8Rvsn7R9MMypGaIbyqQ5mvyZd62oAMQzRju3r4ZZ6Dbh4Z
         PGwXTw7U7ke5bt4PusVhU/FjOe6PO8GyPwyQEOdOvEKEQO2whSN6EREZEHU4BumJ0tUN
         wYRqkBp8E0mktosAXmG+bLKjKBN+4yGMkELK1CaFKSqtKceOXNV5kbTOZ4Y9znDBNz7U
         OaKb8R39/BDxfS854M5MpP4bM8rl5sKWIpgUHtqb2i2Vtr8Gvv6JoSyU7i78Aj09c75j
         QnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
        b=g/omApq9W5bkGKNA2cNJaAxEZunXQANlSqwcT3hridE0EBaBgJQbvvofBveslk1nJi
         8BbXNG17dSdeaOnIJO0/k+JzFzjI1vLT8Ve1vTLzI6dIHnimsiLV9oTv9KDILU6Qf1mN
         4h9HtNMmVPmPqCVBhzMrHK6aMFxVYXqIATUOhLG1nh+k1d6blrfQgyIVb11TB0RH3OYj
         one7u6Sw8mRiZrAFFrxL3UOU0nIH5TD6MyUnJT+/kf9R4KiDNFsLDLYDyaHmPuYGQGEU
         fL4x8hiq2ka5cL0UfY79slPjLaBIu06Yog8HwhqFcX1ofjNjJULm+N/LtYOyeyPIhGJZ
         h3xA==
X-Gm-Message-State: AOAM531an65kwLyW3rMXGZyWoYbGH6oY42JRymgn1J/fIwLbtE/F6zpv
        4HQ0ZRtkZA3FLyjt6CXbHiYBHwCZGqV9fTYiYL0dEQ==
X-Google-Smtp-Source: ABdhPJyFMNunA2bOW/HTfw7I2Fxc07FXNBNlKOc55ZJx0surGmu20mPs7uTrsxToUeLXW66T1s7Gq8IAg4lX/ItiTU4=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr6553464edw.97.1619556543314;
 Tue, 27 Apr 2021 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210408170123.8788-1-logang@deltatee.com> <20210427192838.GP2047089@ziepe.ca>
 <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
In-Reply-To: <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Apr 2021 13:48:58 -0700
Message-ID: <CAPcyv4h-YVLHTCnXhTy5DVbhXndWZnhcKerDdS=+wDjWzZc4Fg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 27, 2021 at 1:22 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 4/27/21 12:28 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to to add P2PDMA support to the common
> >> dma map operations. This allows for creating SGLs that have both P2PDMA
> >> and regular pages which is a necessary step to allowing P2PDMA pages in
> >> userspace.
> >>
> >> The earlier RFC[1] generated a lot of great feedback and I heard no show
> >> stopping objections. Thus, I've incorporated all the feedback and have
> >> decided to post this as a proper patch series with hopes of eventually
> >> getting it in mainline.
> >>
> >> I'm happy to do a few more passes if anyone has any further feedback
> >> or better ideas.
> >
> > For the user of the DMA API the idea seems reasonable enough, the next
> > steps to integrate with pin_user_pages() seem fairly straightfoward
> > too
> >
> > Was there no feedback on this at all?
> >
>
> oops, I meant to review this a lot sooner, because this whole p2pdma thing is
> actually very interesting and important...somehow it slipped but I'll take
> a look now.

Still in my queue as well behind Joao's memmap consolidation series,
and a recent copy_mc_to_iter() fix series from Al.
