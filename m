Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A5C433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5176961A45
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhCYV1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhCYV1N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EBC06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a19so1843422ybg.10
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sXfRUgmRe7kH6AU5n/x2XWTuNQDYYUL8f3DAKwSKEzw=;
        b=AnRR1mnKpdEoFdG1gN035lAY93R2KGeI6lEzSv4jdsznjZwNgsmypdE7iioWFPasJ9
         kkpo9QDUQhkLE5C/7Im6GCZo6xSTN4rTX93pOPcxYDT55LOOCRgw0oZ5Hl6+jy62ShYu
         6OutHCkIzXZoEU0+M0hWhBgE/PbHpI0Tv3Xc20Z50n1j891rZd1mijgvr8lVeuv649yP
         JGok9RRTZQ8m/AoapgbgajjfTsU+JR+/E5B0C6KuqYkzh7Vh5vYDsWGyARRnQ1bLwF9n
         7YhbC+dut7xa7s27Pv/EkiHvBju9UKIIgcaFyDyeJk6LvSYkF5dQX8znbwtFWD0PsWGi
         6/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sXfRUgmRe7kH6AU5n/x2XWTuNQDYYUL8f3DAKwSKEzw=;
        b=thu2ff8MXv1VYnx43djvmISHnDvWYxlQkaA9KRrVdj/1wiQuPkb1oMOj8ZInwNsSwZ
         Mz+zmjigY41q6DHO6jvLuAm8hmdFiOBrGGapNdYHM3Q8zsb39DwryEaODwLRc++2/8hY
         mry4FV7JyDWGXuQMkxKJcfHVbiAaBv14ceQRf1Ofn79HufdsFt8WPoxdM0voeXHNdPug
         PvDP0wUTvoaPLjjSVBv5ojvuh0TIOPTcULETAkArndxf0GOF15yjFcuxDDwk9l/OZS/H
         pctqQDx7W4qyFWEkFfq0yK2rKHmZg+e8dI++P+8xrqhSBLJ/B7d7OuLZsZ9TUMCJJic5
         xrpg==
X-Gm-Message-State: AOAM5320kMioPeZsT3LNrEGvzBHlq+a/GezX0jkVvUltX7atA3dAUWht
        s2Tl92UXbhWfX8bbMN0Nxx6K638hxLXQ/A/wq+n6jOSXhxq31eCIV5if+H5a639QRCQ/+gki3uS
        GMC5bH0W1qeHOe32BwZZbp5pysbozD8uGV9j0FEp/IW2UJnDMmCQ7+dEmDT5kHPVdIJPj
X-Google-Smtp-Source: ABdhPJz7DN29DrVMX+YcK1AWw6+N8szReisPV6zaP6Y2M4RZL7AZWIt95VSCM5um9M2HM8lBbP8Iet4DGCA=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:a0cd:: with SMTP id i13mr15307478ybm.302.1616707632232;
 Thu, 25 Mar 2021 14:27:12 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:03 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-3-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 2/8] dm,mmc,ufshcd: handle error from blk_ksm_register()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Handle any error from blk_ksm_register() in the callers. Previously,
the callers ignored the return value because blk_ksm_register() wouldn't
fail as long as the request_queue didn't have integrity support too, but
as this is no longer the case, it's safer for the callers to just handle
the return value appropriately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-table.c            | 3 ++-
 drivers/mmc/core/crypto.c        | 6 ++++--
 drivers/scsi/ufs/ufshcd-crypto.c | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index db18a58adad7..1225b9050f29 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1372,7 +1372,8 @@ static void dm_update_keyslot_manager(struct request_queue *q,
 
 	/* Make the ksm less restrictive */
 	if (!q->ksm) {
-		blk_ksm_register(t->ksm, q);
+		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
+			dm_destroy_keyslot_manager(t->ksm);
 	} else {
 		blk_ksm_update_capabilities(q->ksm, t->ksm);
 		dm_destroy_keyslot_manager(t->ksm);
diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
index 419a368f8402..616103393557 100644
--- a/drivers/mmc/core/crypto.c
+++ b/drivers/mmc/core/crypto.c
@@ -21,8 +21,10 @@ void mmc_crypto_set_initial_state(struct mmc_host *host)
 
 void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
 {
-	if (host->caps2 & MMC_CAP2_CRYPTO)
-		blk_ksm_register(&host->ksm, q);
+	if (host->caps2 & MMC_CAP2_CRYPTO) {
+		if (WARN_ON(!blk_ksm_register(&host->ksm, q)))
+			host->caps2 &= ~MMC_CAP2_CRYPTO;
+	}
 }
 EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
 
diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
index d70cdcd35e43..f47a72fefe9e 100644
--- a/drivers/scsi/ufs/ufshcd-crypto.c
+++ b/drivers/scsi/ufs/ufshcd-crypto.c
@@ -233,6 +233,8 @@ void ufshcd_init_crypto(struct ufs_hba *hba)
 void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
 					    struct request_queue *q)
 {
-	if (hba->caps & UFSHCD_CAP_CRYPTO)
-		blk_ksm_register(&hba->ksm, q);
+	if (hba->caps & UFSHCD_CAP_CRYPTO) {
+		if (WARN_ON(!blk_ksm_register(&hba->ksm, q)))
+			hba->caps &= ~UFSHCD_CAP_CRYPTO;
+	}
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

