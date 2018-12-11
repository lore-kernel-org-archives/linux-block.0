Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343B5C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED36420849
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psnOmRjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED36420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeLKOK3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:10:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40174 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeLKOK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 09:10:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so16467810qtf.7
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=04sBntbvXvyrz+pXSS54UpuM2OP29BSlGBO38wuJji8=;
        b=psnOmRjCfdZveXMizPa2zjABW6Br4Q6XWY+ckLBoJKDAUuq/7ikK4G6NJU/fdn61VN
         7S6a3HxxZzRcvEkXwXQxZfO1Mn+IsqnWsHIsqBLlK7d8BzuC8moMwahJAnfbGAkHhMyG
         cEbuLivhTBamFXHGKje5sehgyz5hf5mjOcVVKJ5RP0vICMAOhVhJRAkrAciZA6k5I/K4
         1xVUM1frBfO2g+9chf9gfBqEpP/lqbcPx/udgAMDbXrbUkG0Jk16m3m2UAD6+eafG6bE
         IZP+Av+lyjCh0Bwx6yAiMBLU2ZahQl2bspE5NQpKHMd/fh/ZKBTsbJ4+jg3lRC0tHK75
         nMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=04sBntbvXvyrz+pXSS54UpuM2OP29BSlGBO38wuJji8=;
        b=IFT/A9giJ2tHh0RL4dBTyzWOHbMlY3/z+0FNfBrp1HY+jMbDNYQEriXM1pPgQcuFXk
         dA5jJaSWmH1nnwC6Wn+s6EPpxASLny77xS46Rm0hu9bwbLCKe6tvXcjemjWfTXzxONd6
         XX8PPdEn3AOAD4ArsXRQOhQ+hvfIgw0sWF6kCoUhVGvL/ou0kkoiPdw4cy8hoDWAV5Hp
         exVW0vuYBLWlnPQi8W8fkZYoZsPYCiy7zCwNAA84CuFnLthJKTnpXyNfyP/bFVTAxvhB
         zILy7BjIaUcl9IUGqXUrx/pL9eUotGha2m+7MWRH3xD4A5CfzZjql6f8kiCwoy+vd8bh
         ab8w==
X-Gm-Message-State: AA+aEWb6mWTFfz5GBpUqlXA2U/yc3Ff1Th+HP+5jwpY9tCXH0N9MYewI
        tVsdDYKLvwpUkfnJroLuFyg=
X-Google-Smtp-Source: AFSGD/Vay7tAJRl9Pyyy2CzEntoejrCW8TMBXABZrUh0OnqlhQbgTdL1xquv3f7/iiRPT4nzgHBqcA==
X-Received: by 2002:aed:3bd7:: with SMTP id s23mr15975286qte.207.1544537428000;
        Tue, 11 Dec 2018 06:10:28 -0800 (PST)
Received: from localhost (pool-68-160-176-113.bstnma.fios.verizon.net. [68.160.176.113])
        by smtp.gmail.com with ESMTPSA id r16sm11385595qkh.71.2018.12.11.06.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:10:26 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH] dm: fix request-based dm's use of dm_wait_for_completion
Date:   Tue, 11 Dec 2018 09:10:26 -0500
Message-Id: <20181211141026.30174-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The md->wait waitqueue is used by both bio-based and request-based DM.
Commit dbd3bbd291 ("dm rq: leverage blk_mq_queue_busy() to check for
outstanding IO") lost sight of the requirement that
dm_wait_for_completion() must work with all types of DM devices.

Fix md_in_flight() to call the blk-mq or bio-based method accordingly.

Fixes: dbd3bbd291 ("dm rq: leverage blk_mq_queue_busy() to check for outstanding IO")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-rq.c |  6 ++----
 drivers/md/dm.c    | 10 +++++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 5af22e165fb7..202e9be5aea7 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -131,10 +131,8 @@ static void rq_end_stats(struct mapped_device *md, struct request *orig)
 static void rq_completed(struct mapped_device *md)
 {
 	/* nudge anyone waiting on suspend queue */
-	if (unlikely(waitqueue_active(&md->wait))) {
-		if (!blk_mq_queue_busy(md->queue))
-			wake_up(&md->wait);
-	}
+	if (unlikely(waitqueue_active(&md->wait)))
+		wake_up(&md->wait);
 
 	/*
 	 * dm_put() must be at the end of this function. See the comment above
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d80c34a34a2d..3a50675cfc1a 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -646,7 +646,7 @@ static void free_tio(struct dm_target_io *tio)
 	bio_put(&tio->clone);
 }
 
-static bool md_in_flight(struct mapped_device *md)
+static bool md_in_flight_bios(struct mapped_device *md)
 {
 	int cpu;
 	struct hd_struct *part = &dm_disk(md)->part0;
@@ -660,6 +660,14 @@ static bool md_in_flight(struct mapped_device *md)
 	return sum != 0;
 }
 
+static bool md_in_flight(struct mapped_device *md)
+{
+	if (queue_is_mq(md->queue))
+		return blk_mq_queue_busy(md->queue);
+	else
+		return md_in_flight_bios(md);
+}
+
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
-- 
2.15.0

