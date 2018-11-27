Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD34DC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 01:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6F204FD
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 01:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s++pL8e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF6F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeK0Mv7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:51:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35412 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeK0Mv7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 07:51:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so4498885plo.2;
        Mon, 26 Nov 2018 17:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WTwvgoCZRsGXJrsy5qBbc33rFwaI9Gq0zhdjYK2sLE=;
        b=s++pL8e3E840PqO8FX2ewoyVHJKBMxi2UtL2Saf87F7wybYP44uXjv2K7MK/9YMZwP
         L2cQHTG8ajHCoIT1FeYO+T00x2cwqbguK48YZvnqhzOXzF2QknxnHfwCTsgNDFccYxOr
         xAO7xqmIkKIjiDmlMbseJlLDYnOjLT1pMJNveITmBvwVP7GF9bMorPckQ06imKcL0OJ6
         KG/u6v0N/nSAwyGq8hcm1kBi6WULEXe79QjA6a+Tt0tjKuCfmSgnTKO5a+l3ue9b/M70
         tHBV1k7qgvTq6RlK5lPZURIc+VwG3zCFtq0z+x94mKAH2reEXnvEgFIlgJKIOLh9pQ6U
         ukzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WTwvgoCZRsGXJrsy5qBbc33rFwaI9Gq0zhdjYK2sLE=;
        b=tY4AoM3OAnPyhe4U3dkYmJnSLgr9e/Getls07es3MbKfUpT6pBOB1cqBXOHIKiITQD
         lWLqkaGOYHAML2OLlZOb8knbH6tBAhCtp9nCyUEXA8mpmnT9pMgtihRYvMmvb86DkJ0U
         vBGI1BnRyoMoY+iGoSpYdcxNxN+6h3I5aosnSTtLNmMG8tCRBr+5EtqVz+LuRggJNXbh
         osKHbcQulggUIzdejmy2zRehxQSvXFmm+at1CtbUFFkSnJC+dTvvSPRqB6Nl6kj2Tw/3
         ZKje6JaXzz9FMilDGdbFIjUrd1Lx3bw3J7I/XugNdcFLLBISvx9ESUIThhicvnbICy1j
         +kiA==
X-Gm-Message-State: AA+aEWYTJMpjH6SoDu5e99NZuLYbh2Z9mZ9NR5kjpeopuLOZqipBLjxv
        025hMrz2wRSfVgZ6mYep2k4=
X-Google-Smtp-Source: AFSGD/UqJktlt0i3CTFZk/tWBydoA7lPfOpEPGhXvTQbhtcWtEKB8XHu7vMWQ3Qvv6iUSN/cGAEhLA==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr30175676plc.211.1543283748013;
        Mon, 26 Nov 2018 17:55:48 -0800 (PST)
Received: from localhost.localdomain ([119.40.32.42])
        by smtp.gmail.com with ESMTPSA id a16-v6sm2157182pfh.107.2018.11.26.17.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 17:55:47 -0800 (PST)
From:   Hua Su <suhua.tanke@gmail.com>
To:     mb@lightnvm.io
Cc:     javier@cnexlabs.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, suhua.tanke@gmail.com
Subject: [PATCH] lightnvm: pblk: adjust the position of the lock
Date:   Tue, 27 Nov 2018 09:53:09 +0800
Message-Id: <20181127015309.2374-1-suhua.tanke@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add lock protection for list operations.

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
---
 drivers/lightnvm/pblk-core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..e490df217dac 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1286,24 +1286,27 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 	list_del(&line->list);
 
 	ret = pblk_line_prepare(pblk, line);
-	if (ret) {
-		list_add(&line->list, &l_mg->free_list);
-		spin_unlock(&l_mg->free_lock);
-		return ret;
-	}
-	spin_unlock(&l_mg->free_lock);
+	if (ret)
+		goto out;
 
 	ret = pblk_line_alloc_bitmaps(pblk, line);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (!pblk_line_init_bb(pblk, line, 0)) {
 		list_add(&line->list, &l_mg->free_list);
+		spin_unlock(&l_mg->free_lock);
 		return -EINTR;
 	}
+	spin_unlock(&l_mg->free_lock);
 
 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
 	return 0;
+
+out:
+	list_add(&line->list, &l_mg->free_list);
+	spin_unlock(&l_mg->free_lock);
+	return ret;
 }
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1

