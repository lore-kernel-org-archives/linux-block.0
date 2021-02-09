Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5BCC433E9
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B60464EC7
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 17:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhBIRPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhBIRPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 12:15:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24848C06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Feb 2021 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bD12DKVM4IAOwxfWxL6Laof4YAQ/5luOeIs7QG5El/0=; b=dc7zdf4KpL5zPcp6Gf6db6Rm/S
        G3y3x/wpQ00lP95Cxy2NlloGeV5yaPSPUrsxaUGrCqxmAXDR7En07M6RZHZmQMpimUaaCCyv+omLa
        iU0V7d8BeXqGRK6GdXJef2ZoAJTsCBhjHuWbDEvLQij862RJu+BIUeslTA7Cpkqc+eg9Oi1eSy/vp
        Af6SzCCWrUpm7mVCKeGW+n9o526v+4B1QtHC3ROwpqA4NNPruBl5n485ARXc7tJo2urYWekwgfHb0
        5/NlQLilhGdpoDzfjqhS84p1yBD/aH4jUYHri+JNmWtQaY4qSU/KDMc47BJAsKeZM8jI17dHzAQlL
        qzUtiEoA==;
Received: from [2001:4bb8:184:7d04:8942:6d04:f432:bc43] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Wai-007jBz-BC; Tue, 09 Feb 2021 17:14:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: another swap/hibernate code cleanup for for-5.12/block
Date:   Tue,  9 Feb 2021 18:14:18 +0100
Message-Id: <20210209171419.4003839-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this cleans up another lose end in the swapfile.c after the previous
bio related cleanups.
