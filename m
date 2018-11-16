Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C1C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4A62087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RMj/iJBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4A62087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeKPSrO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:47:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPSrO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3XtksG97TFdV+UZvMBpt6NEXGTG/OWZiXvmjVKB5vPM=; b=RMj/iJBjB9QvyAAhVYyaN5mV/
        qx7kvPWwG/ao2QzKD3To2yBMKTyHZyTfA3rd6fEzxk4p5NQuzcaNV9l7vYMdnhv3mPdJtjygyfijL
        mBNr8DQN+Dew65WAVfDds2LyPvT5v/p8+gnZTYMIeptzu7QN/7g5PnSkb+IUqydqJlAfcLDUWQbvc
        mChR03oG3rDYJnTiKmgcQyoq/DMawN690VbKu3eUITjvIULzjlVE+5hxVxcpMCVMuQpAWscvg/2xp
        NtLfGi9ETXGryMSHephg9wlPpb2zZVKQLRT22FWHC2kqcjBbBLJmCGs/ctUKK/P+PlM1ZikWpNqCW
        /0TBCr6wA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZbW-0003vY-0f; Fri, 16 Nov 2018 08:35:54 +0000
Date:   Fri, 16 Nov 2018 00:35:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 02/11] block: add queue_is_mq() helper
Message-ID: <20181116083553.GD9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-3-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:26PM -0700, Jens Axboe wrote:
> Various spots check for q->mq_ops being non-NULL, but provide
> a helper to do this instead.
> 
> Where the ->mq_ops != NULL check is redundant, remove it.
> 
> Since mq == rq-based now that legacy is gone, get rid of the
> queue_is_rq_based() and just use queue_is_mq() everywhere.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
