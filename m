Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4167FC43611
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19899610CC
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhDSHif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbhDSHie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A830C06174A
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:38:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so39446212edd.4
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjT+RMguLzB/ydHWKHwjOq0GIA6D6i7AJvW+As1h5Do=;
        b=Sh/Fg0ll6X03ziKmHodXyrxXJHafQsw+MUvwQ+5AcmFtbtWTsEOIp2bxFN8O4TnR46
         jnKbPHiD1PEczxyWDgbP7zA705rQufnPkGQNsDuNcVS+Hvqw6coC9nz5SkulBS2P9cpK
         bYmApqKucC/r05q2JmT4L8pKmXMr9jQYgM7Vy2ne+UlzliAQlpEPfwHEMtt+40j0kBDA
         Dn38di5CTNPg8cxiDd+FoPTwH9oaT9xujuC+bOFhZToZNXXAHk6ok3+C/DYc/o9J4rp7
         l2yplYQ7HPsQdJ+p64PnWp2e576Oyc9Pz0146YKig9TTo1JP7BwZQx2mGmCaYGPVYTEC
         4qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjT+RMguLzB/ydHWKHwjOq0GIA6D6i7AJvW+As1h5Do=;
        b=T4PCVvFBFq6AtjMrSrNGpoesu0a66DMpMUjeORJjTBNQ9FsCOYNFmD2YUX5DLctNEC
         xK3Bq/Cwf2RCtQNRtYaSGfB9wucvlwFi1jAJKkLqMgMmidaJPqU6eIXOyUJXE3HHpciH
         w3mIncxSJ9KAJMhsv6GqbnI4c3CZAGDH/TYCRY8B9TaQMnSu67la202URx9pwgIWEC7z
         dKMEMI3+e8hsOJxlc2vAqGohq4TQelPrcGPXWX52+7aqSEOLf/wvASf/TUyE+wt9xxUm
         88yGvMzDF2DDIBhzCdm0jKjyF59iQomMJ8KvBiMAYpcdUkGktmbuIFejTZtN43MPrWmz
         wInw==
X-Gm-Message-State: AOAM530Uy42/8KL4zYRbKyIXetcvad0/ml2mzHrQN4XndsyZ/Yrh+gQi
        XsQVafTvUfZmaqcSzzwQsZQn9SfNH/N5xD/Y
X-Google-Smtp-Source: ABdhPJxdIgjYmLvxL2QRQl40L2C6ldx9rtxO4RAhrwq6afBTvsfPUCwPItknuQXq2LOsz0q/rFkhMA==
X-Received: by 2002:a50:f28e:: with SMTP id f14mr207557edm.371.1618817884142;
        Mon, 19 Apr 2021 00:38:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:38:03 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv5 for-next 18/19] block/rnbd-clt-sysfs: Remove copy buffer overlap in rnbd_clt_get_path_name
Date:   Mon, 19 Apr 2021 09:37:21 +0200
Message-Id: <20210419073722.15351-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>

cppcheck report the following error:
  rnbd/rnbd-clt-sysfs.c:522:36: error: The variable 'buf' is used both
  as a parameter and as destination in snprintf(). The origin and
  destination buffers overlap. Quote from glibc (C-library)
  documentation
  (http://www.gnu.org/software/libc/manual/html_mono/libc.html#Formatted-Output-Functions):
  "If copying takes place between objects that overlap as a result of a
  call to sprintf() or snprintf(), the results are undefined."
  [sprintfOverlappingData]
Fix it by initializing the buf variable in the first snprintf call.

Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices")
Signed-off-by: Dima Stepanov <dmitrii.stepanov@ionos.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index f3a5a62b2062..042566b47bd9 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -514,11 +514,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	while ((s = strchr(pathname, '/')))
 		s[0] = '!';
 
-	ret = snprintf(buf, len, "%s", pathname);
-	if (ret >= len)
-		return -ENAMETOOLONG;
-
-	ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
+	ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
 	if (ret >= len)
 		return -ENAMETOOLONG;
 
-- 
2.25.1

