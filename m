Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E8C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349AF20989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy4GUKPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349AF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeLEUYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:38 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42286 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:38 -0500
Received: by mail-qk1-f195.google.com with SMTP id w12so1908098qkb.9
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPsDdKQlx38t2S9AR2ga4G4Dr1vJK59J1pvT/EwZZ1I=;
        b=iy4GUKPDxuT1gV7T2f4F2eL93pW0UkFoVY3DrQQE0WXJV2GBk6VAQ52lHMCtyLMk4C
         Xcw2mqDdVEbnHsF2ZjBpvRTq3ESbWET6kN7jG3RAnk308kwWIdzKN+mtnIkGx3XoV4RB
         swhGvozoUoipnoJqFY5/nlc1hUg/Oqt2jnkWobE7NIHH0qq1Bkd45UUsBZhAezUgoD8x
         Jrm8jyWabmAn65iJHTUxROVpNGAV1trTKotcFlHhfJAGjWynIw9/DYvsEPeJnAQ4dNHl
         e9sZWGnfRfuG5x8liyrpXDRJLpLCSTPmySLxXD6ihbN5PFxUUB2BybuPfbloN/lTlHWJ
         fEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IPsDdKQlx38t2S9AR2ga4G4Dr1vJK59J1pvT/EwZZ1I=;
        b=J8C7HsALyhAJnWZeNDjh8EqSBYVWqOP8B0muAVu6wWZHabpcA7huQbniyuSlC3u5ll
         cNfJ1hkjhsArBBiyHgjgYPyRw6vIlfYiBIG47ZqrOhkP5aZy9Bwiw5NuqbThkYOpE+ha
         ItgUQkJ1oDiELFzrPWteUN6GBatk8oKvTPxDHuazKOBKu1+XU9JTxau6Y0YPkfN5c5MZ
         PwQ3DKfeZpR96J7FQ6hI6Y06Qo6OsxyrOQ3a1H2D2EyzxH1+AED73E9Bj7UMeP63JgOp
         siaRz7fYJfiwUETuLvPZDl53SZ0DOF5npPUCesUmglWtONbUqMKzD9ESo0g3FINhRbTS
         KLkg==
X-Gm-Message-State: AA+aEWa6NJILv5CDJ6NcL5gtBPgOj6SLXDupnoiAV6GhpTUqs7KaV+HK
        Ftf8GJQLyFwMKOKFzJCC738=
X-Google-Smtp-Source: AFSGD/V5F0whJ55efXgBHr1ccvJU7JBgy0XfZh/SUfic2blW8KYM5VFVP1mLlbKa0hLLdv/uQnSP8Q==
X-Received: by 2002:a37:3008:: with SMTP id w8mr23660228qkw.75.1544041477424;
        Wed, 05 Dec 2018 12:24:37 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id z23sm18445488qkg.50.2018.12.05.12.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:36 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 1/7] dm: dont rewrite dm_disk(md)->part0.in_flight
Date:   Wed,  5 Dec 2018 15:24:27 -0500
Message-Id: <20181205202433.95823-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

generic_start_io_acct and generic_end_io_acct already update the variable
in_flight using atomic operations, so we don't have to overwrite them
again.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a733e4c920af..a8ae7931bce7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -663,8 +663,7 @@ static void start_io_acct(struct dm_io *io)
 	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
 			      &dm_disk(md)->part0);
 
-	atomic_set(&dm_disk(md)->part0.in_flight[rw],
-		   atomic_inc_return(&md->pending[rw]));
+	atomic_inc(&md->pending[rw]);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
@@ -693,7 +692,6 @@ static void end_io_acct(struct dm_io *io)
 	 * a flush.
 	 */
 	pending = atomic_dec_return(&md->pending[rw]);
-	atomic_set(&dm_disk(md)->part0.in_flight[rw], pending);
 	pending += atomic_read(&md->pending[rw^0x1]);
 
 	/* nudge anyone waiting on suspend queue */
-- 
2.18.0

