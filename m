Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242E6C43610
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E254E2086B
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sd6FN2Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E254E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbeKNBlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:37 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38737 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbeKNBlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:37 -0500
Received: by mail-it1-f195.google.com with SMTP id k141-v6so19064053itk.3
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fz9g1ov0KEBk0jca5hC7QbGAUKLsaBIiDlim4iRDh3o=;
        b=Sd6FN2XiMMy2fLFPu278s/m80rTFcVkyVi7Da6PEShW2mg8FprQOAGV+qvsYE2Lomg
         5yzMadXXfeUijZaQYtQkQSiIXoO+3oKiwIt1RQ04ziANhlCXTOWAwoswlj7UeKk1ruIJ
         Q1idg1g7jtt0PO5ChhvwlqwgaiHMd/DDmGiuYeNYdWG1+tJnfAMv5pP6VfGKr+X56tTX
         cPo/18TVaZMv8/1/68ZWUUSJBoiR9t9DK+fbxcWd5qnDM02Zb9RAJya1WQ+t4krx309k
         QxnVQovq45rlzGHFbs9uU37en7YBjTeGNGshpVjHGQbUN6ZeEQF+9i7ss+1TxtfUkVf7
         +sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fz9g1ov0KEBk0jca5hC7QbGAUKLsaBIiDlim4iRDh3o=;
        b=hCp6qLiD0pWcGrp3pzHNZLb0o/08BLkvyxeOLA9Ul8Ajei18hiDgx2suq8oxNW/fUt
         y0rpLLvzsuaA0v8AF+jGUHFPfWEsxZMytS4GJZOuRT1EwCmg68JjmUHtLiIw5JrPmyAl
         v3RAXiA/FA/q5VJ6Czm64uKnZttgaoQ5YNdtUrrUrfpuCpKM3Co0fjSP/IIt3xSnSdUI
         s8CWzs3aiUeg3BhhEoJnnfhSHxehQyO/TpxlLGy27wd1lC7fRcP/3WPqiR+/1Q06AOK5
         ylSVMy2RFvKCAkaaW13tSFYyoDlp4+F3x/dL2H6G60AW793Gfc5B1GnBHAapHVlimU3l
         Y9nw==
X-Gm-Message-State: AGRZ1gL1Bb2niAPHrgwa+u/C0fXmetn7c0bN8QXoakVMeLdqbl5pW6gs
        Ctfh8hINWn4ZEk7gjPYJ8G9GYmp0X+w=
X-Google-Smtp-Source: AJdET5ecZTcjHWgJIM5f//nes9SHvCftsfFk/yhD+lANPd9/3VyUGnMaMV6VbG7balz9ubKbNaaveQ==
X-Received: by 2002:a24:440f:: with SMTP id o15-v6mr3990915ita.15.1542123778003;
        Tue, 13 Nov 2018 07:42:58 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] block: don't plug for aio/O_DIRECT HIPRI IO
Date:   Tue, 13 Nov 2018 08:42:33 -0700
Message-Id: <20181113154233.15256-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Those will go straight to issue inside blk-mq, so don't bother
setting up a block plug for them.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c124982b810d..9dc695a3af4e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -356,7 +356,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	dio->multi_bio = false;
 	dio->should_dirty = is_read && iter_is_iovec(iter);
 
-	blk_start_plug(&plug);
+	/*
+	 * Don't plug for HIPRI/polled IO, as those should go straight
+	 * to issue
+	 */
+	if (!(iocb->ki_flags & IOCB_HIPRI))
+		blk_start_plug(&plug);
+
 	for (;;) {
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = pos >> 9;
@@ -403,7 +409,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
-	blk_finish_plug(&plug);
+
+	if (!(iocb->ki_flags & IOCB_HIPRI))
+		blk_finish_plug(&plug);
 
 	if (!is_sync)
 		return -EIOCBQUEUED;
-- 
2.17.1

