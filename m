Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C349E95A97
	for <linux-block@archiver.kernel.org>; Mon,  9 Oct 2023 10:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbjJIKEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346003AbjJIKD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2023 06:03:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D999
        for <linux-block@vger.kernel.org>; Mon,  9 Oct 2023 03:03:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf55a81eeaso28230165ad.0
        for <linux-block@vger.kernel.org>; Mon, 09 Oct 2023 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1696845837; x=1697450637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hMq2jaKv0w7qan5Rleu8o2mGnamgbpb4/RZFYckJiqE=;
        b=eIN6wv78V6TIKbWZslEO89bntQLmIuBcYQSWGCKiV8hx3qW1IGCESB+Oa1htaV6KpS
         isOAXUhyeAdED4TzYY++98CVRGuqHD4AToSEcjSRKdiJT1Vx8BwuODWuw50OFghIpAy2
         cZ6kNNVgBq0tFbObLYRdD4dar+zLGyosiRu09MRlB5rTCLAbEALZZxKeCDcPXLCz10Lt
         1bZXqUolgxjnIvMGDzjRNSebzBZR7z8w0bZEKlGhfNbKZ7GjtOzImAK03b+S4cO1+87L
         9AdAN80jZ8+Aik7LTv5Ki7QcU3jfdon1BFoIJlXvUxJ1Ht9KBwTWP+ADnDc3a99FkEeV
         7ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845837; x=1697450637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMq2jaKv0w7qan5Rleu8o2mGnamgbpb4/RZFYckJiqE=;
        b=M/frgggjBq3wPNLhRG09H3SUhUHms8EgxVW5uzDJhL9Emr8U0ISo58E04NcoSc+tlb
         c7N6qucOQHPRgJswfPeqFWQTSNg7E7eG4FeyEFwS/Mm1cFXqhZ9o2bMlPdBq4W5wzNu7
         tbbe8PtsfRHViucAa4z2k4KUhZJwp7IYt+aHKgCXn+tNo94qHx9JyTQwpcYGbrgJrqAP
         28D1BOXkE8gnXYHtc9x0V7eLebbLN324cPi2V4hej0E+RWq+eN1x1h8AaaejSuua8pPz
         ILB9oQ56mBPBbZ16iNRAcqbVYm2pKKWVR0DNe7UmaG9y3cqp+opOnEH4l54HnkR1ls93
         odsQ==
X-Gm-Message-State: AOJu0YwV9fZFtMLThGUTrTUTUV5ZrYRwMqZZhNQsiA6f1EbmrnappSMi
        ldaTJLoK8AA83wCYSSof1c28ow==
X-Google-Smtp-Source: AGHT+IHqyeR/SlcADUh0qh+R4VMms4WKkZS0JH3GoHyZjxjZO/4rMaaXkeB8vh9DU/H7/MsJVadC6A==
X-Received: by 2002:a17:903:1245:b0:1c7:49dd:2df with SMTP id u5-20020a170903124500b001c749dd02dfmr14037224plh.32.1696845836897;
        Mon, 09 Oct 2023 03:03:56 -0700 (PDT)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001c5eb37e92csm9119991plg.305.2023.10.09.03.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:03:56 -0700 (PDT)
From:   yizhou.tang@shopee.com
To:     houtao1@huawei.com, jack@suse.cz, bvanassche@acm.org,
        kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yingfu.zhou@shopee.com,
        yizhou.tang@shopee.com, chunguang.xu@shopee.com
Subject: [PATCH] doc: blk-ioprio: Standardize a few names
Date:   Mon,  9 Oct 2023 18:03:49 +0800
Message-Id: <20231009100349.52884-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tang Yizhou <yizhou.tang@shopee.com>

Our system administrator have noted that the names 'rt-to-be' and
'all-to-idle' in the I/O priority policies table appeared without
explanations, leading to confusion. Let's standardize these names in
line with the naming in the 'attribute' section.

Additionally,
1. Correct the interface name to 'io.prio.class'.
2. Add a table entry of 'promote-to-rt' for consistency.
3. Fix a typo of 'priority'.

Suggested-by: Yingfu Zhou <yingfu.zhou@shopee.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4ef890191196..10461c73c9a3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2023,7 +2023,7 @@ IO Priority
 ~~~~~~~~~~~
 
 A single attribute controls the behavior of the I/O priority cgroup policy,
-namely the blkio.prio.class attribute. The following values are accepted for
+namely the io.prio.class attribute. The following values are accepted for
 that attribute:
 
   no-change
@@ -2052,9 +2052,11 @@ The following numerical values are associated with the I/O priority policies:
 +----------------+---+
 | no-change      | 0 |
 +----------------+---+
-| rt-to-be       | 2 |
+| promote-to-rt  | 1 |
 +----------------+---+
-| all-to-idle    | 3 |
+| restrict-to-be | 2 |
++----------------+---+
+| idle           | 3 |
 +----------------+---+
 
 The numerical value that corresponds to each I/O priority class is as follows:
@@ -2074,7 +2076,7 @@ The algorithm to set the I/O priority class for a request is as follows:
 - If I/O priority class policy is promote-to-rt, change the request I/O
   priority class to IOPRIO_CLASS_RT and change the request I/O priority
   level to 4.
-- If I/O priorityt class is not promote-to-rt, translate the I/O priority
+- If I/O priority class policy is not promote-to-rt, translate the I/O priority
   class policy into a number, then change the request I/O priority class
   into the maximum of the I/O priority class policy number and the numerical
   I/O priority class.
-- 
2.25.1

