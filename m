Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E15C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD6564D99
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBKShI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBKSfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 13:35:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2FAC061793
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vk/zx/cn4qqDUcNFMuSktnN4N6etVJhff6bENdZeajI=; b=uwhKmEuj07URDtJuU6fveCDVAI
        ncbpoRDyaGup9iiaTxtRaD7ExW5tg5lpP/BLS32jfiKVShp4Bm2hkqGBe9UajYyUzvNs8ERK6Ori2
        RmsDtAGGNs4+zOfcgN9SSoodKZ0MTj88fNbJcFJQ9FqgVTe8D35gB/S8KVaxjh4r2kD8NygdKkaPM
        nOXx6HNL1QxwtfIr8F76EYNTnanY1toXKyzWhyGZ1Nso+9w1t5sxVvwiP3ld4f1pxSFr1arO4bA5R
        YqKAeeoBLndSJRDoASv6/d60QwfklrV17XYyJ7QYeeTjzFljy85mevy4XASY4FG0JHdpgoG9hNBAz
        EdaOSxHg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAGmC-00AbdW-37; Thu, 11 Feb 2021 18:33:21 +0000
Date:   Thu, 11 Feb 2021 18:33:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] second round of nvme updates for 5.12
Message-ID: <20210211183316.GA2527859@infradead.org>
References: <YCV0PmcdMDOeQp5Q@infradead.org>
 <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76200cd-1ab2-8ac5-31b6-388db44bef3b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 11, 2021 at 11:31:58AM -0700, Jens Axboe wrote:
> On 2/11/21 11:15 AM, Christoph Hellwig wrote:
> > Note that we have some issues with the previous updates.  We're working
> > fast on fixes for those, but in the meantime I think it is good to get
> > these changes out to you and into linux-next.
> 
> Pulled - it throws a trivial reject in the quirks list, fwiw.

Yes, people are producing buggy controllers way to quickly.. :(
