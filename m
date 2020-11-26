Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7876FC63697
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0439620DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="X6r9NINy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbgKZKr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbgKZKr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:27 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8FC0617A7
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:27 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id u19so442279edx.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LltlK60r4LyNjCoDNXMYJYASHu9Oufj7+fCgendHkG0=;
        b=X6r9NINyvryxJSxhnnk2PepkAAJHwTb0DMnxHZvJrOl5PagBUJx/VvkzRU6U2fviTO
         JPXqqy5xxeoBBmwUiTOwh58eJcwGS7U9vQI/5NolzBtEbHDAxEShHw67ES3mjYy2ZOF/
         6RxKSJUmxxvN1DncPGGupYOQtiZnl2SQZ2zgJvvd4TfEMRMzprrj6gSS6kFqRuIe4eW7
         YjcXdr6/d8z2tf62JgQDOhnpnXvHSdlxr0ICUSYbVGJga21Lik4/Lk5r3G7d5i1ja0Z6
         kPEWKkCbGW6TDJuhN5f0na1Pk9MoeU5jvBiaBusXAsMnWUgNhSRPBB/pyV7pWE14bxWJ
         LqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LltlK60r4LyNjCoDNXMYJYASHu9Oufj7+fCgendHkG0=;
        b=VIQN7P/XlJm09zSbSsPA1FCuz+8MnlYhyxBQKkBp83dNiFf0SrBhT8LsYS5f0oeBOC
         vLsdpMMHdKoogQ2hKJ+n+WPMAEX7xyvcXxn1M6QHLmDMv5pC7GHMmm+PmetiOoaxhWU2
         Cj+qUgKm8gsHjb39v4yVzhL20o1q/ZwaBvnhHMRZl34H4mtLf8Yy7Q35xvIvJuah4tc/
         vwFzv7xGg7mKMKqP9ya2BgU4azQMOl/V+P3tCFtB3JN1DQ/Xt4leReCD491RIX0Dt+vd
         yPRb14LH7vGW1S6n83mR4RPEEojo2KFGyiN9wupmVvkRTVD5fKro6p/15GBd3BWURTSn
         uKYw==
X-Gm-Message-State: AOAM5321xng29ytN9gi8+VExbyU/jq4lknPC1Qb7sh0juM8K/NIH3ZOd
        SiN88uWwwTPJ3rfkK2BpAXMDoyBFUjleFw==
X-Google-Smtp-Source: ABdhPJwoDV4EfqWlXfeQL+BDnymsqkx+rBeCMSdV7ywJ2n2N9o4mKL2tr0OF1P3U5NAYJGlEVHGY7g==
X-Received: by 2002:a05:6402:17f0:: with SMTP id t16mr1828766edy.107.1606387645664;
        Thu, 26 Nov 2020 02:47:25 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:25 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 1/8] block/rnbd-clt: Make path parameter optional for map_device
Date:   Thu, 26 Nov 2020 11:47:16 +0100
Message-Id: <20201126104723.150674-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

During map_device if the given session exists, then the path parameter is
not used. In such a case, the path parameter is redundant.

This commit makes the path parameter optional for map_device. When the
path parameter is not given, if the session exists then that is used to
establish the rtrs connection.

If the session does not exist, and the path parameter is also missing,
then map_device fails.

Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 1 -
 drivers/block/rnbd/rnbd-clt.c       | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 4f4474eecadb..e7b41ec7cd6a 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -37,7 +37,6 @@ enum {
 };
 
 static const unsigned int rnbd_opt_mandatory[] = {
-	RNBD_OPT_PATH,
 	RNBD_OPT_DEV_PATH,
 	RNBD_OPT_SESSNAME,
 };
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8b2411ccbda9..edefa0761a81 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1193,6 +1193,12 @@ find_and_get_or_create_sess(const char *sessname,
 	else if (!first)
 		return sess;
 
+	if (!path_cnt) {
+		pr_err("Session %s not found, and path parameter not given", sessname);
+		err = -ENXIO;
+		goto put_sess;
+	}
+
 	rtrs_ops = (struct rtrs_clt_ops) {
 		.priv = sess,
 		.link_ev = rnbd_clt_link_ev,
-- 
2.25.1

