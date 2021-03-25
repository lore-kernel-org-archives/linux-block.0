Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A0C433FC
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD15C61A28
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhCYPah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhCYPaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE9C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l18so2866147edc.9
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYrKVjesVD1IcOvr0jp+YRcYHhKoOXOE75IsHPsZDFE=;
        b=XLzlZ6cuiNoXMt0vpFQKcjWrteYRJuPHE/CumV0u5W3LaGcZul3OkoY/C+8CUqKULg
         BO9IF7CZbpAr7clk/FJzJ9imQS+WMv0T4biaQ4Thf14vflxIXlt+4HI6yrX4Xf468eli
         EnnTB0r5gNEzt8dNQcLqiCHGIgZhCCpLRVy+dHUo2Z1lL3ZSD0+exgnVtg73xF1jMkFA
         eQpv0E5rWVtM4LNzR/oRSvp66FHWU0J7igXzAotWXmr9nOgYnfK27PqLPYg1F9NBc2DQ
         0vUxFCbthCd/mHyltONRf3O8mJwQWy9kK609tt6KMp2rOstiK28rcTabCEoa0Ctz/jLR
         pFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYrKVjesVD1IcOvr0jp+YRcYHhKoOXOE75IsHPsZDFE=;
        b=OPyYUw1CwmhIyUGJnjMefiB5IkvfOciUAXkyBx/EsuKbqgryyO2VjWxYdqlrh+3ieu
         K9uFCvGY4uBr8YLBScfwXDJcFrnym/dllB9UUscYu8Mfhpe5oxvjddISaSNBFI4EduGy
         ngvH/OCiI+B/nETV1Z1LE3uJKvE7pog5okDCx9zJDilLreafRyaEandV0d33YThP2zeK
         SQgkRMwQx29fIYyzjaXZ9bWiboJgHP04xN1hK12EDO8zT1WtW94Ek8cP+4NlPPw/0Fz+
         W4MJu5+O3k/08Q+NFBeqrx1aVdn6IvXiBMtYyVG8x6kW4U5fACFdJkGPTszhMvdmwdki
         1wHg==
X-Gm-Message-State: AOAM531+LHXlSwVZxn7dhOy6x7tLMXe84fHxt/qyxj4x3V9GZ+YW+jg5
        pO+LKn/zQe93Xq1I+YacFGLtTvEBguEtJNOP
X-Google-Smtp-Source: ABdhPJwlx+fEkS3xWkhHL+BPM2x+eoD1ayZUh1b9oFgn7h6f3S+9neELL6Gq8Fdqr2z7o0bG/wqiDw==
X-Received: by 2002:a05:6402:31e9:: with SMTP id dy9mr9933323edb.186.1616686203203;
        Thu, 25 Mar 2021 08:30:03 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:02 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tom Rix <trix@redhat.com>, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 16/24] block/rnbd-clt: Improve find_or_create_sess() return check
Date:   Thu, 25 Mar 2021 16:29:03 +0100
Message-Id: <20210325152911.1213627-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
index 1a1c57b51fd8..8fda94460a88 100644
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

