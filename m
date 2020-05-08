Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2810C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 07:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BDA2070B
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddWEUMyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEHHrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgEHHrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 03:47:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06755C05BD43
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9b9Bs+uVFeIQOjgP03GnJGkoZPfz/Pb/eL2ur5UaBMQ=; b=ddWEUMyltOXFcPWnckqYkbQiUH
        x02+JvDrbNDiZjJ3As0uEzrVoaUfKuh/NWDW8AOhIxdSGTo6Zdjl4e7Ggw/S4NCzTCxjocFR4cwFo
        e5bu6M6hDnuOvdflupdMvBQr54Z8fuk1Lw81AauZFw0Ls33PH3f/2Moli7vwskeqPHzspqVLv7gZl
        kAZgjWr2nBLQrb6N/bSDBgpty3LKKwW3vbL2FLiLLsjQjfpQVmmwJVqvsrpzGfkAsYdQnSoqfW0ut
        gElRw/p97CFBx+DEIi2DDyxqsdyEIEecjR6WXazX8P5N2pQ7CyRVpmnZGhtaweMKy+oEJEI4oGadm
        vOAWdj0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWxim-00075r-KY; Fri, 08 May 2020 07:47:00 +0000
Date:   Fri, 8 May 2020 00:47:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH V2 4/4] block: don't hold part0's refcount in IO path
Message-ID: <20200508074700.GA27126@infradead.org>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
 <20200508044407.1371907-5-ming.lei@redhat.com>
 <20200508064133.GA11136@infradead.org>
 <20200508074157.GA1375901@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508074157.GA1375901@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 03:41:57PM +0800, Ming Lei wrote:
> On Thu, May 07, 2020 at 11:41:33PM -0700, Christoph Hellwig wrote:
> > On Fri, May 08, 2020 at 12:44:07PM +0800, Ming Lei wrote:
> > > gendisk can't be gone when there is IO activity, so not hold
> > > part0's refcount in IO path.
> > > 
> > > Cc: Yufen Yu <yuyufen@huawei.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Hou Tao <houtao1@huawei.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > This looks correct, although I'd still prefer to centralize the
> > partno checks in the helpers.  Also hd_struct_get is unused with
> > this patch isn't it?
>  
> OK, are you fine with the following patch?

Yes, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
