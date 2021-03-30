Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB8EC43381
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154E361957
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhC3Hir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhC3HiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ACC061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so17029290eds.7
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvJ5MzPF8I45JiDjPGx6l81wa3gYMJbbWHVkqSrx3qs=;
        b=YxyIRE/C34fU7tL0sALIEfjUbtDC3GfWkjg6AwDt2fo8Tw7U639uq51TdoLpB8mNeb
         i64yee+hdfDSnZ1wd55Yqtf9/bGRpkSvYFkQVLdTVk0BG3QggKg4QaHcUofrOmzLqRdz
         1SyUzCbj71ADYTE5BvYaF2QIRkqpBxxnUSp/Fiiq1RJhMOf4OjuuidUxK4bklA5ffnaU
         laJ9BAbXjHygkLuPG8IiEhyyYtjCG7nUamkJTHoVtxgudxVlkPgifTPD33U4WEhRZEtl
         G4qdIoIbbnsf5DQz2t63RV5C00uxgwnm0RjQHZjwDm52BJ3umHy5wn0JHT+xPSoV2Ws9
         vRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvJ5MzPF8I45JiDjPGx6l81wa3gYMJbbWHVkqSrx3qs=;
        b=bjUoCdjNlXqKTJQON+Q1kBM6KdbRO8o819mye9ZkT3BYVT6HhrD6e970uykukMGrWM
         RB2CjKVrqX/m5Lqc4gHC9jlAgtSl5FxZ4ARsrKdYa/sjevnrT5OL+kZhcrBrk3DHf7DK
         P8fG4D9Au0bnAynUy8Yx8U90iqjyjEJbyihY+AXDDCRiA4sxbR2C345Y1grBUY/S68nb
         UB1KActeIJYObju5eySK5gNhpqgNKPGcgcOMiBobVIoWk7oIhrezUbEq46unqcAdk2Ei
         hx5FNlVjEjQo7R6+7nrCcH65/cpVPGSrXhd+xWGZ76Z760+gdSC/Yx/GmUYQEKD61kSc
         G4PQ==
X-Gm-Message-State: AOAM532epOMnQKHutj1RY8w7By9xeXqs4sg+rX7uu7lFPQKG2zfXNHeO
        LihxUpNgYbYaU73+RBO2g2w+uT26GSwg6n/S
X-Google-Smtp-Source: ABdhPJwnjkpMY5xAGTsaUINcuGhIRnuppelmcv+GQ2ACkvWY0guY/A+1OQNUL0A0Zllliv6mZZCUMA==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr32226314eds.1.1617089895174;
        Tue, 30 Mar 2021 00:38:15 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:14 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2 for-next 23/24] block/rnbd-clt-sysfs: Remove copy buffer overlap in rnbd_clt_get_path_name
Date:   Tue, 30 Mar 2021 09:37:51 +0200
Message-Id: <20210330073752.1465613-24-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 630351574d1b..b1d04115e049 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -515,11 +515,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
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

