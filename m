Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E1C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 11:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB42073B
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 11:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BxKHzDGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbgDCLPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:15:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCLPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 07:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AeG0BBS5fyuZ5/KLlk5YFUpG+5gZPDE4CvetHvPlXLE=; b=BxKHzDGwyIXNN8s1f7rIBysFtk
        wzP6Sf32TcKqJxc2ZcDbVwuX+QNk/JcOuCjvwj3Eh4s10GKhdEVlxmI/zHYRkrlapehuoIyWF665Q
        lGAoqrgZVqe156p/Pt4Ds7LM01/XLj020qjI9FsphEMss2rGk/wm+X1bfZf1u2dhqpqbvTiCJAZVG
        f4VFxgV/stMQakn8Bwu9PrCy6CC/NujHlANf6eQpL08oQtagpDLcMmJAWVGr/Kl6ZVvUPR259t2Rt
        ZLi5yRfnSArDzjUyISdtSFyXkAaUmyGEX8GVrfHFUOfau/ZH3E0Gqj4rCS54Ex4miR8b+Su1q5EaI
        zycRd+uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKKIa-0007m0-SF; Fri, 03 Apr 2020 11:15:44 +0000
Date:   Fri, 3 Apr 2020 04:15:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Christoph Hellwig <hch@infradead.org>, evgreen@chromium.org,
        asavery@chromium.org, axboe@kernel.dk, bvanassche@acm.org,
        darrick.wong@oracle.com, dianders@chromium.org,
        gwendal@chromium.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com,
        kernel@collabora.com
Subject: Re: [PATCH v8 2/2] loop: Better discard support for block devices
Message-ID: <20200403111544.GA27769@infradead.org>
References: <20200402170603.19649-1-andrzej.p@collabora.com>
 <20200402170603.19649-3-andrzej.p@collabora.com>
 <20200403063955.GB28875@infradead.org>
 <49a20f42-f082-be3a-52f8-a4179ab886c0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a20f42-f082-be3a-52f8-a4179ab886c0@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 03, 2020 at 12:27:26PM +0200, Andrzej Pietrasiewicz wrote:
> > The backingq could move into this local scope.
> > 
> > > +	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > 
> > No need for the inner braces.
> > 
> > But the actual functionality looks good to me.
> > 
> 
> Would you A-b or R-b if I corrected the two small issues which you found?

Sure:

Reviewed-by: Christoph Hellwig <hch@lst.de>
