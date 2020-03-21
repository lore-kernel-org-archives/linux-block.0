Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C774FC4332E
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975CD2078A
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0wF+ou+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgCUJpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:45:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46975 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgCUJpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 05:45:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so6896121wru.13
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aRXmKaWpCikyhPB1r1OmE2K1u3/BRFi1kHB95qxuFw=;
        b=g0wF+ou+Z581+cBmPEU9Ede5RC7dNifbbFNqvzLutBgtLAn120kUaMH0t4rxT+JlH4
         Mn5DNctfVE8t7kUofJeoSEOlHwMPXgyE/bb36JYczb2ot/a5MmIk1EYpkCa7wHjaHmYF
         DutIkIG2KE7GqcdZfou7rHwDDJouipWqQP4BNLdoA17IK5NxsFaudtxDUgXdfaNnVzUD
         OLRV6jOj9B6USC7AWKqnBQQDwoL+bTGXklYXJkqC8JVh/0+NDTjXpvSotK4Z02cqIqhE
         FDm8fEyv1A0lnRbI/pSBaUlLnd+iyciDalVskfkqUK2I2WK95UIwAw3hXJ1lcIdQzSuM
         OV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aRXmKaWpCikyhPB1r1OmE2K1u3/BRFi1kHB95qxuFw=;
        b=GfLf5TJzlnt2XM5B4Z1pYpEcL0dMtvKUdPPECzx7FUBAJ2sdU5r834HV2xjMePoGkl
         aUCF9N29fbV+HT+I3TJh6SOTNocP1rYkjv0jDHkA/lqTEcPGuxboArrMDsTsMIF1L/de
         UsU/RDvllmnykkP2kV7LtK6/vF7FbZ0V2tec7rK7G2NgTsTnbBxLt/CX3ywI0Unxqkzb
         NCGzoJWAtxVhmvT7Eoua8D476TfbIrz4Ax7/COgtq4tszrlWAWgAYCLZjgXZ9BwkQY8k
         +jlSUoPEMJ/fHyYup6RrJbTw0zDj2px4BtRfKxQryAmj4UQRIYKWGhMzVOq8bZwQ4zTs
         xDIA==
X-Gm-Message-State: ANhLgQ3hodm663y+6V+Cqc+ckk8+slZk+X9UnnPTpb5RFXT6jeG/g640
        tWQnggBUcq/iXau3X8LwZC40dw==
X-Google-Smtp-Source: ADFU+vt6T6nUeI6bl3t9eRMr9wGqBkGoytGMG7fogvZ6K4Vx2wN+9uT8zFhopeIu3DiGK0gsaJu5Nw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr15497200wrt.24.1584783913506;
        Sat, 21 Mar 2020 02:45:13 -0700 (PDT)
Received: from localhost.localdomain ([84.33.129.193])
        by smtp.gmail.com with ESMTPSA id z203sm5396378wmg.12.2020.03.21.02.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:45:12 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        cki-project@redhat.com
Subject: [PATCH BUGFIX 1/4] block, bfq: move forward the getting of an extra ref in bfq_bfqq_move
Date:   Sat, 21 Mar 2020 10:45:18 +0100
Message-Id: <20200321094521.85986-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
References: <20200321094521.85986-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit ecedd3d7e199 ("block, bfq: get extra ref to prevent a queue
from being freed during a group move") gets an extra reference to a
bfq_queue before possibly deactivating it (temporarily), in
bfq_bfqq_move(). This prevents the bfq_queue from disappearing before
being reactivated in its new group.

Yet, the bfq_queue may also be expired (i.e., its service may be
stopped) before the bfq_queue is deactivated. And also an expiration
may lead to a premature freeing. This commit fixes this issue by
simply moving forward the getting of the extra reference already
introduced by commit ecedd3d7e199 ("block, bfq: get extra ref to
prevent a queue from being freed during a group move").

Reported-by: cki-project@redhat.com
Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index f0ff6654af28..9d963ed518d1 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -642,6 +642,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
+	/*
+	 * Get extra reference to prevent bfqq from being freed in
+	 * next possible expire or deactivate.
+	 */
+	bfqq->ref++;
+
 	/* If bfqq is empty, then bfq_bfqq_expire also invokes
 	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
 	 * from data structures related to current group. Otherwise we
@@ -652,12 +658,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
-	/*
-	 * get extra reference to prevent bfqq from being freed in
-	 * next possible deactivate
-	 */
-	bfqq->ref++;
-
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
@@ -677,7 +677,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
-	/* release extra ref taken above */
+	/* release extra ref taken above, bfqq may happen to be freed now */
 	bfq_put_queue(bfqq);
 }
 
-- 
2.20.1

