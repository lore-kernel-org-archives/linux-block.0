Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13885C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B0A2082F
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGbpiC0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B0A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeKZTKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:10:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZTKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 14:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QB4i+gFCi2k1G6xJcL90CWYF8NEbFmQk2DzxvEjRkaU=; b=pGbpiC0VdeYwfx6vNgXto6Qcq
        NpueFKd6Le0TEzGWgc3iFvIWZeGT8Mp2S9QPxLP74jwqKGrs89SjrhuBI4Ivm+swUl4V7HmiOjTd/
        TB9sVWqklKY2/92hWSThJk8/3qvzVEUNP7xBLx3CIyUrOsh1gyvy3LpsCXPa3FAG/oeYhbzFnUNo/
        8u1SJ2SQXzEQx09LQuYVmOLwQ5voQd8fvOUtluefbUoUGSRP3O4Z399n1BhInEGHHEdoftIn//ZQu
        4+MJw0lubMPreJ+3pmtKY4bxj6Hnh742db5YM/BtYWHRqdwXbDqe5GW2cQ15onNHqbgnfDIez4K6l
        nYMF1lrVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRC4a-0001lN-Q3; Mon, 26 Nov 2018 08:16:52 +0000
Date:   Mon, 26 Nov 2018 00:16:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] blk-mq: when polling for IO, look for any completion
Message-ID: <20181126081652.GA362@infradead.org>
References: <20181123183411.8708-1-axboe@kernel.dk>
 <20181123183411.8708-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123183411.8708-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -bool blk_poll(struct request_queue *q, blk_qc_t cookie)
> +int blk_poll(struct request_queue *q, blk_qc_t cookie)

Can you add a comment explaining the return value?

>  {
>  	if (!q->poll_fn || !blk_qc_t_valid(cookie))
>  		return false;

And false certainly isn't an integer constant..
