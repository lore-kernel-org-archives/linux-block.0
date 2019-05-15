Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494CC04AB4
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 00:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E5020843
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 00:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="hmkVWGZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfEOAj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 20:39:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEOAj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 20:39:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so405609pgl.5
        for <linux-block@vger.kernel.org>; Tue, 14 May 2019 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=from:to:cc:subject:date:message-id;
        bh=aBmiAOmZcdYY0O365EiKabnGd5fG0JCgLUx8je4V9gc=;
        b=hmkVWGZbVyVVrQmfIO/zA/A5PprcEYZo9Fgh2bNu/OxBdej3W4auhEAANb9btrTC3z
         6WnUnSvpBLIArEZcgVTJOdv5AvWyxa5RbFtgGMjZNP7BYe38q1j7z3E2vtv72P3is6Ej
         Y8zLMqyZwp9gpLW3cYA/2fv3s+h6aYy08zeAk5vQmOtmh3OC7VyCeyUEscFXQx6r2jlI
         GycW9Jf+mzGfJXNLVPZC4M3ySs8k/XPhjas7X8U2XXwaClcmq+AfNNGVpO5Lgu14GqXx
         bPpgxnqG2/P2hygAyd2Qy6hoAvO2UqN9bqm7tv05qd9DlkfC+87qXWIn8mlo73vKzXlp
         T3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aBmiAOmZcdYY0O365EiKabnGd5fG0JCgLUx8je4V9gc=;
        b=sYcV/6IS7I7pwliT0Qc1iDPaP7lp98m4JbGW9YasiVdL/UrCwua2nYjO3P6z7CYqwb
         79SHA4vjBV4GY2+OHUXS1nOBgZpkAlK1U9GQTqBFGM3O01F8HdD7gvSB4walK9QTG1Vi
         L9CfizS+a14Pm22Bm2ZW87NbmRlONUEZ4wq1xzyFN5Ya385hognN8EIRZ2ZSAo3iditw
         SPuLG4dsyu7drmvKKQpT5IuL4JuqPHgNZYEK4BE9GDIL56mS5aCb7NjE64sJRKgDsUKG
         5WQ56/fqWGPQRrIJEgl1+NL5Msb/qDqbWmiPU/0ODFgxlrenAMSMoDXRicKEoFlbEsHs
         lU7Q==
X-Gm-Message-State: APjAAAUeqoRJwymMguNTMVHTyh7yy96T6rbVDOaAJk87RNR3dYBR+WV/
        68D1ULs17o7dlogJN8CJiGSG0Q==
X-Google-Smtp-Source: APXvYqzhrP+LtYZUGswHP9CMkZx92NYmqyOYiODyiaeHyjNWAUphjgsfhiKzXRO4XISxvyvjJdlDjA==
X-Received: by 2002:a63:7054:: with SMTP id a20mr27458699pgn.354.1557880796429;
        Tue, 14 May 2019 17:39:56 -0700 (PDT)
Received: from bohr1.soe.ucsc.edu (bohr1.soe.ucsc.edu. [128.114.52.184])
        by smtp.gmail.com with ESMTPSA id c142sm370727pfb.171.2019.05.14.17.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 17:39:55 -0700 (PDT)
From:   Heiner Litz <hlitz@ucsc.edu>
To:     mb@lightnvm.io
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH] lightnvm: pblk: Fix freeing merged pages
Date:   Tue, 14 May 2019 17:39:52 -0700
Message-Id: <20190515003952.12541-1-hlitz@ucsc.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_add_pc_page() may merge pages when a bio is padded due to a flush.
Fix iteration over the bio to free the correct pages in case of a merge.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 773537804319..88d61b27a9ab 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 			 int nr_pages)
 {
-	struct bio_vec bv;
-	int i;
-
-	WARN_ON(off + nr_pages != bio->bi_vcnt);
-
-	for (i = off; i < nr_pages + off; i++) {
-		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, &pblk->page_bio_pool);
+	struct bio_vec *bv;
+	struct page *page;
+	int i,e, nbv = 0;
+
+	for (i = 0; i < bio->bi_vcnt; i++) {
+		bv = &bio->bi_io_vec[i];
+		page = bv->bv_page;
+		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
+			if (nbv >= off)
+				mempool_free(page++, &pblk->page_bio_pool);
 	}
 }
 
-- 
2.17.1

