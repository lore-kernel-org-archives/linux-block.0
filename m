Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEEC4743E
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A43261407
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhFDUCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:02:23 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:56177 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhFDUCX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:02:23 -0400
Received: by mail-pj1-f73.google.com with SMTP id y17-20020a17090aa411b02901649daab2b1so5790027pjp.5
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jBlEUGbY3b8g6dIjXWcbrWjBefIWreF/HXMBvYwoDp0=;
        b=jm8my7TF16J35qoVRbezLA3WooLXFZjasFcGwe7I9POWEyg8Ps/qcqZ2Yo/kVEVBsL
         p0eD8bDMQyqeOLCDxgv+pxoDtS3tSNses9uWQt+gM7oDVKmYBB86WkVjfJCprWJ+BhVj
         IVwCghFtTXluOmuABGDvnPlr5fzxFUchsBtHr2zdBnCB19P9YGaq5PclLTQ/HO3HiX3p
         m7i/9v5ucfa7dotnV/gz/N5cINZ/bi0+xG6g45QuKLDLlYk+/UYMtygawoY4tI5L1KiN
         Lwsdeh5imCR+xDI5XJRQk/S2+VZa5wMa6cHDSh8DiG7TuI+MidIOI9DXDCpNXLdozuis
         0OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jBlEUGbY3b8g6dIjXWcbrWjBefIWreF/HXMBvYwoDp0=;
        b=QCg1q+5SaVyDJTJNChwZHC5u5rQm2hx2OVHnuVoxehz845VjN9hE+NknV1CzTjKJQN
         KJk+eXF59eU9L/SqKHhfx2O+ZHRG4uyZBK4CpZ40qBZ0cV1+OqX9qr53C2mNwmO3QuUl
         UIfi+NiwfOEiy46Y4Sl30DMZWfVUrljnek7RATawDBH6EZbT9BnuoTXHhdV7V1/8Oayl
         8Dwo9FT3Hj6s468e2rCmkLxCRL0asN5uwLFJuWLCoD1YFlUWjz+X1VyQ6IyR8KCn8m8i
         MHPDpj+2PFJ3WogQft0kysVmwYJt8WuSmE1I1r6WOguguZJAkDAYuWt0nnOoFy313EtG
         Jsuw==
X-Gm-Message-State: AOAM532OEhiGyxxKokvBnYovLewdHOynOVAymYPHhPuZ0cROpq+OuJun
        j4DTISAwSEbRwXDO7Renpt3GgQLH+NBnJieh221Mp4HRJEqerI9x6rL6WYZivgtf8UXV0PqokWY
        odNKQHBLWtYrEAdCaGxKD4wwGLbXJ/lrsbWt4+bdVIT7yNMeTSBdlgNPs6jnOtuqhrlQL
X-Google-Smtp-Source: ABdhPJybK+Y+9fdHsla3It3WXjr5AOT/z7ea31AoJVRgzJKgiqpfrCt0fg3QxTSDhnBOdYvRVjuAHbqoA5o=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:aa7:9d92:0:b029:2e9:dcf0:a2ef with SMTP id
 f18-20020aa79d920000b02902e9dcf0a2efmr5949723pfq.46.1622836776394; Fri, 04
 Jun 2021 12:59:36 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:58 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-9-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 08/10] dm: handle error from blk_ksm_register()
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
 drivers/md/dm-table.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 29cbfc3e3c4b..e44f304b5c1a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1354,7 +1354,21 @@ static void dm_update_keyslot_manager(struct request_queue *q,
 
 	/* Make the ksm less restrictive */
 	if (!q->ksm) {
-		blk_ksm_register(t->ksm, q);
+		/*
+		 * This WARN_ON should never trigger since t->ksm isn't be
+		 * "empty" (i.e. will support at least 1 crypto capability), the
+		 * request queue doesn't support integrity (since
+		 * dm_table_construct_keyslot_manager() checks that), and
+		 * it also satisfies all the block layer constraints
+		 * "sufficiently" (as in the constraints of the DM device's
+		 * request queue won't preclude any of the intersection of the
+		 * supported capabilities of the underlying devices, since if
+		 * some capability were precluded by the DM device's request
+		 * queue's constraints, that capability would also have been
+		 * precluded by one of the child device's request queues)
+		 */
+		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
+			dm_destroy_keyslot_manager(t->ksm);
 	} else {
 		blk_ksm_update_capabilities(q->ksm, t->ksm);
 		dm_destroy_keyslot_manager(t->ksm);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

