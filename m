Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57551C432BE
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 03:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCB061019
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 03:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhHIDd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 23:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhHIDdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 23:33:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2886CC061799;
        Sun,  8 Aug 2021 20:32:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x15so21690881oic.9;
        Sun, 08 Aug 2021 20:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Z9rErwEGMPwtnMf+3tIIodscSEF7PbZLxINPsDN2pY=;
        b=IXXn0yae9+6114TDZPAO0JeAF6zuOlZMoTq8VpXENUmAQNQ7J2EPFPNQ1MVrjnoFFz
         hNIsg3Mz9dhGm/RzwzxruxNoHxZzgWUlx19wJxgtnFjNerMYuLqhUK3XGXsxuBvwbadd
         RYgG4+gNYwTOzNbjrYL36s8kU+HEvPubnywgq+2mStie6v17xHJXnVEZjbH1JKYo2m+Q
         ILUxBRClj7WKlpWioSxVcF9ggIcvHDTzmdko9uNmv18JFtfTp5sm4jj3ZAfswiSDUIXV
         sNCpMddoKvR/GemueDFaL4624RRz9Bq3pJAVoUqXeqY9vK5Vn3SfMM6J8SmHgepj1JET
         eg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Z9rErwEGMPwtnMf+3tIIodscSEF7PbZLxINPsDN2pY=;
        b=iuwYWC4olbOwjJWXosBNLS98aopxFv1hmlOXTVksI9NQYnWZLcZLkD05YHwIdjajgv
         DF15x53OVyMtH3d+KjL+tk/sxwRvt8PB7ji/fHmEt0tnGsApDpNbil51CgZ6Dbq/Hvna
         mCvhdw/ZLOM5rCNDcQFq+f7kvmeNMfjvTv51iLu2X4dGhRv+tAWtllyivrOQrs7Y16n0
         kmJXRPzDQyrN3E/G64/O5h238D5XAs4oBFktxBX0yD4O2yQtaRYjNYIysHyT4oEKhrlu
         AzIG7fMwngXyggLb4VWMQ/h74xcif9GHk63FjwWjCDhHJ2296mPf0FqujTxDDZ8eQhK1
         vzOw==
X-Gm-Message-State: AOAM530fWX7LrGVnos/5gcPXdzxrMxVY2hWSUVNFUX3Tyqe1bIS3Ai5f
        aBFnUXSqyLp1muo76hKDCn8OZgqsstRFCNHE
X-Google-Smtp-Source: ABdhPJw6WuVvMNMovP224EhottNlKQH77w4NGsl9QyH4Cca4nRDS2xno/r4Q9LNL1jTtzb/qY2vupA==
X-Received: by 2002:a05:6808:194:: with SMTP id w20mr13809607oic.142.1628479975581;
        Sun, 08 Aug 2021 20:32:55 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id r7sm1463646oij.14.2021.08.08.20.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 20:32:55 -0700 (PDT)
From:   Ian Pilcher <arequipeno@gmail.com>
To:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     axboe@kernel.dk, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: [RFC PATCH v2 08/10] block: Add init function for block device LED trigger
Date:   Sun,  8 Aug 2021 22:32:15 -0500
Message-Id: <20210809033217.1113444-9-arequipeno@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809033217.1113444-1-arequipeno@gmail.com>
References: <20210809033217.1113444-1-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Register the blkdev LED trigger

Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
---
 block/blk-ledtrig.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/block/blk-ledtrig.c b/block/blk-ledtrig.c
index d02f32205985..14b1d33a2953 100644
--- a/block/blk-ledtrig.c
+++ b/block/blk-ledtrig.c
@@ -406,3 +406,38 @@ static ssize_t blk_ledtrig_blink_store(struct device *const dev,
 
 	return count;
 }
+
+
+/*
+ *
+ *	Initialization - register the trigger
+ *
+ */
+
+static struct attribute *blk_ledtrig_attrs[] = {
+	&blk_ledtrig_attr_blink_on.attr,
+	&blk_ledtrig_attr_blink_off.attr,
+	NULL
+};
+
+static const struct attribute_group blk_ledtrig_attr_group = {
+	.attrs	= blk_ledtrig_attrs,
+};
+
+static const struct attribute_group *blk_ledtrig_attr_groups[] = {
+	&blk_ledtrig_attr_group,
+	NULL
+};
+
+static struct led_trigger blk_ledtrig_trigger = {
+	.name		= "blkdev",
+	.activate	= blk_ledtrig_activate,
+	.deactivate	= blk_ledtrig_deactivate,
+	.groups		= blk_ledtrig_attr_groups,
+};
+
+static int __init blk_ledtrig_init(void)
+{
+	return led_trigger_register(&blk_ledtrig_trigger);
+}
+device_initcall(blk_ledtrig_init);
-- 
2.31.1

