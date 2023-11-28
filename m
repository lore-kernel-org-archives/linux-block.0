Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0A19B0
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 11:40:29 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso4792713b3a.2
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 11:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701200428; x=1701805228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5Jsm+KgM+O1nqdc6mUTRe4NwFRWRH/HKvh3Ynd75y4=;
        b=cW03e0thxTAuMiODf3QgvuTGc6FPUZO6Op3q0qvVK0zPO0+NvaUXi8mHTT5KBboPeS
         tzFeNK8w8SI3Fbc/ozbg/Rj0rAcaz1YRJL6TokuvAo0gaTHFLjBu56OaJ17Gra9d1WKN
         2/aXBqI18yErPimDaecq5djNLUBpnSsyveBhdnuDnxy7ONzcJyw77QIU4x/C94zeg49b
         TpI672voUCKVzSL331eT0/E1xXVEN91upI8py+3minXQXfXiNeBZtfpPFtBUIl7U9E+i
         2cRv6/rpleGJWWytdEcyFiaR27rXe5RMC9/KEFlm16t0g+69V2VDCmeo/ppJSHMHEEz7
         Az8Q==
X-Gm-Message-State: AOJu0YyD08tGO4iRej5CGXYIKIX5HHl/WRsIN2rQKnL7drcFihlvTzXd
	xVGbaRgI/2CZ+257QdE+lt4=
X-Google-Smtp-Source: AGHT+IFGB4v8BeEgAT0en3rMDTxLEEaZUmtNoqNzj1P638II5V8NzAy5n3NBUIWFj3l97e1Sh/pGrQ==
X-Received: by 2002:a05:6a00:1953:b0:6c8:705f:4090 with SMTP id s19-20020a056a00195300b006c8705f4090mr16405036pfk.30.1701200428012;
        Tue, 28 Nov 2023 11:40:28 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1f8e:127f:6051:78b3])
        by smtp.gmail.com with ESMTPSA id t43-20020aa78fab000000b006c9c0705b5csm9219368pfs.48.2023.11.28.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:40:27 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH] block: Document the role of the two attribute groups
Date: Tue, 28 Nov 2023 11:40:19 -0800
Message-ID: <20231128194019.72762-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is nontrivial to derive the role of the two attribute groups in source
file block/blk-sysfs.c. Hence add a comment that explains their roles. See
also commit 6d85ebf95c44 ("blk-sysfs: add a new attr_group for blk_mq").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e481262336..0b2d04766324 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -615,6 +615,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 #endif
 
+/* Common attributes for bio-based and request-based queues. */
 static struct attribute *queue_attrs[] = {
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
@@ -659,6 +660,7 @@ static struct attribute *queue_attrs[] = {
 	NULL,
 };
 
+/* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&elv_iosched_entry.attr,
