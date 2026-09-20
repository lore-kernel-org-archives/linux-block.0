Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EB424D5A
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907113; cv=none; b=S4w5wC8ZEBjayxgFFSzAyZk3O07uS/N2jqHbndKEhL9WLHt+ZecOxtDH78PB0Tj1kMFVGhE0pkNJK7G12t+pz2WHe703IkqQALaPeHDXb915CG681sCYpyDSl/NNRaY/BnkZTo31Kr0LKaFW6x+N65YDCGhwj6TEmletP86IDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907113; c=relaxed/simple;
	bh=jTDEcx0QAMA0lyxrUy4j0XDoCK3htmIZ3hOyMeVJEnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRnGiGDz3LdrbbQCvav//vHxJoc0FNY8nnX5WNrJpmt0RNHcREh66ThyDvQhnaOkAWuKL6dRH3Nx57J3geYHMupK1+PKrwuXp0e64BGE0eo99m5VOUfzQN34b4vnggcbXgqwfQtaxQLpsP1IRxq41FYzaVVx4zveXnR5dQmKsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j1si+E9H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ge1JE4nr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1si+E9H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ge1JE4nr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBqB2c979449
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 12:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m5rUTyzfMIR
	fFWjBv3oHCftmU2JcMDhPJIv+az2123g=; b=j1si+E9HuGn+Zb2WuX989y/B5UY
	bhMmtfwRn/lmDvQA/cTnhaTpH56Y+3aI4AcKgLfaQ5kqlcZQ6emHgMYRCspjtZPK
	eLdHI6C/HubPBvYcy51yWWZIWzDYc/jZAwron6cB/KiPbx2TMIEEt+N6VA47Wsb6
	lvRKhK/hfWMx3xRFdoSLOXHrhMkO262M9bbFXNKwyqvCX/CqhNyV9XPROtW3tRry
	dpF4Eu16YYkglkt/nDXn0VxNaw4tYDKcXlJvnAyAW+FHgvvTRyR6WtBBayO9XecY
	QTnxCY5jm5tFQ3cveXkHIx/XKN7QNP9nbpCzO0OwF2Gh+DrA4cYNbgH0ibQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskjk2uds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 12:25:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so3091688a91.2
        for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789907100; x=1790511900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5rUTyzfMIRfFWjBv3oHCftmU2JcMDhPJIv+az2123g=;
        b=Ge1JE4nr5hquKKHtsZjxBIuNHUG2MTt88t27jFURWOMobtq5yD6BuGjDYLMfzGqBSp
         OHxp4QhOord6LiPywVP3zCUR4IiMTiPMhYELHGwikSlYKobpFqoUOQ2cIUPToYavRPZs
         M2o2Fred4L+eVGfgE42T5IT14WAwOmbsAxV9st+nj5YX54ii362WmqW/d3G/XfS6cVe0
         rD4OPTcql90bYyKbw+0yd8jjOHy1UrWRcfY8xkswTiCoy6mdYaQM9v+5qV2nRWzyLIbK
         jBRuLrEPKUhwQYmI6DM9yoQXak701XrTlTdtYoJh2KiQn+2FSuJYF+jWYu9QpbOB4NWQ
         VZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907100; x=1790511900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m5rUTyzfMIRfFWjBv3oHCftmU2JcMDhPJIv+az2123g=;
        b=gfvJt0ci+Hv/6Cv8FUbiqAoRJqYRteMygoafmLjj7pnWP3/cFTsLtD7oT0eqLdhkbT
         wNPbRLRWR8vPaO2YkyCKpQuArl89W1VQZzTBV9nPZz5RV97Rp1VcOfqWbQwTQCaUqIh/
         TN09+h6zQTklmCHGe6uk38YgB9aicYHWnJFRKWiHxP0zH1sgDWmJTXGKj1xLJ0caQ45v
         DMSjR433vQVA8EGkQwBW0237lOubmhcrKiT80D91PYbu7pnqMLdf90gZ3005MoRtG/rK
         NZjqJ9JVCDWeygqbSVM2jIkaGOSdaMS+FnHqGVGVynFMrcxq0J29V2vfOV9jbBeIX0fW
         ijRw==
X-Forwarded-Encrypted: i=1; AKwUvBwJD0abct9vOB7GHknOzUVBsJty5oiMeXXaAFVnEsAT3CJ28RJ9KJHwWe65NSR7C6smLss0nOEdy0B4+Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mf0UCF05q3YU0XJey+iQEgqn8FFiSjO0u23yN/HrHOnY8BQKRS
	cLtWEsN5h6LJ6Sp290xU8bgbatpgl+BGYVlzmXlvkojLAcy2LVtuhZPIx5Ske6k2QBtn9g7ypDh
	cZgk7xTg4VxY/zYNut0ChcxFJ/bkln2XqdX06CO+m6iEbL95il9+1Jpweboy0nPmQkQ==
X-Gm-Gg: AYBFou1+REahSvuhsOfUG9iS9WV9A5OzF75yvxOyenucXY+QxTIGgPnvg33dCJe77x7
	3skCnixNnVkaCHylZY1oU3YkNaGSEmB71q9URW2SwgpMQuMqWNNRpXYSiyLDk05ku1lDZEJMaVi
	6KhJdpV215IOO3rmVR7kfRlSxCtWC+nU+Oub5CQbd0iMTYopveC5GHnEMH3LahVB2/uuGE5YSGY
	o4B75zBlBF0oxrTM/QnKD6vMvIFrOiwVxOZNNiSAE5AmEVx/Amt/YlbmDeeqpsto6dzei3rbZ54
	G20QMfkYoSD95i1rD41IE8cjQzGnDBNDoHzyfPuRixWYOlkJyUGKeRjbP2yBpIB8s4PEMhNHjeS
	x2gRUne4eJ9ezZUSa/jwaWtPdPmpLETNO1UQwDaYVGmnS3o+eQY96582ByA==
X-Received: by 2002:a17:90b:3f4e:b0:39e:6a80:dda0 with SMTP id 98e67ed59e1d1-39e6a810c46mr6720536a91.39.1789907099517;
        Sun, 20 Sep 2026 05:24:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4e:b0:39e:6a80:dda0 with SMTP id 98e67ed59e1d1-39e6a810c46mr6720503a91.39.1789907098785;
        Sun, 20 Sep 2026 05:24:58 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm12007386eec.25.2026.09.20.05.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:58 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] virtio_blk: add inline encryption support
Date: Sun, 20 Sep 2026 05:24:32 -0700
Message-ID: <20260920122444.2549493-3-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
References: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H6JOUOYi c=1 sm=1 tr=0 ts=6aafd09c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=whdzJqZpIcB1mn4a2kEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfX1K4u6UGEUIoe
 dZ2Bo02zA8MOgbe1B7Xm7aBx4Eh7x0qg3dWrKMyMAzgOYUxc6eVJw3u7rJGJwMUBl8Ho0nE19rB
 Yaox09r5xdCk3yyKVvCY/s/K7UtABXh8BuO/fTsQjt6TNDS1ZxpaSyi18CHfLJX+cpsJ0me7Ewh
 fZ3AGQDBg3vTLOtL481gbYgHPtFwzX5H4/FofMDpede0I05Wk/9emuZi9FDPotIH6lCCmXHCDpQ
 goR11J6ebRg+V7BnhwrM1Y8Xp6DBIiRG3g0R/PXM3afQ7BQfHjrsOZ/a9C/HhkdkIKcTyCxJYeG
 KTpNv+rGzWtJOw+u6/x2NqXkZkHQh0U+uKzWIHdVFLB9LGESoHD3UenyNemJa5tRMHJa9WZiOby
 kOxTAs22sm10DHWX6ItYASJLWQAw1ANfW9o74ccCXsV7axSGpNLAASy2+vKoRQNKJFhpF6TE8yp
 tSxlz996Ics/vU7N1FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfXwsii47S0i1Y7
 91FIsVAtc5ttPbwkfJv68W3O1PjYl0J8X/c5hmN1WewsB/iVy2w/VqbtaDNaJOzxWGhhmHbT8Nf
 ej0ueAelpAASlJbCsL4r9W56toyiaoc=
X-Proofpoint-ORIG-GUID: S1Xvbfnv0-Vk74bU3dAcVhsDdnEnjdr8
X-Proofpoint-GUID: S1Xvbfnv0-Vk74bU3dAcVhsDdnEnjdr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200180

From: linlzhan <linlin.zhang@oss.qualcomm.com>

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

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/block/Kconfig           |  12 +
 drivers/block/virtio_blk.c      | 668 +++++++++++++++++++++++++++++++-
 include/linux/virtio_blk.h      |  87 +++++
 include/uapi/linux/virtio_blk.h | 123 +++++-
 4 files changed, 874 insertions(+), 16 deletions(-)
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
index 2fad86e8f7a9..30c303364ca9 100644
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
@@ -124,7 +136,21 @@ struct virtblk_req {
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
 
 	struct completion *compl;
@@ -167,12 +193,17 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
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
@@ -262,6 +293,22 @@ static void virtblk_cleanup_cmd(struct request *req)
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
@@ -270,20 +317,27 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
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
@@ -336,8 +390,8 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 
 	/* Set fields for non-REQ_OP_DRV_IN request types */
 	vbr->in_hdr_len = in_hdr_len;
-	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
-	vbr->out_hdr.sector = cpu_to_virtio64(vdev, sector);
+	vbr->out_hdr.base.type = cpu_to_virtio32(vdev, type);
+	vbr->out_hdr.base.sector = cpu_to_virtio64(vdev, sector);
 
 	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
 	    type == VIRTIO_BLK_T_SECURE_ERASE) {
@@ -345,6 +399,18 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
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
 
@@ -595,8 +661,8 @@ static int virtblk_submit_zone_report(struct virtio_blk *vblk,
 
 	vbr = blk_mq_rq_to_pdu(req);
 	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
-	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
+	vbr->out_hdr.base.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
+	vbr->out_hdr.base.sector = cpu_to_virtio64(vblk->vdev, sector);
 
 	err = blk_rq_map_kern(req, report_buf, report_len, GFP_KERNEL);
 	if (err)
@@ -844,8 +910,8 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 
 	vbr = blk_mq_rq_to_pdu(req);
 	vbr->in_hdr_len = sizeof(vbr->in_hdr.status);
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
-	vbr->out_hdr.sector = 0;
+	vbr->out_hdr.base.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
+	vbr->out_hdr.base.sector = 0;
 
 	err = blk_rq_map_kern(req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
@@ -1062,11 +1128,558 @@ static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
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
+	kfree(creq);
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
+	kfree(creq);
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
+	mutex_lock(&vblk->vdev_mutex);
+	if (!vblk->vdev) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (eph_key_size > VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE
+	    || sizeof(creq->in_resp.secret.secret) < BLK_CRYPTO_SW_SECRET_SIZE) {
+		err = -EOVERFLOW;
+		goto out_unlock;
+	}
+
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
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
+	kfree(creq);
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
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
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
+	kfree(creq);
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
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
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
+	kfree(creq);
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
+	creq = kzalloc_obj(*creq, GFP_KERNEL);
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
+	kfree(creq);
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
@@ -1661,6 +2274,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	};
 	int err, index;
 	unsigned int queue_depth;
+	bool zoned_disk = false;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -1684,6 +2298,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	mutex_init(&vblk->ctrl_vq.mutex);
 	spin_lock_init(&vblk->ctrl_vq.lock);
 
+	vblk->crypto_profile_initialized = false;
 	vblk->vdev = vdev;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
@@ -1759,6 +2374,28 @@ static int virtblk_probe(struct virtio_device *vdev)
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
@@ -1858,6 +2495,11 @@ static int virtblk_restore_priv(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
+
+	/* Reprogram the keys to keyslots. */
+	if (vblk->crypto_profile_initialized)
+		blk_crypto_reprogram_all_keys(&vblk->profile);
+
 	blk_mq_unquiesce_queue(vblk->disk->queue);
 
 	return 0;
@@ -1904,7 +2546,7 @@ static unsigned int features[] = {
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
index 0a16972a1535..fc57407ff2c7 100644
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
 #define VIRTIO_BLK_F_CTRL_VQ			22	/* Control queue */
+#define VIRTIO_BLK_F_INLINE_ENCRYPTION		23	/* Inline encryption */
 
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

