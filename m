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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FD0C4743D
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9385613AD
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 19:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFDUBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhFDUBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:01:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444EC061768
        for <linux-block@vger.kernel.org>; Fri,  4 Jun 2021 12:59:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lb17-20020a17090b4a51b029016bc5d1a583so2676762pjb.4
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kd1E77D6aPxR9eaBjS43P1vtWPIox0q43LsvhH1VUfg=;
        b=slBbxZ7y6pnAglU6rF2VZ7Pn/uFpNALrK5ZbJmvrcqUfyvWtXQ4DJzEXClxVSHSKV3
         j0rQodPMbpzXNW3zZ5ZPmY/UAaEYEl43nnkF6gvU2QI00dCLmKbZ89OHwqY+6EaXkFIL
         nsKVawzGjmYw2Y61BKJx9hPcsO5o0kGVoiCvlvwSuDWWw0l2XZiTOxCEVtik8mj/x484
         1++e5KQki6hBpinevssj6mAO8A7nwvBuJcb25kB+ff++tObZaFuKQ/OYy3Esgx4SV8ke
         /lWfjoDmxGeuuQ1sarp1OGCXpsd2Q1r9oDF0ys16ljSPzBvyJa2FSgJe0dD1ds3XxGA3
         e8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kd1E77D6aPxR9eaBjS43P1vtWPIox0q43LsvhH1VUfg=;
        b=Am5bw15zl0eKb08x4eHa5o25477Hs9txPazI80lA6jLxztVoKCfGiR5VbntRO9d2A7
         N8AUUHYZ9qG1tt6yKQbVZbhiIaRx8r57xKAkY7MA9vf0LSMkWqb8mtSKPQbwI/QEPpF1
         l1IEAbp8xDNh69s8LPTUp4eo5i6XIrTPi/n4UFBHUA6eGhplEaxu5gp/0ZVgsdNh67LT
         xQ4Hs7qcYSMqNYTeph6grb+4Bu03MW4uxMt+e44d2i3iN5XGTBoPPisG+DLuEpNAuBRX
         XHdSx9ppUOxf3LsaLpKe+aVAhG9MH+YrOCXKzHihvlmw1u/6aSZTmsxf0KINal4wD6X/
         s1Wg==
X-Gm-Message-State: AOAM531tdTbIw33jyWFxnxZdhPZpkt5BuEm4ry/kKoedCoLQErr6LCCv
        4YexwNQxs/DwyuEM+aFduBvSnDGgkQ8KU5VJBdh7VGLQ4bKqa5de1o2BE1TJjaY21OpikO6ayp7
        Qyk2/NSX9otZJ64gFqS2/ij2uSvY1SX8c6TYEWC5bEvga8tfVnn9vafxrgY+lTeLFroES
X-Google-Smtp-Source: ABdhPJyFd5ZwvoVxCS1V14luiBtciIHgcOru+4XK3wB3hc+geHyGYCQsnOy5fsYAo81EETM/7MtLS2AJewc=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a62:380b:0:b029:2e9:9eb1:ba71 with SMTP id
 f11-20020a62380b0000b02902e99eb1ba71mr6023434pfa.80.1622836759568; Fri, 04
 Jun 2021 12:59:19 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:56 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-7-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 06/10] ufshcd: handle error from blk_ksm_register()
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
2.32.0.rc1.229.g3e70b5a671-goog

