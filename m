Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811CC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CE2218AD
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DM+LxS8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfDYHD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:03:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYHD2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 03:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MG7jUpC2RPm3275BGAuRtJMlGOIcN9H5ysqi5ABuATo=; b=DM+LxS8FpvNXUrgnZIR7vZ8K8
        1uLtNDTPHYUHW+XM9JdKC5edQNNTPkBdCeOLVSewk432VJZ0QApiRWTK+0MKeRXtdrl9vi4y14oF1
        s7kiivpG9qHVuQNC9LSBtsaayz7Y9WgQscISNJ6GWZ1RfnngQtui3tsCc9C7rcPTI3ckryLdG8/ut
        84cTF0+TO+izzTnrP+wHH3e7O2Sy91HMbtbJzTLEmPdki36lFCvGE6F13FXSXJSHaAjLG3N1CrTJz
        wo4u7V6kU4bCYptHCbrHZcLh0YPKBPjx2Dl6ZmamEa70MJUfIidi4ZK3e32hEv3U1NWHwcenS+ydr
        xQ3jeBdbg==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYPn-0006CW-4W; Thu, 25 Apr 2019 07:03:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: simplify bio_for_each_segment_all
Date:   Thu, 25 Apr 2019 09:02:58 +0200
Message-Id: <20190425070300.3388-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series simplifies bio_for_each_segment_all a bit, as suggested
by willy.

