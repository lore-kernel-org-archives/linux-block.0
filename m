Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3694772A7
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393076; cv=none; b=JxxbJ42NPwvewThZ8xEmzSGUpWw7rkwa+uruy3DBmsjA896O8xEZEZYwS3jLT9gGU6Y4zSLEDCjiIa5pgCYlzZ5XseWCWGx8FPdI80Zlvz75Fa9Z94gKpddxFlZhXDxN7vKDW0UNizKmVBqlkyWYr6az5o3VJpirScwb+L50XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393076; c=relaxed/simple;
	bh=jCoZuWEgSbjtm4wLSbpNx2rVBrFvTgX7s+RrR3f+ndo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi5f8ozCMoovl+5wgkNYWhyhDivbtxhD9zsC2C9MxQFWJc/tSokfpgVKDrfoUdTMTeRbnmw7fEV01/NeQX0E4Z/M7DyqYQv19e7of362PQAv9sJcpeoUKNjkXf6b6a9o+pzC7ig345deZb9NFKIWE7idYwWMQ8sAkNyEj8F6T8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBkGbM0V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XnwImuxF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBkGbM0V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XnwImuxF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0ZEG3588187
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/m1IO6ReHXB
	nIHxR1Y+am6Pid+itc/UswH9TAnSjnTQ=; b=dBkGbM0Ve6n706ia3z2t5c/CKA0
	YA/WNHr0UQqdN0vpuG55FOY+oQd90RfxhuGlBSK9bWfloeXOcBLr4Cc23335Mgze
	UQ2yKmHjadTyHboxLOvitnBa7QRm6uYoYgWFIpF7tyjZPWFDliZSwocG5d9/ghMh
	4TNKkr9wqquUxFm4rpowsrnlRT6EzdhLfki6s3IZStB+NWnog7nWoRhigMYpEKB9
	/9O/rocBAzOvKWKv/BOXT4/OvdmrrBWMpzsIzeVevSdnYvXB145OzxBc+fwwW1Qk
	Q+VVmwDy1w0+saRYuGx/CViOM4e2Gd6l76jgFhQkwvul2xLHPGQgzFseiUg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg8v81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:37:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4306850a91.2
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789393068; x=1789997868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/m1IO6ReHXBnIHxR1Y+am6Pid+itc/UswH9TAnSjnTQ=;
        b=XnwImuxF8J60BkGL1pyMaS8pap2cQZ8jFaxKa2d6KzAKYf6HAi/IAIrsTylWwrt5V4
         K2Zyh2SBGvU/cY/vUtZN+N3NL34s8zhuo14Ja0OFjxRaQne8sMxzWo6c4agEXp12GJ/i
         GFYziDzCL7W3EivWhkFy96mqYAcnK9YeoaMnftqJ/dzK8xy1ntsCXtmDYADH4U8Aavli
         T/F6bG0p2nYKQIwDAT3vz9Ql+EYNzjTxRb/EDIYGdldRTsaxtC8VM2P0h6d51Ze30Bud
         1Kj2P7/lw/kwq63jsMBrUP3O+EmQA5BXYKb3aEOEONX9uvX13AA3abivTdFAANtfuLTh
         mzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393068; x=1789997868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/m1IO6ReHXBnIHxR1Y+am6Pid+itc/UswH9TAnSjnTQ=;
        b=peFNblFZM85leVwrZPkD2bf28ZZaWU6WjV2rS578ylcxIdW/57/J7uMu5+gQTUgolg
         8yvN/KPvQGyhHqSrAbG/xvN0tJcVHyhvWNENbCUdpPxLFRQGtyQkDz3LY4TFH7eJe48/
         BZFnngG2nu9/QWCHPN6M4v148m/HEuavZ/cRMEsW/5y6vJQmf2IOv8CXOcyi+xCDv4zn
         GOOsDEf4zY1rp41/kH9JLowuMiWOeELd9PRqGrS6tKtwu2w1y0A+IfErK448vwiTnh9f
         DEiIE+Z0I4Gd6nsJnNxd/TRgq88H3pi7AtB9H6LRAyUmlJ3vQQQi9A6w1yYHD2Xlb9cP
         mhOw==
X-Forwarded-Encrypted: i=1; AKwUvBxBGp8361nI4ndMiQr9ImtyYItJ6kCrnXxto8P5SOnXZBRnn1CKlG+MMB/i+egg6lFG4bhWbN+MhcmkrA==@vger.kernel.org
X-Gm-Message-State: AFuF++l732lFnHv/2mkLMisapszU8qh1CUWyB+mEowKgVH3Aw4xwBX5B
	+i7DTRbk1XCvyl6WnQvt/fJ3iE/sEz/8l+PlTEeRn/BJJkJcqberZ7dLPAJXIb0Ap9Jhk8JvMyQ
	RZ/YSenmKku4oCCkL0fMRoaSKRrZCH1wjq+ZwWwYR1fuzDXo7j6S55v8dmDHGTUUDVg==
X-Gm-Gg: AYBFou2ksrsg+gRQ0DkQIAyzkQOvAiDlVOH0onF0dl6NqEgWfG9Tpf0mKc3gAL2Y0CR
	/BY5m0eUxE+V4o2GQp5uSTOJ6f+TJS86pZa+OIyLakzXMdl8BaZRBi2IUHaabmKzBw5NpEyHW+4
	+ayI4Fd+CWcPm661RZ9MTb9d2AXQ01q+T8p6emWHc6299I6+X3OPMUONxXDOgoiMhG1o7HV+Aqd
	Ei25qT/s+favALccgNjj99xe42cYVW6LgUFzZ17NSzAnoagylKyWBah8va9OOTWfpxa2LIrSmu6
	WqTJDMlLUxbx5Sib/Xf72wBZieuQDnA+UOhPPXYksEuEy2LlOUyGtTqoRu5miQfW6foqe90mSDc
	0BZc8buUtV7gZPqAkPivxyIWaZtS1mRwTGRGVz7C8J3O5094C5zTndGXqLLQ=
X-Received: by 2002:a17:902:db12:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2dd6c6eb73emr53965965ad.11.1789393068068;
        Mon, 14 Sep 2026 06:37:48 -0700 (PDT)
X-Received: by 2002:a17:902:db12:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2dd6c6eb73emr53965255ad.11.1789393067452;
        Mon, 14 Sep 2026 06:37:47 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd8c84sm49132685ad.62.2026.09.14.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:37:47 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] virtio_blk: Add control virtqueue support
Date: Mon, 14 Sep 2026 06:37:20 -0700
Message-ID: <20260914133733.15429-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
References: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa7f8b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=3eFvK4jGiganB99P3z8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: UUcailei7R5z_zA6IkO6S2KxHwtm4OAg
X-Proofpoint-ORIG-GUID: UUcailei7R5z_zA6IkO6S2KxHwtm4OAg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX+r61U+9gLX4d
 EJAJA08f+8q3kHVzMxBfAeclFZWzFHZMGxdulBdfsmE0KhtAJ7il49Aq89mzfJd40NNGs4XpkV7
 IJEMXZfP1OuqMjjXYC4NmvEEzMETTXUEeEj6CU6dexP0GEecKhM8G8SEKVjSlGZ0E+f7ZbHny4e
 lLnfeW1m+WTG+KP9ZJOrOUc/ayin/Ja4epHB0btXIWrTqQRLZdcf/0fXxDEqJodhBaUlllaHUyA
 MRWQJ6qGGmXOlb0pKmt6W3RO99FLbaj1iLm+2UlWEYOmOkl/FTkc/XR0LWuS/9jmGTrneLmrxW3
 2IzPyF/pWTkhyCE2UUjabTfmRtStE/RG/KnKqw8sN5S8gHkgvoyjDrsi9OqZBaV5Oe6eJAEARgS
 6idn0p5xr5NbCsARKyyCDARkMX9JF0I8mJznWljwuJfGPGeGTfBF0NY+paanMOa5kRgIKpd51Gk
 ySEKzpbZtWGJA0hqzYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5NCBTYWx0ZWRfX1rUCZhOqUUIQ
 MfQosdCffOpkQg+ymgYBU3PRPqcikaEY5PRALOr/RiGhjH90bBLGs1hfoAOjLWBBTyMY2a25LuR
 bzR5fWJoVCCWOAXbvloXFD653ryFgfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140194

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add support for the optional virtio-blk control virtqueue.

If control queue feature bit is negociated, this allows the driver
to manage control-queue requests independently from the data path
and to safely handle outstanding requests during device removal
and suspend.

No control command is submitted by this change. The control virtqueue
will be used by a subsequent inline encryption implementation.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/block/virtio_blk.c      | 179 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h |   1 +
 2 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..252ec9366153 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -6,6 +6,7 @@
 #include <linux/hdreg.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/virtio.h>
 #include <linux/virtio_blk.h>
@@ -52,6 +53,15 @@ struct virtio_blk_vq {
 	char name[VQ_NAME_LEN];
 } ____cacheline_aligned_in_smp;
 
+struct virtio_blk_ctrl_vq {
+	struct virtqueue *vq;
+	struct mutex mutex;
+	spinlock_t lock;
+	unsigned int inflight;
+	bool dead;
+	struct completion drained;
+};
+
 struct virtio_blk {
 	/*
 	 * This mutex must be held by anything that may run after
@@ -83,6 +93,9 @@ struct virtio_blk {
 
 	/* For zoned device */
 	unsigned int zone_sectors;
+
+	/* Control virtqueue state. */
+	struct virtio_blk_ctrl_vq ctrl_vq;
 };
 
 struct virtblk_req {
@@ -110,6 +123,12 @@ struct virtblk_req {
 	struct scatterlist sg[];
 };
 
+struct virtblk_ctrl_request {
+	__virtio32 type;
+	u8 status;
+	struct completion compl;
+};
+
 static inline blk_status_t virtblk_result(u8 status)
 {
 	switch (status) {
@@ -863,11 +882,131 @@ static int virtblk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 	return ret;
 }
 
+#define VIRTBLK_CTRL_VQ_DRAIN_TIMEOUT (10 * HZ)
+
+/* Prevent new submissions and wait for in-flight requests to complete. */
+static void virtblk_ctrl_vq_quiesce(struct virtio_blk *vblk)
+{
+	unsigned long flags;
+	bool need_wait;
+
+	if (!vblk->ctrl_vq.vq)
+		return;
+
+	init_completion(&vblk->ctrl_vq.drained);
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	vblk->ctrl_vq.dead = true;
+	need_wait = vblk->ctrl_vq.inflight != 0;
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+
+	if (need_wait &&
+	    !wait_for_completion_timeout(&vblk->ctrl_vq.drained,
+					  VIRTBLK_CTRL_VQ_DRAIN_TIMEOUT))
+		dev_warn(&vblk->vdev->dev,
+			 "timed out waiting for control queue requests to complete\n");
+}
+
+/* Fail requests left in the control queue after reset. */
+static void virtblk_ctrl_vq_drain(struct virtio_blk *vblk)
+{
+	struct virtblk_ctrl_request *creq;
+	unsigned long flags;
+
+	if (!vblk->ctrl_vq.vq)
+		return;
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	while ((creq = virtqueue_detach_unused_buf(vblk->ctrl_vq.vq)) != NULL) {
+		if (WARN_ON_ONCE(!vblk->ctrl_vq.inflight))
+			;
+		else
+			vblk->ctrl_vq.inflight--;
+		creq->status = VIRTIO_BLK_S_IOERR;
+		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+		complete(&creq->compl);
+		spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	}
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+}
+
+static void virtblk_ctrlq_callback(struct virtqueue *vq)
+{
+	struct virtio_blk *vblk = vq->vdev->priv;
+	struct virtblk_ctrl_request *creq;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((creq = virtqueue_get_buf(vq, &len)) != NULL) {
+			bool drained = false;
+
+			if (WARN_ON_ONCE(!vblk->ctrl_vq.inflight)) {
+				/*
+				 * Still complete the request.  Never leave a
+				 * synchronous caller blocked because the accounting
+				 * state was already inconsistent.
+				 */
+				spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+				complete(&creq->compl);
+				spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+				continue;
+			}
+
+			if (--vblk->ctrl_vq.inflight == 0 && vblk->ctrl_vq.dead)
+				drained = true;
+			spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+			if (drained)
+				complete(&vblk->ctrl_vq.drained);
+			complete(&creq->compl);
+			spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+		}
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+}
+
+/* Submit a control-queue request and wait for completion. */
+static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
+				    struct virtblk_ctrl_request *creq,
+				    struct scatterlist *sgs[],
+				    unsigned int out_sgs, unsigned int in_sgs)
+{
+	unsigned long flags;
+	int err;
+
+	mutex_lock(&vblk->ctrl_vq.mutex);
+	init_completion(&creq->compl);
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	if (vblk->ctrl_vq.dead) {
+		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		return -ENODEV;
+	}
+	err = virtqueue_add_sgs(vblk->ctrl_vq.vq, sgs, out_sgs, in_sgs, creq, GFP_ATOMIC);
+	if (!err) {
+		vblk->ctrl_vq.inflight++;
+		virtqueue_kick(vblk->ctrl_vq.vq);
+	}
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+	if (err) {
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		return err;
+	}
+
+	wait_for_completion(&creq->compl);
+	mutex_unlock(&vblk->ctrl_vq.mutex);
+	return 0;
+}
+
 static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
 	ida_free(&vd_index_ida, vblk->index);
+	mutex_destroy(&vblk->ctrl_vq.mutex);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
 }
@@ -965,6 +1104,8 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
+	unsigned short total_vqs;
+	bool has_ctrl_vq;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -993,12 +1134,19 @@ static int init_vq(struct virtio_blk *vblk)
 				vblk->io_queues[HCTX_TYPE_READ],
 				vblk->io_queues[HCTX_TYPE_POLL]);
 
+	/*
+	 * The control vq is appended after the data vqs whenever
+	 * F_CTRL_VQ is negotiated.
+	 */
+	has_ctrl_vq = virtio_has_feature(vdev, VIRTIO_BLK_F_CTRL_VQ);
+	total_vqs = num_vqs + (has_ctrl_vq ? 1 : 0);
+
 	vblk->vqs = kmalloc_objs(*vblk->vqs, num_vqs);
 	if (!vblk->vqs)
 		return -ENOMEM;
 
-	vqs_info = kzalloc_objs(*vqs_info, num_vqs);
-	vqs = kmalloc_objs(*vqs, num_vqs);
+	vqs_info = kzalloc_objs(*vqs_info, total_vqs);
+	vqs = kmalloc_objs(*vqs, total_vqs);
 	if (!vqs_info || !vqs) {
 		err = -ENOMEM;
 		goto out;
@@ -1015,8 +1163,13 @@ static int init_vq(struct virtio_blk *vblk)
 		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
+	if (has_ctrl_vq) {
+		vqs_info[num_vqs].callback = virtblk_ctrlq_callback;
+		vqs_info[num_vqs].name = "control";
+	}
+
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
+	err = virtio_find_vqs(vdev, total_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -1025,6 +1178,9 @@ static int init_vq(struct virtio_blk *vblk)
 		vblk->vqs[i].vq = vqs[i];
 	}
 	vblk->num_vqs = num_vqs;
+	vblk->ctrl_vq.vq = has_ctrl_vq ? vqs[num_vqs] : NULL;
+	vblk->ctrl_vq.dead = false;
+	vblk->ctrl_vq.inflight = 0;
 
 out:
 	kfree(vqs);
@@ -1464,14 +1620,18 @@ static int virtblk_probe(struct virtio_device *vdev)
 	}
 
 	mutex_init(&vblk->vdev_mutex);
+	mutex_init(&vblk->ctrl_vq.mutex);
+	spin_lock_init(&vblk->ctrl_vq.lock);
 
 	vblk->vdev = vdev;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
 
 	err = init_vq(vblk);
-	if (err)
+	if (err) {
+		dev_err(&vdev->dev, "init virt queue failed: err = %d\n", err);
 		goto out_free_vblk;
+	}
 
 	/* Default queue sizing is to fill the ring. */
 	if (!virtblk_queue_depth) {
@@ -1553,6 +1713,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_vq:
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
+	vblk->ctrl_vq.vq = NULL;
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
@@ -1571,16 +1732,21 @@ static void virtblk_remove(struct virtio_device *vdev)
 	del_gendisk(vblk->disk);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
+	virtblk_ctrl_vq_quiesce(vblk);
+
 	mutex_lock(&vblk->vdev_mutex);
 
 	/* Stop all the virtqueues. */
 	virtio_reset_device(vdev);
+	virtblk_ctrl_vq_drain(vblk);
 
 	/* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
 	vblk->vdev = NULL;
 
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
+	vblk->vqs = NULL;
+	vblk->ctrl_vq.vq = NULL;
 
 	mutex_unlock(&vblk->vdev_mutex);
 
@@ -1593,6 +1759,8 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 	struct request_queue *q = vblk->disk->queue;
 	unsigned int memflags;
 
+	virtblk_ctrl_vq_quiesce(vblk);
+
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue_nowait(q);
@@ -1600,6 +1768,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
+	virtblk_ctrl_vq_drain(vblk);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
@@ -1612,6 +1781,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 	 * pointers safely.
 	 */
 	vblk->vqs = NULL;
+	vblk->ctrl_vq.vq = NULL;
 
 	return 0;
 }
@@ -1672,6 +1842,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
+	VIRTIO_BLK_F_CTRL_VQ,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a..0a16972a1535 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -42,6 +42,7 @@
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
+#define VIRTIO_BLK_F_CTRL_VQ			22	/* Control queue */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
-- 
2.34.1

