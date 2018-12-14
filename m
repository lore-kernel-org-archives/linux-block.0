Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53EDC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9BE20811
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 07:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc5z4jOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9BE20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeLNHEO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:04:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32844 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNHEO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 02:04:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so2307425plo.0;
        Thu, 13 Dec 2018 23:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W94W/BgjeqGKPkfSUeTBUijXYogWQIiSWFVM4GqFHtE=;
        b=Lc5z4jORTWT8eBOLSsR6XO+aoHAREhvZULccbyk0hMRdsOtuUsqST+xrwCEH2n6CwF
         T6lJNqGeFYq6rauioLr/sG56leo6xxRvLhut7g0OqIWrUdp8x2P/IOb8OIwlJVt9fOhK
         oKAbKfwQ53ZFea1VctMnVUEzOhXifausjzwFlsH3R0380DU660qL/jCDRfJ1qYHN/B9R
         LnTTkqQbrS+VoetU+IOkZCpsA0Ym8PgvxvHzqKWdS+dgzQSmDRNB6i4msiw3kuBXpmxp
         jLfVhLeVDMP713FrrEO9HrYZJq0x6KpeMae7m4gD6IDShRsYu+aviM3vheNvXCmd7DE6
         XjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W94W/BgjeqGKPkfSUeTBUijXYogWQIiSWFVM4GqFHtE=;
        b=okpKGmZsROd1HToVJspEvfFgKhmPVdZbq4i7LnmPV+ysb//xiSt7CHd2rqCpn60TxG
         ecAchRh1EAWcCUWdHTg8Q8hL+GAT80oqtiTh2dn+MYc5gudT9S/Uvq9UqVqnn8t39RhA
         EMjQ4zDr5W/boO+s3Lb+NBBuBGrDWY6NhTEbgsfJvNLjXvhNbFbxJsLU855L/FyNeXuu
         w2kyYPXwF3YH9SMDOSpQG5uHsocAfl6IzPa/tCUs6droExFEswS+RkfIaMM1+osTMoVJ
         jCaY5nt78O9Xne8NzJQmBC1yCLmwhK5DGXEf7MLlvFJlBUbidUyQURs4Flu9ioF97p5d
         kp6w==
X-Gm-Message-State: AA+aEWbWXo8WGM7dZCTpDM6KL371ePZV6ZU1d4stHq14YYs23WCiajf7
        ZQNwZREVYHHLGZO3qsR8mco=
X-Google-Smtp-Source: AFSGD/UPlBGPfMuqf/vmcBKgP4yFKlwAsDHITPAKvUIuWjX6QxH/CU9YmFF+L6D/o2d2i5k17isH2w==
X-Received: by 2002:a17:902:b83:: with SMTP id 3mr1782716plr.42.1544771053891;
        Thu, 13 Dec 2018 23:04:13 -0800 (PST)
Received: from localhost.localdomain ([119.196.123.230])
        by smtp.gmail.com with ESMTPSA id p7sm5956330pfa.22.2018.12.13.23.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 23:04:13 -0800 (PST)
From:   jotun9935@gmail.com
To:     axboe@kernel.dk, jotun9935@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions: fix coding style
Date:   Fri, 14 Dec 2018 16:04:02 +0900
Message-Id: <20181214070402.92541-1-jotun9935@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sungkyung Kim <jotun9935@gmail.com>

Fix coding style of osf.c

Signed-off-by: Sungkyung Kim <jotun9935@gmail.com>
---
 block/partitions/osf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/partitions/osf.c b/block/partitions/osf.c
index 4b873973d6c0..96921a1e31ce 100644
--- a/block/partitions/osf.c
+++ b/block/partitions/osf.c
@@ -22,7 +22,7 @@ int osf_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct disklabel {
 		__le32 d_magic;
-		__le16 d_type,d_subtype;
+		__le16 d_type, d_subtype;
 		u8 d_typename[16];
 		u8 d_packname[16];
 		__le32 d_secsize;
@@ -50,8 +50,8 @@ int osf_partition(struct parsed_partitions *state)
 			u8  p_frag;
 			__le16 p_cpg;
 		} d_partitions[MAX_OSF_PARTITIONS];
-	} * label;
-	struct d_partition * partition;
+	} *label;
+	struct d_partition *partition;
 
 	data = read_part_sector(state, 0, &sect);
 	if (!data)
@@ -74,7 +74,7 @@ int osf_partition(struct parsed_partitions *state)
 	}
 	for (i = 0 ; i < npartitions; i++, partition++) {
 		if (slot == state->limit)
-		        break;
+			break;
 		if (le32_to_cpu(partition->p_size))
 			put_partition(state, slot,
 				le32_to_cpu(partition->p_offset),
-- 
2.18.0

