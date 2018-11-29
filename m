Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD2C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB63A213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IEIoNEW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB63A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeK3CuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:50:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeK3CuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=IEIoNEW5dGqb/E4c3ISAiNeem
        D2MHPbpCKKXfzy7yg6CAwCr3IJ7rzv69H91oTt1RMmSQ+986nOrEtwRGOvwxXuGu44A8QMT+3cICm
        Q3lIP4NCyfM8XGFTCW7OXcAfOzxOfi95N+Jnil0N/zJCX8J3OpWd0KaYETDsBfZBsVWwCxtiKY1cO
        tKr+daG9s9FL3xNqVkDrdV4AbnkUXLjsSHNnf7eCZ/1eSQkNFqiOaq3MYpWynnG3XTqOGcsASVJ5J
        8yW3eyeq0diqT/uTf5StrSU8v9Lzf/+pKOmx+1+RuYeqKAJ2BRsGFWCru1/HFwnpFfN7U10zKXR10
        duy4yUwuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOUO-00024l-To; Thu, 29 Nov 2018 15:44:28 +0000
Date:   Thu, 29 Nov 2018 07:44:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/7] block: improve logic around when to sort a plug list
Message-ID: <20181129154428.GA7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
