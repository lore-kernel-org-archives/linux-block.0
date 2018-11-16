Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23AEC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926CC208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oMaPYtoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926CC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeKPSV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:21:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPSV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MFq7fg67ZVz1noiKgXexGoC29SBcubvQ8JQz8Jkr8Qg=; b=oMaPYtoUiRxPqslyowvQ4EVD6
        z2w3ZzDx5aM2Mxjf8zTHBoILITr16RNNaPwwNOCB82Sw9/X6UO4I0zI99at1qFH88YYyd7SXyJ6Hq
        ECjUpmSet5ubZLSJZ+D9CLWBHhN5L4SYKzJa6exAwujpuJEdi4SBiFsTNBuV2mYapKvBFUrmhbdkm
        t8UudTTZqB5uNJjAY9FNojSoNxabGnaeq8u+lAOOnTm0EpGk0CHl8cFi/BR8WcZkMv1qhhuwTeqJ9
        Oj4+3q42HkQnDAYtqDAm8dJaGu3bMool2kus4HZH4Lx0LnMmQoe+89zzgiqNHBcMPYv727J9iy5kS
        FlElgIGdQ==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZCa-000244-7K; Fri, 16 Nov 2018 08:10:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: queue_lock fixups
Date:   Fri, 16 Nov 2018 09:10:00 +0100
Message-Id: <20181116081006.5083-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

a few fixups for the queue_lock conversion, drop a few more bogus
queue_lock uses in drivers, and clean up the mmc use of the queue_lock
as suggested by Ulf.
