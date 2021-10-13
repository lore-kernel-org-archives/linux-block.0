Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC6260F21
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJMPUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMPUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:20:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE6C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yjAH4g1m3G/h4Pl1sq8vdVgX8DSuHv9jb7Ylv7cukGU=; b=tPB5NCS5RWBx5nLAjTgLPsMvnA
        G9OVYvndoSXfMBGo6VOVoPjg0jiVyRPXxA9FpyqE9hmnftS5OfDm68D3NhZwXmSd6wIMCUuD/vIpI
        0SG+m3IZW8s91zdrHa1/IFR7sY/GgJIYJroZhZvKsApFjBHcK6AfS5t3sbhNH4sh/SBRki5bIqnXc
        GhtrgJ3OCTnGkVPmW+L/aP8ywpjl3/hc4OfTec789GqTsQ9/zhJY7i7lJi/I978nLVZ8GDJMW3XY1
        UMSNAKsBkbX9Sg+IBNYxIOGzUH8W/CXEMXfTcpq9qG8i5zttd/4MuCk7P+BW21kjeEDpu1qPAvHpD
        9BeGADWw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mafzW-007Y5J-HZ; Wed, 13 Oct 2021 15:16:45 +0000
Date:   Wed, 13 Oct 2021 16:16:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
Message-ID: <YWb4SqWFQinePqzj@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk>
 <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 09:10:01AM -0600, Jens Axboe wrote:
> > Also - can you look into turning this logic into an inline function with
> > a callback for the driver?  I think in general gcc will avoid the
> > indirect call for function pointers passed directly.  That way we can
> > keep a nice code structure but also avoid the indirections.
> > 
> > Same for nvme_pci_complete_batch.
> 
> Not sure I follow. It's hard to do a generic callback for this, as the
> batch can live outside the block layer through the plug. That's why
> it's passed the way it is in terms of completion hooks.

Basically turn nvme_pci_complete_batch into a core nvme helper (inline)
with nvme_pci_unmap_rq passed as a function pointer that gets inlined.
