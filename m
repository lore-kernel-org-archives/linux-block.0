Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537FC55199
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CED214D8
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="oGC3hWAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD0Hmj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgD0Hmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1674C061A41
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so19293928wrw.7
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpydbUORH6esAS5gi+cl+9hT95SHJdDoYerkBD0BMSQ=;
        b=oGC3hWAK5PSMXwewUJVSLEn3ogH9c7x5GKyIHrpt9Un7/DBlDORpuf62nVnG49Srxq
         CBPr6rjegtfdy4HmaesOJcdbArkYcmrSclkKdby2Szkv2vZysdmhW/l8xsDWAw2iyPnq
         jfboZFx7R4wbNNSHjoAWW5eMpNn76nkOspz55Y5+OFrUkDYZ8p0wXuqCEi45cqbxXUBG
         TeFDLDb0OfgPptEIe47XWWQm/bN+bVLTlgFBc4gekSc6hGd2QXs2dBk0V1KbvDBHqQW+
         3g1EWvZ+w2B1/oRR4QmdxkGkGcsOVE2LCqMRuxP+CV8IuHcnno6CdC3EKkUvtBdSkHpL
         gEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpydbUORH6esAS5gi+cl+9hT95SHJdDoYerkBD0BMSQ=;
        b=beX5YpgTD8ozmwn2pFv6L8P7H+25x/Ew/4qgQJ/0mUgnil8QKc3vsoAb0Gk78ZYCkb
         17L7+FV/mR3ECHETLkTtjWBLHJH3DzZEnpZ+0xzJ2OMdHmDG2cZL/+bBylSZ2MI2a0Uu
         Z9H0RDCmDPoAWJGXcl4k9MXa3kw/HPjMr4SR42poc1SNuZwtKnikWzP7FFUnye9nXxWY
         UTn8DVpULuW7sf2KuuNRpbo+BIRDoEAYTp9McPTXPY1wMkU4AKV5aoSsZfs3liqkFZmP
         sP2NFW3lk10wRpLb/k7j9Be1voi1KYOoHTxI3zrIPdClODap3KXCtY2M/h3Gnhdys7ua
         +n2w==
X-Gm-Message-State: AGi0PuYVdfKH3ZSH52FodnotaU5INtgfip0dDQKUz5+s132ldNOrCgN6
        5obmPC+r754vW4tEGqhaEn+9kg==
X-Google-Smtp-Source: APiQypLFrOdL4tryNZXtOTQNslh1ABY9mm0tKM345BBzQpNwqTXF9WQtd8sATSSGF3XCbbu98PFwRA==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr26755993wrx.239.1587973354636;
        Mon, 27 Apr 2020 00:42:34 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:34 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 1/9] loop: Factor out loop size validation
Date:   Mon, 27 Apr 2020 09:42:14 +0200
Message-Id: <20200427074222.65369-2-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensuring we don't truncate loff_t when casting to sector_t is done in
multiple places; factor it out.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f1754262fc94..f812f11649d3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -228,15 +228,30 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
+/**
+ * loop_validate_size() - validates that the passed in size fits in a sector_t
+ * @size: size to validate
+ */
+static int
+loop_validate_size(loff_t size)
+{
+	if ((loff_t)(sector_t)size != size)
+		return -EFBIG;
+	else
+		return 0;
+}
+
 static int
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
+	int err;
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	sector_t x = (sector_t)size;
 	struct block_device *bdev = lo->lo_device;
 
-	if (unlikely((loff_t)x != size))
-		return -EFBIG;
+	err = loop_validate_size(size);
+	if (err)
+		return err;
+
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
@@ -1003,9 +1018,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = -EFBIG;
 	size = get_loop_size(lo, file);
-	if ((loff_t)(sector_t)size != size)
+	error = loop_validate_size(size);
+	if (error)
 		goto out_unlock;
 	error = loop_prepare_queue(lo);
 	if (error)
-- 
2.26.2.303.gf8c07b1a785-goog

