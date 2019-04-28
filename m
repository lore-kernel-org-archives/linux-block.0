Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20457C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 12:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD1520843
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TeIGe5pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfD1MDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:03:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfD1MDO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 08:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TeIGe5pTsacj0bp3QXWWFhaZf
        SSEbvPTdEgffT+X01mSiFBwHVuw6kUYZah4LO/o7Lgqve1q96qnOzDdMg7KgASYGcYarJwgoXRiw2
        rFEKpgLXpRrARLSCdPcQryqpjX/ps+VHSzyQqoekhvK/D1djJZPKkUx16pm07qllx7A6QlweAtLaH
        OpktEt7WY6bT7UiPz2dpu2NNv+ECACorQ3TMGop3FjQazOwkDgGxdO2l8S38+k2rSAeODO0EDUj4v
        z9lakdVM895jJpH3X5+j3uMPBY2WQbkl2HNmpmLRXWSsSmWjTiqhfhpzoDfNHMb7Tq8PmuZdMNN0H
        oJiHW92+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKiWX-0002Ya-L7; Sun, 28 Apr 2019 12:03:13 +0000
Date:   Sun, 28 Apr 2019 05:03:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Move tag field position in struct request
Message-ID: <20190428120313.GA9759@infradead.org>
References: <20190428074803.19484-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428074803.19484-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
