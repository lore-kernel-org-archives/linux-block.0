Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF3FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EDD610C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJMQQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMQQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:16:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993DC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YwVd+lveMisa4MC2613HMxwHzRSRc48B6eRCJLbyxP8=; b=lznIs8HAoA1B5AJCxZwN/n/nbr
        obsGId5zRZ/gWc0EdHGTtJzMAkpKx2euUdpZqt+EPgIfmBDmuaMSxkiUGM1XMTc9GmIWQozAUKVg5
        oD0yEzNHi5yfdg1fQMmmBwoD1WEqMDcJ8nEkMknw5/DRNuHPyKCQVPGeVX1BaC6wMMeC268mEkELS
        INx7pgATG1/+H6tlMYw3Gehr2HVKVLyYz6X9Ss/7ZyGUc8arbjuWDvXBxPPcmXAO/j80NipmFKMCj
        rhGunibIfIQO7FeU6DWJQ0vduIbd21CJ6Ttjgxows5XY6xi+lC22y5gbO927LGfEvKcll4ScAbH3P
        Pm09cbeg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1magsS-007bOv-8b; Wed, 13 Oct 2021 16:13:39 +0000
Date:   Wed, 13 Oct 2021 17:13:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
Message-ID: <YWcFmHnnk1dGigO9@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk>
 <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
 <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
 <YWcAK5D+M6406e7w@infradead.org>
 <9456daa7-bf40-ee85-65b5-a58b9e704706@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9456daa7-bf40-ee85-65b5-a58b9e704706@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:04:36AM -0600, Jens Axboe wrote:
> On 10/13/21 9:50 AM, Christoph Hellwig wrote:
> > On Wed, Oct 13, 2021 at 09:42:23AM -0600, Jens Axboe wrote:
> >> Something like this?
> > 
> > Something like that.  Although without making the new function inline
> > this will generate an indirect call.
> 
> It will, but I don't see how we can have it both ways...

Last time I played with these optimization gcc did inline function
pointers passed to __always_inline function into the calling
function.  That is you can keep the source level abstraction but get the
code generation as if it was open coded.
