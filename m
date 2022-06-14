Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A6C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 09:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiFNJJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350773AbiFNJJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5233940919
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fI0tRANQH2nU3PtBFf55+GFG0RwSOinhoWxQkZND0uY=; b=XE2jYITqh3q2aiDYUAJA8pwXv/
        eibTjnSwfCUzt+FL9Okq4ml800HI3OLzdgLm8oAdy0cR+8ulwmhSil7Poxe1G1kF3kAQ4ryMWD68g
        VIZkfI+CXi7lABZzGXxX6HLITF8dMMUUk6xpXMxjNEuKSAMt+s9p8yrkFnPOwqOptyyFS3+RQZjJU
        LH33LLvKDGFLex05yeaptIXPQw/je3uSKejaKIM6f1PjhFe+oYnowhmrLJrC4Dx2tIgfdacyC2FsZ
        wzkYYWPcf7v71DJWPCUF/rHEBL3eipnUOvb5BUJIjL/W6C/eh0UstCd1owNH3MIzjTYccFqY+Qkz3
        KsyePyKQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12YN-008ZcG-4L; Tue, 14 Jun 2022 09:09:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: clean up the chunk_sizehandling helpers a little
Date:   Tue, 14 Jun 2022 11:09:28 +0200
Message-Id: <20220614090934.570632-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up a bunch of block layer helpers related to the chunk
size.

Diffstat:
 block/blk-merge.c      |   28 ++++++++++++++++------------
 block/blk.h            |   13 +++++++++++++
 drivers/md/dm.c        |   17 ++++++-----------
 include/linux/blkdev.h |   39 +++++++--------------------------------
 4 files changed, 42 insertions(+), 55 deletions(-)
