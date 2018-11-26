Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81382C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A5520664
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6PR212i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A5520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeKZTLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:11:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZTLg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 14:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9+Sto9eHL+93QsRY9kTHEUqiN8+PSj1fdF0zeDc931U=; b=H6PR212icVX+IYqNKaYo2dwvj
        sm8ReVRKTA/SZ+voldXlTIA0g3pYFV7ogs3kSRrEPHGIwcYQtEe28JeMqrOY8G52aBPiQAsv309BL
        EUkxoSQaOMjcPOMuH3SLEsPOUDMLts7Xo7z3q6FGAjGSYLm2RUNuHXy6n/aBsPxUL6v9V15TPrNdr
        DrD0BJHVZ0iGAQsTYOTOHlT1bxSHY49ypcEuK/g4Po9OgXgXTm0aIJkwEi7LaHNbNTe4kDVfCbfmu
        K+tLIC4s8VKYnmwJsDVX453bYp1bD6ION6RGEPyO8W7wqjGDdR6PpDVgN9erzw+hkji0T8s0xahr+
        O/jPHdo8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRC5w-00020j-Bu; Mon, 26 Nov 2018 08:18:16 +0000
Date:   Mon, 26 Nov 2018 00:18:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 4/6] block: make blk_poll() take a parameter on whether
 to spin or not
Message-ID: <20181126081816.GC362@infradead.org>
References: <20181123183411.8708-1-axboe@kernel.dk>
 <20181123183411.8708-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123183411.8708-5-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -int blk_poll(struct request_queue *q, blk_qc_t cookie)
> +int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)

The parameter will need some documentation.
