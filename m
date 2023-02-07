Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC3C636D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 07:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBGHJF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 02:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGHJE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 02:09:04 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37970423C;
        Mon,  6 Feb 2023 23:09:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vb64zE8_1675753736;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb64zE8_1675753736)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:09:00 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH RESEND 0/3] cleanup for ublk
Date:   Tue,  7 Feb 2023 15:08:36 +0800
Message-Id: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, this series contain cleanup for code and comment of ublk including
removing unnecessary NULL check, unused variable and comment fix.

Ziyang Zhang (3):
  ublk: remove unnecessary NULL check in ublk_rq_has_data()
  ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
  ublk: pass NULL to blk_mq_alloc_disk() as queuedata

 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.18.4

