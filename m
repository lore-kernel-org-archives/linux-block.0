Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1FDC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2916761056
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhHRG3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhHRG3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:29:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83DC061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VfmFqXAC8QuM0wNvbIHk3b5015A2OwBAcO6LYyZ52bg=; b=FK0jygseuedOgzcRawU4o2J6SC
        8mLefmI9xhWpYWrhJD8pXKOdPpZgqslHHZDVqloKyFTmF2HMdosAYRrebRACwy1SmRQmukoEL3oOy
        YJKE1sdSFPvLcjCEFPyIkwHv1w+h7MabL6UwVLEA4cJtABBoPt0GLBnxwWtZK6n+S4alcjd2V7ltp
        /Lj/amPItt1V+6oBA9SNNov/YPpYIItxFckhZ83pitOhwFB+FZkH//9eyxOtpm8B/BPNmTqe1e/La
        X0ri5kF5xdLTE7mTagH+eceqzpCl9BgDZhemZjpgYBoIb/U307EQjiwFBuDwmtGz7IrPogCEVWsCU
        lU1HmwMA==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF0S-003Qxw-6N; Wed, 18 Aug 2021 06:25:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: sort out the lock order in the loop driver
Date:   Wed, 18 Aug 2021 08:24:48 +0200
Message-Id: <20210818062455.211065-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series sorts out lock order reversals involving the block layer
open_mutex by drastically reducing the scope of loop_ctl_mutex.  To do
so it first merges the cryptoloop module into the main loop driver
as the unregistrtion of transfers on live loop devices was causing
some nasty locking interactions.

Diffstat:
 b/drivers/block/Kconfig    |    6 
 b/drivers/block/Makefile   |    1 
 b/drivers/block/loop.c     |  327 ++++++++++++++++++++++++---------------------
 b/drivers/block/loop.h     |   30 ----
 drivers/block/cryptoloop.c |  204 ----------------------------
 5 files changed, 188 insertions(+), 380 deletions(-)
