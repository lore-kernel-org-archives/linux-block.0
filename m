Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20926C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjDFFpM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjDFFpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:45:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D261AA
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MRbuA4D34e5dKravgt8WKoLJlBRtfFmghG7/Ejeo3l0=; b=XCXoJDPi4f09YieLFT0EqXDXY3
        ntrsX4vQ+l8Ltf9D+CmLxsADeuiB0gVWPmnZrkLGSNz1Ejax6F1zLWmXI5Xt62J5VCVN8/08eLw84
        CkAbwRlcyDyO+p3Tc/fFPcsNFWCDYEXNdASaerf6B09bS6abXksw9kK8MrOgw3wU2Ie71MaTs4AgA
        R+lhnSuRteVTO9+PR7ihy3yBVj22baPO+nUs+YKI776ADeB6vC9Xk4q8rtajT+o2vj/DZkDILLOe8
        qTEMqUEZW5c+qv2jR/kRD5B7PXDmuIXSyOfsxAmrsRfV7JdKgPR3ArUZe3ka4m3EqEN503V2x0Nt6
        a+24c6pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkIQi-006Oef-1Y;
        Thu, 06 Apr 2023 05:45:04 +0000
Date:   Wed, 5 Apr 2023 22:45:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 12/16] zram: refactor zram_bdev_write
Message-ID: <ZC5cYKAgq/v5Ms7L@infradead.org>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-13-hch@lst.de>
 <20230406051505.GB10419@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406051505.GB10419@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 02:15:05PM +0900, Sergey Senozhatsky wrote:
> > -static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
> > -				u32 index, int offset, struct bio *bio)
> > +/*
> > + * This is a partial IO.  Read the full page before to writing the changes.
> 
> A super nit: 		double spaces and "before writing"?

double space afrer . is the usual style more monospace fonts such
as code.  The to is indeed superflous and a leftover from the previous
comment.
