Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C150CC433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DE32071A
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 21:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pdobmyvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgE0VGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 17:06:37 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54790 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0VGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 17:06:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49XNg00dkfz9vBsM
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 21:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vh0k-8L4lAJJ for <linux-block@vger.kernel.org>;
        Wed, 27 May 2020 16:06:35 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49XNfz66lSz9vBrr
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 16:06:35 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49XNfz66lSz9vBrr
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49XNfz66lSz9vBrr
Received: by mail-il1-f197.google.com with SMTP id x20so21454051ilj.22
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZSlV3tEQ6XuheL2Xc2G2BwyWDLdcBMbchtoHVKeo45U=;
        b=pdobmyvOcgMFfTVziKKFwlbsc4W+5+f2QHsIHMFMtSGeGb971/hub2yEdPrdbZdMNu
         VZmEh8HK5u4DaJOCS0yFe/gUwxpCXVW/W4tyC6o+l88wEeFuBCX12c0E9OupOiZsVYnS
         w1ZsxES85zs5hSh8e8r7u2bt7JAmb/WNBJ5IXRxXR3QxKB3/O7r3HpqGomOPLC8i/R+D
         jJCTq1JObP7L+m6xkagcXbPm3wgW1F2P8OwkmEvq1MPPzy/AiDPrHGt17AmreDUZh2td
         Y1tb0yfvJvIUHtGh+R+qJgtkUEuRJOly4G2BdjTpZIAq9+hJ5OU4Yb5UdrAF77c6cTCt
         ugng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZSlV3tEQ6XuheL2Xc2G2BwyWDLdcBMbchtoHVKeo45U=;
        b=DFU5Hz3baNXDw3LvvDFDxb9iLfwzfQjsXS1KCVXPfQJMthDusXMMzirt2eoZnjbSza
         9MLEU1OCQWLGKTBfc5PNfFK6NytpiiMr5kXLHuP0PzipXgvYaBskcO8cRRYa6/j8yHHy
         +UVwRUO8uFncpYV1RMFclzyE0fpatgILGw6EI1wLy1GKj232T+zFLZ43lRqPsHYUJIfb
         iISutyw8yWkdSxlY+bKCZVE6oy4Sfd4bs/su5h0l7yc9KwtwtQDuQX99NB2DIQrZPh3J
         EGW3sT3BiygeMpBqGMAdDlaOz6VTSH5FqAica1riHR0iB1uTfe7fvMnwShxrrVcQVCgG
         fCqA==
X-Gm-Message-State: AOAM531AMiiFR3SjzvV2/KNfsV8953diNdic0nOT4S7ho5xJg9beRb/I
        7lKyaOhM/sJeAy9eEe6jaOmh0zKCu1PviInEkYvZzAO0JFdtwfBXqeHwE/eBbaxxsUcc+80MtY4
        qgX9lZDN+20aJMr7mqMnpH+9pFgg=
X-Received: by 2002:a92:ba46:: with SMTP id o67mr220225ili.66.1590613595353;
        Wed, 27 May 2020 14:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0pmOT1Qb57G2i2D/b2H4L/d1ug6uNxyKQtfBL8egEssL9tZNr4G4bJNl2U6YgQ/CmMa7j9A==
X-Received: by 2002:a92:ba46:: with SMTP id o67mr220214ili.66.1590613595091;
        Wed, 27 May 2020 14:06:35 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id h5sm2063832ile.35.2020.05.27.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:06:34 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: pblk: Fix reference count leak in pblk_sysfs_init.
Date:   Wed, 27 May 2020 16:06:28 -0500
Message-Id: <20200527210628.9477-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/lightnvm/pblk-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 6387302b03f2..90f1433b19a2 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -711,6 +711,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
 					"%s", "pblk");
 	if (ret) {
 		pblk_err(pblk, "could not register\n");
+		kobject_put(&pblk->kobj);
 		return ret;
 	}
 
-- 
2.17.1

