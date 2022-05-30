Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174A8C433F5
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiE3NIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiE3NIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDDD70908
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6H5bpctjD3xxW7e3P3Lffyv6s34sGo1b1U0tv0I3qes=; b=ENcozjkwSJKZuQyuJ8/Ljq34DE
        rgQyxZvs3mIUEuxYiSnLiGPUr9jXuhwyShw1t0ve7+/3lB+kFETMQz0fwRYMlwBVgVyQbEPq9lowU
        DC/US5J6rNiTcxwVC1ngDjrkQN+Sioev797XYQHzpXgKEs6s88BxSk8OOQ8LnILSzEfrmsRqDWBuN
        mbAJZvAMgWWJYXEJRgtBOAQXjj9MUCMnKZJicSUYp3lvKFWXDGV+RUf7rv5G12cGyHm2Y5PhjNUZk
        oOhci/MtsUR/9kZCDctwAyfJfwBTRCDpSyn5GG7LD0jwWV0qFWg7An5yj96EwFEQ24TIlgYWugIhm
        rb+7ThDQ==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf82-006bjC-MG; Mon, 30 May 2022 13:08:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: reduce the dependency on modules
Date:   Mon, 30 May 2022 15:08:02 +0200
Message-Id: <20220530130811.3006554-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shin'ichiro,

this series reduces the dependency of blktests on modular builds
of various block drivers.  There are still plenty of tests that
do require modules, mostly because a lot of scsi_debug and null_blk
can only be set at load time, but I plan to address those in the
kernel soon.
