Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 06:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2260E76
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 06:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhJ0Gtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhJ0Gtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 02:49:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C8C061570
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GckivjiWH5oV7PTMass9C7T4EydeBekRIFbghukfOX8=; b=4DrC1gPEvK8RerWrcQoFdZMcr4
        99QvDAbAB+kLVQFWwt9uKrN3KXRXznP/iSE0U540g51vpmVbXQ4uKG/ZDs6/MKrNUFsudbkdeyHI1
        hVpCJv74+D7EAllAgYROeyV/7ETBq/lD/MYCsoOSVRdIigsvNBJNvCJ0BreDHAjM8k6mmCptU0V1T
        Mp6TPcDxtGCKXyVd0pN+TcVKOxbvJmTkXn6vZoUjy3W8FLb3q1NTo7MV/sjB/fMv0XGI50FBYq+wq
        S8PzvyzYb6+Jz5ygw36ojO43n8VrgdlE6SYVhItBXQ5Xjvl7Y1AN6ULYjoU2686LK/NjQd9bAR2W1
        aH4c9PTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfcib-0043J8-9r; Wed, 27 Oct 2021 06:47:25 +0000
Date:   Tue, 26 Oct 2021 23:47:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
Message-ID: <YXj1/c78XP52V0AA@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
 <YXZeNUVx3cJW/lV+@infradead.org>
 <4e53a08b-3cfa-8351-2713-af632a759e88@gmail.com>
 <59bdf1f5-c96d-2cdf-32ba-a8b3ab777cf8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59bdf1f5-c96d-2cdf-32ba-a8b3ab777cf8@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 11:27:12AM +0100, Pavel Begunkov wrote:
> On 10/25/21 11:12, Pavel Begunkov wrote:
> > On 10/25/21 08:35, Christoph Hellwig wrote:
> > > On Sat, Oct 23, 2021 at 05:21:35PM +0100, Pavel Begunkov wrote:
> > > > With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
> > > > serves only multio-bio I/O, which we don't poll. Now we can remove
> > > > anything related to I/O polling from it.
> > > 
> > > Looks good, but please also remove the entire non-multi bio support
> > > while you're at it.
> > 
> > ok, will include into the series
> 
> You mean simplifying __blkdev_direct_IO(), right? E.g. as mentioned
> removing DIO_MULTI_BIO.

Yes.
