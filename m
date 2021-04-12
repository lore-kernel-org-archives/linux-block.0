Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6EC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58C36128B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhDLKaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbhDLKaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 06:30:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43DC061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4S/yEhmgO1q0uaRY8hfA7XVwhgWUMLpynMUG2SjAxzw=; b=FnR+sH0853DVufpazIdybBXyAd
        Grp8h0rRO0FnSaQt3yXOJRqM/toHq1ginCFi44W7I3nHf+juSUPJMqx+o1EyGZFGOTyva/Yj3D71h
        PiyxLUIbbiiSTACz3YxiHWfa2yOcztS+URD+cmbyyKFk/khWlijWPm8xy8wJVAKAxBZqylszyhhp+
        /tsfj6JoGpQ1sAjs328cAo2wd2FAjcvoAGZKjU1cUWN11XAoY6WzbHowPUTkh6g97yvctUOfLVxrW
        QT2aL3r+oRdKX2eakW1PBkrBaq5PCqmF9ipZctB3TAL5PBpXwvj3iTMghqYjvhV4nM+jvDImG5fGt
        1GcERgCQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtpD-004BtM-65; Mon, 12 Apr 2021 10:29:48 +0000
Date:   Mon, 12 Apr 2021 11:29:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 08/12] block: use per-task poll context to implement
 bio based io polling
Message-ID: <20210412102947.GA998763@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-9-ming.lei@redhat.com>
 <20210412095427.GA987123@infradead.org>
 <YHQfB83n8dQSwD3O@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHQfB83n8dQSwD3O@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 06:20:55PM +0800, Ming Lei wrote:
> > > +static inline void *bio_grp_data(struct bio *bio)
> > > +{
> > > +	return bio->bi_poll;
> > > +}
> > 
> > What is the purpose of this helper?  And why does it have to lose the
> > type information?
> 
> This patch stores bio->bi_end_io(shared with ->bi_poll) into one per-task
> data structure, and links all bios sharing same .bi_end_io into one list
> via ->bi_end_io. And their ->bi_end_io is recovered before calling
> bio_endio().
> 
> The helper is used for checking if one bio can be added to bio group,
> and storing the data. The helper just serves for document purpose.
> 
> And the type info doesn't matter.

So why is bi_poll typed to start with then just to need a accessor
to remove the typer information?
