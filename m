Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2053F60238
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQVj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJLQVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:21:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F2AC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xszv4lAQljeQHzhYRJxkEaETWDJO2EkTcBK3gp2wi8I=; b=kaF8R0NoO+sgrGrlCUiHtmC6Ri
        DGMx15ZHPDqICWXor3rh054nZtjC+RDA1MFwA0SsUnREAjZrXrSRe6xtJjrk4fnayNeQNuMZLhAPX
        sF7G1tMSZZwykZZAecgQNUr+chN+o+yd3jJZdfi/3yBsb+vpUMPdukuIh6yG0LduqmNDXrmQvfrev
        lb2tm8bSWKa7Oh4l2g00ssas0NC0PoM3EpXXIeaWgfbLhZp0tJg4Ykh86Sr9zByqxDWph179CLBwz
        qqZUw+TtKoshFFPH+pq3uvPIyIgLEtfoNoBCQuhCXJkojGjW6N8HXCwZGhqEDlVIdWMuIWDjQ3O8D
        8cIPFYAw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKTd-006dvx-Bv; Tue, 12 Oct 2021 16:18:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: decruft bio.h
Date:   Tue, 12 Oct 2021 18:17:56 +0200
Message-Id: <20211012161804.991559-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series moves various declarations that do not need to be
global out of bio.h.

Diffstat:
 block/bio.c            |  100 ++++++++++++++++++++++++++++---------------------
 block/blk-merge.c      |   31 +++++++++++++++
 block/blk-mq-sched.h   |    5 ++
 include/linux/bio.h    |   78 --------------------------------------
 include/linux/blk-mq.h |    6 ++
 5 files changed, 99 insertions(+), 121 deletions(-)
