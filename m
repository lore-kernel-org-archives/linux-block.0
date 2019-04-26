Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F0C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 18:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E26720B7C
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 18:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g2Dw3CIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDZSvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:51:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbfDZSvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 14:51:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QInV9t004908;
        Fri, 26 Apr 2019 11:50:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KK74Ik6tG2c+y4kydUC2rWejPCIIYS31jlFNwlYDWlY=;
 b=g2Dw3CIV+d90V0Gi3uxQCIMeGWlYAMMF/hWXCnPBOy/FLvthgVIolECguxsNJUtDOBeQ
 SwY0pEkDxXZYlucUaYRgPG0QjZzQDn7EfPX8RzowBYdp9+5UEhZ0jX800ezzOP4LA51F
 6rMH4jIP2nC+iakM3DHtrq8keOT/1kWU8xg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s447r0s22-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 11:50:14 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 26 Apr 2019 11:50:13 -0700
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
Subject: [PATCH bpf-next v5 3/5] nbd: add tracepoints for send/receive timing
Date:   Fri, 26 Apr 2019 11:49:49 -0700
Message-ID: <20190426184951.21812-4-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426184951.21812-1-mmullins@fb.com>
References: <20190426184951.21812-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c081:10::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_12:,,
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c        |  8 ++++++
 include/trace/events/nbd.h | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 24cc10d1f0b4..3e6c3d5dadc8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -513,6 +513,10 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	if (sent) {
 		if (sent >= sizeof(request)) {
 			skip = sent - sizeof(request);
+
+			/* initialize handle for tracing purposes */
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
index 5928255ed02e..9849956f34d8 100644
--- a/include/trace/events/nbd.h
+++ b/include/trace/events/nbd.h
@@ -7,6 +7,57 @@
 
 #include <linux/tracepoint.h>
 
+DECLARE_EVENT_CLASS(nbd_transport_event,
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
+		"nbd transport event: request %p, handle 0x%016llx",
+		__entry->req,
+		__entry->handle
+	)
+);
+
+DEFINE_EVENT(nbd_transport_event, nbd_header_sent,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle)
+);
+
+DEFINE_EVENT(nbd_transport_event, nbd_payload_sent,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle)
+);
+
+DEFINE_EVENT(nbd_transport_event, nbd_header_received,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle)
+);
+
+DEFINE_EVENT(nbd_transport_event, nbd_payload_received,
+
+	TP_PROTO(struct request *req, u64 handle),
+
+	TP_ARGS(req, handle)
+);
+
 DECLARE_EVENT_CLASS(nbd_send_request,
 
 	TP_PROTO(struct nbd_request *nbd_request, int index,
-- 
2.17.1

