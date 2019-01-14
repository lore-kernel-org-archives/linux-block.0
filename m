Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EFC43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15BD206B7
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvPzBeLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfANQpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:45:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfANQpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 11:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wGTzQHBcMyTcVWE6+t1dFeMTCAS+VeKwcnuwc7zF/UE=; b=OvPzBeLkd8hmKunlz9uA0RhfR
        N/e2H+oD4giWXNO0L9XhIR6oDP6ulwsJ4BIKZQvivMmpBtVDPN/4W11iYV9NZu7ojqZYOZuQxCrHK
        o/07lPjJFARkldHPqjnv6bGg+/RmghNM8L+lvrTCuPq7WoBfWwJm3pROvORM5Audqoy9+xVI0SG6s
        61+NnKLGBUDM5fHR48RUqNQSnRqpZMIP190DBTRX9YkzFp1cutDnuKzqkg+6/al2HQoDyZr46cb7D
        caZF/tM+mjUJ+f1rS1rJpnEWFluDA+F3zE52FXRD/a6RKOtyEsHP5UuxMe/PPCV1U3bFA5xYxJ07h
        NkZEhuy+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj5Mz-0001qN-Ea; Mon, 14 Jan 2019 16:45:49 +0000
Date:   Mon, 14 Jan 2019 08:45:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kurt Miller <kurt@intricatesoftware.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: Block device flush ordering
Message-ID: <20190114164549.GA26523@infradead.org>
References: <1547130601.20294.152.camel@intricatesoftware.com>
 <20190113224244.GC4205@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113224244.GC4205@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 09:42:44AM +1100, Dave Chinner wrote:
> On Thu, Jan 10, 2019 at 09:30:01AM -0500, Kurt Miller wrote:
> > For a well behaved block device that has a writeback cache,
> > what is the proper behavior of flush when there are more
> > then one outstanding flush operations? Is it;
> > 
> > Flush all writes seen since the last flush.
> > or
> > Flush all writes received prior to the flush including
> > those before any prior flush.

The requirement is that all write operations that have been completed
before the flush was seen are on stable storage.  How that is
implemented in detail is up to the device.  The typical implementation
is simply to writeback the whole cache everytime a flush operation
is received.

> > 
> > For example take the following order of requests presented
> > to the block device:
> > 
> > 	writes 1-5
> > 	flush 1
> > 	write 6
> > 	flush 2
> > 
> > Can flush 2 finish with success as soon as write 6 is flushed
> > (which may be before flush 1 success)? Or must it wait for
> > all prior write operations to flush (writes 1-6)?

No.  For all the usual protocols as well as the linux kernel semantics
there is no overall command ordering, especially as there is no way
to even enforce that in a multi-queue environment.

>
>  * C1. At any given time, only one flush shall be in progress.  This makes
>  *     double buffering sufficient.

Very specific implementation detail inside the request layer.

> Then flush 1 does not guarantee any of the writes are on stable
> storage. They *may* be on stable storage if the timing is right, but
> it is not guaranteed by the OS code. Likewise, flush 2 only
> guarantees writes 1, 3 and 5 are on stable storage becase they are
> the only writes that have been signalled as complete when flush 2
> was submitted.

Exactly.
