Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980BBC3A5A3
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 01:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0D120856
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 01:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRMhGeFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1BTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:19:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41244 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfH1BTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 21:19:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id i4so1146667qtj.8;
        Tue, 27 Aug 2019 18:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fD7GsM1ydbBIc5H/Xp89rOJflMYNEvnB2/MRHbI69S8=;
        b=QRMhGeFp8E+iLwoI4p4NieVsiHbGPCo+Y/WZdZIiecEjiLHKHq6IvH/pwedv027qGP
         0I0k1SYUvI0/Mr0bGTI79m4D0moX7yCHUaUjDYV5Xer9U9A4VZd7VoftRtW7gMF2X2aK
         IfkVWSafj1h8bZc+aFSNCG+1N0JMw3/Pt9fG6J/i5ooL4xiG4FiKKzdesXfRSJCIK/aJ
         1YHiM+By1mADl21uaRELp0K9H9C//q3ByfPg6Zl9wUG1LtPobhSMIDK29zFcewDlY90U
         L5/jRIdBXu/wXv/rt7Io7/fQ0YCtApK7PQ1VwZrelvXiHgfRrmQ4lrbzat04cghI0TwY
         5FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fD7GsM1ydbBIc5H/Xp89rOJflMYNEvnB2/MRHbI69S8=;
        b=S1F6ocrg4ECVOYbr1xAsGZqrs55vNJrdBZvRvTXb1gLiVKdVM5Y/h/7EPcIa5D0Lbf
         s1IlMOE1217nryE0mcjp6qKmniZXW2xJsXAyOrX6WD70eux55WqxapFY7Ni2FuR89k0/
         lN7dpM4DdVtS4dr06udd4zLQYX8OiTUyfO/k2LaQEMpfKyDpuqmou2B2K0ExuPPr8ibX
         kp6s1vbhFjEAlT7dYUwG7sgtVjt6Ad31jtPX8mN/vz3gSCTgYzIcHh2Oo7vq14s5j6oZ
         02/XIScGBRPbjjp3UH6YAMui5chRhirwLCf1oWiQQa6iM2J1yLyqm1rM8ltyiaNcdDjM
         y97w==
X-Gm-Message-State: APjAAAX8llslBXXAEp2+63JWNKDJC2dZoEaHgUSB62CtRx3jMTq3eaTI
        ojpbFglH9oXsbzUa7kbNQXcwmB9a+FY=
X-Google-Smtp-Source: APXvYqzMv3pK2nJ5k3zebxy6Wpcd7cSlAdka0+OqyFn3RmJu8WTFta9pUnfB6ybI37jNk6VVbCcXXQ==
X-Received: by 2002:a05:6214:1447:: with SMTP id b7mr1191403qvy.89.1566955145144;
        Tue, 27 Aug 2019 18:19:05 -0700 (PDT)
Received: from localhost.localdomain ([186.212.48.84])
        by smtp.gmail.com with ESMTPSA id c201sm499231qke.128.2019.08.27.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 18:19:04 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RESEND PATCH 4/4] Documentation:kernel-per-CPU-kthreads.txt: Remove reference to elevator=
Date:   Tue, 27 Aug 2019 22:19:30 -0300
Message-Id: <20190828011930.29791-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828011930.29791-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-1-marcos.souza.org@gmail.com>
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

