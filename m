Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030CC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8C520868
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="khsHIbZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8C520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbeKXFTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33213 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391577AbeKXFTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so2984983pfb.0
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dwmb4KEzJ3RrNx1bsdmJxba6f/9aWI5P0VkiLMifhJ8=;
        b=khsHIbZFKhVLzIw9QQo4SZny7rDIWQJxNCghMeH0tU1zvIJMtAKp2Sk7FqFAjX4vHM
         LyMTlm2maUpmJq11fterAu5ctCvYIomhlmcAv5eRcSucsw4My+k05B0A041MrNLht2MX
         w0qTxRou50exed+gbDnFvzpxmWEIER3/bJyZpnX6W9YRc8fFkMcRGK8EOlcMQ4N1n5lT
         4lmxH9KydSf7+m2hmYqG0voKmuc8iR9/GU3WQRM28ieuKj5i241Ai6SiItigFuux5OIW
         LCtP7aSQTx6qiEqLEZdNUPgR/QXNX3Q8F8UIhLVjWBbZcmMVS9/C002MW+58okpy9wo4
         xNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dwmb4KEzJ3RrNx1bsdmJxba6f/9aWI5P0VkiLMifhJ8=;
        b=LkAfaXHsDz7uZnOf9HjDlAFv4x42ckMd9sJbf5t4OP+zLgKRroluCyENSn3YFeea6F
         CUxX6FY6Tt+OquT4KSqfAXBqoF9fwbqF+xaWLZ3BgPTxTC9vqpEn5gFKFNutYlp9WduJ
         DTULV/Nfv8nJFv1cyh8/wj0o/qonFN/9yaCaYxzdu/xd3ZWORgZuxyt+3VAxEaYqihE1
         R/p2NIyT0k4uIVhtY7FX3LKxcg5NNLVlE3sWNsQBjiEZ/+hAu9G6aN18dZvO3tTYNnI8
         buRumR4fR1zL+r1z+YWEfEXZwPax9lOfgH0uf+g7Kyh18Itdn6NeC1Cn6hD6rdWNvCEt
         XmSg==
X-Gm-Message-State: AA+aEWZZeME6JedvBtWsSrOD7BsRsM+JzAHurAh9nLsWQFWDFTomM3uH
        OiiTE2dYAzrV0SCaR17rZk+7pq5E8SQ=
X-Google-Smtp-Source: AFSGD/UAj8XypGdSTB7q0oXikBFFJT6yTzGHKrS0y7RAmaerVLe0i9WTTVTbAAR6SlpnUaG6zxnCZQ==
X-Received: by 2002:a62:8f8c:: with SMTP id n134mr3220980pfd.137.1542998060438;
        Fri, 23 Nov 2018 10:34:20 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] nvme: remove opportunistic polling from bdev target
Date:   Fri, 23 Nov 2018 11:34:08 -0700
Message-Id: <20181123183411.8708-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123183411.8708-1-axboe@kernel.dk>
References: <20181123183411.8708-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It doesn't set HIPRI on the bio, so polling for it is pretty silly.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c1ec3475a140..c1cb2ed5531c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -115,8 +115,6 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	}
 
 	cookie = submit_bio(bio);
-
-	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
-- 
2.17.1

