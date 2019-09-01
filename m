Return-Path: <SRS0=xSfi=W4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836BC3A5A4
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E34A21874
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnWRhXYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfIAX2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Sep 2019 19:28:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45332 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfIAX2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Sep 2019 19:28:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so11048742qki.12;
        Sun, 01 Sep 2019 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wgz4pNzu4xMDyciaAAQpIen+rsuaRgPe2eC75rZgfnY=;
        b=gnWRhXYUSMPA8TnCQdWDTsCWmx3OtvjNz56sd460qbNROrNVWnadKJUp9M1oTFxNTG
         D0l1zTkugcmXF+CNiUkjVtx7Hv4SKuCA5/lUOTfqTpN1xSfyLpL3RoJUwAHKrpbHcdyK
         EbyxxLew/r18jOlD1+WZZ6NpbKk1tvLMuJ2m82WPZ+0f7/+gtf3NY512SCUZejHFPEq1
         Pzb9ORbhvqXhL67XOhcY01ZxIX0kA/53eNH/5xra5LiKLSSJVSHVC35zFth3o5R09qs9
         ZffUEDVShpbh2I+1QnwAtcQqQQpB2VRqismAdIOAY5xn1c49LMMUZYfuofE1AkncXPjF
         M/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wgz4pNzu4xMDyciaAAQpIen+rsuaRgPe2eC75rZgfnY=;
        b=WDfPXIIfDjTSHiXIxkOFn33GvZxSp84HOW41ucxpNjU05GMpDr8TB44/lLG7Mp39hr
         im327D0ML/q0S8qmQwuKYKhgCoaCnu1R5pb6Goxh8d4aCAPdrUVy361M5Aoy1ggSGzGj
         JopYJTrdpHy3sxNBN7gnBoMCSBBgOl/wDtJcd4T44cdZCoJ5JvqpMI+yxW6VQEZDVEnc
         F+INLCeL4dkfkfe557VX3k+hpn4kLQTe7vD76+f+PbTGeFBG8rzzGZ2imn0A4Fkwb7ZI
         Am7pYQGfCC2ckoJIA8eVoEKEoKGaYwoA5il600VgrenqAPrzHiCI4c4c4Uk2f0Vwt+Xo
         9O0Q==
X-Gm-Message-State: APjAAAVT7iKd31yiDnkHRe6CW6bSJsQWTyTdSYk3QwVEnsXre1tv4mUi
        N0/dtJbKdSK5tVn1X34hx1MzLeM4
X-Google-Smtp-Source: APXvYqzCPqhiZ9/ucEsgOsgMsuAXZ4vNrKb2zjjjxZQfHNUmMB+cXNRCvCA9jUIyqtfnYhRSb7DCkg==
X-Received: by 2002:a37:aa58:: with SMTP id t85mr19395830qke.381.1567380489303;
        Sun, 01 Sep 2019 16:28:09 -0700 (PDT)
Received: from localhost.localdomain (200.146.53.87.dynamic.dialup.gvt.net.br. [200.146.53.87])
        by smtp.gmail.com with ESMTPSA id p59sm5684085qtd.75.2019.09.01.16.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 16:28:08 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 4/4] Documentation:kernel-per-CPU-kthreads.txt: Remove reference to elevator=
Date:   Sun,  1 Sep 2019 20:29:16 -0300
Message-Id: <20190901232916.4692-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901232916.4692-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was not being considered since blk-mq was set by default,
so removed this documentation to avoid confusion.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index 4f18456dd3b1..baeeba8762ae 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
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

