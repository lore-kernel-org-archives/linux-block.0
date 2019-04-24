Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B787C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8BF218B0
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 19:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NLakzwQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfDXTJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:09:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45350 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729617AbfDXTJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 15:09:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OJ3TcH004034;
        Wed, 24 Apr 2019 12:07:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ZQK1RKD7pny6TeOYYZlJ53KTkn3Ym1U0yTfX7nvxVDA=;
 b=NLakzwQGTE6BG8zG7405kXnLQ2LCryfo8PCBFEqstLYnNO/qjkfYnYOsN/C9io+Mc2hu
 04bUgR8vY+ryc31ONsbfHef8gbVdO/bU4v6W97mLGA9lLipbySilAjceLoOAD2g7UxkW
 +xdyOTtid/sSkA2qP7b+rQJh3wWlYSnxqk0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2w00g70h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:07:54 -0700
Received: from mmullins-1.thefacebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server id
 15.1.1713.5; Wed, 24 Apr 2019 12:07:50 -0700
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
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
Subject: [PATCH bpf-next v4 2/5] nbd: trace sending nbd requests
Date:   Wed, 24 Apr 2019 12:07:18 -0700
Message-ID: <20190424190721.24453-3-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424190721.24453-1-mmullins@fb.com>
References: <20190424190721.24453-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c081:10::13]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a tracepoint that can both observe the nbd request being sent
to the server, as well as modify that request , e.g., setting a flag in
the request that will cause the server to collect detailed tracing data.

The struct request * being handled is included to permit correlation
with the block tracepoints.

Signed-off-by: Matt Mullins <mmullins@fb.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 MAINTAINERS                |  1 +
 drivers/block/nbd.c        |  5 ++++
 include/trace/events/nbd.h | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 include/trace/events/nbd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..6db583d2b0ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10737,6 +10737,7 @@ L:	linux-block@vger.kernel.org
 L:	nbd@other.debian.org
 F:	Documentation/blockdev/nbd.txt
 F:	drivers/block/nbd.c
+F:	include/trace/events/nbd.h
 F:	include/uapi/linux/nbd.h
 
 NETWORK DROP MONITOR
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 90ba9f4c03f3..7393d04d255c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -44,6 +44,9 @@
 #include <linux/nbd-netlink.h>
 #include <net/genetlink.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/nbd.h>
+
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static int nbd_total_devices = 0;
@@ -526,6 +529,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	handle = nbd_cmd_handle(cmd);
 	memcpy(request.handle, &handle, sizeof(handle));
 
+	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));
+
 	dev_dbg(nbd_to_dev(nbd), "request %p: sending control (%s@%llu,%uB)\n",
 		req, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
diff --git a/include/trace/events/nbd.h b/include/trace/events/nbd.h
new file mode 100644
index 000000000000..5928255ed02e
--- /dev/null
+++ b/include/trace/events/nbd.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nbd
+
+#if !defined(_TRACE_NBD_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NBD_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(nbd_send_request,
+
+	TP_PROTO(struct nbd_request *nbd_request, int index,
+		 struct request *rq),
+
+	TP_ARGS(nbd_request, index, rq),
+
+	TP_STRUCT__entry(
+		__field(struct nbd_request *, nbd_request)
+		__field(u64, dev_index)
+		__field(struct request *, request)
+	),
+
+	TP_fast_assign(
+		__entry->nbd_request = 0;
+		__entry->dev_index = index;
+		__entry->request = rq;
+	),
+
+	TP_printk("nbd%lld: request %p", __entry->dev_index, __entry->request)
+);
+
+#ifdef DEFINE_EVENT_WRITABLE
+#undef NBD_DEFINE_EVENT
+#define NBD_DEFINE_EVENT(template, call, proto, args, size)		\
+	DEFINE_EVENT_WRITABLE(template, call, PARAMS(proto),		\
+			      PARAMS(args), size)
+#else
+#undef NBD_DEFINE_EVENT
+#define NBD_DEFINE_EVENT(template, call, proto, args, size)		\
+	DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args))
+#endif
+
+NBD_DEFINE_EVENT(nbd_send_request, nbd_send_request,
+
+	TP_PROTO(struct nbd_request *nbd_request, int index,
+		 struct request *rq),
+
+	TP_ARGS(nbd_request, index, rq),
+
+	sizeof(struct nbd_request)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

