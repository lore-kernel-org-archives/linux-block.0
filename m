Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF5C07E9C
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8604261CB9
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGGFcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhGGFch (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514AFC061760;
        Tue,  6 Jul 2021 22:29:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m3so2059577oig.10;
        Tue, 06 Jul 2021 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUUA/OMHV43Qf9wUeTFKaW1N3Z/e6TEsnjEdV6JbzIs=;
        b=O8yBFIWxpmsOT8njJ5ahG6yy2+FKk0r/sJSXeoapbK3qHq6/+XtSfSioINKw1vbUWM
         FMsKt35md4p3OQtSQP1Qp+mOKFUs7yR8TJPugozcZ2gkL/NxxNQxfIBpvZmzntFtUAaF
         KkKE9sUAzTpTbwHWkOq8viGRF2MGKISSAKVTsElsA7yq0Il8xKreetA3vCmvMTb9IsV/
         aH4QM22S94q870EL2ke3K76G/Y4nuVWliOLvQlGy2jJKVlmcVper9QbzhqhTxrrKUXnh
         vodfXdZGEQ1ae+yoIW0MHTEiLcwzs5MXmVB0sRC/sGRNcvAqdePJiplJ+0b5f3RoLPyt
         Fh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUUA/OMHV43Qf9wUeTFKaW1N3Z/e6TEsnjEdV6JbzIs=;
        b=GdpZM9KPLBXNbC8/zSBM9PkTYUBXTta1Z4qGsWRWRUOzPEQHknlQsSsBEk0A+f/yiM
         QtmYyZkSZc0VWvb3c+IfELs4zw/0i8vTGvXaMQzmiZ7XbOBQYL78pJddbsVKBEGpJsdV
         z03ef9QbSg7TZ7j3xpZ48n3sz1hs3eGtGgIrlKeVxLZVSJxevwvLX/AUCV8bHM/Yuldd
         WpGKY/W3G+VKIexbIgQH9rj6hLbqmygfs5slEveNXB8bMfqbfSOFrcLDx9J6mnP/wavA
         gHXtdjsucbhm0tsOUsMvD5pWzij2Vfdg+UIdrIHYuQST+8J6bUQ5yiJK50hUya/H/h5e
         IsHA==
X-Gm-Message-State: AOAM5333pzx+FRbof/9DLSOy0KIJ+3KeUJCXC4jJeHfwZHFkrt+MxplV
        hIQz7uRU7wJluQ5rD6FWErUo8WpSEW4=
X-Google-Smtp-Source: ABdhPJzJ0AdXsGTVs36rKWCYXnpFMyQdSNRdGzqmXJVaBZcD+eKUB/zaPijFL7uxcJJBXgE8HbugbQ==
X-Received: by 2002:aca:5793:: with SMTP id l141mr3429760oib.14.1625635796642;
        Tue, 06 Jul 2021 22:29:56 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:56 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 5/9] ufshcd: handle error from blk_ksm_register()
Date:   Tue,  6 Jul 2021 22:29:39 -0700
Message-Id: <20210707052943.3960-6-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

Handle any error from blk_ksm_register() in the callers. Previously,
the callers ignored the return value because blk_ksm_register() wouldn't
fail as long as the request_queue didn't have integrity support too, but
as this is no longer the case, it's safer for the callers to just handle
the return value appropriately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/scsi/ufs/ufshcd-crypto.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
index d70cdcd35e43..0fcf9d6752f8 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.c
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -233,6 +233,15 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
 					    struct request_queue *q)
 {
-	if (hba->caps & UFSHCD_CAP_CRYPTO)
-		blk_ksm_register(&hba->ksm, q);
+	if (hba->caps & UFSHCD_CAP_CRYPTO) {
+		/*
+		 * This WARN_ON should never trigger since &hba->ksm won't be
+		 * "empty" (i.e. will support at least 1 crypto capability), a
+		 * UFS device's request queue doesn't support integrity, and
+		 * it also satisfies all the block layer constraints (i.e.
+		 * supports SG gaps, doesn't have chunk sectors, has a
+		 * sufficiently large supported max_segments per bio)
+		 */
+		WARN_ON(!blk_ksm_register(&hba->ksm, q));
+	}
 }
-- 
2.25.1

