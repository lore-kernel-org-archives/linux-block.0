Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E9FC28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BDE208E4
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pUV0VeoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgEFOkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgEFOkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 May 2020 10:40:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46366C061A0F;
        Wed,  6 May 2020 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IieGVj9Mh3LlaGPlVHA/3gGTPV3gJyGh0mfqCHjfMh4=; b=pUV0VeoXHdwaVQBkEtQDKZiD0s
        c3abF+d6dx0Y4B87RXFDkt0zDpWkFLppT7HQh/bb9V0+MPYnvXwmqsBYiQfl8BAysg9brFpulc6yW
        ctQREzZ7eQosJnOvuhhQH60ajDeG7bV5TgsIJwIdkbbrT0bo5iX8FV77g989uVpsMUWYPMYvsXQMP
        vDTC+l65Z2nA9KyP/qV6T/Nu9IR7FzA+3xw86xqjqZB7eL/bK8wWpT4y2cL5SpITMUcUKeeEmzNsw
        YEm4792CsDFd6dapuOb90JpGj5ROyaIpgP6gw2dLkSs3xKKxcSjgCEAuZxqh81cc7RMe10s0tzH2M
        E8ceRz8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWLDz-0001ks-4W; Wed, 06 May 2020 14:40:39 +0000
Date:   Wed, 6 May 2020 07:40:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 2/2] fs/direct-io: pass NOWAIT to also for read
 requests
Message-ID: <20200506144039.GC27643@infradead.org>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
 <158860769737.32485.3674517821826063792.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158860769737.32485.3674517821826063792.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 06:54:57PM +0300, Konstantin Khlebnikov wrote:
> For some reason NOWAIT currently is passed only for writes.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 03a07c92a9ed ("block: return on congested block device")

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
