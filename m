Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DAFC2BB40
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D951B23B87
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLIIVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLIIVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:21:38 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46223C06179C
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:20:58 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so804232ejb.13
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9910OhrigqXRatu8UjPkLXZju51Dv3N9YERCZWMqnE=;
        b=bZhZoWri7UFBH3VYaLU8Kb/qN0oyDS3EEriWhlC/pDgQ71zFXm8YYQ7qKxk5uNfUAe
         TsWQmmLs/Mngp49fWEPYnMoZffJEHQCReXpHabbbDLgqG01pXAOr6qLCx+ym/9BeuPap
         5hSY+F70pDWuRHJP9G/bQZ/NjndqnNvCHGWCZ8OIrrbv2mu/YsLDVOf+PbfOTv1qa7py
         lkRRo6yosSLisIZ0HqZJTCfcZuShVbbyOV6eXRUjdPlyPnqhVF6rC/eXsWCyUYRCvStZ
         xVVXQX8ML6w3RzEboREy2ViUkrj+1IMsj6ShF8Y53FhbBg6YyUioapg60EGUdQN4yilA
         6SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9910OhrigqXRatu8UjPkLXZju51Dv3N9YERCZWMqnE=;
        b=HecbuHmGjilKLBfN6LZuBMRjsVqYoo9osY4gqvSmP/18BaK2ZILWi5ZVHdhDSRCcCj
         IIdkIjAo5F+HYQQthxu1n6BsHIkkvfpQba9VHp3Oh9qHSYtYX3fceFcxfQhrVPatQ+j1
         lf6O9mQ1n6GXN819wubNi80baaeaEAPlDdJvmRMfy43ZGeWRJBjpQbzweKYAF9dSU7tW
         fv6mUiusWeR+pMQYixRX6WRXhLy8TMTgpAfhJ95tWtpRIUqHOqWx1aevQ9wOBkIS+w/G
         kMsKs8CN1Ge0pE5ZgB64P8/sTxo+hiPmUtKO3f3moRmO9fHuUoCt7h1+02Qd4oS27l5r
         c+nw==
X-Gm-Message-State: AOAM532v9+hDvBhZDISJ2Wu5QZn2Qheg8hA1otcPLnlAmmMVCEN6Na3s
        39BI8fvXXMRsqsTPWR4L+aiD169ffOmJcQ==
X-Google-Smtp-Source: ABdhPJwzR6mVIjY8Bdi9/o2qMI+WjFmxUlF7szby/BoTER2Jn6fpka099e5PVD94hbRnxM8K6drhuw==
X-Received: by 2002:a17:906:ec9:: with SMTP id u9mr1096878eji.400.1607502056889;
        Wed, 09 Dec 2020 00:20:56 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:56 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCH for-next 4/7] block/rnbd: Fix typos
Date:   Wed,  9 Dec 2020 09:20:48 +0100
Message-Id: <20201209082051.12306-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 62b77b5dc061..9641afa17095 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -359,7 +359,7 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 	 * 2nd reference is dropped after confirmation with the response is
 	 * returned.
 	 * 1st and 2nd can happen in any order, so the rnbd_iu should be
-	 * released (rtrs_permit returned to ibbtrs) only leased after both
+	 * released (rtrs_permit returned to rtrs) only after both
 	 * are finished.
 	 */
 	atomic_set(&iu->refcount, 2);
@@ -803,7 +803,7 @@ static struct rnbd_clt_session *alloc_sess(const char *sessname)
 	rnbd_init_cpu_qlists(sess->cpu_queues);
 
 	/*
-	 * That is simple percpu variable which stores cpu indeces, which are
+	 * That is simple percpu variable which stores cpu indices, which are
 	 * incremented on each access.  We need that for the sake of fairness
 	 * to wake up queues in a round-robin manner.
 	 */
@@ -1668,7 +1668,7 @@ static void rnbd_destroy_sessions(void)
 	/*
 	 * Here at this point there is no any concurrent access to sessions
 	 * list and devices list:
-	 *   1. New session or device can'be be created - session sysfs files
+	 *   1. New session or device can't be created - session sysfs files
 	 *      are removed.
 	 *   2. Device or session can't be removed - module reference is taken
 	 *      into account in unmap device sysfs callback.
-- 
2.25.1

