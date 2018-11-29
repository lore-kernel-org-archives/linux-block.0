Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A753C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05B720863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LV+BPDfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05B720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeK3Czr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:55:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3Czr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IwhxQ5rCyiFFZ8mZlKz9PUKqGMrsG3bTsh+FknZmWyQ=; b=LV+BPDfU1nShEBozSwB+hJE+H
        ps3En4zFji8oNJ0UIQbpuRtxihtcfRrFptVoruUU0pWKWT52x8GQYrChaJzB4ST4T39C6r9H9+Hfx
        L+ld9vfsbnzVHWq2eJO5PH9zSTph7UHYGZ+ZNAy0sRs5QaYIbqriJZUN/GIC9kRDERhxM3ipfkSCp
        QPhEnBOHvwd/S0ZUFr4/3IND2LIuOGy27QMKlAxFUz3ddRuKXLEB2T13lj2k/XosAsdwxICFTyn32
        0xcl8ANP9Tk6UxE9R0AOKGjO0P79guqUdVOPkSVyZVl1kESLW3Ws6NzM7UdchHGsZdcm4wzEiB+oy
        q0RyBxzlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOZj-00053b-QN; Thu, 29 Nov 2018 15:49:59 +0000
Date:   Thu, 29 Nov 2018 07:49:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
Message-ID: <20181129154959.GF7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-8-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +		/*
> +		 * Use plugging if we have a ->commit_rqs() hook as well,
> +		 * as we know the driver uses bd->last in a smart
> +		 * fashion.
> +		 */

Nipick: this could flow on just two lines:

		/*
		 * Use plugging if we have a ->commit_rqs() hook as well, as we
		 * know the driver uses bd->last in a smart fashion.
		 */
