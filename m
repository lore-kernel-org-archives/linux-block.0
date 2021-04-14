Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E66C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F138961107
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350874AbhDNMYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbhDNMYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5745C06175F
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so31066570ejz.11
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GLmGEOM8a8Vo8sEzMJWKxgZlfWZibMODdE55QOLHT8=;
        b=S+aa7MKWj4O7Z0A6uqvAIVO9sEgxu8N2hq9XmmPkImZjRTs8hBvQem7qu4bODnYPqR
         DhqB2E7TUoGaOWNvavVpQET/xfyu+UDXS92ezH+XBj31wApuxcb30UpC/UETSvcl4h2o
         8d/ag4NaJkdfH7nkl4Rd9j4Gjhn7Ul40mpYWqVQ9dCuH2nTS5OGU3YfulKApkhKfvsWC
         jPIZtqIeV/bkYXXLbUS0LdHRW9JC/YnsOhnNa2mkNquAVYUD3+GqUuhJi+hBVHz/C5rX
         s4DcVQp7ZAB62d++c5kkhyD4mDM1E7S9ZikBMA9ByCgN/J2IVWaq+ECmPuOHuaeW1UIL
         5m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GLmGEOM8a8Vo8sEzMJWKxgZlfWZibMODdE55QOLHT8=;
        b=UklGPSwVqoH28lNlBYPcOZXZtiYLDra0U5Rx2RfPV9kXtc0FNvvjbXrbqJ8wlyfr4g
         1jSSbEXWysufLwzbm0veGwjo2/oUkdsfUVVUHF5Mmk45sDB2XMekfIYB/h+/1OOUnUaJ
         f/SwZyiLHo+7Mg7JfspNVu2X+oB/IHd6bye6TSUSrEKJCXDgec+cNXQHcdXSWO4Fqp4H
         WS6WwiDzs8cE143gnfszpX+aAwRQB5/aBcftQExEZwQEcs7/6KzBVq8LUf0/6hlwpjqW
         a/VF2i6AgtEpU+NbSMDgkEuBZhfii+3Xpj9BT0vRgH/L03LY2ahvaYL6yi9aqHNeR9fG
         Pi+w==
X-Gm-Message-State: AOAM532j/RZkyfMMWihs4MgnDmL9G1zOMkKvtsSxJCcZOkfq3RdQeCpH
        snEbUXYBsKJ8wnS3/cx2rkbJokkDuIeBNol9
X-Google-Smtp-Source: ABdhPJztYp6U0wFbnX3h2M2gExK9f/oyRIdsAsWHnRvfAiu1ylNvfBpKHpAv8jTKSRjotbJLG5c5Yg==
X-Received: by 2002:a17:907:2d94:: with SMTP id gt20mr30114998ejc.552.1618403064418;
        Wed, 14 Apr 2021 05:24:24 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Dima Stepanov <dmitrii.stepanov@cloud.ionos.com>,
        Dima Stepanov <dmitrii.stepanov@ionos.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCHv4 for-next 18/19] block/rnbd-clt-sysfs: Remove copy buffer overlap in rnbd_clt_get_path_name
Date:   Wed, 14 Apr 2021 14:24:01 +0200
Message-Id: <20210414122402.203388-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
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
index 5609b9cdc289..062c52e7a468 100644
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

