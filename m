Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01E3C6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9736020989
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovv+EPyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9736020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeLNKUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:20:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41656 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 05:20:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so2618906pfi.8;
        Fri, 14 Dec 2018 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JbyqLT55xxZClEvDqYl+g0umwguOTkbwTAY5gviOoQM=;
        b=ovv+EPyMG4SbU5/KftS/XpNtHhhp1/zRELYPG8UAvnRs6AKZgTB8njzpbceEi84s7e
         ccV2PDt1BZY3zUXiRbmhZ782eKygqDjAvxO6YfP9DDaKvzjri/euP8jHebWAi2wm83iO
         cbdxFMPKJN8AR96OEGU67RgLevZBwXjz5K+Xk/IJCc6t5o1O+cV9FgkwOfKa5baVDrb7
         TtZskpiERM72PDlxkXYdjlXitwBnUrMZokj8Ub9FO4PXhBj1QbXXm99HTydJ3xCRQSF1
         qsmygtJGo+QgY1r5dSiZs5tE2L0JA5LG5qQvXs1KRlDvAQ3E4grEUA8Albwaq6JS0bBj
         kjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JbyqLT55xxZClEvDqYl+g0umwguOTkbwTAY5gviOoQM=;
        b=PMnpn8OHb4iKCGsU/YpVj7FLQU0PvhkoN+2xHEbsnMqjyDZqfnVK2Ful6CP7p4eXwI
         8S434vqYK+L8trV9D71WAv1DCHN78jq3HxwKE8XYmVWmNjIsqJhiaPhM1dHvkB837yYt
         D4MYJ9QUC1x2z1ODXlYFQAIe3T1tg/MtF+FjAzM1af8qlxSvz8LRC4DlvbVUthvI4m96
         NFFbRAPHt5edmdttqGdti2K4FBf1OXm1/WHb7Q6vZvfDKlSBY6euPsRISaqFAQJB+m+X
         jguXRYg0m75NUT4ZSjSW8oLf7blT8fJ+jvpyyZUHTZmN2dPMlyGqS4F24zfe9v+E7wyK
         9lHA==
X-Gm-Message-State: AA+aEWZnOipjkwHAzuOEJ3uYYQY2NawnsM8N1+Sp5m1Xnr6rWo/Na//b
        +n0Xdo4fM5dceWPV/uoOm7ViEHDNANAs5A==
X-Google-Smtp-Source: AFSGD/USNBZlZfKNrNcETuU2/BMkaQkxPTNMnT/KP0eki39SBV7wuD3g1+JvmIUTIAKWJ6ZZ9gM08w==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr2206820pgk.386.1544782805016;
        Fri, 14 Dec 2018 02:20:05 -0800 (PST)
Received: from localhost.localdomain ([58.232.246.132])
        by smtp.gmail.com with ESMTPSA id f62sm4838781pgc.67.2018.12.14.02.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 02:20:04 -0800 (PST)
From:   jotun9935@gmail.com
To:     axboe@kernel.dk, jotun9935@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions: fix coding style
Date:   Fri, 14 Dec 2018 19:19:58 +0900
Message-Id: <20181214101958.90690-1-jotun9935@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sungkyung Kim <jotun9935@gmail.com>

Fix coding style of osf.c

Signed-off-by: Sungkyung Kim <jotun9935@gmail.com>
---
 block/partitions/osf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/partitions/osf.c b/block/partitions/osf.c
index 4b873973d6c0..19f8e91979f0 100644
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
@@ -50,14 +50,14 @@ int osf_partition(struct parsed_partitions *state)
 			u8  p_frag;
 			__le16 p_cpg;
 		} d_partitions[MAX_OSF_PARTITIONS];
-	} * label;
-	struct d_partition * partition;
+	} *label;
+	struct d_partition *partition;
 
 	data = read_part_sector(state, 0, &sect);
 	if (!data)
 		return -1;
 
-	label = (struct disklabel *) (data+64);
+	label = (struct disklabel *) (data + 64);
 	partition = label->d_partitions;
 	if (le32_to_cpu(label->d_magic) != DISKLABELMAGIC) {
 		put_dev_sector(sect);
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

