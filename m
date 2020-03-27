Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D56C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 08:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06D420716
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IzgIVwWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgC0Ic0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:32:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0Ic0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 04:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yXEos4Y+JyUZ3uIzmi8B7rv6j3/FvErDCTESVLzuhQU=; b=IzgIVwWvQdG+ilYGYRUDT7t1hu
        U5bUvJwSZ/ISwtOc8O6RXMldws87sSaJnZobULbi8xyXedl4SfGq5QAgQTYBHbR+NMM67/xc5UT/B
        8UVFp7DKlLt7r+9iQTS0cX0mcP2ZvGg+uiqQED0orglov9wsLGKK42hGBXc46IMiC3vxAu+KIUnpr
        Pwp3MfpGJS9thhWNYL0P+AkmsR5DiJTCMSjhvKBQnAYZu4QUT3tf1pdO2V1rrdUqDPAvFENI85CFT
        pEITa6G9115jB8tlIJiImaQx3ORkH6HpLXBii7LQtoL38fYU5MTetqMtw+J/+fJhSGlkoRiYaESuG
        +rz0OYOw==;
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHkPh-0007RK-5f; Fri, 27 Mar 2020 08:32:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: simplify queue allocation
Date:   Fri, 27 Mar 2020 09:30:07 +0100
Message-Id: <20200327083012.1618778-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series ensures all allocated queues have a valid ->make_request_fn
and also nicely consolidates the code for allocating queues.
