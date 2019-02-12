Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FFC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5721773
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 08:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBMYW+iF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBLII0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:08:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLII0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 03:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HBMYW+iFSeRBqov7VwJ8+h0kZ
        g21tkL9YdrB1zbVODOIDWnFRGAHFb2f23KAuhZ1QaNOYA09zFp7TmWkEzwcbrDkbMi39PEM9LMpnB
        AgY+LfaXUcsh/gR/caA+2PeibfuDQ4jcGHDJ/DN6IVnSpZEmNVyBJdqJmE9KK6ro5xVrjCKdliNnS
        gmoqjEcXuzMMxHMs/tfnHFmhop+/pKOMPXma30wJKiCou4sAEt5snGykGcoxQQO1SShdveDyoTdtq
        iSEX9Dd5KFuqcHMZVn7ZWeg5muUtt2fQcbNqqVyf124jCMOf1xzJadIs6rXtwp7piSSDe3ZL5Rdv2
        ZpXjdq52g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtT7B-0000mR-Gi; Tue, 12 Feb 2019 08:08:25 +0000
Date:   Tue, 12 Feb 2019 00:08:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: kill QUEUE_FLAG_FLUSH_NQ
Message-ID: <20190212080825.GA1807@infradead.org>
References: <20190209224424.7560-1-axboe@kernel.dk>
 <20190209224424.7560-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209224424.7560-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
