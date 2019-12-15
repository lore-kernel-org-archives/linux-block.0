Return-Path: <SRS0=PLNA=2F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE6C43603
	for <linux-block@archiver.kernel.org>; Sun, 15 Dec 2019 16:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2674020726
	for <linux-block@archiver.kernel.org>; Sun, 15 Dec 2019 16:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gASw7z/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLOQnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:43:39 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48668 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfLOQnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Dec 2019 11:43:39 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Dec 2019 11:43:38 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bVPv4Sk1z9vYfP
        for <linux-block@vger.kernel.org>; Sun, 15 Dec 2019 16:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aKtWzZokSCdz for <linux-block@vger.kernel.org>;
        Sun, 15 Dec 2019 10:35:31 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bVPv3FqDz9vYdy
        for <linux-block@vger.kernel.org>; Sun, 15 Dec 2019 10:35:31 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id 132so4668613ybd.3
        for <linux-block@vger.kernel.org>; Sun, 15 Dec 2019 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtqtAENkikt2OwSsUAKI6q95l8UgBNbet4mLKXhPLPc=;
        b=gASw7z/I0SjFUTMduO0mrbXnhtLKxXhWkOF1hA/NCG12Ch6gDZFEqMnbJIwzzEPoou
         +xH47X1jCoab581xt65AVJdaT3JqBWycPK5jVlQq0+xGLTyro0BNAy6T6oB1/wt/dles
         ag7qhX3VwtoyqJFRO+djy8VltI5NtuvPH+NoE3e2pZl1gm9KBPs0tNtqIYIV9YV+iP7j
         BHNwjeLz35FgXSkYJz0vrOhsE/tvHIKDsss25zHf4nVDcqCbzb7gM6ATSy0cbmgug3Q2
         XTlMUOK0GYYiGZRDWz5Esl0NS0AozgZJ4ge0Ve6AbtJCcyVVNp8l9cAL4TZxrmk86wn2
         VLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtqtAENkikt2OwSsUAKI6q95l8UgBNbet4mLKXhPLPc=;
        b=dnZhTU2Apw3JXb4jrpBP4MlqFlo6cu+zwuW3YqYnAPDYBSuD0HG6jGE0hIEbgDSMJ/
         AMKxZhNcMRAlA/LT+enskVRA0PsmmotJv05I4MaHL2kCAENuWSOrvLcXON9I8biEJnWC
         9wmAg02/KMFoos7V3/M9sBw7z517rs3O1R7y8l9T43up4B4K1XOnA+3VuwaXrUy5TVRf
         m2/k7xpYlXatqqhcYYdLqkDtj44klzq25c0zH+LWwisrgi7p24r2ZonkW2lcpM+O69Im
         UT5M+j73xCnb7lQEzgKfGyTX7gJWw47OCPJSneZi8SfMnr176j/bMwofkeqWKXIO4fON
         K/4g==
X-Gm-Message-State: APjAAAVhobHBRK2iRCi6TCxNkLW/3VzmxVS8EiBrCS4XO0LGbs6CiYcX
        w/pDp2UyivgVQDJHo3Ps/M8tgzRPfUxmmmrJgDa8dsdRKsFPTXceqnd70IPRoV8ApG2wcnnmFdt
        nKvCI/eMRx33sPR3YviBYx9KdkC0=
X-Received: by 2002:a0d:cc4c:: with SMTP id o73mr16970364ywd.482.1576427730955;
        Sun, 15 Dec 2019 08:35:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqz926INkyG4z0GFI/Np7oPSQT09p97e6twIqiathpPSkhQbrht1R/pRTZ9FNegpZbKOIIU6sA==
X-Received: by 2002:a0d:cc4c:: with SMTP id o73mr16970343ywd.482.1576427730693;
        Sun, 15 Dec 2019 08:35:30 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y9sm7261560ywc.19.2019.12.15.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 08:35:30 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: Avoid calling BUG() when object_map is not empty
Date:   Sun, 15 Dec 2019 10:35:27 -0600
Message-Id: <20191215163527.25203-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In __rbd_object_map_load, if object_map contains data, return
error -EINVAL upstream, instead of crashing, via BUG. The patch
fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/block/rbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b184563cd32..6e9a11f32a94 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1892,7 +1892,8 @@ static int __rbd_object_map_load(struct rbd_device *rbd_dev)
 	int num_pages;
 	int ret;
 
-	rbd_assert(!rbd_dev->object_map && !rbd_dev->object_map_size);
+	if (rbd_dev->object_map || rbd_dev->object_map_size)
+		return -EINVAL;
 
 	num_objects = ceph_get_num_objects(&rbd_dev->layout,
 					   rbd_dev->mapping.size);
-- 
2.20.1

