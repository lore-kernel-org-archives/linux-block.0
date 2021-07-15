Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCBAC636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB30C6127C
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhGOVCx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:53 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:50862 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhGOVCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:39 -0400
Received: by mail-pj1-f53.google.com with SMTP id cu14so4999143pjb.0;
        Thu, 15 Jul 2021 13:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opwhNKeojQqHFAHP3TlwxM2PDAe+bMtwLiQ5ZcK4UGw=;
        b=JUlSXrmXXdRIYfiCmR32cs5+o5DpggyTxaSXUwV9ZMgwO8rci0j8KzbLbDQYyfgsF7
         XImymzSRYJy66rHfChPS3T7gAI3uKPq5O6bA0HNGa06HVAR45I0FHxig9If5yzEd4zhj
         yGzKEwXjw9Wa8C3FoNQdUgR24fnWm0bMxhkrkgBV+doKRkl7gCVshBXDyKyIXdu11daN
         bHRMP3IGu7QD7mfJf0hAQpT/7ZjVZZL4wfFn2ZhuZo7VU72G0OnOXEdHuDolmWY2o6n2
         CQftpffQlHogMBr5aRKABpTO4usvd5lduKGrR/HB9wV8/eLmCNNEVSp8Jk7KXWApmvWK
         Q6KA==
X-Gm-Message-State: AOAM530SUNJ91ly+OAGgjwSJfLkRfJHeZw9qPVbsH/fTbR2Higs/7hyt
        yaGUt/1LQHRsZXwWz1qoIak=
X-Google-Smtp-Source: ABdhPJwcL2iOwyaCUxvCsBAK7LrubtQ4Qm6hGPoN8uSRnwjGYm7S3QwYerpxQD1rHcPYmZbFBA2QzQ==
X-Received: by 2002:a17:902:d90b:b029:11b:f58c:f3d6 with SMTP id c11-20020a170902d90bb029011bf58cf3d6mr4989458plz.42.1626382784943;
        Thu, 15 Jul 2021 13:59:44 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id w6sm8348456pgh.56.2021.07.15.13.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:44 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 07/12] scsi/sr: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:59:15 -0700
Message-Id: <20210715205920.2023980-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 362f04a3761a..ed097b69821e 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -776,7 +776,10 @@ static int sr_probe(struct device *dev)
 	dev_set_drvdata(dev, cd);
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sr_revalidate_disk(cd);
-	device_add_disk(&sdev->sdev_gendev, disk, NULL);
+
+	error = device_add_disk(&sdev->sdev_gendev, disk, NULL);
+	if (error)
+		goto fail_minor;
 
 	sdev_printk(KERN_DEBUG, sdev,
 		    "Attached scsi CD-ROM %s\n", cd->cdi.name);
-- 
2.27.0

