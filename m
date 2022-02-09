Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F8C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiBIIQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiBIIQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:16:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87799C05CB85
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 00:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t6pwxX06cxN9HqWz8E3uniZJge3wd7zTS/YbTiFs5ck=; b=XNnOO3Jxju49VtuLZeBobvcOVh
        0w2Sy52PcQt28S38SOHrkjhcvAiN0fOavrgCX4xtIJnrgQvSNKKaGIYUY22KWSOEt6VNmkIix4b5u
        0Mbro7Y/Axsa3WRfR5SPQmzLFT+rkbyAVi/kyn0vMslc+xGFFfHYXpZ/BSYO0wDHjeG+Sf3kmkxwN
        vjdKvHCmfhup6cFD/6nEGBnnUJzgW92LPBTceYM+oU745QuE7BIvCMmrNC7qJW7C1BtKvpbMhCsxV
        GNJvi89OWNUex+YFBu+OBoCh0FsdZV8B0QwmDIJ4a/KBChsbZjiEnSbjXxP0U7rWyJbjud3XokqmZ
        ngPInaGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHi9A-00Gauu-Fr; Wed, 09 Feb 2022 08:16:16 +0000
Date:   Wed, 9 Feb 2022 00:16:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [RFC PATCH 3/7] block: allow to bypass bio check before
 submitting bio
Message-ID: <YgN4UCKEslA3sQny@infradead.org>
References: <20220111115532.497117-1-ming.lei@redhat.com>
 <20220111115532.497117-4-ming.lei@redhat.com>
 <YeUnERz9Qoz2UtVn@infradead.org>
 <YgN3e98Px8F5w3q/@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgN3e98Px8F5w3q/@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09, 2022 at 04:12:43PM +0800, Ming Lei wrote:
> On Mon, Jan 17, 2022 at 12:21:37AM -0800, Christoph Hellwig wrote:
> > 
> > >   * systems and other upper level users of the block layer should use
> > >   * submit_bio() instead.
> > >   */
> > > -void submit_bio_noacct(struct bio *bio)
> > > +void __submit_bio_noacct(struct bio *bio, bool check)
> > >  {
> > > -	if (unlikely(!submit_bio_checks(bio)))
> > > +	if (unlikely(check && !submit_bio_checks(bio)))
> > >  		return;
> > 
> > This doesn't make sense as an API - you can just move the checks
> > into the caller that pass check=true.
> 
> But submit_bio_checks() is local helper, and it is hard to make it
> public to drivers. Not mention there are lots of callers to
> submit_bio_noacct().

What I mean is something like:

-void submit_bio_noacct(struct bio *bio)
+void submit_bio_noacct_nocheck(struct bio *bio)
 {
-	if (unlikely(!submit_bio_checks(bio)))
-		return

...

+void submit_bio_noacct(struct bio *bio)
+{
+	if (unlikely(!submit_bio_checks(bio)))
+		return
+	submit_bio_noacct_nocheck(bio);
+}

