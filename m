Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD9C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582EA20809
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TcoxCQiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgFSGwl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgFSGwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 02:52:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88017C06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 23:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nb1nK3zLgh0CjfDQ76fVSS7aK8UI2PgPurE/sZ4Pj/s=; b=TcoxCQiGHoO8TGgWXEL51m6KT1
        qMAhs2VUHKTMz/53FpqQeEf08JJs+ZyGH22EjQw0o73ls9ZWRT01t62zw2Vg1fwsFH/9YZnWL0IVw
        z5SXEOFYCDN9I/ouG7WwbegRcZWpe6P5JUpe1Pu5xEqpG6+qR/xWvg6K0OdXrrwkWPaccDtfNON8f
        wGmZIhPZx2prE1t0xqP+e4PGMRMUmQrlD8k40U497a6Z/ZuCT7rKpvIeas72sdroIR+hHlTSh7IeM
        JGDioEV9kHBmlW1yuurecM/xpNzqrHlU/Hz5J0VLA7G5XUZ/k9g3MqA7W2YqdPrWyrsPwoG7Z+ivD
        lrytd9Dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmAtE-0000qK-Pk; Fri, 19 Jun 2020 06:52:40 +0000
Date:   Thu, 18 Jun 2020 23:52:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Message-ID: <20200619065240.GA3212@infradead.org>
References: <20200617135823.980-1-jack@suse.cz>
 <20200618065359.GA24943@infradead.org>
 <20200618161331.GD9664@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618161331.GD9664@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 18, 2020 at 06:13:31PM +0200, Jan Kara wrote:
> On Wed 17-06-20 23:53:59, Christoph Hellwig wrote:
> > On Wed, Jun 17, 2020 at 03:58:23PM +0200, Jan Kara wrote:
> > >  	blk_account_io_merge_request(next);
> > >  
> > > +	trace_block_rq_merge(q, next);
> > 
> > q can be derived from next, no need to explicitly pass it.  And yes,
> > I know a lot of existing tracepoints do so, but I plan to fix that up
> > as well.
> 
> I had a look into it now and I could do this but that would mean that
> block_rq_merge trace event would now differ from all other similar events
> and we couldn't use block_rq event class and have to define our own and so
> overall it would IMO make future conversion to get rid of 'q' argument more
> difficult, not simpler. So I can do this but are you really sure?

Ok, let's keep the original version for now then.
