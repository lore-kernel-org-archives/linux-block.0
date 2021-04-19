Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A1C4361B
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498E961178
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhDSHi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbhDSHi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE3CC061760
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so51370168ejr.5
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7YY4Yx0tOezgEdUSrG57nr2i7WNMjSlXas7hudpooo=;
        b=JRm6/AWTQGyjo1dM6Da//+mk/f54RFVdV5Nh2psyZ5ZOvqeuKOms2gaB1phryzguNx
         ogfjPcVX3Y/7XpsGfBmJU71RFyEgdNR4r0OPY3h5V7gZr8tobzIYfE5mNtOaxSxZkhPN
         CmZjKj5H8NaSkY7v515XJZsyP4Id4Vv5kXjXiQy6FdJgMVe4mGDzpLS/GCDezkql4mk1
         tly9LTJ9csp15azYDnV9aUpCgpIQZOhPU/FLa60LafXSuuWMStcWT0Yb7IRbqXss3kdU
         yp8rp/H3Y2VR3MBpZP075MNhenICACD7jWTDbJbtH2926RmKFempKiysev5xZheHiOpp
         KUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7YY4Yx0tOezgEdUSrG57nr2i7WNMjSlXas7hudpooo=;
        b=RNSyhMkik6QShKD0KAqDhhA0FXfkN4jHZrfBMXGvGxbSOWOqjE2Wbrjp+VM17BYQ3L
         EW2T3gs8EqRJajEaikB7e8X+FeCjC6N39eqRWmasKMZxzlzUP9AgOWVI+R+O6VFVk60c
         QJGdeGsE6xrf0vTOYrk3HM5wV/bEqwclyAS00lqvsDFyTL47+qfbdw4+q8NoXyrNYYzi
         5qDfNLMoUegjxFohZYOmeRY3OxHFd7l9UwffB+7WpkHX1YvARbtI7Ja/oayWlmLhrONU
         q+yT/F93Ie/IjchJnTZy8FA2+iaH50R2LxeVsHJnV4xuR4nBS8LBCB1KHNgCDO0YNrgx
         Sb5A==
X-Gm-Message-State: AOAM532d+olJymMp1i9xhVhKI+EeWkezkyih1/X68p1X3si3opfX9a/0
        jLg5sJj5ma8sFfEcupIhTrGdqjzwWR7nrlfL
X-Google-Smtp-Source: ABdhPJxwMkzkWVlCAkAD1VvglIFWPpw3654ugCjLUnJtWuiOESzpmwmw1LabZQBQTKcRfEU4pfnK4Q==
X-Received: by 2002:a17:906:9b2:: with SMTP id q18mr20598005eje.147.1618817877398;
        Mon, 19 Apr 2021 00:37:57 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:57 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tom Rix <trix@redhat.com>, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv5 for-next 11/19] block/rnbd-clt: Improve find_or_create_sess() return check
Date:   Mon, 19 Apr 2021 09:37:14 +0200
Message-Id: <20210419073722.15351-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
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

