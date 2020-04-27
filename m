Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBFC7C7E1
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E090E2087E
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Fpxnl/UA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD0Hmp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgD0Hmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC7C061A0F
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so17655954wrx.3
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCmoWGSBp0bkzJg26kKRHWQrBipKAajMKVFOcPDe3LA=;
        b=Fpxnl/UAJRSu0MlJX/eTcPVQag3sJsu1tNWj/IhwcCrALMssjX1D99A/8Pf06ZRJm6
         DfAGzVGkwco3mmYXL0yWR54tkAPJAAf+yQcA1MEaQn2Jf3OxWsY6W0gxjuIw4e7zuTWo
         RNniWSsJ3DojLB7zizi27lOPQZjG8Kn9AsJgdziHXKnnFPx/MioQSmvhTjNTVFZqxG4I
         WTT34OXOr8Nqhtc0wj175eXmlHwJFehGqmLASAfuw+xxfuipMG5hrfxmUv3sj6Ke569A
         H1jV+WQj8KCiVKzn63y86pH9x1SNV73l4zPWXeWLV/O5ZwOeChPNcp7YKR05Bdf33brv
         juiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCmoWGSBp0bkzJg26kKRHWQrBipKAajMKVFOcPDe3LA=;
        b=NodWh/owyunxmlWRlcnPWA7c7e2EQsNlkJ2j6qKDXguu6SivBtLgtuEo66bFvKITjl
         OWDj2VvKqBqVGr2/aasmmruksI/OEt51DjVFtWbh3XEepcgbDtW0rE945OQkB76PBo18
         VxkRtXHMEm8g5UQoHnAlkRCp9j74P6ViRwlFmNflNgca6kPWA+3VqZV4OuZ9+hpu8sUF
         b2weqMu2VSmMC9qEABgo8psePcqFfQzlisFP2LfIS1Xe0jAiopqgmhnHRVqdr7w47rVc
         ZpDj4dUf5EAOdg8jEPrS5Y+HutcM4zjfwxUkCh0+JSHUrDETd5/CsO6awMUcnFF0k8OM
         EMjw==
X-Gm-Message-State: AGi0PuYYERTSoIhb/J66zkd4SnrylYkvpB75pwaKW6I6ZT9ry1YUmN1d
        W8yoSO+II1lDmOdf4qsjQt0EkQ==
X-Google-Smtp-Source: APiQypIeVxgjC84n/+iNIZdbu7Zqu5t8RkSwPK2GboDSMrHKbOfN6W3WuwmPkwZd9nt91ItTKfwsaw==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr25344895wrm.404.1587973363097;
        Mon, 27 Apr 2020 00:42:43 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:42 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 8/9] loop: Rework lo_ioctl() __user argument casting
Date:   Mon, 27 Apr 2020 09:42:21 +0200
Message-Id: <20200427074222.65369-9-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for a new ioctl that needs to copy_from_user(); makes the
code easier to read as well.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cd1efe0eec5a..92bbe368ab62 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1660,6 +1660,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *) arg;
 	int err;
 
 	switch (cmd) {
@@ -1672,21 +1673,19 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status_old(lo,
-					(struct loop_info __user *)arg);
+			err = loop_set_status_old(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS:
-		return loop_get_status_old(lo, (struct loop_info __user *) arg);
+		return loop_get_status_old(lo, argp);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status64(lo,
-					(struct loop_info64 __user *) arg);
+			err = loop_set_status64(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS64:
-		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
+		return loop_get_status64(lo, argp);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
-- 
2.26.2.303.gf8c07b1a785-goog

