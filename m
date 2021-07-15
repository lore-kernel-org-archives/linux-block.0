Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60256C636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA73613C7
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbhGOT4B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:56:01 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37695 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345146AbhGOTyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 15:54:45 -0400
Received: by mail-pl1-f179.google.com with SMTP id a14so3985356pls.4;
        Thu, 15 Jul 2021 12:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOZJguT6e/3qRtTmvglKU9JRoKMGH/7hjY62u5soSk8=;
        b=ZUi1OAQEE5vhE9yn0Ne7DvMF7nZPFR52sOggUoyx3Kq5QhMDEroPfL0DiNFA65TA4g
         FbrZHK8Ev/oDgRcq8dstvR9M1hgMzDRixI+sFMdTcP/qVs2TwCUYYdNLtxeRFYFpXj0e
         pNIvC05LVRrCGbgS3aMym66woFSOvHfB6D+4q4YGOvhH0wj1nAOVFTzKvcUM+b41JZ50
         mrdUi728xDHsE5v/dbNLgOQEq51c1kGSuzgat7Gwsv8FMpNocLY+vHm60V8aOZa6Nh7n
         STMpncZ+qDygKOSakcZoy4fpnUuJFxlPXNvoPxWZEHnbYE79GzzL/kNANC8lfeNvwGDs
         H07Q==
X-Gm-Message-State: AOAM533hR/5boazrL8v5XIO8nj8Ht/OydrqvgwWZQ5YSCFcwj03ExNz2
        QUyRlK42OImVA1QxPd7f3ws=
X-Google-Smtp-Source: ABdhPJwjYNjp+FUDGCk59hrqetTx4Z8BQ8/4Mba8i0AYXQM4OCICd+2wzT80C3/eHSYFlY+bFkda5w==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr11649926pjh.40.1626378710845;
        Thu, 15 Jul 2021 12:51:50 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id o1sm6095214pjf.56.2021.07.15.12.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 12:51:50 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/3] nbd: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 12:51:41 -0700
Message-Id: <20210715195141.1882285-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715195141.1882285-1-mcgrof@kernel.org>
References: <20210715195141.1882285-1-mcgrof@kernel.org>
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
 drivers/block/nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b7d663736d35..0ecc1e4e16fd 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1730,10 +1730,14 @@ static int nbd_dev_add(int index)
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
-	add_disk(disk);
+	err = add_disk(disk);
+	if (err)
+		goto out_err_disk;
 	nbd_total_devices++;
 	return index;
 
+out_err_disk:
+	blk_cleanup_disk(disk);
 out_free_idr:
 	idr_remove(&nbd_index_idr, index);
 out_free_tags:
-- 
2.27.0

