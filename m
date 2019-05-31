Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FFC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61F525972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEaABJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43197 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfEaABJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so4961752pfa.10
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vnHNVRtozPlGQFkNwwR5rrWtpp3cok6C77kqj9k9mU=;
        b=dKsidzGJStRygborY2eqMIfYdoOCYu0kWxHdO/gLcAFw2AWDG452t25u6J5T00JM02
         558i8opIPx87Xut4s2+SmfgBJWx4x7QGCojHU2pZm3qtlI2+8X0xWAOm1CwSaReIZB39
         IY/DjbI+IWZ7hg2jnSDmlxxq3M1WHfrOKn4NkYvmyc3IWvSIEtjdeqOFSuDVbNPCRBwK
         S1srkWQnomu7hKj597azBszArYJWc4IkZ8eek5FXei3Zx+DQWT2o+cVvvDXRdROoVtFg
         VXUr8AuFFEaMEGdGXwbBhErBy7L5al9qp+PC7lerPAB0S69C0Fi+pAfw85ARyZYts37k
         ibrQ==
X-Gm-Message-State: APjAAAUNe0rH0GtN2RGHauJ9gLFaGKstrOiA/w0Y0H03Q8PDqddMo6bZ
        XvX9STYMdSP0eDiIkHiT/fs=
X-Google-Smtp-Source: APXvYqwATFxGAZxvTtQZ3gaBz0FlHFXLlKN/6ssRruYDeoVY0rXWGXy14fnx4rPeOujrcGfvKpLJOg==
X-Received: by 2002:a17:90a:192:: with SMTP id 18mr5982444pjc.107.1559260868174;
        Thu, 30 May 2019 17:01:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6/8] block: Fix bsg_setup_queue() kernel-doc header
Date:   Thu, 30 May 2019 17:00:51 -0700
Message-Id: <20190531000053.64053-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document all bsg_setup_queue() arguments as required.

Fixes: aae3b069d5ce ("bsg: pass in desired timeout handler") # v5.0.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bsg-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index b898a1cdf872..785dd58947f1 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -354,6 +354,7 @@ static const struct blk_mq_ops bsg_mq_ops = {
  * @dev: device to attach bsg device to
  * @name: device to give bsg device
  * @job_fn: bsg job handler
+ * @timeout: timeout handler function pointer
  * @dd_job_size: size of LLD data needed for each job
  */
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
-- 
2.22.0.rc1

