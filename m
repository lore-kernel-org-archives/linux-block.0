Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED9C43219
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357211AbiBNRot (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:44:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357189AbiBNRoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 12:44:39 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84465438
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:31 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ECH7rk005103
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3ywzASqRXEEJ9XSq0ACPCijbM5X1A9Yxp6sQB3vKKIQ=;
 b=VuKwdu4B8gJ3TfFlk4Rf4oyf/WjffGYDORsZTeHCxuoNtqGrm9+W/mQcXY9t/VviW22i
 MLw/DbwdUSlIOJP4uVAjcXPbWWm5wqXOjUES3SSUxv/uAA6uJwo0q7eKtS41rPzemx07
 Ivo1b66x7V6b56StF0T7g/JIjsaOxISg9Iw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e7pxr25xj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 09:44:31 -0800
Received: from twshared9880.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 09:44:29 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id C730AABBD107; Mon, 14 Feb 2022 09:44:09 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 10/14] io_uring: Add tracepoint for short writes
Date:   Mon, 14 Feb 2022 09:43:59 -0800
Message-ID: <20220214174403.4147994-11-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214174403.4147994-1-shr@fb.com>
References: <20220214174403.4147994-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B02nWtBfADHKzDEbgTiqa2Kw54gdCbEA
X-Proofpoint-GUID: B02nWtBfADHKzDEbgTiqa2Kw54gdCbEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_07,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the io_uring_short_write tracepoint to io_uring. A short write
is issued if not all pages that are required for a write are in the page
cache and the async buffered writes have to return EAGAIN.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/io_uring.c                   |  3 +++
 include/trace/events/io_uring.h | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 76b1ff602470..507f28b5b2bb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3836,6 +3836,9 @@ static int io_write(struct io_kiocb *req, unsigned =
int issue_flags)
 		if (ret2 !=3D req->result && ret2 >=3D 0 && need_complete_io(req)) {
 			struct io_async_rw *rw;
=20
+			trace_io_uring_short_write(req->ctx, kiocb->ki_pos - ret2,
+						req->result, ret2);
+
 			/* This is a partial write. The file pos has already been
 			 * updated, setup the async struct to complete the request
 			 * in the worker. Also update bytes_done to account for
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_ur=
ing.h
index 7346f0164cf4..ce1cfdf4b015 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -558,6 +558,31 @@ TRACE_EVENT(io_uring_req_failed,
 		  (unsigned long long) __entry->pad2, __entry->error)
 );
=20
+TRACE_EVENT(io_uring_short_write,
+
+	TP_PROTO(void *ctx, u64 fpos, u64 wanted, u64 got),
+
+	TP_ARGS(ctx, fpos, wanted, got),
+
+	TP_STRUCT__entry(
+		__field(void *,	ctx)
+		__field(u64,	fpos)
+		__field(u64,	wanted)
+		__field(u64,	got)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	=3D ctx;
+		__entry->fpos	=3D fpos;
+		__entry->wanted	=3D wanted;
+		__entry->got	=3D got;
+	),
+
+	TP_printk("ring %p, fpos %lld, wanted %lld, got %lld",
+			  __entry->ctx, __entry->fpos,
+			  __entry->wanted, __entry->got)
+);
+
 #endif /* _TRACE_IO_URING_H */
=20
 /* This part must be outside protection */
--=20
2.30.2

