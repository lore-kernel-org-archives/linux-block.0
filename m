Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D494C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D904822360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krSd49AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D904822360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeKOB1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:27:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKOB1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ebgbmebEGB9dzPK80bEYwKJ7WXOSPChV/Pn0QRg8TBc=; b=krSd49AU6JwCw+JBwAANedQXr
        HSI2pC2gOPUo9AWSj1MaVoObgDh15ZV3rDNna/q2TXqvRIhX/6zRbffGSpdHGjPZLd7EPRweJ88wa
        A38eijqgFmtfFO7V9y1dmhst5sEXxfODLxxqsIR2BAExZHxdtv75rB4FBGyc9gBUkXSQLFRaNGGFa
        mEOe3fOyw4Y8i7wAvs856btzwYfucvhlzswt5f6nMLbC9WtqGQPTkqrsV3ulQQ0VuD5wiCfR78cjt
        lA/QVfY8+OOHZvo5uWARlpW9oOPPVraba1bQyeytm05BQGjUhmd08fEIE5E2Lm0X50MNX+WMVApW/
        dSdiiuNwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMx1G-0007M7-Os; Wed, 14 Nov 2018 15:23:54 +0000
Date:   Wed, 14 Nov 2018 07:23:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 02/11] block: add queue_is_mq() helper
Message-ID: <20181114152354.GD22186@infradead.org>
References: <20181113154233.15256-1-axboe@kernel.dk>
 <20181113154233.15256-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113154233.15256-3-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 13, 2018 at 08:42:24AM -0700, Jens Axboe wrote:
> Various spots check for q->mq_ops being non-NULL, but provide
> a helper to do this instead.
> 
> Where the ->mq_ops != NULL check is redundant, remove it.

With the legacy request path gone this isn't really any different from
queue_is_rq_based.  So either switch everyone to queue_is_rq_based,
or switch all queue_is_rq_based users to queue_is_mq as well and
delete it.
