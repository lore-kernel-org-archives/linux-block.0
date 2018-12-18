Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77830C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413A4217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg8L9YAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeLREvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:51:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40598 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeLREvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 23:51:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so7225179plq.7;
        Mon, 17 Dec 2018 20:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=3J7R6Oz0DODsJXzkw2UPrkqCiVmzgzvObOsXweyNBpo=;
        b=hg8L9YARkT6P8CFmIvI7rnv8quVTh0UL2dDFHBf7crYFzcP6KGHJ3yc8JV9SP0+NI4
         r5u4CHlE64+2e/8GHQdtyu2RDoFPe6z1icxJE7CLUKKvRAem4HDD7x2LLe02fVBaABq+
         HN1bPoDXRSDSRcVyA0lphuvUYdJLej0NOW+oC2IYrCsCZX7QOqdOmxmdlX9ZjKIkhgOm
         sE3IUk/lJSlAzXCFNo6hvcPezmUfC5/dyG7ffLs/+Mojp+LA1gnU/efN+zuQaYNVVMrH
         DxpNsfaebvJpN5zoN2uvS82DyFb+dEcz9Yi+YSbZ/NUX5Ij7guUrmOiQFFRDGdmoy94y
         GHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=3J7R6Oz0DODsJXzkw2UPrkqCiVmzgzvObOsXweyNBpo=;
        b=KSCTK9yJWytIyp/Qei6/y23l/ASpIzxZVjAaErlpfXlCPcRazwtXwYUsZU9XhahRmL
         zlEIAGcqqWwXsGwZUE5xXtDcnrxws7C0xzcn4Yt8PTUlLlq637knn/gp6yR9b2XLHdL6
         3jfBOQnJg2UUZ262Zbt5s2+Ls3fuMXWhdvTVgoZvhEwYfsDjswzgf4pJGXy/hUIVvHk7
         bgBSu3u/GCYLbYkESi4MsR65g95tGZrNedPoUVeh1TWAkjF8Y1M18qmK6BxJnT6YeG6y
         6YvDMAKkNYnUfNr56lowk7WCtPXejXdbBfD1BK21e2k6r9/+P9zcMiYk0mTEV5fSDfI8
         9SWA==
X-Gm-Message-State: AA+aEWZuiazgyvU+UmElsXhyUyaU1NTzPcWl7S/YyBzoAcFqOOCRuNmW
        L7lgvkFGLGkduKL6ChjPeXNXdcvfH4o=
X-Google-Smtp-Source: AFSGD/Uq8kgKTu0dievmK3w4fjldwq5GEcKI/YHRA27VKj66A8eZEzsCxFJr5/y53Tgvmq0WwNlh3g==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr15507929plb.235.1545108700478;
        Mon, 17 Dec 2018 20:51:40 -0800 (PST)
Received: from localhost.localdomain ([2601:602:9602:6598:1820:defd:529e:3b95])
        by smtp.gmail.com with ESMTPSA id e9sm18164152pff.5.2018.12.17.20.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 20:51:40 -0800 (PST)
From:   yupeng <yupeng0921@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, jthumshirn@suse.de
Subject: [PATCH v4 1/2] export trace.c helper functions to other modules
Date:   Mon, 17 Dec 2018 20:51:37 -0800
Message-Id: <20181218045138.4282-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Export bellow three functions:
nvme_trace_parse_admin_cmd
nvme_trace_parse_nvm_cmd
nvme_trace_disk_name
Thus any other modules which depends on nvme-core could use the trace
events in trace.h

Signed-off-by: yupeng <yupeng0921@gmail.com>
---
 drivers/nvme/host/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 25b0e310f4a8..8ca7079ed2bc 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -113,6 +113,7 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
 		return nvme_trace_common(p, cdw10);
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_trace_parse_admin_cmd);
 
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 				     u8 opcode, u8 *cdw10)
@@ -128,6 +129,7 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_common(p, cdw10);
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_trace_parse_nvm_cmd);
 
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 {
@@ -139,3 +141,4 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
-- 
2.17.1

