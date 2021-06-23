Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924CAC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688C1608FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhFWPCS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFWPCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:02:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C785C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sCEu7NfW99+5UTq3b/aJ48oNwvCKGZQbDP7g4sPzUBE=; b=vYuREc6VntZfZkcAoEumsxn2/t
        4YZ8fnG97WxsQrOOoNXXKUth+UMYIh5Z8nj2jcNz9a52Jum2CJTdmPcKsSEQr880sWb+prklwEq1u
        eUl0R53sJYumkB1072IBzfezoMa29hVhk7F6494kmM5ayhUH85UI9Qh/T9ggdTA3l+2aBVMUxVXQW
        gzTY8LHncQj63xvqVR8WbQnpiwgliJIu9wNbWNW8Iak2I+MGUqLPsaJeB99wqZPAf9U7wZtU+pV+u
        GTaHx2kAbFDDCDwBsvYFoNkf/tkbKeKbqFnQXxm0fRizEIfzFMIQOZbe/PZRO11TCqmT9nmvDBJyv
        yTxMTMeA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4LN-00FXp6-Uo; Wed, 23 Jun 2021 14:59:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: loop cleanups v2
Date:   Wed, 23 Jun 2021 16:58:59 +0200
Message-Id: <20210623145908.92973-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series contains a bunch of cleanups for the loop driver,
mostly related to probing and the control device.

Changes since v1:
 - use local variables instead of dereferencing struct loop_device
   outside loop_ctl_mutex
