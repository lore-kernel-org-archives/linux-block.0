Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9EC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B250420884
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXzcV3/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGBItY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBItW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:49:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4DC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=niz8BZ3+orX2F8Zgd7PShUBTkfMRHT9kOHEGtsE5E/A=; b=RXzcV3/yEo39V1QRsG2VaLq3Cx
        LgHP5rLWHRJX6YZf1z7KtHElpdA7siwXL0ILcOSNY97EOxz4Z6QHYOqHZm6D+wZFC4Z2H8iKbiiTT
        uFsFbE8iona8M+NA4Rut4o5c9TI+wN13hR16kpnqsIjYnK4WVb3UPnPozSZIU3J6BVyHEJ2dgsL7i
        VjsQoUIbU0qU6F/3VjW5fDsTe+jwXwKMo1twz4jeGQbkGRQ3rDYMSSlz2zTxqCFcotDRTdnSwhhcP
        NOZf/sPQ/aHaTMH48w+XduN2pHeF9XpivOVC/0yv+ymakl19Fk7SL4WOfVt+zLWRhcdu4UgeWDZPG
        Th33GqNw==;
Received: from [213.208.157.36] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquuF-0001VL-QB; Thu, 02 Jul 2020 08:49:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: simplify block device claiming
Date:   Thu,  2 Jul 2020 10:49:15 +0200
Message-Id: <20200702084919.3720275-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series simplifies how we claim block devices for exclusive opens.

Diffstat:
 drivers/block/loop.c   |    7 -
 fs/block_dev.c         |  231 ++++++++++++++++---------------------------------
 include/linux/blkdev.h |    3 
 3 files changed, 81 insertions(+), 160 deletions(-)
