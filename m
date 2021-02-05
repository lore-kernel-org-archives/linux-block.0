Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D5C433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 06:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99E664F3F
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 06:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBEG4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 01:56:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhBEG4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 01:56:33 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX5k92kpVzlGnx;
        Fri,  5 Feb 2021 14:54:09 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 14:55:40 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH v5 0/2] fix a NULL pointer bug and simplify the code
Date:   Fri, 5 Feb 2021 01:56:48 -0500
Message-ID: <20210205065650.2357457-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v5: Adjust the title and add “Suggested-by”.
v4: Share exception handling code for if branches and 
	move put_nbd adjustment to a separate patch.
v3: Do not use unlock and add put_nbd.
v2: Use jump target unlock.

Sun Ke (2):
  nbd: Fix NULL pointer in flush_workqueue
  nbd: share nbd_put and return by goto put_nbd

 drivers/block/nbd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.4

