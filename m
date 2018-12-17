Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F05C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 08:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197E204FD
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwih6L6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeLQIGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:06:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39072 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeLQIGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 03:06:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so5968538pfc.6;
        Mon, 17 Dec 2018 00:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=xAzmZsYseHWEZm5R0Espu8YH93YzKvO/TS92Z7+C7i8=;
        b=nwih6L6eCsD04U/9gRISLApxTJJOHkJSRj7XTZY287wBXsPASjSGMmGsZUva7+CChM
         cHOOdSg8l1MAL4qCsZB/ocoer3nucykmjLZJb3iH63pSpq9ALPdz/C2yQ9DbhJ/OnmXF
         WgXvPtr60rhlccwyRWi8q7pWf8mmQ7gsVKEAm4Vakh8foLlprvCOAiYW3sxVEPAUcw0O
         eljRk7fizYGZ6UxJdZL19+Al0MHSGoNnl6dld7fJWBjZr0c5wJVVG4sqiIPlR5Mh/X4C
         rQsWRdxM1NX3zOspNGopKnzMsGbiV9NoxrmtNaXvl3m/Cji835eZxqtiZOFrme5nqvws
         Sn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xAzmZsYseHWEZm5R0Espu8YH93YzKvO/TS92Z7+C7i8=;
        b=tP8fQl/uZ6DN7Mg4QyPGz837+I/ZamaETyFdooJeosLPu/u5auKPhYk45ZIXFCScWZ
         atJhjfPBnCF1/KLVin9Kzem25LA2hx78AxLmFZ9A4265WiOjD+NwLmFr/ymAkqC+sGxU
         Jrqv9YKVs9+gfid/is/nSX3vkbCVixfRE48gJJi6iV2ADEvsFOn8X7IIkDtOlIQwwXng
         fMk8gi6ioBQ31bF1vAyNSVZyzMMGp1Ht3b5FTq9HISaaEsuGElcjuaEY/UOe5Ne2T7Zl
         dP4XpR6qOKvOEOAsaJFYPemDaVVFxePTYJuCq7ShCMSof4wWgGpFK/qf6kr6g6TRKoed
         Fj9A==
X-Gm-Message-State: AA+aEWa+UFVy7nI7y+grdy2orHrCml4e6xDa4vQsUps8VInbEMKlhuA1
        BIiwSl4HCfnI6GTbBCVGR/qCmX3kEDA=
X-Google-Smtp-Source: AFSGD/VA56oG2Ljzc98FZfiCY9+I+VSf8h5Z93MI8eKrNs9gdWM0Dgs6pzXmybsQToj6uPYIzUQmxA==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr12347435pfd.40.1545033967197;
        Mon, 17 Dec 2018 00:06:07 -0800 (PST)
Received: from localhost.localdomain ([2601:602:9602:6598:9540:1d4c:35c2:b8e8])
        by smtp.gmail.com with ESMTPSA id q1sm18517115pgs.14.2018.12.17.00.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 00:06:06 -0800 (PST)
From:   yupeng <yupeng0921@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH v3 1/2] share nvme trace event helper functions with other modules
Date:   Mon, 17 Dec 2018 00:06:04 -0800
Message-Id: <20181217080605.16867-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the trace.c/trace.h could only be used by nvme-core. This
patch moves __assign_disk_name to genhd.h, exports nvme_trace_disk_name to
other modules. Thus other nvme modules could also trace disk name.

Signed-off-by: yupeng <yupeng0921@gmail.com>
---
 drivers/nvme/host/trace.c |  2 ++
 drivers/nvme/host/trace.h | 10 ----------
 include/linux/genhd.h     |  8 ++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 25b0e310f4a8..99a132a34403 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -139,3 +139,5 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 
 	return ret;
 }
+
+EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 196d5bd56718..23f3fcf04fb6 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -82,16 +82,6 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
 	nvme_trace_disk_name(p, name)
 
-#ifndef TRACE_HEADER_MULTI_READ
-static inline void __assign_disk_name(char *name, struct gendisk *disk)
-{
-	if (disk)
-		memcpy(name, disk->disk_name, DISK_NAME_LEN);
-	else
-		memset(name, 0, DISK_NAME_LEN);
-}
-#endif
-
 TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 70fc838e6773..468ab3143d77 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -749,6 +749,14 @@ static inline void blk_integrity_add(struct gendisk *disk) { }
 static inline void blk_integrity_del(struct gendisk *disk) { }
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
 
+static inline void __assign_disk_name(char *name, struct gendisk *disk)
+{
+	if (disk)
+		memcpy(name, disk->disk_name, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
+}
+
 #else /* CONFIG_BLOCK */
 
 static inline void printk_all_partitions(void) { }
-- 
2.17.1

