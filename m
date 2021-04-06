Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16513C43470
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC93613BD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhDFHHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbhDFHHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E465FC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so15277701edc.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7YY4Yx0tOezgEdUSrG57nr2i7WNMjSlXas7hudpooo=;
        b=Gq+AJzHwygRQecO1DUI06EgwmtIa2x4/T8iosx3EBM8c3yRRgv7bGbKNjbQ0AIhmRe
         5DM6KEOIFHqB3syV7L9gJZgazFTYf2KMtOj+5KAsvarLRVq0h/YIzTi1yIrylaGr/M9E
         nEOAMPYRVSrJc668DKuUQWy0Rvh2PfHhlBVo3/d1oHvo3MCbG3cl8XrtRuNuiKHlTXr2
         epgIHAP1rg37dbX2xVhRAyvuUX1EXOVeGxUi+YqNLIEXfTgRN1pffiiy5axpIlxNw466
         mc5wemeI9vAsCRVdnb+QJcfSu/BtNlC8gt5IgOLM4rDqHojOKvB69+cogP8YuPDHwi8X
         kXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7YY4Yx0tOezgEdUSrG57nr2i7WNMjSlXas7hudpooo=;
        b=SvgX9UP93W3U8o0zIH/HtdqiRm3Z11u6aQk8PP6c/Ro735XExbFp9XtyLe48rMyWFL
         02Iy1hWQIWs2GeUdYkfhJej7TFGQdh+3JG55oUech5BH466LAwP5tXSUaA6lReJe4M0e
         RjnU/PX8JYlxpggNiwPa/2vmfqXKxHWjRmoGYa7QSLj2LOAcTdxyMHuh5vzfZ6DZYdBr
         EY+5Ryml9mnue3O4z9Rr/kpaqI/ngVObwuZmiaztoV6LUImGqzFGBLnuGnH1USLxpPRa
         CWrEyFgoUDAbjE4XGVTjyVuIv9kAhkQjBd6uNOmSAoCUqRQsUh/VDd6ft/C+It+ltqUb
         LFzA==
X-Gm-Message-State: AOAM5307v2CrArSCUBP8rhx1ttylcblFYFy6OyOoVRZqdy3c1skiRe9F
        x1oSPASdXNovhPuIk0rRzcPpINkqAa9PRpFk
X-Google-Smtp-Source: ABdhPJwVeqfTK7amZO6bEOReVOaiRcS+6tLwJ2OtzEytlMVd6aVDY1v+p4dcvmhHy99aH1tvzHCCLg==
X-Received: by 2002:aa7:cd12:: with SMTP id b18mr17421092edw.340.1617692847611;
        Tue, 06 Apr 2021 00:07:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:27 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tom Rix <trix@redhat.com>, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 11/19] block/rnbd-clt: Improve find_or_create_sess() return check
Date:   Tue,  6 Apr 2021 09:07:08 +0200
Message-Id: <20210406070716.168541-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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
index 652b41cc4492..9b44aac680d5 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -910,6 +910,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
 	return NULL;
 }
 
+/* caller is responsible for initializing 'first' to false */
 static struct
 rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 {
@@ -925,8 +926,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 		}
 		list_add(&sess->list, &sess_list);
 		*first = true;
-	} else
-		*first = false;
+	}
 	mutex_unlock(&sess_lock);
 
 	return sess;
@@ -1194,13 +1194,11 @@ find_and_get_or_create_sess(const char *sessname,
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

