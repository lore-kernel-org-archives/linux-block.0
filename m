Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B1C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB10E61157
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhKDTHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhKDTHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 15:07:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035FC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DGfq7eGtjUXBN+9Yc+nuJVB2dpOxBizTAOPhI9R6wls=; b=ZjaLOQnGL3Ol58htSecPrbu0YJ
        PbTkuoW94cmPC+pldfMu1XLCwuP75679KXDbhDU00dBmemUJ2ySLw0OG1BiR+41m4Cz7DMV0N4O6s
        U2ygB2fATGQJHsgTQ5D+UUvqI5NSnC8pJSugoBOcRYd6hNMw9CSj5YIDuMhDoa0hE42aMGIXLQicP
        +lD34yOdSgBGd55MtJ5lfAZowGR2U4TBS9P4EC+S/wKrUrCfnHVjiLsflLiV7u4OXTNnUuej4YLlS
        pz+icru2bgxoAFItXH9pKXDps8hQoQFgqWlF9YV68nEnXhLk4j5CcpxaiywvSct5GczJkeGo3wrbd
        wR8E8NRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mii2U-009rCI-V6; Thu, 04 Nov 2021 19:04:42 +0000
Date:   Thu, 4 Nov 2021 12:04:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYQuyt2/y1MgzRi0@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk>
 <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
> On 11/4/21 12:52 PM, Christoph Hellwig wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> So these two are now:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
> 
> which is the one I sent here, and then the next one gets cleaned up to
> remove that queue enter helper:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
> 
> Can I add your reviewed-by to this last one as well? Only change is the
> removal of blk_mq_enter_queue() and the weird construct there, it's just
> bio_queue_enter() now.

Sure.
