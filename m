Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86CAC31E44
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8237F2082C
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaPnhTGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFNLju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:39:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55941 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfFNLjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 07:39:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so1992372wmj.5;
        Fri, 14 Jun 2019 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QkQOtBCvlpUCN6hRdiPhpjDsy/zd75Sg/vSA1kvV7I=;
        b=jaPnhTGE71G4ZdV+SZXIJmPlRFM8tFsJyRbm6x51cF1rn2xU5i9q+R/NBoWeGCO5cp
         S96GZGjqgBM2i8xp7GrvTL7EQ1gAydh2T6uw2UldnXHA5zfjaS9RnzKO9fDhmAAYwWyM
         ZBVQt/O41N2xQa5IRa2Z8Y/4yYKR8tkRLlm/9AE0Gptl0hSigq0QeNfx2HRz3pLvD2O+
         zbB9gDgwapWNU/Wiy/coZiBp/KQn5UDhdS1Hw0ax33+485vgFCXBrwCc6oOag+z5kj8/
         bzkU1MI37eoBr+DgQPQ+cE1HjmeFRJXTR67XEuWPH9f8oM9TASSWyxnUu4Bv59GmlBYu
         DtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QkQOtBCvlpUCN6hRdiPhpjDsy/zd75Sg/vSA1kvV7I=;
        b=DcxuAAsvQ86flfE5TPkC8IllLPsMGEw2qWNZc9PJo+wwJLbEdfrduaq+05qG5ZMp3Z
         aLYVCRTtAZ7lDC+jdjojlHfUKVMUHNWspd9CUerWzQso7xsfPe07zwlyjgXVmvmoEKsU
         zhDPDfe9qhRxyfVRdnpHjJZtx417EHjHwJ6g+d78e/51BVda89Av13/PLNJ6cm8Hp+tM
         +8CRUw3BOGiPrsH68/frJJYbbYub3HBNVhuwFV7X32ihGb6VQaMMBwT2pIUrWxmZy3eS
         /og9pwGVCQjpSs31DJktaSyVHEZ36EtCIJLBz4IX70Y+hNax8oTHu2szJ6/BlKv3Hst+
         y/sg==
X-Gm-Message-State: APjAAAWUpciCRttTFcq/3Wj1Ei5j7fMFaH9DLDQNWfVUJ6kOTQ7ERl6n
        bq0g5fxVzioU3Yec85HW3V2TmfbpLC3PVw==
X-Google-Smtp-Source: APXvYqxq6BZ+1M454AIWXxu8PflknrArMEw84BFEpKH9XMXPD0MCV08mnGX+9mgYW5qR/mO3ohNYPg==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr7682152wml.28.1560512387550;
        Fri, 14 Jun 2019 04:39:47 -0700 (PDT)
Received: from localhost.localdomain ([185.107.117.129])
        by smtp.gmail.com with ESMTPSA id o1sm3051021wre.76.2019.06.14.04.39.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 04:39:46 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] blk-mq/debugfs: Fix improper print qualifier
Date:   Fri, 14 Jun 2019 14:39:26 +0300
Message-Id: <7f9091f59d0331bf55286d5f78fa20fa4dde2e21.1560486257.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

struct blk_rq_stat::mean is a u64 value, so use %llu

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6aea0ebc3a73..f69da381cb1e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -17,7 +17,7 @@
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
 	if (stat->nr_samples) {
-		seq_printf(m, "samples=%d, mean=%lld, min=%llu, max=%llu",
+		seq_printf(m, "samples=%d, mean=%llu, min=%llu, max=%llu",
 			   stat->nr_samples, stat->mean, stat->min, stat->max);
 	} else {
 		seq_puts(m, "samples=0");
-- 
2.22.0

