Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09395C19F2D
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 09:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiHIJR5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiHIJRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 05:17:45 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1822B35
        for <linux-block@vger.kernel.org>; Tue,  9 Aug 2022 02:17:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLpL3ef_1660036654;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VLpL3ef_1660036654)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 17:17:39 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH 0/3] ublk_drv: cleanup and bugfix
Date:   Tue,  9 Aug 2022 17:16:26 +0800
Message-Id: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following 3 patches are cleanup and bugfix. Patch 1 and 2
simply inline a function and update comments for ublk_drv's
aborting machemism.

Patch 3 fix a null-deref bug reported by myself. Ming gives out a
patch and I integrate it with more comments on this bug.

ZiyangZhang (3):
  ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
  ublk_drv: update comment for __ublk_fail_req()
  ublk_drv: do not add a re-issued request aborted previously to
    ioucmd's task_work

 drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.14.4.44.g2045bb6

