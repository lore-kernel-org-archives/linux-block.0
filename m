Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEA4C04AAA
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BB5206DF
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="0VsA2vvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfEDSip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37317 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfEDSip (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id 132so127125ljj.4
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQ/F91AqqahwzDmzRYg8075AZY4HOxSjDSQnasY0MSg=;
        b=0VsA2vvNiCwi/3NizZ/lIqxct6ZJWOymwyEubYEPu7TK/viAPZnxDFWLaRUFnpQy4R
         wFvJ4G/ENkpKps/Kxy8MR52I7a1qVz2KF0UCSI0tn3gLxnDB5XMWfjikJo9TkbSB8J5O
         jInIOybW4UdZfezQAfE+ER3aAfNq3v0dX14E5L2w/46bJsIPgsKv2T1hCbkhHynGVb/n
         u4Qh2u6SB9SxS2b2bslcnLtpE++3YqsAK7AKrWCig4z3eKry1bBv1FTi2SMJw8WUlvSk
         sEWqPyZPXk1cOpfQRgDKj3gBiD309ULlmLGXEnMlsBawdXJsk4n0FRvNY6PjXCVBdLTC
         Xh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQ/F91AqqahwzDmzRYg8075AZY4HOxSjDSQnasY0MSg=;
        b=ohxJeHCJld7ogJJ4uQ5ZshfiLVkWNeTqER87rlYnQn9kliN5N5MxtZehuZ3iuWTyJG
         gl5STcZDftxWJ0TpBYRAFKV56r9MB5kBgGfNqkDh9fjZCkyL9qcuwNYjL4orTNB8nESF
         HbxrHdeP+VLmroi7PSPQ9r+wFfA41AgfHJpdC8gsU+GoyEVrD7yhX5cQvfWRGaN9xW/N
         8MdaSS1dOyN9LJuQn6/D1s8IxwwB3r+xJDiDvYwMwJ5xhEO5ECkpWWhSDtqp/jYY1Lzy
         cvboOtLbxfaPjN6nri+t7RxrbPdU1P5RCa5W0NzRtC0ewScNIj9RMY3JFsgfIZkPdd/D
         fRIA==
X-Gm-Message-State: APjAAAUjIQKTLiAHSNsjLWk6ikR6Zw0aEZPWWQz+dGOanFGkwW1F6vKk
        Y3T189BqTFFhGWxOsF36bQ9jZA==
X-Google-Smtp-Source: APXvYqxtiv102Cbm6gu1TZRu6QhFqSZ6qbPjj+8k/9IDGLCljN+nGo6Djs8R4lFiw4/ziq2YOX9huQ==
X-Received: by 2002:a2e:9f53:: with SMTP id v19mr9012205ljk.0.1556995123138;
        Sat, 04 May 2019 11:38:43 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:42 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 18/26] lightnvm: pblk: wait for inflight IOs in recovery
Date:   Sat,  4 May 2019 20:38:03 +0200
Message-Id: <20190504183811.18725-19-mb@lightnvm.io>
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

This patch changes the behaviour of recovery padding in order to
support a case, when some IOs were already submitted to the drive and
some next one are not submitted due to error returned.

Currently in case of errors we simply exit the pad function without
waiting for inflight IOs, which leads to panic on inflight IOs
completion.

After the changes we always wait for all the inflight IOs before
exiting the function.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 124d8179b2ad..137e963cd51d 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -208,7 +208,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (rq_ppas < pblk->min_write_pgs) {
 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
-		goto fail_free_pad;
+		goto fail_complete;
 	}
 
 	rq_len = rq_ppas * geo->csecs;
@@ -217,7 +217,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto fail_free_pad;
+		goto fail_complete;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -226,8 +226,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
 
 	ret = pblk_alloc_rqd_meta(pblk, rqd);
-	if (ret)
-		goto fail_free_rqd;
+	if (ret) {
+		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
+		bio_put(bio);
+		goto fail_complete;
+	}
 
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PWRITE;
@@ -274,7 +277,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		pblk_up_chunk(pblk, rqd->ppa_list[0]);
-		goto fail_free_rqd;
+		kref_put(&pad_rq->ref, pblk_recov_complete);
+		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
+		bio_put(bio);
+		goto fail_complete;
 	}
 
 	left_line_ppas -= rq_ppas;
@@ -282,6 +288,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	if (left_ppas && left_line_ppas)
 		goto next_pad_rq;
 
+fail_complete:
 	kref_put(&pad_rq->ref, pblk_recov_complete);
 
 	if (!wait_for_completion_io_timeout(&pad_rq->wait,
@@ -297,14 +304,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 free_rq:
 	kfree(pad_rq);
 	return ret;
-
-fail_free_rqd:
-	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
-	bio_put(bio);
-fail_free_pad:
-	kfree(pad_rq);
-	vfree(data);
-	return ret;
 }
 
 static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1

