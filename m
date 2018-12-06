Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F7C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AB420838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN3U5ouo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AB420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLFQlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:41:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45771 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeLFQlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:41:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so1187494qtr.12
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Km3DVg7kPkPAtrwtLRbiZLclidyo2CRUUEynAEX5xBM=;
        b=UN3U5ouoIo7M5Ur/+YUgbw0A8Qv2l5hRlWwji2YMu7la0KY9AprDSU2AkhZ7EPKx82
         E6Tb4DVe74VN/yuMPLIZN30Nw/UNqSw2AAWBtHm4my8UgFotdUQbuSNchqgmA+pF5ZpQ
         5wxKKM6Cq+NGDmb6r+kjPwjmBkF/NFHV4kbrY/qGgfNwC8ak8Ac7NkPAZ/b1iIO8kLbL
         z47RgZgFK1Fc4y+bUGxY1J+4nCGrEipEh6tBL+WYGBl9dCI48yqQEVR5t4iB7b2N3tYb
         hWdfYtZstEK757WW6qxoy9nbggAUiXZGEIks3G/B8+nTOiYiak09gNcvK7CO2tEAoZ64
         UtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Km3DVg7kPkPAtrwtLRbiZLclidyo2CRUUEynAEX5xBM=;
        b=iO72S7fXwhSMxCHyROqxwrGjbBaJPL+ZIPucObJttsBSUhy2C6O0XCDoFXQ3Buxn8u
         JO+PPxtRjC2UYq0Aiy35x2WWxYk/qj64u37SOnmIpIpXXGOTRY4uY3belMk/Sc0DaP3o
         Jb1wS6EWgcjEcIMXXPZK84uJ52T9B29bMOIpB94l74tVCRZepGNwZ/luNAQwrjUy3JpE
         SmC1k/ZD8YuayguFl34yeh8WwNhlJGPp/l0vYTXatCJ73RRB4TAhs9SAXaPuhLIjT5u4
         LdUFTxB0Iih6/wPwW+AP2OX6D4i47fVReJXRc9Lg8ujAw72B5Gi/UAiCZHVwoxlouLb8
         aohQ==
X-Gm-Message-State: AA+aEWbNpip5HvZCZzkbKhwEuLGDyObvrez+Pzq4TNBECaBExOCArDkO
        QkfkHyZB5VgliYz2ZA6NMDC3zKry
X-Google-Smtp-Source: AFSGD/XnxQ5VTVVYmF/iDAsXyyPE+2EEFFq4m7bO6etb5EAVApSCPju368BTobbxnlV1wyT2jx3aeg==
X-Received: by 2002:a0c:f053:: with SMTP id b19mr28101301qvl.29.1544114490165;
        Thu, 06 Dec 2018 08:41:30 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v53sm586744qtb.6.2018.12.06.08.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 08:41:29 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v4 2/7] dm rq: leverage blk_mq_queue_busy() to check for outstanding IO
Date:   Thu,  6 Dec 2018 11:41:17 -0500
Message-Id: <20181206164122.2166-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that request-based dm-multipath only supports blk-mq, make use of
the newly introduced blk_mq_queue_busy() to check for outstanding IO --
rather than (ab)using the block core's in_flight counters.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-rq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 1f1fe9a618ea..d2397d8fcbd1 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -130,11 +130,11 @@ static void rq_end_stats(struct mapped_device *md, struct request *orig)
  */
 static void rq_completed(struct mapped_device *md, int rw, bool run_queue)
 {
-	atomic_dec(&md->pending[rw]);
-
 	/* nudge anyone waiting on suspend queue */
-	if (!md_in_flight(md))
-		wake_up(&md->wait);
+	if (unlikely(waitqueue_active(&md->wait))) {
+		if (!blk_mq_queue_busy(md->queue))
+			wake_up(&md->wait);
+	}
 
 	/*
 	 * dm_put() must be at the end of this function. See the comment above
@@ -436,7 +436,6 @@ ssize_t dm_attr_rq_based_seq_io_merge_deadline_store(struct mapped_device *md,
 static void dm_start_request(struct mapped_device *md, struct request *orig)
 {
 	blk_mq_start_request(orig);
-	atomic_inc(&md->pending[rq_data_dir(orig)]);
 
 	if (unlikely(dm_stats_used(&md->stats))) {
 		struct dm_rq_target_io *tio = tio_from_request(orig);
-- 
2.15.0

