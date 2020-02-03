Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C249C33C9E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 05:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3112080D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 05:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfW/QbJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBCFhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:37:22 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35973 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBCFhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 00:37:22 -0500
Received: by mail-pg1-f180.google.com with SMTP id k3so7182196pgc.3;
        Sun, 02 Feb 2020 21:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=od7Z1FJ07CsMHs7dn27tq7etJRWPdotU0tt4EY8WHv4=;
        b=EfW/QbJnbycVtEhwdvT/Iuqu1DJ4URWnMKchwUQQtssqvBzQ64W2xigdR2bH7l95Cx
         r6ONLAgI6LeLA30RMWWpXmMSv2/jhzwYOAaHjp4ZSdEgXE2iKVF6twj8iAcPXMqaclTD
         T0emWrDG8CT3JeUHv1r3jRzttg5N2jC5BKNgMt/HESEKhk+/xctzpIUYGnG4WlomLdiP
         Vg5fxmYAG3lJ4nNuenALh69xSw9GE0G4GDUDfEcqMS4JGAl+qpki6tNhuCFI6FxFkI16
         wJd9wG/+f8Qn+c3kX+8Q7rmoq35gGeJZtwhzFi/mGbCZmm2djvxLFH3shX00/HgVmkeA
         jntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=od7Z1FJ07CsMHs7dn27tq7etJRWPdotU0tt4EY8WHv4=;
        b=j0eaiRCJFeeZdvrltdtA0lpC0zOJPT2HarT/9AcxXwXNJHUsLjxn7P2U1ZkpAwx88k
         ILatYSlItYVZLyFN7ao32Zf+8D1m+EQ1LRXgK9VdbE8G+tBP9GppwwIKTGarFT7M/rP3
         eAEPSrm0AfwKO1NiyVSsShETL2mHQeiAl/7RahvjziRbhwwyaYdkFNXGStkSEaAke48a
         XaL4GdFnuZRCtI8wxP5Whu43b9pWZL6CTkb9aQ7gAxgVlzgx09Heu2QjuQROxrSuVVHi
         HZfXsIPIlJ2iEp9M0ZVh04he5HlS7JgKEl37EJY46H0kvZvNl89xy5VXl3Hdke8gDsJi
         A8tw==
X-Gm-Message-State: APjAAAX4b8gyDyUD5Yrg/1zKizenp6bDyXsddKQ9XGikfAdHZjt5wSTu
        lbbtgvg6zotoTOlQr5oeVZWipU6h
X-Google-Smtp-Source: APXvYqxLSDqFv8aXKB4MW8ZB7Gb01xxVky60IJZmJX7PqAPosw/8TlW0qqY0jR8Y0Vn4e15mKoJGYQ==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr24091099pfn.202.1580708241194;
        Sun, 02 Feb 2020 21:37:21 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id gx18sm19816337pjb.8.2020.02.02.21.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 21:37:20 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [Patch v3] block: introduce block_rq_error tracepoint
Date:   Sun,  2 Feb 2020 21:36:50 -0800
Message-Id: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, rasdaemon uses the existing tracepoint block_rq_complete
and filters out non-error cases in order to capture block disk errors.

But there are a few problems with this approach:

1. Even kernel trace filter could do the filtering work, there is
   still some overhead after we enable this tracepoint.

2. The filter is merely based on errno, which does not align with kernel
   logic to check the errors for print_req_error().

3. block_rq_complete only provides dev major and minor to identify
   the block device, it is not convenient to use in user-space.

So introduce a new tracepoint block_rq_error just for the error case
and provides the device name for convenience too. With this patch,
rasdaemon could switch to block_rq_error.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 block/blk-core.c             |  4 +++-
 include/trace/events/block.h | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..0c7ad70d06be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
+		trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
 		print_req_error(req, error, __func__);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..575054e7cfa0 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -145,6 +145,47 @@ TRACE_EVENT(block_rq_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
+/**
+ * block_rq_error - block IO operation error reported by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_error tracepoint event indicates that some portion
+ * of operation request has failed as reported by the device driver.
+ */
+TRACE_EVENT(block_rq_error,
+
+	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes),
+
+	TP_STRUCT__entry(
+		__field(  dev_t,	dev			)
+		__string( name,		rq->rq_disk ? rq->rq_disk->disk_name : "?")
+		__field(  sector_t,	sector			)
+		__field(  unsigned int,	nr_sector		)
+		__field(  int,		error			)
+		__array(  char,		rwbs,	RWBS_LEN	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__assign_str(name,   rq->rq_disk ? rq->rq_disk->disk_name : "?");
+		__entry->sector    = blk_rq_pos(rq);
+		__entry->nr_sector = nr_bytes >> 9;
+		__entry->error     = error;
+
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
+	),
+
+	TP_printk("%d,%d %s %s %llu + %u [%d]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __get_str(name), __entry->rwbs,
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sector, __entry->error)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request_queue *q, struct request *rq),
-- 
2.21.1

