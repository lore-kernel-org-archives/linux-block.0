Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E01AC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427E1206BB
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 07:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9f6gw6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427E1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeKSSVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:21:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeKSSVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=F9f6gw6ShU3XOfaPFtw29qvG+
        w/XSGtjzQeigD67SaFjFqwDNeQW8El/rixvJ+uxl/F6LLxbFKPPs+wypnlaBWxpUxSFhnYOs/2jGD
        FKi81RF2024sUwVOZ3NLL95Ic7uuR1+YO5wisOTzPabI24fvH4YzxtuumTroohmpOP+c1svC+cQn+
        TU5w0qHil/ElzEKsq2BRlONSuna/jfHzazrpR+kWlSmwI6BrCdV0NGTu+MnuALo3+y/gq7w9gufqi
        /V+ALl5+tg2kEPzfYk5nCLxlTmHHLI/WmksKW8WWYkF2mJaR1nc4ZZbKRh6DLlhxeq/yhD0d6ByoB
        P2nmbYPMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeSE-00036g-1T; Mon, 19 Nov 2018 07:58:46 +0000
Date:   Sun, 18 Nov 2018 23:58:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/7] block: have ->poll_fn() return number of entries
 polled
Message-ID: <20181119075845.GB9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117214354.822-3-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
