Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEBBC433FE
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149C36101D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhJLKoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbhJLKoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28B1C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iclCgrJnD2aQhqGe9OEuUUPwyBjmsnYtM8lP1U2m8Ts=; b=TGEQRFXvSJE8GWRW4u/HiOrBK7
        7cNYqwSCSAI4l62eTMXpznMC9IZBNJSvZEmaInt+A12IVFAW/eW1rMBgNGPZ6F2laYD0UIs9xXupk
        ip5Rug/kV31dspP1tO5UXsL8e/nnzB2gT+ypPpDNJjEvq2tREO3Ri35l/6PHOctuPyDOzH/NjfA2O
        8wJUtYfC64m1VR0vtxXaOYp48RTdsMfe9xu5ROs3PemJFMZPAZabwxkL/yqCCUTZQTXZnsa00qoge
        +SzGxAXNi8c2VR3uwcdZPL3iTzHnfxbSbGB3o/SjnMjEt7J8X7o/d+NXp7TOQJ3k15g3VgtxCP+jt
        h9z5xHag==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFDC-006QHj-5e; Tue, 12 Oct 2021 10:41:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: two small blk-mq cleanups
Date:   Tue, 12 Oct 2021 12:40:43 +0200
Message-Id: <20211012104045.658051-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up some of the code recently touched for batched
request allocations a bit.
