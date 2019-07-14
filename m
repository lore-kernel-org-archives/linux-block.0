Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14641C742A2
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC94520C01
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc6j38WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfGNFe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:34:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47040 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfGNFe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 01:34:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so12380472qtn.13;
        Sat, 13 Jul 2019 22:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NuZBQYq6h4qssOwOc1GYw/bYwn0rg1ObW5YhftgdKo=;
        b=Rc6j38WHmlwoJ6+nn1UzHs0z5kKcHeRTnkdMI1haEQYRiv68Jaxdt46vXIi+zBbbcr
         SYAEWbGQQl4dHOdLj24edmB3gGykzrP1FMdZ9299TSoAufgb0mPy8x6aeCA2FO2IF8br
         VLoJRc4GDq9T3sngTJ78jRNc7oMihS80+wnoHOJaNgg6Kdga/8GjEXgVBOstmnClq2OW
         kcvi4xJiHhqb54UyagO2/g2/gx5wmNEZboIE31uf2ZQ5FXhXbOSyqba0PW5CXZvzSP/+
         YJCbOvBE7R0ZBkC6MkThlyTYq7p+h1RLL7HPaf2WSSmWqitkGhxcSF6PtIRC/qyGr03r
         i7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NuZBQYq6h4qssOwOc1GYw/bYwn0rg1ObW5YhftgdKo=;
        b=clzJOehgLlNbJgxhmLIhQzIkN0zBYulLs1no/28W7R4GBYPeHI3ZdWlSiNvWLCtA9R
         8SgI/AZ3k3hkgEXOmnGpmkOTkr2+mQbxPbUwPIN/FC4bh0ebYZtOXvzbiC6KzcS9RIfd
         V/HqwiikeS9QCNvpi4t2ke5mOMOcHiMBVjxezf3bfjHnwje4dHh3YUHrXSxs2Z/obKFc
         HNX4WOHKDEa6LkQZzzQC+Njkb7Jx/osO3jlQBahev3ZM9Z54NA4KvjwvZtoBrwib3tMx
         hHwRY1j938FbOfxYBzVLCy8AWt9H6oAkw9HI3HReruCDgby2AFC28FlXbEqYOSO4nsWz
         3H9w==
X-Gm-Message-State: APjAAAU277LcOxufdM4WkDgQEs1++/sqLgd/E9VHyYOJqycQCdauSO7G
        H0FCRsFDl0b5gIv6raBpEx/UqYn7eKE=
X-Google-Smtp-Source: APXvYqzbKUt2+dUfTolXSJIoItXsrnwI/cMSGQLlpamlQPHK1Ih2v6SivMNd42MzAWpnIntXozHS3g==
X-Received: by 2002:ac8:180e:: with SMTP id q14mr12664651qtj.327.1563082466762;
        Sat, 13 Jul 2019 22:34:26 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id f133sm6308808qke.62.2019.07.13.22.34.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 22:34:26 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/4] Documentation:kernel-per-CPU-kthreads.txt: Remove reference to elevator=
Date:   Sun, 14 Jul 2019 02:34:53 -0300
Message-Id: <20190714053453.1655-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714053453.1655-1-marcos.souza.org@gmail.com>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was not being considered since blk-mq was set by default,
so removed this documentation to avoid confusion.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Documentation/kernel-per-CPU-kthreads.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-per-CPU-kthreads.txt b/Documentation/kernel-per-CPU-kthreads.txt
index 5623b9916411..c68c6c8c26a4 100644
--- a/Documentation/kernel-per-CPU-kthreads.txt
+++ b/Documentation/kernel-per-CPU-kthreads.txt
@@ -274,9 +274,7 @@ To reduce its OS jitter, do any of the following:
 		(based on an earlier one from Gilad Ben-Yossef) that
 		reduces or even eliminates vmstat overhead for some
 		workloads at https://lkml.org/lkml/2013/9/4/379.
-	e.	Boot with "elevator=noop" to avoid workqueue use by
-		the block layer.
-	f.	If running on high-end powerpc servers, build with
+	e.	If running on high-end powerpc servers, build with
 		CONFIG_PPC_RTAS_DAEMON=n.  This prevents the RTAS
 		daemon from running on each CPU every second or so.
 		(This will require editing Kconfig files and will defeat
@@ -284,12 +282,12 @@ To reduce its OS jitter, do any of the following:
 		due to the rtas_event_scan() function.
 		WARNING:  Please check your CPU specifications to
 		make sure that this is safe on your particular system.
-	g.	If running on Cell Processor, build your kernel with
+	f.	If running on Cell Processor, build your kernel with
 		CBE_CPUFREQ_SPU_GOVERNOR=n to avoid OS jitter from
 		spu_gov_work().
 		WARNING:  Please check your CPU specifications to
 		make sure that this is safe on your particular system.
-	h.	If running on PowerMAC, build your kernel with
+	g.	If running on PowerMAC, build your kernel with
 		CONFIG_PMAC_RACKMETER=n to disable the CPU-meter,
 		avoiding OS jitter from rackmeter_do_timer().
 
-- 
2.22.0

