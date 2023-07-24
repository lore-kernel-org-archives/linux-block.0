Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2964EC001DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGXQyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGXQyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6D10F4
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dVBw9C6L6a7S2QtTlPSWGEHC8f6tBNKd8qWOU7uEKCo=; b=14txw/k7d2Rh8C1Y6wRO7MRwsw
        Is7Qpdq5QBrAwiNiNCJAq4cQ3y/jLbO1FgLaUOpFF1G2xH2pDMpuQMxD7sgPH/yDCRsWr72aPHMkZ
        T18KkWYaEwNvpIkLSruNSCJymWIoUp8sDO+u6yEMWljvlxjjJxSjWWPCc5nZa3a1i5CApJqJQrEF6
        t7JlyZe54WwYK1uQo+p8ZMq7zZlkYSam0TnMNlg9Y/YgthM9FPasdRhRqCDiEPs2C78dp+xlThjqr
        VfoduYv1axY9hfS57GKSWm2CtCWCZdut3SapNxcxm31T+73A8JUZUkk2x6vF3usoao7qChCO/EsL0
        W0eUtZ9A==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypN-004vto-16;
        Mon, 24 Jul 2023 16:54:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
Subject: rationalize the flow in bio_add_page and friends v2
Date:   Mon, 24 Jul 2023 09:54:25 -0700
Message-Id: <20230724165433.117645-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

when reviewing v2 of Jinyoung's "Change the integrity configuration
method in block" series I noticed that someone made a complete mess of
the bio_add_page flow, so this untangles this to make the code better
reusable for adding integrity payloads.  (I'll also have a word with
younger me when I get the chance about this..)

Changes since v1:
 - rebased against the current for-6.6/block tree

Diffstat:
 bio.c |  124 ++++++++++++++++++++++++++++--------------------------------------
 1 file changed, 53 insertions(+), 71 deletions(-)
