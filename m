Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCEC54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202D1206B6
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OP/l2G/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDYRJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726156AbgDYRJv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:09:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1ADC09B04F
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GbNMHND1sthkOkW2rXq+aE/ykRg7043pW+5RpvHRkfE=; b=OP/l2G/i1Q4xDZPCxrr1jGfKcL
        SgLeqgim4usoUZAQF0OfyuxEozU8iDSvfCT694nc86JmuJd5BgjfRBL6pJuxGrLry1LiN3vvjDL3g
        c411neH+XF99RayH9WIoUWS3c9IqoUJ2Gykrt4SYkEZeMPZKBm6PXG6E9p7f1hW+PELf9IF33VaFz
        ZniRFglHQsTz4/QI9joKueuHev3ndHiFvKZMQjXccx1xjgrpfF7Fyx5maNRo8tpt5Bo+7YEUsCviG
        X2s4Kh5pTl2Ze8T9z21W1E7/izxuPhztL5525PDJxHfid4NsEnsltV2uYwgyWXZEfUu3j/aqKjZEw
        TqpgDuiA==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJG-0001hq-EI; Sat, 25 Apr 2020 17:09:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [RFC] more make_request optimizations
Date:   Sat, 25 Apr 2020 19:09:33 +0200
Message-Id: <20200425170944.968861-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this fresh off the press series optimizes the submit_bio /
generic_make_request to avoid the setup and manipulation of the
on-stack bio list for the case of issuing I/O directly to blk-mq.

Let me know what you think, this has only survived very basic testing
so far.
