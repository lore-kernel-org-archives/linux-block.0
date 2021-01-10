Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D7C433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 21:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1504D224D2
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 21:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAJV7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 16:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbhAJV7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610315889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3eVTM/WNkAqgnImqOE9gVZKZvkeANNt1RNH+SQOg+Dg=;
        b=JzfB34Qu4C+iJjfFvPHiNSlc+cVLFWbLakT6RIKqbH6tuNR9mZgMKdZxAR3rHOFyoBHo53
        t3h8QWbfwvHsNIQuE8ye5TaHy1O6/rjLWAWUGlE+dDRclSKFnUsGgaxTAlfeEWKqXeudWf
        SmlCPyr/3mcrU51qaO5PBka9QAOY3xU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-l2s42KyhNVugGoaGAhe3pg-1; Sun, 10 Jan 2021 16:58:07 -0500
X-MC-Unique: l2s42KyhNVugGoaGAhe3pg-1
Received: by mail-il1-f198.google.com with SMTP id e10so15596698ils.5
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 13:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eVTM/WNkAqgnImqOE9gVZKZvkeANNt1RNH+SQOg+Dg=;
        b=NJ/gI3SZ2sA15X54BQfI4oovT71mxXl5+GCB7WNIQzyuy84gJNSaOe49HpStE9NMGv
         evyQwdEGHoBNATBPT8dWfrH0nbAZAADJUY7iuwOjCvOYcuIP9mFR6DmqbBH5+DpQGRrn
         BAZnh8Pnpadx5rahk7by5+SzNPLyiC2Us6i0bEj0LCF8HBxTJod4CuU+1K0OrTyb45PE
         wF8+b+aOFYqpvqjlCjAnQR32lhd64iZCHJVs3wIVa+WMAl1GDAl4V4IGjI0XvkMWUffT
         KFu3GWinZomGUgqWlWVZ5x6ajBkpI3uwofDYYeFLSNKDaPiqlIeQWfLNPQ2MfcMCxIbz
         AZFw==
X-Gm-Message-State: AOAM531Ywlq1quWo9iEP/lPNCGv2nlSK3ma8UDGW1PF3w/c2jpA8FUYk
        aOeBcpDNIsstbpbqzQc/I/DMd1MlPPNDwLrAI0EmMLIeVcckCEnX9kPAZuEQnbUo4Za06IHFjZH
        D57p8su3SGZiU/3Fo5QGKqy4=
X-Received: by 2002:a6b:3bc3:: with SMTP id i186mr12800073ioa.192.1610315886933;
        Sun, 10 Jan 2021 13:58:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhXHAmjJbP70famD48l8MmAZeIccDPOkMoTViCj28iRQ6f8vgQrbgucsrH02pgV72MBdd4cQ==
X-Received: by 2002:a6b:3bc3:: with SMTP id i186mr12800067ioa.192.1610315886747;
        Sun, 10 Jan 2021 13:58:06 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e19sm10014698ioh.15.2021.01.10.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 13:58:06 -0800 (PST)
From:   trix@redhat.com
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] block/rnbd-clt: improve find_or_create_sess() return check
Date:   Sun, 10 Jan 2021 13:57:26 -0800
Message-Id: <20210110215726.861269-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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
---
 drivers/block/rnbd/rnbd-clt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 96e3f9fe8241..251f747cf10d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -919,6 +919,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
 	return NULL;
 }
 
+/* caller is responsible for initializing 'first' to false */
 static struct
 rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 {
@@ -934,8 +935,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 		}
 		list_add(&sess->list, &sess_list);
 		*first = true;
-	} else
-		*first = false;
+	}
 	mutex_unlock(&sess_lock);
 
 	return sess;
@@ -1203,13 +1203,11 @@ find_and_get_or_create_sess(const char *sessname,
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
2.27.0

