Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904AC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C05A2072C
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6kK7VDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETRu0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 13:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:50:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF9C061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y75+eTqvmZpjJ1mXRYgakSuKQ7kpWmP4KBQErl1ZrOo=; b=V6kK7VDM4PSn/flJFi70sw67E/
        /Zku5E4H4i2x/2J+W8MwyeVyoiEvY9mx92ZAt+CeKaFP2+G9B95VfUsa57jDsnJHfpyd6NxROGyLO
        Fn1BdSiBy7SpLTuSd6ljZO4y5sJNgaPsUgkmMW7v8E07FEXMvdg8CkaTnfDmyyoXjOhcpsqdda8au
        OJ6xrrd4E4QmTaa3xoy3IYJOCyR7+YN9qog/ZsEO53OjS0al7KGibONPzT0PvsQgvGU/DY9vNNx+I
        o3yK+pH2hDb+30E0LFh10EqFeMElqTD/nBVuEvfBh8TMShH9gZhJmOaVPeN77Lt4L3nPs/s5/RYiO
        +ZJ/iLjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbSrJ-0006QK-ML; Wed, 20 May 2020 17:50:25 +0000
Date:   Wed, 20 May 2020 10:50:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Fwd: [RFC 2/2] io_uring: mark REQ_NOWAIT for a non-mq queue as
 unspported
Message-ID: <20200520175025.GA13855@infradead.org>
References: <1589925170-48687-3-git-send-email-bijan.mottahedeh@oracle.com>
 <3503f837-0958-0a55-ab7b-d4f1c7131179@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3503f837-0958-0a55-ab7b-d4f1c7131179@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 04:16:45PM -0600, Jens Axboe wrote:
> 
> 
> 
> -------- Forwarded Message --------
> Subject: [RFC 2/2] io_uring: mark REQ_NOWAIT for a non-mq queue as unspported
> Date: Tue, 19 May 2020 14:52:50 -0700
> From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
> To: axboe@kernel.dk
> CC: io-uring@vger.kernel.org
> 
> Mark a REQ_NOWAIT request for a non-mq queue as unspported instead of
> retryable since otherwise the io_uring layer will keep resubmitting
> the request.

Someone needs to audit if this translates into the right errors message
for the syscalls, as they eventually need to return -EAGAIN
to userspace.
