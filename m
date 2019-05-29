Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B436C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA622075B
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLopjJep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE2WIQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 18:08:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37354 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 18:08:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so2577723qkl.4
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFWpnyMCBI2HjRfy30XMpOktsDUJvxC/m3/fJSrrM7I=;
        b=BLopjJepJi1pOenVA7BqGBZdJ1GCRJFIvPY5dMmZy8eG9ge8Nbs+/veQTyhkk28PDK
         2UQaJez1pNtAZaEXS4VtbPGjqet8+SdlbFcUg1RAVaiHjKdJ0BpgvQtkxT1VxtXqUp6x
         fvB1Srcoj6Q8GCPyuOOi2e73nxSzmCX8wI35Qdx7tk1tUhmr8kbAGEWHaiOaE5x2lqc/
         Vst9Akr7u5bD9BxDu84zV5qImFdwqw+kK2rSNKOWfXAsel5Z37LVK10yL9XeLMgrBr6Z
         tPvpYDFDmbJJJENWNWdLjSYqC0mQggQibR8gnMnOScMG7sEEJXl5rpxtdI6D3NXb6sz8
         2Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFWpnyMCBI2HjRfy30XMpOktsDUJvxC/m3/fJSrrM7I=;
        b=ZOQP/epm5NN7oeXImoKtKi/u3jui24RgwH2iibOIL1Uc0aQiJ3fDuqxYqsn9vuDJTe
         WZOf0lwGUPOI6KzPhEEc85gsy9XV6peX/4iFtTZVRVKaNNlSy/75KjhauLMYYRdyRcNq
         dsTInYncqGnrGcBhEfIx/Rj8BsmL4yIXqLR+dr3DCqGBO9Vmxruum6jrAo7fXyfoYkAt
         ZknVkh6NM5jEq/UgnqdUJ+pfObZFYEyJ/uh+pszzAWtGWPOoVEUJdge8kT+PHhjQlxEj
         DYJizx99I3nsT0DvBw8/cg1L9nu6lvZBgVwTDDhBrjo5Qp47BHY9xxoyZSBuK+fePyYY
         hr8Q==
X-Gm-Message-State: APjAAAXN34Wz0IIxtnPmubZzWqHnO9dKZPsAbXuGoLu1oc5Ahs3CbWPR
        1JQ1suFVY+36EV2YHhG6quxQpWDX
X-Google-Smtp-Source: APXvYqzXbVPBHRm4bTBJhcQUvTsmCSd513P7iACjnBz+d6zcFVn6kNbLUgYgShrL4BB/6Q50WQvjiA==
X-Received: by 2002:ae9:c106:: with SMTP id z6mr150192qki.65.1559167694354;
        Wed, 29 May 2019 15:08:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id x7sm458268qth.37.2019.05.29.15.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:08:13 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jbacik@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 5/5] Expand block stats to export number of of requests per bucket
Date:   Wed, 29 May 2019 18:07:30 -0400
Message-Id: <20190529220730.28014-6-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
References: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63fdda5e6ccb..0dd4a3825a92 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -543,6 +543,14 @@ static ssize_t queue_stat_show(struct request_queue *q, char *p)
 				       q->dev_stat[i + 3 * bkt].size);
 		}
 		off += sprintf(p + off, "\n");
+
+		off += sprintf(p + off, "%s reqs: ", name[i]);
+		for (bkt = 0; bkt < (BLK_DEV_STATS_BKTS / 3); bkt++) {
+			off += sprintf(p + off, "%u ",
+				       q->dev_stat[i + 3 * bkt].nr_samples);
+		}
+
+		off += sprintf(p + off, "\n");
 	}
 	return off;
 }
-- 
2.17.1

