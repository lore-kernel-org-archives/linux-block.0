Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C957DC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDFFkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDFFkC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:40:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81296A65
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AhZDdAozMXfRUiuoHxsYaNFluODcyq5NpO7yYgs8Cl0=; b=3RN2/uf2apD9FmeViPS/yDUp2t
        y4epZMOyyGYMKb60rvVVD11SuOSQIfm9VkMA1u5eaZiXSnnJ1q1vBUCTSsBoiX2YH4DPQ5Qd6VSKt
        QK+Brfo8ZESLiBVy1KrIh9N29DVtEItpG9IcPZV1hKIv2ePV8iNwhheSV4ju0q32OShgcOJOic+yO
        qI4sfuTa9tAZM42xO+8uMU/Vsqy4lq+ludQzf3z9pEfJZtqHWUZhOPdFYNDYxwMIlJje6maXwjx1b
        eTUN5+pRzoHDmyQqSJw5u2EVFbmT8GgngdBypNsnLFCHLWT6WSYfD6QH0+yyyjMQDmxJjMdlobR3F
        ci76VClg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkILn-006OGh-1E;
        Thu, 06 Apr 2023 05:39:59 +0000
Date:   Wed, 5 Apr 2023 22:39:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/16] zram: remove valid_io_request
Message-ID: <ZC5bL4aCGfylPZmn@infradead.org>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-2-hch@lst.de>
 <20230406014449.GM12892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406014449.GM12892@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 10:44:49AM +0900, Sergey Senozhatsky wrote:
> On (23/04/04 17:05), Christoph Hellwig wrote:
> > All bios hande to drivers from the block layer are checked against the
> > device size and for logical block alignment already, so don't duplicate
> > those checks.
> 
> Has this changed "recently"? I can trace that valid_io() function back
> to initial zram commit 306b0c957f3f0e7 (Staging: virtual block device
> driver (ramzswap)). Was that check always redundant?

It was always redundant.
