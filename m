Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF1C433F7
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4467361955
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC3Him (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhC3HiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C33C0613D9
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u5so23329739ejn.8
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pl2/fbfuKZ1ockeKTle4rwoFO6U1pHK3irg5VzOx9k8=;
        b=N/ZeqDaiLjWBR2XvYWW9My+j/Fks7Y+jenFhYx2GZCAtrKf2kT4EVX0LK5tnb1B579
         jybyKAADuesHIw4cYtuuXv9LRGom1zK1jQdPRn5uBl4vRPwLv4VuI7ikTks5Q2VDLHEm
         G/6+DVToeeeqTiQt9dSioFW1YsEm2+th0ebbbZbp8JgddM15/nFrPQTwuxUdNNFkc5dt
         tiauV8RT/RrjiAki/XSD4ObLwAwtPwuZbbDdls9R1VnhpynNTQc32RHD5h5PJvXlid8I
         FkmFelmnBSuGdnHQXJnVjd6/op5m96JPmEADnze8uUToRMOonNGTJ01MZA5OQioHg4/G
         r34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pl2/fbfuKZ1ockeKTle4rwoFO6U1pHK3irg5VzOx9k8=;
        b=D0wyIS1448b+zgjmYh6pePoG81ZH13Pxwri/0sULJrWkNV+8jtpWmPC0GXjWf/8a01
         UUYeg71cZ9vauFe8vowPvqEzdDFdc6P2CLRSCmxkyvPOasXChBDwGq1DutaDTaeAwjZL
         2lbNx1416YBKAe8C9m/fRfcaGzxCULXixpR+plOIbXg2NK6ddYJzzxJmxzP+ZWnEFFVa
         XODbGwT8UcEQziaQ7QCtSPQUHE1NrM52NedAg7wOVvZnyneED8WjUfCmquabf8mFkOnP
         eFravOBoA0fRhRGbZonSZ3MNEWa0izhaUrxi9otixtt6fmyuBQXRFnOO+aMn4HliACHJ
         BzMQ==
X-Gm-Message-State: AOAM530kD2sq0LwhOiISYPM/8pnp9/n6KPCd9FBpesIWeO1tq7wI6Eoy
        FoGLT/RpuCjtu5qRNSqkR7WzB26nZb2+Nhmz
X-Google-Smtp-Source: ABdhPJzE0oa9YtUt+WjUaubXky3sNLvKv/eOKcupntCS1R7318NoxAXc/WPcBtUgmif04YUeqx+n3Q==
X-Received: by 2002:a17:906:33d9:: with SMTP id w25mr33525389eja.413.1617089889944;
        Tue, 30 Mar 2021 00:38:09 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:09 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tom Rix <trix@redhat.com>, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 16/24] block/rnbd-clt: Improve find_or_create_sess() return check
Date:   Tue, 30 Mar 2021 09:37:44 +0200
Message-Id: <20210330073752.1465613-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

rnbd-clt.c:1212:11: warning: Branch condition evaluates to a
  garbage value
        else if (!first)
                 ^~~~~~

This is triggered in the find_and_get_or_create_sess() call
because the variable first is not initialized and the
earlier check is specifically for

	if (sess == ERR_PTR(-ENOMEM))

This is false positive.

But the if-check can be reduced by initializing first to
false and then returning if the call to find_or_creat_sess()
does not set it to true.  When it remains false, either
sess will be valid or not.  The not case is caught by
find_and_get_or_create_sess()'s caller rnbd_clt_map_device()

	sess = find_and_get_or_create_sess(...);
	if (IS_ERR(sess))
		return ERR_CAST(sess);

Since find_and_get_or_create_sess() initializes first to false
setting it in find_or_create_sess() is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 6aba7b26f260..6f955a937f40 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -915,6 +915,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
 	return NULL;
 }
 
+/* caller is responsible for initializing 'first' to false */
 static struct
 rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 {
@@ -930,8 +931,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 		}
 		list_add(&sess->list, &sess_list);
 		*first = true;
-	} else
-		*first = false;
+	}
 	mutex_unlock(&sess_lock);
 
 	return sess;
@@ -1200,13 +1200,11 @@ find_and_get_or_create_sess(const char *sessname,
 	struct rnbd_clt_session *sess;
 	struct rtrs_attrs attrs;
 	int err;
-	bool first;
+	bool first = false;
 	struct rtrs_clt_ops rtrs_ops;
 
 	sess = find_or_create_sess(sessname, &first);
-	if (sess == ERR_PTR(-ENOMEM))
-		return ERR_PTR(-ENOMEM);
-	else if (!first)
+	if (!first)
 		return sess;
 
 	if (!path_cnt) {
-- 
2.25.1

