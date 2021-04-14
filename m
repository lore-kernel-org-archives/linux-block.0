Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA54C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42458610E8
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350858AbhDNMYm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbhDNMYl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39883C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r9so31107605ejj.3
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7YY4Yx0tOezgEdUSrG57nr2i7WNMjSlXas7hudpooo=;
        b=Ngk+XWf0eKbj1ZsLoLx1ZM4pFNm9FLuyK5qbPTeD+vYkt6M1uJBK6ZEXme4W35BnKl
         L6ftvbp9hOdjryLKbUXTUl5dXoy127hrbG3+9eVG38vqLsXUs3bF9kyya4tFSrWPQRVF
         SusIAiz35cSYwsPg43/CLpw9qr1SZpxIATWIgQr3GY3VMyYPJ13JymfSfXGUNudsDr75
         +7LBAwyD4WwXoEqUGOrJzekHIhnNXD08UYUid7pleH5w1l6LWbMnQdOIpZrlxuG4qoLr
         ZrHVoXer0+lHD/lH2SffVmJVpSeG4ItLodKrrGYGX9Yi+BonMb2NxJJMusjmQUy8gp87
         sVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7YY4Yx0tOezgEdUSrG57nr2i7WNMjSlXas7hudpooo=;
        b=qmW5ioPz8o4SYvFQ/GTQ9k0ZXnY/BTLTEbxW39Zr01zEiOt+pvDhBCsy+hSX/VJjzX
         MHZOyRTsblxhNUk4mqBeKSpPsxKjkqYTM0w2LiaQp7I5SV+1p/x3f/fUegK8EmZupmQW
         r054NSWkKEz2a5qqUgXCuwEyV8auDmqEyWaf+A9CM4rkRll/J5DMPMPlr+dXfwsiXJiX
         +rULjTeM5z1gAw8aU2qETOwJcERF82OggITpWU742oOONeb4T98l8ECsfKzGmg1T5IlI
         UToTeQQmrJ+Cu+jNvNjOOM15Fh7g1z7WrIyfOiIU34SKPVOh9UtOdbA4y0281stEw5k8
         7z1Q==
X-Gm-Message-State: AOAM531p1pC4/uiis/Xdkh9AnbJihPmpwnqvZxg/3UbuMT04nGR/vx/H
        W2jzp1AE7P6p1Ft1zt7937Pc8b5g6UUH3MnE
X-Google-Smtp-Source: ABdhPJy+/TjwpZ0GyrS7i3hwKY6It2zYZ15nQ70pcwb0U86Ctr0mTHIriyrcTgdN+avcoXuY08d1Lg==
X-Received: by 2002:a17:906:a10e:: with SMTP id t14mr30147697ejy.103.1618403058731;
        Wed, 14 Apr 2021 05:24:18 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:18 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Tom Rix <trix@redhat.com>, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv4 for-next 11/19] block/rnbd-clt: Improve find_or_create_sess() return check
Date:   Wed, 14 Apr 2021 14:23:54 +0200
Message-Id: <20210414122402.203388-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
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

