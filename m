Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B49DC25B06
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 02:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiHOCg6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Aug 2022 22:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHOCg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Aug 2022 22:36:57 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3F13D5B
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 19:36:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMCMnrG_1660531006;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VMCMnrG_1660531006)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 10:36:53 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V2 0/3] ublk_drv: cleanup and bugfix
Date:   Mon, 15 Aug 2022 10:36:30 +0800
Message-Id: <20220815023633.259825-1-ZiyangZhang@linux.alibaba.com>
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

From V1:
- reserve comment on __ublk_fail_req() to notify that aborted
  requests may be issued again.
- only reference ublk_io in branch of not using task_work_add()

ZiyangZhang (3):
  ublk_drv: check ubq_daemon_is_dying() in __ublk_rq_task_work()
  ublk_drv: update comment for __ublk_fail_req()
  ublk_drv: do not add a re-issued request aborted previously to
    ioucmd's task_work

 drivers/block/ublk_drv.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
2.27.0

