Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EFC2D0F4
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE3A2075E
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jN02qKcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgDHTon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:44:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgDHTon (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 15:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9HaDKG5oE1iT4iyweZ78HDMHnz0M6i1LwdyVaWp4alg=; b=jN02qKcBn11ZF71XaYJXxc16T0
        Qyq56rpcCU75FW/MGrrmFCJOfXrH2Qi6/w8gozIV/97I2l0KVSeubs0Q3u3U5UTtiC/L2IGx+rxop
        PCQpXeq4Po6DB04mMRsLG1bwP15Rp5sB6k21iWukqcjGT5p2ZaJRmpTS4q3nZcHsC+EhMEUkmCICz
        jQSan68boWKFIrkHiwLSAw8J02FCYxtIguO1AOjNBEK7CVsIwLd8QjAbW5h+jH6TYZIRF4hXgj97t
        7yBSpTAGXAJZFGwrWzzY7kFPru9lfdOaqf4ZDZDhBGOFq69+U+FsIBwxl+SswHc5QAA9R8w/VeBB9
        Ovpo916A==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGcr-0004GL-IG; Wed, 08 Apr 2020 19:44:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: 
Date:   Wed,  8 Apr 2020 21:44:29 +0200
Message-Id: <20200408194439.1580699-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Subject: more partition handling cleanups

Hi Jens,

this series cleans up more lose ends in the partitioning code.  It also
removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.
