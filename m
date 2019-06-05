Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF1C28D18
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5C206C3
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 14:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfFEOQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:16:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728161AbfFEOQx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 10:16:53 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D265EF6D1C1336EA5915;
        Wed,  5 Jun 2019 22:16:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Jun 2019 22:16:37 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Subject: [PATCH] block: Drop unlikely before IS_ERR(_OR_NULL)
Date:   Wed, 5 Jun 2019 22:24:27 +0800
Message-ID: <20190605142428.84784-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
so no need to do that again from its callers. Drop it.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b97b479e4f64..1f7127b03490 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -881,7 +881,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			blkg_free(new_blkg);
 		} else {
 			blkg = blkg_create(pos, q, new_blkg);
-			if (unlikely(IS_ERR(blkg))) {
+			if (IS_ERR(blkg)) {
 				ret = PTR_ERR(blkg);
 				goto fail_unlock;
 			}
-- 
2.20.1

