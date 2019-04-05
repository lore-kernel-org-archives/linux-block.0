Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF64C282DA
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5522621726
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QGACJq8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDEX5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:57:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbfDEX5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 19:57:10 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35Nt3hh022716;
        Fri, 5 Apr 2019 16:56:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hrmkK86CLcUqI7FOsA7WTDumNlH5nTqSdid1LV/cbvQ=;
 b=QGACJq8ioJNkbFtLtLdJrY9O7P3qC/uK9tl+NQtdJ3pVbvHgcI+VFB0LPXub6vbhE0aD
 ZG/Fw/1205ed0EG9H5ZLWfdrR+NDA/3BLBt+nFcom+EHmMOxj+qgqPFBo5RrxccbIkKb
 7haZjB7QPi7+lv3n+NC6+8jruFMcyfBF8vA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rp9r5hnp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Apr 2019 16:56:12 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 5 Apr 2019 16:56:09 -0700
From:   Matt Mullins <mmullins@fb.com>
To:     <hall@fb.com>, <mmullins@fb.com>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
Subject: [PATCH bpf-next v2 3/5] nbd: add tracepoints for send/receive timing
Date:   Fri, 5 Apr 2019 16:55:04 -0700
Message-ID: <20190405235506.29236-4-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405235506.29236-1-mmullins@fb.com>
References: <20190405235506.29236-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a1:3::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andrew Hall <hall@fb.com>

This adds four tracepoints to nbd, enabling separate tracing of payload
and header sending/receipt.

In the send path for headers that have already been sent, we also
explicitly initialize the handle so it can be referenced by the later
tracepoint.

Signed-off-by: Andrew Hall <hall@fb.com>
Signed-off-by: Matt Mullins <mmullins@fb.com>
---
 drivers/block/nbd.c        |  8 ++++
 include/trace/events/nbd.h | 92 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7393d04d255c..d3d914620f66 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -513,6 +513,10 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	if (sent) {
 		if (sent >= sizeof(request)) {
 			skip = sent - sizeof(request);
+
+			// initialize handle for tracing purposes
+			handle = nbd_cmd_handle(cmd);
+
 			goto send_pages;
 		}
 		iov_iter_advance(&from, sent);
@@ -536,6 +540,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
 	result = sock_xmit(nbd, index, 1, &from,
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
+	trace_nbd_header_sent(req, handle);
 	if (result <= 0) {
 		if (was_interrupted(result)) {
 			/* If we havne't sent anything we can just return BUSY,
@@ -608,6 +613,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		bio = next;
 	}
 out:
+	trace_nbd_payload_sent(req, handle);
 	nsock->pending = NULL;
 	nsock->sent = 0;
 	return 0;
@@ -655,6 +661,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 			tag, req);
 		return ERR_PTR(-ENOENT);
 	}
+	trace_nbd_header_received(req, handle);
 	cmd = blk_mq_rq_to_pdu(req);
 
 	mutex_lock(&cmd->lock);
@@ -708,6 +715,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		}
 	}
 out:
+	trace_nbd_payload_received(req, handle);
 	mutex_unlock(&cmd->lock);
 	return ret ? ERR_PTR(ret) : cmd;
 }
diff --git a/include/trace/events/nbd.h b/include/trace/events/nbd.h
index 5928255ed02e..eef476fef95a 100644
--- a/include/trace/events/nbd.h
+++ b/include/trace/events/nbd.h
@@ -7,6 +7,98 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(nbd_header_sent,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle),
+
+	TP_STRUCT__entry(
+		__field(struct request *, req)
+		__field(u64, handle)
+	),
+
+	TP_fast_assign(
+		__entry->req = req;
+		__entry->handle = handle;
+	),
+
+	TP_printk(
+		"nbd header sent: request %p, handle 0x%016llx",
+		__entry->req,
+		__entry->handle
+	)
+);
+
+TRACE_EVENT(nbd_payload_sent,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle),
+
+	TP_STRUCT__entry(
+		__field(struct request *, req)
+		__field(u64, handle)
+	),
+
+	TP_fast_assign(
+		__entry->req = req;
+		__entry->handle = handle;
+	),
+
+	TP_printk(
+		"nbd payload sent: request %p, handle 0x%016llx",
+		__entry->req,
+		__entry->handle
+	)
+);
+
+TRACE_EVENT(nbd_header_received,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle),
+
+	TP_STRUCT__entry(
+		__field(struct request *, req)
+		__field(u64, handle)
+	),
+
+	TP_fast_assign(
+		__entry->req = req;
+		__entry->handle = handle;
+	),
+
+	TP_printk(
+		"nbd header received: request %p, handle 0x%016llx",
+		__entry->req,
+		__entry->handle
+	)
+);
+
+TRACE_EVENT(nbd_payload_received,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle),
+
+	TP_STRUCT__entry(
+		__field(struct request *, req)
+		__field(u64, handle)
+	),
+
+	TP_fast_assign(
+		__entry->req = req;
+		__entry->handle = handle;
+	),
+
+	TP_printk(
+		"nbd payload received: request %p, handle 0x%016llx",
+		__entry->req,
+		__entry->handle
+	)
+);
+
 DECLARE_EVENT_CLASS(nbd_send_request,
 
 	TP_PROTO(struct nbd_request *nbd_request, int index,
-- 
2.17.1

