Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CEDC4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C9163261
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhHPM2Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhHPM2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 08:28:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA24C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0Q4eRZ3F/7EPjvto2u2E52fMotAgIC5rwp4aHMwV6oQ=; b=o1xvzCJGoUG4gTDVeMnq0/547b
        Fl4aKPEkWju1Xkiq+i222h4kHpKFBXbS3u65RoUaITLUYSiQs7LmoYcuRmjmmvFM6zH9Dmu9jk6L0
        u8Cu6V2IFsh/VYrttLxCnYq7UIixWy9w4B/iOMebEV/VEjVGl0vujXEOFRFnPFTZbClyXuck9oK4H
        Xk8ASstXcYRKqaZjYbFQPZgGE8LuA2WV0D2pQEYFrYgqvQmlfbsF+ktaTSUDbaIt/Br5eCTL0F8KG
        zpKdgaoyx1T2m2pMr8807lsKUPLDC99j6cEkL8a64CzRTO+TUL2yZzjJS1pnKDOcgJtxQNhc7o/En
        t9v2ifMA==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFbhH-001L2b-34; Mon, 16 Aug 2021 12:26:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-block@vger.kernel.org
Subject: bdi lifetime fix
Date:   Mon, 16 Aug 2021 14:26:12 +0200
Message-Id: <20210816122614.601358-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series fixes a bdi lifetime issue.  The bug report was triggered
by the move of the bdi to the gendisk, but the underlying issue is much
older.

This supersedes the ealier "block: ensure the bdi is freed after
inode_detach_wb" patch.
