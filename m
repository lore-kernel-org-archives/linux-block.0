Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C12C433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E454E20714
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 14:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgIGOKz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:10:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729707AbgIGOJm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Sep 2020 10:09:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47D942B6B023013B0D8C;
        Mon,  7 Sep 2020 22:09:36 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 22:09:32 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: [PATCH -next] blktrace: make function blk_trace_bio_get_cgid() static
Date:   Mon, 7 Sep 2020 22:06:52 +0800
Message-ID: <20200907140652.9060-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The sparse tool complains as follows:

kernel/trace/blktrace.c:796:5: warning:
 symbol 'blk_trace_bio_get_cgid' was not declared. Should it be static?

This function is not used outside of blktrace.c, so this commit
marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4b3a42fc3b24..c0887f32f647 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -793,7 +793,7 @@ static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 	return cgroup_id(bio_blkcg(bio)->css.cgroup);
 }
 #else
-u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
+static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 {
 	return 0;
 }
-- 
2.17.1

