Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C653C32789
	for <linux-block@archiver.kernel.org>; Sat, 20 Aug 2022 03:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbiHTDRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 23:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiHTDRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 23:17:22 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D007EA32E
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 20:17:21 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220820031719epoutp01f90f9ffb37d33cc9dab74ef4d147e5b1~M70R5TeP10711307113epoutp01a
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 03:17:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220820031719epoutp01f90f9ffb37d33cc9dab74ef4d147e5b1~M70R5TeP10711307113epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660965440;
        bh=R/7IxdDqZAFv1UkLuGaTnie2Vp6DVZlh+y9vQjzdh70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d25xRMWrG5HzPQcK174JcvMmIbuE7jGtTDqYDaj8eKi0GZknbMrJIhzyGzIm+RNUa
         sr9bGTN+QC8PcaBbeO0eqR2uHYmOvS5MLznRO8LG29wFi08g+IbDoNOaXuukMXBwsu
         YP3BCH/ojrDDqLe49DBEIDH2RNb+h90374I8Bv+I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220820031719epcas5p2214c1087670fe23d2ec6160d90477261~M70RONYgm1302613026epcas5p2L;
        Sat, 20 Aug 2022 03:17:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4M8kM03mY6z4x9Pp; Sat, 20 Aug
        2022 03:17:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.88.49150.C3250036; Sat, 20 Aug 2022 12:17:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220820031716epcas5p1f3956d5c4215feff00b178e185fd3ca9~M70ORKzJX2055520555epcas5p1h;
        Sat, 20 Aug 2022 03:17:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220820031716epsmtrp20aba5d976459f83a854f3e1c96c52c55~M70OQVW-H0249702497epsmtrp2T;
        Sat, 20 Aug 2022 03:17:16 +0000 (GMT)
X-AuditID: b6c32a4b-393ff7000000bffe-47-6300523c44b7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.12.08802.B3250036; Sat, 20 Aug 2022 12:17:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220820031714epsmtip101860453e22ba7b7d719e7f26d38fc36~M70M1xVRD1516815168epsmtip1Y;
        Sat, 20 Aug 2022 03:17:14 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com,
        gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v2 4/4] nvme: wire up fixed buffer support for nvme
 passthrough
Date:   Sat, 20 Aug 2022 08:36:20 +0530
Message-Id: <20220820030620.59003-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820030620.59003-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhq5NEEOywdlFUhZNE/4yW6y+289m
        cfPATiaLlauPMlm8az3HYnH0/1s2i0mHrjFa7L2lbTF/2VN2i0OTm5kcuDwuny312LSqk81j
        85J6j903G9g83u+7yubRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
        uoaWFuZKCnmJuam2Si4+AbpumTlAxykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
        CkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjMOzZzPWPBXueLpwSmsDYwLZbsYOTkkBEwkpu3/
        xdjFyMUhJLCbUaJ97QZ2COcTo8SCW61QzmdGiXm3GthgWrafX8kMkdjFKHG37xMzXNWHuU9Z
        uxg5ONgENCUuTC4FaRARMJLY/+kkK0gNs8AFRol7O2+ygCSEBaIk1l5oZgWxWQRUJTp3fwLb
        wCtgIXF50gyobfISMy99ZwexOQUsJZqW/2aEqBGUODnzCdgcZqCa5q2zwY6QEOjlkFj/9RY7
        RLOLxL13a6AGCUu8Or4FKi4l8fndXqh4ssSlmeeYIOwSicd7DkLZ9hKtp/qZQZ5hBnpm/S59
        iF18Er2/nzCBhCUEeCU62oQgqhUl7k16ygphi0s8nLEEyvaQaJi1CBo+PYwSf34dZ5vAKD8L
        yQuzkLwwC2HbAkbmVYySqQXFuempxaYFxnmp5fCYTc7P3cQITqRa3jsYHz34oHeIkYmD8RCj
        BAezkgjvjTt/koR4UxIrq1KL8uOLSnNSiw8xmgLDeCKzlGhyPjCV55XEG5pYGpiYmZmZWBqb
        GSqJ83pd3ZQkJJCeWJKanZpakFoE08fEwSnVwJS7/Lx9zM6Ysyuuu35mCQmZeb47vl2ZufLi
        04UK6+33xphVuiyb1rnref+DpBlFoV45+gHPguo1LS7P9brmOuen263Ha8MXH7YMd/qUH9jy
        JOCVXc7NLiU1+cLN8V97L8z+vljumc9W1vn7U1yWHt797Ly89uv6g5usJy3V4s1UVSg/MrmA
        81f+jq9RlscLRa4wvujuP/C8r/3nzriv/F9vvBKVzr7SL283SXztq58TlBvWLDa72e32Qv3v
        HbaUh6d+pviUb5jNdIF56gHVrkVyCpwRIjHtPFP45I/yXrq96a43h9CaSPOPB0pDT4vlagZG
        Rvf8va3TdOHyqT/3XZ2/c1/huGu/f1bfqoYVnG+VWIozEg21mIuKEwExylavLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSnK51EEOywan5NhZNE/4yW6y+289m
        cfPATiaLlauPMlm8az3HYnH0/1s2i0mHrjFa7L2lbTF/2VN2i0OTm5kcuDwuny312LSqk81j
        85J6j903G9g83u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGYdmzmcs+Ktc8fTgFNYG
        xoWyXYycHBICJhLbz69k7mLk4hAS2MEo8WTaInaIhLhE87UfULawxMp/z9khij4ySqz/P4et
        i5GDg01AU+LC5FKQGhEBM4mlh9ewgNQwC9xglNjXO4UJJCEsECFxac4pMJtFQFWic/cnNhCb
        V8BC4vKkGWwQC+QlZl76DraMU8BSomn5b0YQWwio5vnsF1D1ghInZz5hAbGZgeqbt85mnsAo
        MAtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMExoKW1g3HPqg96hxiZ
        OBgPMUpwMCuJ8N648ydJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalF
        MFkmDk6pBibpvSqtB+W75qsE1O72leRcO8G99nySykrt+pOLZ6VXhS/U371r1Z1rj1+bJ3vy
        LCl8z5qyKuhcyZXjurqFr3afsP+03z/qhuu36S+rpxm7HJI9FaaaI2Dh/OGTlvDM+65xbw+y
        hLMIvX5WaLtNdiHLiu9rlok3fOZkvDuXq1L1rplYYX+geOtZKYErx10lta7P9mw59H2r5wfH
        pZfzL9+9eEEpNEnRp9m4/mb3NRWrPws3VGqY13UIaVU9K30WPeduxYWj01g2/feUXH5l8iT9
        TJfN+T9lnzP7a7+268q9WKrom8rlZu2+mr3hSkxMxct+y5nZqz6/POt5+8366MulURP43gR7
        1q6Z1z93Q74SS3FGoqEWc1FxIgC34y1U8AIAAA==
X-CMS-MailID: 20220820031716epcas5p1f3956d5c4215feff00b178e185fd3ca9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220820031716epcas5p1f3956d5c4215feff00b178e185fd3ca9
References: <20220820030620.59003-1-joshi.k@samsung.com>
        <CGME20220820031716epcas5p1f3956d5c4215feff00b178e185fd3ca9@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

if io_uring sends passthrough command with IO_URING_F_FIXEDBUFS flag,
use the pre-registered buffer to form the bio.
While at it modify nvme_submit_user_cmd to take ubuffer as plain integer
argument, and do away with nvme_to_user_ptr conversion in callers.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 7756b439a688..5a4649293e86 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -65,10 +65,11 @@ static int nvme_finish_user_metadata(struct request *req, void __user *ubuf,
 }
 
 static struct request *nvme_alloc_user_request(struct request_queue *q,
-		struct nvme_command *cmd, void __user *ubuffer,
+		struct nvme_command *cmd, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, void **metap, unsigned timeout, bool vec,
-		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)
+		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags,
+		struct io_uring_cmd *ioucmd, bool fixedbufs)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -89,14 +90,27 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 
 	if (ubuffer && bufflen) {
 		if (!vec)
-			ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
-				GFP_KERNEL);
+			if (fixedbufs) {
+				struct iov_iter iter;
+
+				ret = io_uring_cmd_import_fixed(ubuffer,
+						bufflen, rq_data_dir(req),
+						&iter, ioucmd);
+				if (ret < 0)
+					goto out;
+				ret = blk_rq_map_user_bvec(req, &iter);
+			} else {
+				ret = blk_rq_map_user(q, req, NULL,
+						nvme_to_user_ptr(ubuffer),
+						bufflen, GFP_KERNEL);
+			}
 		else {
 			struct iovec fast_iov[UIO_FASTIOV];
 			struct iovec *iov = fast_iov;
 			struct iov_iter iter;
 
-			ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
+			ret = import_iovec(rq_data_dir(req),
+					nvme_to_user_ptr(ubuffer), bufflen,
 					UIO_FASTIOV, &iov, &iter);
 			if (ret < 0)
 				goto out;
@@ -132,7 +146,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
-		struct nvme_command *cmd, void __user *ubuffer,
+		struct nvme_command *cmd, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
@@ -142,7 +156,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	int ret;
 
 	req = nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
-			meta_len, meta_seed, &meta, timeout, vec, 0, 0);
+			meta_len, meta_seed, &meta, timeout, vec, 0, 0, NULL, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -220,7 +234,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
 	return nvme_submit_user_cmd(ns->queue, &c,
-			nvme_to_user_ptr(io.addr), length,
+			io.addr, length,
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
 			false);
 }
@@ -274,7 +288,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			cmd.addr, cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
 			0, &result, timeout, false);
 
@@ -320,7 +334,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			cmd.addr, cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
 			0, &cmd.result, timeout, vec);
 
@@ -457,11 +471,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		rq_flags |= REQ_POLLED;
 
 retry:
-	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(d.addr),
+	req = nvme_alloc_user_request(q, &c, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, &meta, d.timeout_ms ?
 			msecs_to_jiffies(d.timeout_ms) : 0, vec, rq_flags,
-			blk_flags);
+			blk_flags, ioucmd, issue_flags & IO_URING_F_FIXEDBUFS);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req->end_io = nvme_uring_cmd_end_io;
-- 
2.25.1

