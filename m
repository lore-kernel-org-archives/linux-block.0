Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B4FC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E521A20831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOaOohdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E521A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKSU6F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37690 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbeKSU6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:58:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so17214820wru.4
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5boqJ0UbdeKGVE+FnIPUcIjT6rvSPY3NTZlqHlp7eY=;
        b=cOaOohdKAX6mJq3wr2E6Hwafuweehz68ABx+2oXHJV0TZuvr4qoCBxK2dufKJTVwOI
         pIuCn8YJgCmgtwHWw/Bhfhh2VvhLRaaHj0AkzG5SpAmKlDJQv+8kIIsF2MoREcj+qMIQ
         C2MBBTrmNvoV9HHeYBNRnb8XIcdxNvnBM7qSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5boqJ0UbdeKGVE+FnIPUcIjT6rvSPY3NTZlqHlp7eY=;
        b=eoi1kXwuy0MgULilGwx4tHhw8NvCspzTuzusII27+zdDTzzIuJ0lNdRvZ+mUkA97Ss
         APNxukmC3RFd4z2g6ZjjbEmtmk2Swez0KM7ofCIEHHAGsx7Y5xs5V42zuxaT+VFL3sOY
         RAyXwKCdN8uC5wQoqn54XZn1aWn62q5FlpbWx7HpMnFwKMWFdGvx4XmZj2/7Vo+OztpU
         lgO0oxfDGKdleea4ab7a5aHTXwPjg9T5gH2o6BgplaTcJgE7wE12zY0Vi0dqx4zJFGkS
         yav41AZ0nXp9F7H5FQhlEGKveXibj2ooeJravxfzzQrmk4POrtS13qnPnWs63/iX4PbG
         XiTw==
X-Gm-Message-State: AGRZ1gL3YYctKnqDGQmqq3dJumQKUct+gz2tpHd/R6+7bm/u2raWuKAy
        thdcm4oS5ichfdhbHA66U/NBYw==
X-Google-Smtp-Source: AJdET5dlidO4F2+Oc57hof7n9lzgBTwrCKQE7wMlAYyJLDMl0bDi14Nwu5lkSVkH9OvaTIOR3d0voQ==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr17824022wru.300.1542623689487;
        Mon, 19 Nov 2018 02:34:49 -0800 (PST)
Received: from localhost.localdomain ([37.162.18.180])
        by smtp.gmail.com with ESMTPSA id e9sm14973298wro.16.2018.11.19.02.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:34:49 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 05/10] block, bfq: align min and default weights with the old cfq default
Date:   Mon, 19 Nov 2018 11:34:19 +0100
Message-Id: <20181119103424.3853-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181119103424.3853-1-paolo.valente@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

bfq exposes a cgroup attribute, weight, with the same meaning as that
exposed by cfq.

This commit changes bfq default and min weights to match the ones set
by cfq (before legacy blk was removed).

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 77651d817ecd..249d8128d3ee 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -22,13 +22,13 @@
 #define BFQ_IOPRIO_CLASSES	3
 #define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
 
-#define BFQ_MIN_WEIGHT			1
+#define BFQ_MIN_WEIGHT			10
 #define BFQ_MAX_WEIGHT			1000
 #define BFQ_WEIGHT_CONVERSION_COEFF	10
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
-#define BFQ_WEIGHT_LEGACY_DFL	100
+#define BFQ_WEIGHT_LEGACY_DFL	500
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-- 
2.16.1

