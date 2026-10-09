Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E03C1F36
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519483; cv=none; b=bSkreDvXVqW3U3+WyLvjpUtA/m/DuYexRdLtWATr1K2yPHJy/qryDH0Odb7HQqt+ygprNBmfg6w0rhWT1NFUNFquC434DKyC03k7fpSX8Xsc2bsEI5Vid7qCskBbqK8iojvpunpnDTclo00uIKJExssj9SRnI9Pm9Md62UsHLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519483; c=relaxed/simple;
	bh=M2qBZUq8DAL1N/H15QX+Xu42pXOuQMpmPfewDfKZtpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKRy2IhedoyivxpYMWRw99qn6VqTTE4Lvr6W4G4616vFsq+GLn5PLN4pQQQt1qSSuuqGigRHK0ZKaUuSQ5eVpwad+v/voosVvV46c21U4KVsxSiiURssv5h+uIKGgl95ivbE/D1LID/tc/pqoMSbe0MS8cRkh0Pa7lByX3Wt6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMU8yvUg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ILD8x9Sv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMU8yvUg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ILD8x9Sv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993I3G1251918
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 04:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4RcsQMFD3Y2
	sKnN62bJcquoq+XfJOaIGkGo1pR1B1Zo=; b=gMU8yvUg7QL4wgVqM6wm0qLGIXl
	OPRli6RwW9tAWEOwT+PK/QE3wLIvzK2UKo/4jcY2LTgBWUKjzVjoiUdWOdjSsxq0
	2vdymcSyAm8IjnXQZ3L35LmfEHnMHfSsqGy/TuSMNxF2BjcEiOOhrfHRkgMVWF4k
	7AveIaRV12WvNhQtz/Tt4nISQMgxpHaiY4Xz5YKTVwKbAKAxIsyah+A/LLTkzOiF
	uSdfmrn0fbIP/8guTNJKeE6c8JfEprjZrkcoI/wSLxNx0vhf/e6bewh5lIBWkdkq
	ZQUFB085hyq9nW1c3aA0IHu8mHI8ZsxgIhauiU7Y5G5WhOQ3Sp4Q/89cUtQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqsxks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 04:17:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso11471007eec.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791519464; x=1792124264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4RcsQMFD3Y2sKnN62bJcquoq+XfJOaIGkGo1pR1B1Zo=;
        b=ILD8x9Sv6Qq3dg2lURykYBPSP0KT+lYJ0LwwX9iWiyS1TazqoJ67NCboNiFLrR//R2
         KH6cmP9FU75URp7t9Ct+LHamTN/mrryT7oOixiPGhU8kuL8CekXuiE5rVfxksFrf5oSF
         ITAV7DAq5AH4WA4lLXwMW7kqXTbavgIcEmnlZVbhP3Uu2YYF2IHkFUy1zA6XFHT2mpeq
         14mPIDqxQC3fZ0Icc9j/ThJ02E1sKyliNo83MuvGLBTj4snMwbOHxbIIHNtgHnz5lzto
         EBBFwe3TWpKKh4HGluQJkNIZXtWThWlCQTH7teDWYza1kTSW4FZzLFXcuJh5HQ1LnlZv
         up2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791519464; x=1792124264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4RcsQMFD3Y2sKnN62bJcquoq+XfJOaIGkGo1pR1B1Zo=;
        b=emLNv+rBmUilatJU9IawgwUDuVFjg3aUScCIu8GQnnB0GmmVjyHxowlKqzjVegbufB
         1CbXJkXS5HGjfd+3Nm0ytPZVoXS+UoOo+E4ffKXpGDPRvz0RSD2d/S5vBqI9CvP5ws8v
         u+sO87t2PDP7FZORNG1Bjm/YOVFs9EfY0XVizaEuVGCPzH7jxPay+CAZFVrQA2S72a+/
         l+Q8nMlwui36YRXtMskX7e2u5R+jgKttWY20H3knwvNJYdgZrHLA5WKSXfW8vLE69+Da
         VUi7FotRXLzliwGlChX2NXGuDgb2GtxbzptJR8iBAimJFr5HnrX2GTgaEV157mqJYF74
         wcNA==
X-Forwarded-Encrypted: i=1; AKwUvBxuRzPBVf6wHKqd4NIa+QX10qhBwAvq4tkv8PYT6t73z6aLiIH3YIjuMff8ctrDa1QTVW8/FX91tqi8wg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLI9N2+TBE7lR9+CBzvL/py/Xb+autdxWyGoPzilodQNxe5Aj0g
	P2PiGtO8ag/6wuP7WCrFkfZr3uR7++EigVF3RFuw1t0YzltnlXbXSUccYc+1d1JtsOO5SFvrsjz
	inbmg+yP6Psky0LK6ZWokonqh4gqTWBUeR8N6nvZO2ugdJhcoNh8DgBlavopSlffNmQ==
X-Gm-Gg: AYBFou1RQryHqmxFk7nOvuHVmrw0OJEgAfCy9R8VOY1jEKp9ss1UF+G7ZVW0OlBwF0V
	mF6JyV4W54E/5VB2skGf61SXJmOt87OZ32zK3LCOPKw2gz/+O4btVJ30lIVxdpxpuDaNcgnBeRC
	HwMmV/FYrFk9jXd3LGbpw95pv5rgZQyH5bzDb7WAORFA4yLrbFydREDMDlo2O3wct8EjY27AjmP
	z5Ri40yCbJt46Z8RBZlouVgA7iq5dCvFdVBA40PAoOwH+O7jTcJ4vIWJh4uB31JwjXCE3+pffSM
	yE1TI6j1nek0/geAIbD57FHUzK2Fp8i/ln8DKdPnHgGn5dC00sCc1qaxj7AxWr6oNgaK1ZkfgmB
	WI26/Urmt7QvLBNhGb7rBfKqGdsOv8y4lhgukasqtov8gC8BgVeEhMX0AjQ==
X-Received: by 2002:a05:7301:904:b0:34a:e4f6:4a4b with SMTP id 5a478bee46e88-3537e0ba700mr1181718eec.21.1791519463473;
        Thu, 08 Oct 2026 21:17:43 -0700 (PDT)
X-Received: by 2002:a05:7301:904:b0:34a:e4f6:4a4b with SMTP id 5a478bee46e88-3537e0ba700mr1181676eec.21.1791519462693;
        Thu, 08 Oct 2026 21:17:42 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm3530749eec.0.2026.10.08.21.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:17:42 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] virtio_blk: add inline encryption support
Date: Thu,  8 Oct 2026 21:17:14 -0700
Message-ID: <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
References: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfXzv4+me9X2z71
 V8s+AuozwHa3KRJ7HdIel0bFFXk6sY7xOZ/KZH00qSKRLwHjC2VuNqTRSVQn/2dtCIca2BdwshP
 4jtAfBOvKeQYD5gmaL8c1/WJwxwKJ9Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfX3TG2UmqRICUk
 PQTluYdhWbEYfH1fBqe+oodtT5Hwz68RmLwGuuIDGB4k8OXHwr4HjxHgiXYQTqQXgUjMyO9UNNy
 pqMNILMZbVlo3VBswL/suHb932+G+FtIYjaoURSxfftCg8W8+RZFW90VY91TfNYv1JSrRKU7Tlr
 b6rCQx/IQ+gV9s7iOprEgGhyFyqpnepk1EYd1hcypImKNluW7u/3LKFfolJNtS2WIcC2L3EZLXJ
 u9tBlARDJmf7wQQUuWmd0lveIm6dwR8B1HMKaZON+AbaBTRyRZe6MGPOPd3ES2Uf6K9aRKJCbHy
 wIzLTC+9LFDtY6uGS+l7efm1GFXxdQHXXVifqoEg24G3EMKzhQpKh3j1jLcDA0OSvUExb5RQJyy
 niMJVrfpbtufX3hbxYEecomDHQYTHdhSXK8jLXlpZT2hqF77Kfxs4oPLOjMdyDuMordczy5iCqT
 ATOQ4QHH5I4AOND5zEg==
X-Proofpoint-GUID: pmRSapkhY6mwgFkgilRpAGWA2enOTxYT
X-Proofpoint-ORIG-GUID: pmRSapkhY6mwgFkgilRpAGWA2enOTxYT
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac86ae9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=hH0yjGw-JMYVMni8d6IA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090016

Add support for the virtio-blk inline encryption feature
(VIRTIO_BLK_F_INLINE_ENCRYPTION), which lets the guest offload
per-I/O encryption to the host's inline crypto engine instead of
doing it in software in the guest.

Advertise the device's inline encryption characteristics (key
types, supported crypto modes, max keyslots, DUN size) and wire
them up to a struct blk_crypto_profile so upper layers can attach
encryption contexts to bios as usual. Key management (program,
evict, generate, import, prepare key, derive software secret) is
carried out as control commands over the control virtqueue, and
per-request keyslot and data unit number are carried in an
extended request header for read/write commands.

Inline encryption is only enabled when both the control virtqueue
and inline encryption feature bits are negotiated, and is gated
behind a new VIRTIO_BLK_INLINE_ENCRYPTION Kconfig option that
depends on BLK_INLINE_ENCRYPTION, so kernels that don't select it
are unaffected.

Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 680 +++++++++++++++++++++++++++++++-
 include/linux/virtio_blk.h      |  87 ++++
 include/uapi/linux/virtio_blk.h | 123 +++++-
 4 files changed, 884 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/virtio_blk.h

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 858320b6ebb7..58bb050d4617 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -372,4 +372,16 @@ config BLK_DEV_ZONED_LOOP
 
 	  If unsure, say N.
 
+config VIRTIO_BLK_INLINE_ENCRYPTION
+	tristate "Virtio block inline encryption support"
+	depends on VIRTIO_BLK && BLK_INLINE_ENCRYPTION
+	help
+	  Say 'Y or M' here will allow the virtio block driver to route crypto
+	  requests to a different operating system in a virtualized
+	  environment. This is useful to encrypt the data stored in the storage
+	  by using storage inline crypto engine. The control queue feature bit
+	  must be negotiated to enable this functionality.
+
+	  If unsure, say N.
+
 endif # BLK_DEV
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6e9729134efa..df24c28d8ca5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -17,6 +17,7 @@
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
 #include <uapi/linux/virtio_ring.h>
+#include <linux/blk-crypto-profile.h>
 
 #define PART_BITS 4
 #define VQ_NAME_LEN 16
@@ -94,13 +95,24 @@ struct virtio_blk {
 	/* For zoned device */
 	unsigned int zone_sectors;
 
+	/* For inline encryption support */
+	struct blk_crypto_profile profile;
+	bool crypto_profile_initialized;
+
 	/* Control virtqueue state. */
 	struct virtio_blk_ctrl_vq ctrl_vq;
 };
 
 struct virtblk_req {
 	/* Out header */
-	struct virtio_blk_outhdr out_hdr;
+	union {
+		struct virtio_blk_outhdr base;
+		struct {
+			struct virtio_blk_outhdr base;
+			/* Crypto message (if VIRTIO_BLK_F_INLINE_ENCRYPTION) */
+			struct virtio_blk_crypto_msg msg;
+		} crypto_append;
+	} out_hdr;
 
 	/* In header */
 	union {
@@ -138,7 +150,21 @@ struct virtblk_ctrl_completion {
 };
 
 struct virtblk_ctrl_request {
+	/* Type byte, always its own out-sg for every command. */
 	__virtio32 type;
+	/* Out request, sent as a second, separate out-sg if any. */
+	union {
+		struct virtio_blk_crypto_key_desc key_desc;
+		struct virtio_blk_crypto_key_blob blob;
+	} out_req;
+
+	/* In response */
+	union {
+		struct virtio_blk_crypto_key_blob blob;
+		struct virtio_blk_crypto_sw_secret secret;
+		struct virtio_blk_crypto_modes modes;
+	} in_resp;
+	/* Status byte, always its own in-sg for every command. */
 	u8 status;
 
 	struct virtblk_ctrl_completion *compl;
@@ -174,12 +200,17 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
 	struct scatterlist out_hdr, in_hdr, *sgs[3];
 	unsigned int num_out = 0, num_in = 0;
+	size_t out_hdr_len = sizeof(vbr->out_hdr.base);
 
-	sg_init_one(&out_hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
+	if (vbr->out_hdr.base.type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_CRYPTO_IN) ||
+	    vbr->out_hdr.base.type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_CRYPTO_OUT))
+		out_hdr_len = sizeof(vbr->out_hdr.crypto_append);
+
+	sg_init_one(&out_hdr, &vbr->out_hdr, out_hdr_len);
 	sgs[num_out++] = &out_hdr;
 
 	if (vbr->sg_table.nents) {
-		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
+		if (vbr->out_hdr.base.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
 			sgs[num_out++] = vbr->sg_table.sgl;
 		else
 			sgs[num_out + num_in++] = vbr->sg_table.sgl;
@@ -269,6 +300,22 @@ static void virtblk_cleanup_cmd(struct request *req)
 		kfree(bvec_virt(&req->special_vec));
 }
 
+#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
+static bool is_crypto_request(struct request *req)
+{
+	struct request_queue *q = req->q;
+
+	return q->crypto_profile &&
+	       req->crypt_ctx &&
+	       req->crypt_keyslot;
+}
+#else
+static inline bool is_crypto_request(struct request *req)
+{
+	return false;
+}
+#endif
+
 static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 				      struct request *req,
 				      struct virtblk_req *vbr)
@@ -277,20 +324,27 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	bool unmap = false;
 	u32 type;
 	u64 sector = 0;
+	int i;
 
 	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) && op_is_zone_mgmt(req_op(req)))
 		return BLK_STS_NOTSUPP;
 
 	/* Set fields for all request types */
-	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
+	vbr->out_hdr.base.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
-		type = VIRTIO_BLK_T_IN;
+		if (is_crypto_request(req))
+			type = VIRTIO_BLK_T_CRYPTO_IN;
+		else
+			type = VIRTIO_BLK_T_IN;
 		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_WRITE:
-		type = VIRTIO_BLK_T_OUT;
+		if (is_crypto_request(req))
+			type = VIRTIO_BLK_T_CRYPTO_OUT;
+		else
+			type = VIRTIO_BLK_T_OUT;
 		sector = blk_rq_pos(req);
 		break;
 	case REQ_OP_FLUSH:
@@ -343,8 +397,8 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 
 	/* Set fields for non-REQ_OP_DRV_IN request types */
 	vbr->in_hdr_len = in_hdr_len;
-	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
-	vbr->out_hdr.sector = cpu_to_virtio64(vdev, sector);
+	vbr->out_hdr.base.type = cpu_to_virtio32(vdev, type);
+	vbr->out_hdr.base.sector = cpu_to_virtio64(vdev, sector);
 
 	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
 	    type == VIRTIO_BLK_T_SECURE_ERASE) {
@@ -352,6 +406,18 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 			return BLK_STS_RESOURCE;
 	}
 
+	if (type == VIRTIO_BLK_T_CRYPTO_IN || type == VIRTIO_BLK_T_CRYPTO_OUT) {
+		memset(&vbr->out_hdr.crypto_append.msg, 0,
+			sizeof(vbr->out_hdr.crypto_append.msg));
+		vbr->out_hdr.crypto_append.msg.slot =
+			cpu_to_virtio32(vdev,
+				blk_crypto_keyslot_index(req->crypt_keyslot));
+		for (i = 0; i < ARRAY_SIZE(vbr->out_hdr.crypto_append.msg.dun); i++) {
+			vbr->out_hdr.crypto_append.msg.dun[i] =
+				cpu_to_virtio64(vdev, req->crypt_ctx->bc_dun[i]);
+		}
+	}
+
 	return 0;
 }
 
@@ -602,8 +668,8 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 
 	vbr = blk_mq_rq_to_pdu(req);
 	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
-	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
+	vbr->out_hdr.base.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
+	vbr->out_hdr.base.sector = cpu_to_virtio64(vblk->vdev, sector);
 
 	err = blk_rq_map_kern(req, report_buf, report_len, GFP_KERNEL);
 	if (err)
@@ -851,8 +917,8 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 
 	vbr = blk_mq_rq_to_pdu(req);
 	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
-	vbr->out_hdr.sector = 0;
+	vbr->out_hdr.base.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
+	vbr->out_hdr.base.sector = 0;
 
 	err = blk_rq_map_kern(req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
@@ -940,7 +1006,7 @@ static void virtblk_ctrl_vq_drain(struct virtio_blk *vblk)
 
 		if (abandoned) {
 			kfree(creq->compl);
-			kfree(creq);
+			kfree_sensitive(creq);
 		} else {
 			creq->status = VIRTIO_BLK_S_IOERR;
 			complete(&creq->compl->done);
@@ -984,7 +1050,7 @@ static void virtblk_ctrlq_callback(struct virtqueue *vq)
 			 */
 			if (abandoned) {
 				kfree(creq->compl);
-				kfree(creq);
+				kfree_sensitive(creq);
 			} else {
 				complete(&creq->compl->done);
 			}
@@ -1066,11 +1132,566 @@ static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
 	return -ETIMEDOUT;
 }
 
+#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
+static int virtblk_get_crypto_modes(struct virtio_blk *vblk,
+				    unsigned int *crypto_modes_supported)
+{
+	unsigned int nr_modes = VIRTIO_BLK_CRYPTO_MODE_MAX + 1;
+	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	unsigned int i;
+	int err;
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
+	if (!creq)
+		return -ENOMEM;
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_CRYPTO_MODES);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&resp_sg, &creq->in_resp.modes, sizeof(creq->in_resp.modes));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &resp_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 1, 2);
+	if (err == -ETIMEDOUT)
+		return err;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	for (i = 1; i < nr_modes; i++) {
+		u32 mode_mask = virtio32_to_cpu(vblk->vdev,
+						 creq->in_resp.modes.modes[i]);
+		enum blk_crypto_mode_num mode = virtio_mode_to_blk(i);
+
+		if (!mode_mask)
+			continue;
+		if (!mode) {
+			dev_warn(&vblk->vdev->dev,
+				 "ignoring unknown crypto mode %u\n", i);
+			continue;
+		}
+		crypto_modes_supported[mode] = mode_mask;
+	}
+
+out_free:
+	kfree(creq);
+	return err;
+}
+
+static int set_virtblk_crypto_key_desc(struct virtio_device *vdev,
+				       struct virtblk_ctrl_request *creq,
+				       const struct blk_crypto_key *key,
+				       unsigned int slot)
+{
+	struct virtio_blk_crypto_key_desc *desc = &creq->out_req.key_desc;
+	unsigned int vtype = blk_key_type_to_virtio(key->crypto_cfg.key_type);
+
+	if (sizeof(desc->bytes) < key->size)
+		return -EOVERFLOW;
+	if (!vtype)
+		return -EOPNOTSUPP;
+
+	memset(desc, 0, sizeof(*desc));
+	desc->slot = cpu_to_virtio32(vdev, slot);
+	memcpy(desc->bytes, key->bytes, key->size);
+	desc->key_size = cpu_to_virtio32(vdev, key->size);
+	desc->crypto_mode = cpu_to_virtio32(vdev,
+		blk_mode_to_virtio(key->crypto_cfg.crypto_mode));
+	desc->key_type = cpu_to_virtio32(vdev, vtype);
+	desc->data_unit_size_bits = cpu_to_virtio32(vdev, key->data_unit_size_bits);
+	desc->dun_bytes = cpu_to_virtio32(vdev, key->crypto_cfg.dun_bytes);
+
+	return 0;
+}
+
+static inline struct virtio_blk *virtblk_from_profile(struct blk_crypto_profile *profile)
+{
+	return container_of(profile, struct virtio_blk, profile);
+}
+
+static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *profile,
+					   const struct blk_crypto_key *key,
+					   unsigned int slot)
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	int err;
+
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	/*
+	 * GFP_NOIO: this callback runs on the bio-submission path, which
+	 * memory reclaim can reach while writing back dirty pages to this
+	 * same device; GFP_KERNEL here could recurse into that same reclaim
+	 * and self-deadlock.
+	 */
+	creq = kzalloc_obj(*creq, GFP_NOIO);
+	if (!creq) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM);
+
+	err = set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
+	if (err)
+		goto out_free;
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.key_desc));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);
+	if (err == -ETIMEDOUT)
+		goto out_unlock;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+out_free:
+	kfree_sensitive(creq);
+out_unlock:
+	mutex_unlock(&vblk->vdev_mutex);
+	return err;
+}
+
+static int virtblk_crypto_keyslot_evict(struct blk_crypto_profile *profile,
+					 const struct blk_crypto_key *key,
+					 unsigned int slot)
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	int err;
+
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	creq = kzalloc_obj(*creq, GFP_NOIO);
+	if (!creq) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT);
+
+	err = set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
+	if (err)
+		goto out_free;
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.key_desc));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);
+	if (err == -ETIMEDOUT)
+		goto out_unlock;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+out_free:
+	kfree_sensitive(creq);
+out_unlock:
+	mutex_unlock(&vblk->vdev_mutex);
+	return err;
+}
+
+static int virtblk_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
+					    const u8 *eph_key, size_t eph_key_size,
+					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, resp_sg, status_sg, *sgs[4];
+	struct virtblk_ctrl_request *creq;
+	int err;
+
+	static_assert(sizeof_field(struct virtblk_ctrl_request, in_resp.secret.secret) >=
+		      BLK_CRYPTO_SW_SECRET_SIZE);
+
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (eph_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE) {
+		err = -EOVERFLOW;
+		goto out_unlock;
+	}
+
+	/*
+	 * GFP_NOIO: avoid a self-deadlock. vdev_mutex, held above, is also
+	 * required by virtblk_crypto_keyslot_program()/_evict(), which direct
+	 * reclaim could invoke synchronously (writeback needing a keyslot)
+	 * while this allocation is still in progress under the same mutex.
+	 */
+	creq = kzalloc_obj(*creq, GFP_NOIO);
+	if (!creq) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET);
+	memcpy(creq->out_req.blob.key, eph_key, eph_key_size);
+	creq->out_req.blob.key_size = cpu_to_virtio32(vblk->vdev, eph_key_size);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.blob, sizeof(creq->out_req.blob));
+	sg_init_one(&resp_sg, &creq->in_resp.secret, sizeof(creq->in_resp.secret));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &resp_sg;
+	sgs[3] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 2);
+	if (err == -ETIMEDOUT)
+		goto out_unlock;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	memcpy(sw_secret, creq->in_resp.secret.secret, BLK_CRYPTO_SW_SECRET_SIZE);
+out_free:
+	kfree_sensitive(creq);
+out_unlock:
+	mutex_unlock(&vblk->vdev_mutex);
+	return err;
+}
+
+static int virtblk_crypto_generate_key(struct blk_crypto_profile *profile,
+					u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
+	struct virtblk_ctrl_request *creq;
+	unsigned int key_size;
+	int err;
+
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	creq = kzalloc_obj(*creq, GFP_NOIO);
+	if (!creq) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_GENERATE_KEY);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&resp_sg, &creq->in_resp.blob, sizeof(creq->in_resp.blob));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &resp_sg;
+	sgs[2] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 1, 2);
+	if (err == -ETIMEDOUT)
+		goto out_unlock;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	key_size = virtio32_to_cpu(vblk->vdev, creq->in_resp.blob.key_size);
+	if (!key_size ||
+		key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE) {
+		dev_err(&vblk->vdev->dev,
+			"backend returned oversized generated key: %u\n", key_size);
+		err = -EOVERFLOW;
+		goto out_free;
+	}
+	memcpy(lt_key, creq->in_resp.blob.key, key_size);
+	err = key_size;
+out_free:
+	kfree_sensitive(creq);
+out_unlock:
+	mutex_unlock(&vblk->vdev_mutex);
+	return err;
+}
+
+static int virtblk_crypto_prepare_key(struct blk_crypto_profile *profile,
+				       const u8 *lt_key, size_t lt_key_size,
+				       u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, resp_sg, status_sg, *sgs[4];
+	struct virtblk_ctrl_request *creq;
+	unsigned int key_size;
+	int err;
+
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (lt_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE) {
+		err = -EOVERFLOW;
+		goto out_unlock;
+	}
+
+	creq = kzalloc_obj(*creq, GFP_NOIO);
+	if (!creq) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_PREPARE_KEY);
+	memcpy(creq->out_req.blob.key, lt_key, lt_key_size);
+	creq->out_req.blob.key_size = cpu_to_virtio32(vblk->vdev, lt_key_size);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.blob, sizeof(creq->out_req.blob));
+	sg_init_one(&resp_sg, &creq->in_resp.blob, sizeof(creq->in_resp.blob));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &resp_sg;
+	sgs[3] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 2);
+	if (err == -ETIMEDOUT)
+		goto out_unlock;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	key_size = virtio32_to_cpu(vblk->vdev, creq->in_resp.blob.key_size);
+	if (!key_size ||
+		key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE) {
+		dev_err(&vblk->vdev->dev,
+			"backend returned oversized prepared key: %u\n", key_size);
+		err = -EOVERFLOW;
+		goto out_free;
+	}
+	memcpy(eph_key, creq->in_resp.blob.key, key_size);
+	err = key_size;
+out_free:
+	kfree_sensitive(creq);
+out_unlock:
+	mutex_unlock(&vblk->vdev_mutex);
+	return err;
+}
+
+static int virtblk_crypto_import_key(struct blk_crypto_profile *profile,
+				      const u8 *raw_key, size_t raw_key_size,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct virtio_blk *vblk = virtblk_from_profile(profile);
+	struct scatterlist type_sg, out_req_sg, resp_sg, status_sg, *sgs[4];
+	struct virtblk_ctrl_request *creq;
+	unsigned int key_size;
+	int err;
+
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (raw_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE) {
+		err = -EOVERFLOW;
+		goto out_unlock;
+	}
+
+	creq = kzalloc_obj(*creq, GFP_NOIO);
+	if (!creq) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY);
+	memcpy(creq->out_req.blob.key, raw_key, raw_key_size);
+	creq->out_req.blob.key_size = cpu_to_virtio32(vblk->vdev, raw_key_size);
+
+	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
+	sg_init_one(&out_req_sg, &creq->out_req.blob, sizeof(creq->out_req.blob));
+	sg_init_one(&resp_sg, &creq->in_resp.blob, sizeof(creq->in_resp.blob));
+	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
+	sgs[0] = &type_sg;
+	sgs[1] = &out_req_sg;
+	sgs[2] = &resp_sg;
+	sgs[3] = &status_sg;
+
+	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 2);
+	if (err == -ETIMEDOUT)
+		goto out_unlock;
+	if (err)
+		goto out_free;
+
+	err = blk_status_to_errno(virtblk_result(creq->status));
+	if (err)
+		goto out_free;
+
+	key_size = virtio32_to_cpu(vblk->vdev, creq->in_resp.blob.key_size);
+	if (!key_size ||
+		key_size > BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE) {
+		dev_err(&vblk->vdev->dev,
+			"backend returned oversized imported key: %u\n", key_size);
+		err = -EOVERFLOW;
+		goto out_free;
+	}
+	memcpy(lt_key, creq->in_resp.blob.key, key_size);
+	err = key_size;
+out_free:
+	kfree_sensitive(creq);
+out_unlock:
+	mutex_unlock(&vblk->vdev_mutex);
+	return err;
+}
+
+static const struct blk_crypto_ll_ops virtblk_crypto_ops = {
+	.keyslot_program	= virtblk_crypto_keyslot_program,
+	.keyslot_evict		= virtblk_crypto_keyslot_evict,
+	.derive_sw_secret	= virtblk_crypto_derive_sw_secret,
+	.generate_key		= virtblk_crypto_generate_key,
+	.prepare_key		= virtblk_crypto_prepare_key,
+	.import_key		= virtblk_crypto_import_key,
+};
+
+static unsigned int get_supported_blk_key_types(u8 virtio_key_types)
+{
+	unsigned int supported = 0;
+
+	if (virtio_key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW)
+		supported |= virtio_key_type_to_blk(VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW);
+	if (virtio_key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
+		supported |= virtio_key_type_to_blk(VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED);
+
+	return supported;
+}
+
+static int virtblk_init_crypto(struct virtio_blk *vblk)
+{
+	struct virtio_device *vdev = vblk->vdev;
+	unsigned int crypto_modes_supported[BLK_ENCRYPTION_MODE_MAX] = { 0 };
+	unsigned int key_type_supported;
+	u16 max_slots = 0;
+	/* virtio_cread() requires the variable size to match the config field exactly */
+	u8 max_dun_bytes = 0, key_types = 0;
+	int err;
+
+	virtio_cread(vdev, struct virtio_blk_config,
+		     enc_characteristics.max_slots, &max_slots);
+	virtio_cread(vdev, struct virtio_blk_config,
+		     enc_characteristics.max_dun_bytes, &max_dun_bytes);
+	virtio_cread(vdev, struct virtio_blk_config,
+		     enc_characteristics.key_types, &key_types);
+
+	dev_info_once(&vdev->dev,
+		 "max_slots = %u, max_dun_bytes = %u, key_types = 0x%x\n",
+		 max_slots, max_dun_bytes, key_types);
+
+	if (!max_slots)
+		return -EINVAL;
+
+	/*
+	 * struct virtio_blk_crypto_msg.dun is a fixed array of four __virtio64
+	 * values (32 bytes total), matching the size of
+	 * blk_crypto_ctx::bc_dun[4].  Refuse to advertise more than that as
+	 * supported, or blk-crypto could negotiate a larger dun_bytes with the
+	 * filesystem and have the high-order bytes of req->crypt_ctx->bc_dun
+	 * silently dropped in virtblk_setup_cmd().
+	 */
+	if (max_dun_bytes > sizeof_field(struct virtio_blk_crypto_msg, dun))
+		return -EINVAL;
+
+	key_type_supported = get_supported_blk_key_types(key_types);
+	if (!key_type_supported)
+		return -EINVAL;
+
+	err = virtblk_get_crypto_modes(vblk, crypto_modes_supported);
+	if (err) {
+		dev_err(&vdev->dev, "get crypto modes failed: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * Use the plain (non-devm) initializer: vblk->profile is embedded in
+	 * struct virtio_blk, whose lifetime is tied to the gendisk, not to
+	 * &vdev->dev. Tying destruction to the vdev via devm would run the
+	 * destroy callback after virtblk_remove() has already freed vblk.
+	 * virtblk_free_disk() calls blk_crypto_profile_destroy() explicitly
+	 * instead, guarded by crypto_profile_initialized below.
+	 */
+	err = blk_crypto_profile_init(&vblk->profile, max_slots);
+	if (err) {
+		dev_err(&vdev->dev, "crypto profile initialization failed: %d\n", err);
+		return err;
+	}
+
+	vblk->profile.ll_ops = virtblk_crypto_ops;
+	vblk->profile.max_dun_bytes_supported = max_dun_bytes;
+	vblk->profile.key_types_supported = key_type_supported;
+	vblk->profile.dev = &vdev->dev;
+	memcpy(vblk->profile.modes_supported, crypto_modes_supported,
+	       BLK_ENCRYPTION_MODE_MAX * sizeof(unsigned int));
+
+	vblk->crypto_profile_initialized = true;
+
+	dev_info(&vdev->dev, "inline crypto profile initialized\n");
+
+	return 0;
+}
+
+static void virtblk_destroy_crypto(struct virtio_blk *vblk)
+{
+	if (vblk->crypto_profile_initialized)
+		blk_crypto_profile_destroy(&vblk->profile);
+}
+#else
+
+static inline int virtblk_init_crypto(struct virtio_blk *vblk)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void virtblk_destroy_crypto(struct virtio_blk *vblk)
+{
+}
+#endif /* CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION */
+
 static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
 	ida_free(&vd_index_ida, vblk->index);
+	virtblk_destroy_crypto(vblk);
 	mutex_destroy(&vblk->ctrl_vq.mutex);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
@@ -1665,6 +2286,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	};
 	int err, index;
 	unsigned int queue_depth;
+	bool zoned_disk = false;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -1688,6 +2310,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	mutex_init(&vblk->ctrl_vq.mutex);
 	spin_lock_init(&vblk->ctrl_vq.lock);
 
+	vblk->crypto_profile_initialized = false;
 	vblk->vdev = vdev;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
@@ -1763,6 +2386,28 @@ static int virtblk_probe(struct virtio_device *vdev)
 		err = blk_revalidate_disk_zones(vblk->disk);
 		if (err)
 			goto out_cleanup_disk;
+
+		zoned_disk = true;
+	}
+
+	if (IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION) &&
+		   virtio_has_feature(vdev, VIRTIO_BLK_F_INLINE_ENCRYPTION) &&
+		   virtio_has_feature(vdev, VIRTIO_BLK_F_CTRL_VQ)) {
+		if (zoned_disk) {
+			dev_info(&vdev->dev,
+				"inline crypto not supported on zoned device\n");
+		} else {
+			err = virtblk_init_crypto(vblk);
+			if (!err) {
+				if (!blk_crypto_register(&vblk->profile, vblk->disk->queue))
+					dev_warn(&vdev->dev,
+						"failed to register inline crypto profile\n");
+			} else {
+				dev_warn(&vdev->dev,
+					"inline crypto init failed: %d, continuing without inline crypto support\n",
+					err);
+			}
+		}
 	}
 
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
@@ -1861,6 +2506,11 @@ static int virtblk_restore_priv(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
+
+	/* Reprogram the keys to keyslots. */
+	if (vblk->crypto_profile_initialized)
+		blk_crypto_reprogram_all_keys(&vblk->profile);
+
 	blk_mq_unquiesce_queue(vblk->disk->queue);
 
 	return 0;
@@ -1907,7 +2557,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
-	VIRTIO_BLK_F_CTRL_VQ,
+	VIRTIO_BLK_F_CTRL_VQ, VIRTIO_BLK_F_INLINE_ENCRYPTION,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/linux/virtio_blk.h b/include/linux/virtio_blk.h
new file mode 100644
index 000000000000..9f5aecad1907
--- /dev/null
+++ b/include/linux/virtio_blk.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VIRTIO_BLK_H
+#define _LINUX_VIRTIO_BLK_H
+
+#include <linux/blk-crypto.h>
+#include <uapi/linux/virtio_blk.h>
+
+#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
+/**
+ * virtio_mode_to_blk() - Convert a virtio_blk crypto mode number to a block mode
+ * @vmode: The virtio_blk crypto mode number (VIRTIO_BLK_CRYPTO_MODE_*).
+ *
+ * Return: The corresponding &enum blk_crypto_mode_num, or
+ *         %BLK_ENCRYPTION_MODE_INVALID if @vmode is out of range.
+ */
+static inline enum blk_crypto_mode_num virtio_mode_to_blk(unsigned int vmode)
+{
+	/* Indexed by virtio_blk crypto mode number; unlisted entries are 0 (INVALID). */
+	static const enum blk_crypto_mode_num modes[__VIRTIO_BLK_CRYPTO_MODE_MAX] = {
+		[VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS] = BLK_ENCRYPTION_MODE_AES_256_XTS,
+	};
+
+	if (vmode >= __VIRTIO_BLK_CRYPTO_MODE_MAX)
+		return BLK_ENCRYPTION_MODE_INVALID;
+	return modes[vmode];
+}
+
+/**
+ * blk_mode_to_virtio() - Convert a block crypto mode to a virtio_blk crypto mode number
+ * @bmode: The kernel &enum blk_crypto_mode_num.
+ *
+ * Return: The corresponding virtio_blk crypto mode number, or
+ *         %VIRTIO_BLK_CRYPTO_MODE_INVALID if @bmode is out of range.
+ */
+static inline unsigned int blk_mode_to_virtio(enum blk_crypto_mode_num bmode)
+{
+	/* Indexed by blk_crypto_mode_num; unlisted entries are 0 (INVALID). */
+	static const unsigned int modes[BLK_ENCRYPTION_MODE_MAX] = {
+		[BLK_ENCRYPTION_MODE_AES_256_XTS] = VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS,
+	};
+
+	if (bmode >= BLK_ENCRYPTION_MODE_MAX)
+		return VIRTIO_BLK_CRYPTO_MODE_INVALID;
+	return modes[bmode];
+}
+
+/**
+ * virtio_key_type_to_blk() - Convert a virtio_blk crypto key type to a block key type
+ * @vtype: The virtio_blk crypto key type (VIRTIO_BLK_CRYPTO_KEY_TYPE_*).
+ *
+ * Return: The corresponding &enum blk_crypto_key_type, or 0 if @vtype does
+ *         not name a single supported key type.
+ */
+static inline enum blk_crypto_key_type virtio_key_type_to_blk(unsigned int vtype)
+{
+	switch (vtype) {
+	case VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW:
+		return BLK_CRYPTO_KEY_TYPE_RAW;
+	case VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED:
+		return BLK_CRYPTO_KEY_TYPE_HW_WRAPPED;
+	default:
+		return 0;
+	}
+}
+
+/**
+ * blk_key_type_to_virtio() - Convert a block key type to a virtio_blk crypto key type
+ * @btype: The kernel &enum blk_crypto_key_type.
+ *
+ * Return: The corresponding virtio_blk crypto key type
+ *         (VIRTIO_BLK_CRYPTO_KEY_TYPE_*), or 0 if @btype does not name a
+ *         single supported key type.
+ */
+static inline unsigned int blk_key_type_to_virtio(enum blk_crypto_key_type btype)
+{
+	switch (btype) {
+	case BLK_CRYPTO_KEY_TYPE_RAW:
+		return VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW;
+	case BLK_CRYPTO_KEY_TYPE_HW_WRAPPED:
+		return VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED;
+	default:
+		return 0;
+	}
+}
+#endif /* CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION */
+
+#endif /* _LINUX_VIRTIO_BLK_H */
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 1daddd259249..87300907abca 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -1,5 +1,5 @@
-#ifndef _LINUX_VIRTIO_BLK_H
-#define _LINUX_VIRTIO_BLK_H
+#ifndef _UAPI_LINUX_VIRTIO_BLK_H
+#define _UAPI_LINUX_VIRTIO_BLK_H
 /* This header is BSD licensed so anyone can use the definitions to implement
  * compatible drivers/servers.
  *
@@ -43,6 +43,7 @@
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
 #define VIRTIO_BLK_F_CTRL_VQ			20	/* Control queue */
+#define VIRTIO_BLK_F_INLINE_ENCRYPTION		21	/* Inline encryption */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -149,6 +150,15 @@ struct virtio_blk_config {
 		__u8 model;
 		__u8 unused2[3];
 	} zoned;
+
+	/* Inline Encryption device characteristics (if VIRTIO_BLK_F_INLINE_ENCRYPTION) */
+	struct virtio_blk_enc_characteristics {
+		__virtio16 max_slots;
+		__u8 max_dun_bytes;
+		/* Bitmask of supported key types: VIRTIO_BLK_CRYPTO_KEY_TYPE_* */
+		__u8 key_types;
+		__virtio32 unused3;
+	} enc_characteristics;
 } __attribute__((packed));
 
 /*
@@ -207,6 +217,33 @@ struct virtio_blk_config {
 /* Reset All zones command */
 #define VIRTIO_BLK_T_ZONE_RESET_ALL 26
 
+/* Inline-encrypted write: crypto_msg set in outhdr */
+#define VIRTIO_BLK_T_CRYPTO_OUT		27
+
+/* Inline-encrypted read: crypto_msg set in outhdr */
+#define VIRTIO_BLK_T_CRYPTO_IN		28
+
+/* Get inline crypto modes */
+#define VIRTIO_BLK_T_GET_CRYPTO_MODES	29
+
+/* Program a key into the keyslot */
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM	30
+
+/* Evict a key */
+#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT	31
+
+/* Derive the software secret from a hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET	32
+
+/* Generate a new hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_GENERATE_KEY	33
+
+/* Import a raw key as a hardware-wrapped key */
+#define VIRTIO_BLK_T_CRYPTO_IMPORT_KEY		34
+
+/* Convert a long-term wrapped key to its ephemerally-wrapped form */
+#define VIRTIO_BLK_T_CRYPTO_PREPARE_KEY	35
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -226,6 +263,86 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+/*
+ * Crypto message descriptor, appended to the outhdr of a
+ * VIRTIO_BLK_T_CRYPTO_OUT or VIRTIO_BLK_T_CRYPTO_IN request.
+ */
+struct virtio_blk_crypto_msg {
+	/* virtual key slot index */
+	__virtio32 slot;
+	__u8 unused[4];
+	/* data unit number (DUN / IV) for this request */
+	__virtio64 dun[4];
+};
+
+/* Key type for VIRTIO_BLK_F_INLINE_ENCRYPTION. */
+enum virtio_blk_crypto_key_type {
+	VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW = 1,
+	VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED,
+};
+
+/*
+ * Inline crypto key descriptor. Request part for
+ * VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM/KEYSLOT_EVICT.
+ */
+/* Must be >= BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in include/linux/blk-crypto.h */
+#define VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE		128
+
+struct virtio_blk_crypto_key_desc {
+	__virtio32  slot;
+	__u8        bytes[VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE];
+	__virtio32  key_size;
+	__virtio32  crypto_mode;
+	__virtio32  key_type;
+	__virtio32  data_unit_size_bits;
+	__virtio32  dun_bytes;
+};
+
+/*
+ * A raw or hardware-wrapped key blob, used as the request and/or reply part
+ * of the VIRTIO_BLK_T_CRYPTO_GENERATE_KEY/IMPORT_KEY/PREPARE_KEY/
+ * DERIVE_SW_SECRET commands.
+ */
+struct virtio_blk_crypto_key_blob {
+	__virtio32 key_size;
+	__u8 key[VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE];
+};
+
+/* Must match BLK_CRYPTO_SW_SECRET_SIZE in include/linux/blk-crypto.h */
+#define VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE	32
+
+/* Reply to a VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET request. */
+struct virtio_blk_crypto_sw_secret {
+	__u8 secret[VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE];
+};
+
+/*
+ * Crypto mode numbers used in VIRTIO_BLK_T_GET_CRYPTO_MODES replies, in
+ * struct virtio_blk_crypto_key_desc.crypto_mode and in indexing struct
+ * virtio_blk_crypto_modes.modes[] below. These numbers are assigned by
+ * the virtio spec and are stable: a number is never reused for a different
+ * crypto mode, and additional crypto modes are assigned new, higher numbers.
+ */
+enum {
+	VIRTIO_BLK_CRYPTO_MODE_INVALID,
+	VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS,
+	__VIRTIO_BLK_CRYPTO_MODE_MAX,	/* sentinel: always one past the last real mode */
+};
+
+/* Highest crypto mode number defined by this version of the header. */
+#define VIRTIO_BLK_CRYPTO_MODE_MAX (__VIRTIO_BLK_CRYPTO_MODE_MAX - 1)
+
+/* Reply to a VIRTIO_BLK_T_GET_CRYPTO_MODES request. */
+struct virtio_blk_crypto_modes {
+	/*
+	 * modes[N], for crypto mode number N <= VIRTIO_BLK_CRYPTO_MODE_MAX, is
+	 * a bitmask of the data unit sizes with which crypto mode N can be
+	 * used: bit i is set if a data unit size of (1 << i) bytes is
+	 * supported. modes[0] is reserved and always 0.
+	 */
+	__virtio32 modes[__VIRTIO_BLK_CRYPTO_MODE_MAX];
+};
+
 /*
  * Supported zoned device models.
  */
@@ -325,4 +442,4 @@ struct virtio_scsi_inhdr {
 #define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE   5
 #define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
 
-#endif /* _LINUX_VIRTIO_BLK_H */
+#endif /* _UAPI_LINUX_VIRTIO_BLK_H */
-- 
2.34.1

