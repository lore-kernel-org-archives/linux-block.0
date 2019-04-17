Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8056AC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9BA20872
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebKeGHeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfDQCKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:10:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43345 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQCKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 22:10:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id c20so13451626qkc.10;
        Tue, 16 Apr 2019 19:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWc/oCnoras1AyWB6niD02t6m/9yqKbPHgDLRnpDnfU=;
        b=ebKeGHeqE8CFjCbb/8lqpz547w/IapbVZ0vHEFWx9P0pj/+bANwXAklKARibAPAG6D
         81Cr1ul4AUw5n4SkpN/8CbVJ4H7rHxP9TbIMU39CHmWwioqpwl4Zd7/4C2m6n6HLgjA6
         3zkyy3mOaqkBJi7PbPBtKJqzxq+oAU7GQS+QoEamA2TEh7+XXEAEhjW0F3ZnQmgMYOfx
         48080dfCKuWjg4CsYpT988SyRsYGq8Y4/MTuPB/VVRuQxQzlJmg4/CrxiyCOV9lj4iYK
         RhOTyuZR2UXDm7brL5vRRi0jRTejbc3pBKpiT4fL0YAzrJaicdmL0lR1Se5ARwbY/H2r
         f13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWc/oCnoras1AyWB6niD02t6m/9yqKbPHgDLRnpDnfU=;
        b=MLNhQyc61XKB5INljxEqIDDq6fLmX5HDplcXB5gsFrTfjDb/Zbf6Ba7CNvMTIzA+0H
         CD2wx2IGPnu1ihk0DA30Cj5PMket6flibAr/srXGFgG8dLUBWO01XIcVlCb/IRn0mg+Z
         xBhDsMGY9qGDOfHYBfX+QzBtt4icbAwogk9jq0YeJe7kYMdm2T3uz5KrWu5e+oo/MWe2
         u/ewpE9dyj0ap5WnmlVIjSUthNwTz13y+gKa4awhms0jKJQvmr7574eeeITU8VFGdhdm
         WlahQVPXgPw9He7twB5ZlQWlLrwDGvhAsLStH/dCqr6pjthIIyIHmQPjCwKFo71Dcc8A
         gLYw==
X-Gm-Message-State: APjAAAW4F7Ebwpuu90vbk4t72gENZPE+npgN7hVI96bP+IP7te8PL6M9
        YB5E2jah0Pi/2xbsD6CNvDjDj4S/v3s=
X-Google-Smtp-Source: APXvYqyFkJwNdv/UdWEAa6fLx4cNDhcRtG1O1AHb2rOrv6D6RPF44g+l0Dj0xLNOXqONwbPcKlWTLg==
X-Received: by 2002:a05:620a:108f:: with SMTP id g15mr64918534qkk.61.1555467048390;
        Tue, 16 Apr 2019 19:10:48 -0700 (PDT)
Received: from localhost.localdomain (179.187.200.226.dynamic.adsl.gvt.net.br. [179.187.200.226])
        by smtp.gmail.com with ESMTPSA id s55sm1497228qte.17.2019.04.16.19.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 19:10:47 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v3 2/3] blk-mq.c: Rework documention of blk_mq_init_sq_queue function
Date:   Tue, 16 Apr 2019 23:10:29 -0300
Message-Id: <20190417021030.82998-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417021030.82998-1-marcos.souza.org@gmail.com>
References: <20190417021030.82998-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Describing better what the function does, what the arguments are meant for, and
what SQ stands for.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-mq.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a8277a54c03..03f45d0cd795 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2675,9 +2675,21 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
-/*
- * Helper for setting up a queue with mq ops, given queue depth, and
- * the passed in mq ops flags.
+/**
+ * blk_mq_init_sq_queue - Create a new request queue with only one hw_queue (SQ)
+ * @set: tag set to be associated by the newly created request queue
+ * @ops: operations to be associated with @set
+ * @queue_depth: number of tags of @set
+ * @set_flags: flags that will be associated with @set, like BLK_MQ_F_TAG_SHARED
+ * or BLK_MQ_F_BLOCKING for example.
+ *
+ * Description:
+ * @set is initialized using @ops, @queue_depth, @set_flags, and using only one
+ * hw_queue (SQ). Later on blk_mq_alloc_tag_set() is called to validate and/or
+ * adjust values of the tag set. blk_mq_init_queue() is called passing @set as
+ * argument, returning a new request queue with @set associated.
+ *
+ * Returns the newly created request queue on success, or ERR_PTR() on failure.
  */
 struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 					   const struct blk_mq_ops *ops,
-- 
2.16.4

