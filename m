Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22009C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C3B206DF
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="lOnXXGZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfEDSjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:39:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45265 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfEDSis (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id w12so7812107ljh.12
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2vs+JZJ0vcQyBAc8rQKC8KdkrSPMNmEh8jTp9rX7l8=;
        b=lOnXXGZaeuzqk4g+X1Xa7z0IlVXP5cXmT/z7JUTtEsiTUXcFqoKNmaWuwjcu47AVBI
         m+nOc5x1HFidIjeSZNszVO2zj/aTrVlcofNbFl5xTVYmYGHf0pUQgfZn1qNerBcCgbsw
         Xm+Cp2FLN/SLqfBb3oRbFK0CdhRgvN1gz7Kq4eN6rXj+Ons+8TxW2I1ii66GG+WHW3A7
         uLl8XzlQ2odK6rTKkAV2SsN4Tv+T8DkMKVIGd6hz/ZYS2g/CbScx2ps4AyxSiwLl+wbA
         w0Er6gD0/TsEKqLQRyV0YkUOwPTcyjTNDhZV3+oFuLC6qyZKPGLG//nCK/IR9H2MzLlQ
         kApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2vs+JZJ0vcQyBAc8rQKC8KdkrSPMNmEh8jTp9rX7l8=;
        b=BwZSsdTlYpeOl49oJrY9Q4xSftCQwUqXaSmi19ucyuoehXHZjrM/K77BYjiLMZT/Ud
         IqpukTcr3FW7ZMpuSIf+0gPsUKS6FjFynlBj3yzjKZn93ou9OIYHNUkqHWsyLoHJ3Db2
         DJIluV0WMgrb0vxXaRWXyzJ/g7ZjPv/6RUjUuYsx0+6mpfwhsOlGyBIlPvVSkiaS3ELk
         lMAYJRJxF02VgdF8ZwJ8nCRuKtT26gCA2HGxRkTAADRhP5zuWEnencc+Z+w+X05wwF2K
         RTx97BwPdphytxPV6/KWZr55MRVHtPHUvL14hZ72ordRSHdzMjG6pPrioIheGKzPnjU4
         CURQ==
X-Gm-Message-State: APjAAAXymWZVItUq84YxnabOO2Jq1B9vWuH9xxImlXlp+RfS0xFu3SvC
        9TlvYwQYAyT8lXO5hywb5gi7kg==
X-Google-Smtp-Source: APXvYqyDpBdYEQsUwYZP/SDub2Id9MEj+wFJ+ztcMqId8TlOmi4wtpTbKgZFpj1Yy2g2FRTDQ3jmGQ==
X-Received: by 2002:a2e:3a0a:: with SMTP id h10mr6783737lja.1.1556995126659;
        Sat, 04 May 2019 11:38:46 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:46 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 20/26] lightnvm: pblk: GC error handling
Date:   Sat,  4 May 2019 20:38:05 +0200
Message-Id: <20190504183811.18725-21-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently when there is an IO error (or similar) on GC read path, pblk
still move the line, which was currently under GC process to free state.
Such a behaviour can lead to silent data mismatch issue.

With this patch, the line which was under GC process on which some IO
errors occurred, will be putted back to closed state (instead of free
state as it was without this patch) and the L2P mapping for such a
failed sectors will not be updated.

Then in case of any user IOs to such a failed sectors, pblk would be
able to return at least real IO error instead of stale data as it is
right now.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 8 ++++++++
 drivers/lightnvm/pblk-gc.c   | 5 ++---
 drivers/lightnvm/pblk-read.c | 1 -
 drivers/lightnvm/pblk.h      | 2 ++
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 38e26fe23138..73be3a0311ff 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1703,6 +1703,14 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
+	if (line->w_err_gc->has_gc_err) {
+		spin_unlock(&line->lock);
+		pblk_err(pblk, "line %d had errors during GC\n", line->id);
+		pblk_put_line_back(pblk, line);
+		line->w_err_gc->has_gc_err = 0;
+		return;
+	}
+
 	line->state = PBLK_LINESTATE_FREE;
 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index e23b1923b773..63ee205b41c4 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
 	wake_up_process(gc->gc_writer_ts);
 }
 
-static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
+void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list;
@@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
 	/* Read from GC victim block */
 	ret = pblk_submit_read_gc(pblk, gc_rq);
 	if (ret) {
-		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
-								line->id, ret);
+		line->w_err_gc->has_gc_err = 1;
 		goto out;
 	}
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 7b7a04a80d67..27f8a76d8bd8 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -641,7 +641,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 	if (pblk_submit_io_sync(pblk, &rqd)) {
 		ret = -EIO;
-		pblk_err(pblk, "GC read request failed\n");
 		goto err_free_bio;
 	}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 90c703d3f84c..e304754aaa3c 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -437,6 +437,7 @@ struct pblk_smeta {
 
 struct pblk_w_err_gc {
 	int has_write_err;
+	int has_gc_err;
 	__le64 *lba_list;
 };
 
@@ -917,6 +918,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active);
 int pblk_gc_sysfs_force(struct pblk *pblk, int force);
+void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
 
 /*
  * pblk rate limiter
-- 
2.19.1

