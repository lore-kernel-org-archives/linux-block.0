Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB62CC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CA32133F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE9CT/Qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF0RfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:35:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35357 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF0RfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 13:35:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so1583407pfd.2;
        Thu, 27 Jun 2019 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G8HET8JWQuc+colOd4dh+X+1LMXfRXZOvk+H7Ks4laY=;
        b=mE9CT/QtAQT9IgiVEICs9I7qhxosev+Tj7R4SflJDIpj6qsuTJ72ZU0m6lerNIDubX
         o40Y6M50noQYe6noFEMvPMWhB8oYt0jAeGMd9ZgdJ+rEBFR9/EtwnbWq0wZa3DTmn1+Y
         GEZQI5ZvE6pQ4lBh3NNHTqU73j2jfzUZm6UpwBfRv+Kp6jlAe0iwgziIcYqBMbMaDn/F
         rcqo+ak++nHZ4FGzP7U7HYU0iLwXace8QiExhm+qCb+h9TvejxijnhyrL+e+bNzgR0Od
         21W2a/4PwaMlWuKFtVzFGg5DG80zU0VqY9n6pEZQ+yJhFoRAPNhueFEiRQ9F4+sSB18y
         R7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G8HET8JWQuc+colOd4dh+X+1LMXfRXZOvk+H7Ks4laY=;
        b=Zjl/7zhW1ng/P/cqxxGN92fBOrgW9HC3ZOGMt6gn5wUpt8eYvFPCzbEafjIr7z0LXD
         AOmQEp9LmmuqX2B+XvBpa1K683baZnUZrhlVP755P0XCRx9WciDiSqmuimcP3ArcicIW
         sb5jQzXB4K3NUxSX+X0HyH3DNP4gmati4T/mJpOJYuyfeiwqjKDC4Nh3mpYdDlLQ6d0e
         QxFUTGmo2nb/EXMxb6SPp/ibcAGixXwB0pIwLRzcjlwfTySEDXr2202xWxOjgrOxPXzH
         qDy0wL4O+7yknxt+/xFCDQzE3TrajOV9RPdGGqXl75wAxND+e0NSMUi2VzX4KiMu/nhi
         nVzw==
X-Gm-Message-State: APjAAAViRDI8vZM3wNllAgNBHZ2O5NVVBuZ7jjeKnMyDFIeWC1ieHX1o
        FWZpicRDXeHH7IprtD07pfw=
X-Google-Smtp-Source: APXvYqy0HqXkmztdVZNb1ex60RgjtPQ+8mjXCh0HbwzqcEfEMShFH8f8647D+Ubiflrb9gqrPuXfvw==
X-Received: by 2002:a63:6ec1:: with SMTP id j184mr4852692pgc.225.1561656921930;
        Thu, 27 Jun 2019 10:35:21 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a6sm6721366pfa.51.2019.06.27.10.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:35:21 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/87] block: skd_main.c: Remove call to memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:35:16 +0800
Message-Id: <20190627173516.2351-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/block/skd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index c479235862e5..51569c199a6c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2694,7 +2694,6 @@ static int skd_cons_skmsg(struct skd_device *skdev)
 		     (FIT_QCMD_ALIGN - 1),
 		     "not aligned: msg_buf %p mb_dma_address %pad\n",
 		     skmsg->msg_buf, &skmsg->mb_dma_address);
-		memset(skmsg->msg_buf, 0, SKD_N_FITMSG_BYTES);
 	}
 
 err_out:
-- 
2.11.0

