Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642EAC433E3
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 20:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A5220738
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 20:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pX8HeaHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXUpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgHXUpH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 16:45:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DBEC0613ED
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 13:45:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o8so11955500ybg.16
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UhQXWcJr+5AoGLVvN3r8tMmBPLG9sprnFDAtBah1ytY=;
        b=pX8HeaHXQwwtYqEGVbc7owuncNK+VkVxqA6JrBLkHY0VR5Fq5NOdR6ewx8RTxsmV7P
         vL/VyLPRSdOCsaBC26za2O+cn40t0EE7laqYOe6/JcNeAoF0/2u9NDJT0uXGF+EEzx75
         kCBRCTdBhW2tSC5tm5MevbX3P7/mFYSq0B3BfU1EKZ0vGRKwfEhAsJR2HJUZZL5cgnLg
         m99+a3KP7Lz9DeajCxjgNCRuauILDxJm0EGQB7Ey/M81yS2G3qC7VYpkyVNsTcK4inIo
         tTckhqkb1oDaAtBwIhTgSaP36fqUXffXWyxtWMOY/jejZ7iXUWJ5NPWfDlnpFKuxikzK
         RnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UhQXWcJr+5AoGLVvN3r8tMmBPLG9sprnFDAtBah1ytY=;
        b=ZtgcBJwtJXKeWbOP4hcGOm2B0gmKknNKqYzaj9NlibNSUhyDHFfIbexj3LXs9xHx2M
         ON9Cnk3Lvc3R1DRWzni8gSdsM/2cqTDpRWQ8uyleiyn575A4GW1Rh9tI/KcIHf3LzOOE
         xzptoBbkPv0K2pldneaKNBFVbQK8+lerMbUNs+6BGk8Ti5qPrRsQWvDKAxQE0Ek4GR3p
         OrVCjKxa08npAoCbOeLdRJ+eZ89NMBNTyU0ir+soQ74ygnKL/Jvm59f9mQV5aAoW6/Oa
         kMzf8qaqcxTY1ptJp/1WhQ9FoVcHhD/wmgPC05CtxqWdrWPVzn/OlN9tdtZqDKOYkaQM
         ayNQ==
X-Gm-Message-State: AOAM530OpqlvyDeemaqqHkP9/M5T1PikZpbcBd09/I/PhrK1jHCx9nEW
        aJdpdfV3mJY/2abb+j5ijTdQQODluCE=
X-Google-Smtp-Source: ABdhPJyQtPlZNY8qKcSrGSypIXx7bMWbjne4oaHh5ALmmnqay5BvInjL0APbUOk1+SCle/Y14u8sml+iLig=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:1ea0:b8ff:fe75:bae4])
 (user=khazhy job=sendgmr) by 2002:a25:1189:: with SMTP id 131mr9454007ybr.364.1598301905865;
 Mon, 24 Aug 2020 13:45:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:45:01 -0700
Message-Id: <20200824204501.1707957-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CAP_SYS_ADMIN is too broad, and ionice fits into CAP_SYS_NICE's grouping.

Retain CAP_SYS_ADMIN permission for backwards compatibility.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/ioprio.c                  | 2 +-
 include/uapi/linux/capability.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 77bcab11dce5..4572456430f9 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_ADMIN))
+			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_NICE))
 				return -EPERM;
 			/* fall through */
 			/* rt has prio field too */
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 395dd0df8d08..c6ca33034147 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -288,6 +288,8 @@ struct vfs_ns_cap_data {
    processes and setting the scheduling algorithm used by another
    process. */
 /* Allow setting cpu affinity on other processes */
+/* Allow setting realtime ioprio class */
+/* Allow setting ioprio class on other processes */
 
 #define CAP_SYS_NICE         23
 
-- 
2.28.0.297.g1956fa8f8d-goog

