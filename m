Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA7C4320A
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938D360F44
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbhHZNlI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbhHZNlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:41:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C74C061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RmD580A0DACMsoaSRK2kAdYxxga/qc1Xe8oKE3LX9TU=; b=FqhnozPHapIQCat3UIX874edF8
        AbF9N+C+hK8fAiH+Wr8pJmcCvkJng3uJPK8SbfXmI1FmG7/ZndaXef6rGrd064BiJ5Fp7gr3T0yee
        WyeicB4yhoWLuHlQMCBHnt7bP2mOeEVrG+DBN0NuxqMeOJqksG1cc2xX2X2mmM7n+dbGqz0XROV4Z
        ZDPiaQ7IAPMZTuSFIlzJrYToNJ1DpKJKteQU9/Krccum1ce30h5bwTSs5lwBMlXJefHiVlHB2E7Gj
        7t65fBVZqz2hCsdymWdrBWbUWxy2+VVV6AcyDEWAfN/rOpB6/M3zrUPHriPr0g69not02kgx4u8xy
        uOuviVDw==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFa7-00DL5c-8C; Thu, 26 Aug 2021 13:38:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: sort out the lock order in the loop driver v2
Date:   Thu, 26 Aug 2021 15:38:02 +0200
Message-Id: <20210826133810.3700-1-hch@lst.de>
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

Changes since v1:
 - add a new patch to fix a pre-existing spare warning in the crypto code
 - initialize various struct loop_dev fields earlier
 - hold lo_mutex over lo_state updates
 - take loop_ctl_mutex to delete from the idr in the loop_add failure
   path

Diffstat:
 b/drivers/block/Kconfig    |    6 
 b/drivers/block/Makefile   |    1 
 b/drivers/block/loop.c     |  334 ++++++++++++++++++++++++---------------------
 b/drivers/block/loop.h     |   30 ----
 drivers/block/cryptoloop.c |  204 ---------------------------
 5 files changed, 189 insertions(+), 386 deletions(-)
