Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B38AC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DE621773
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+gCxE2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfBLIJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:09:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfBLIJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 03:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vu9AScBBB/V1d5AoJvQYMVgNiqdAXC6jfdZDIq3GRRI=; b=I+gCxE2d17dB1w5Iwvtcev5RI
        97ZR/KxNvCO6Hz0Ekb56JaJmc7inBH1kp4+o7n3l50gyss/fi5SbOLgCk7K2buhw097XIaiqLviDV
        IhmTLm4PUBbVyqhB99sZoR+RTBzIMHXR/XFYPyD2gHZSaBbnCXi+YT3aeM09K3tTZdQQfndDUpUCo
        xDn6a9scXUt6oOsgIsO5gQdSRodYSP0znffGd1RDtssnYMLobVaKli4R89Hrbjz8hOS9rnSLYg0Ji
        9vhSDsU0140Frjzhlp5sFb3fQjG4yowYVZVx9ck6A3qhHro2d4Lf4gkrtjpTfFfAOgTKdgeaB/pLA
        VJaOR/LNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtT8P-0001EN-Vk; Tue, 12 Feb 2019 08:09:41 +0000
Date:   Tue, 12 Feb 2019 00:09:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: queue flag cleanup
Message-ID: <20190212080941.GB1807@infradead.org>
References: <20190209224424.7560-1-axboe@kernel.dk>
 <20190209224424.7560-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209224424.7560-3-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 09, 2019 at 03:44:24PM -0700, Jens Axboe wrote:
> We have QUEUE_FLAG_DEFAULT defined, but it's not used anymore since
> the legacy IO stack is gone. Kill it.
> 
> Sanitize the queue flags in general, they use spaces (for some
> reason), and the space is pretty sparse. With the flags renumbered,
> we can more clearly see how many we have available.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, I think we should kill off QUEUE_FLAG_MQ_DEFAULT as well and open
code it in blk_mq_init_allocated_queue instead.
