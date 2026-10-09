Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3C3859DC
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519479; cv=none; b=NPrtsyv5o+SbhzwCkESBg+gZYKuFO0w74NB6lk6prheCzP4KI+di32W9mailsuJ1hSzbScvbL62JANz5UzzI8V3NLcf9TaYauN8iywXb06uFdmK1kyqPZlcjH4Ldw427tJ2TJmXaojmJk3mlI8Gg/cwkKXBg0RuEYs2izDj2URk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519479; c=relaxed/simple;
	bh=MwrjLO9ocEkHCKOzW5F5st6I1YEQTq9yIO5viJj9tAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9V32p+mFhINsRbdUhBxpS7rypZ/ocq4iNRCYDqSZqMaN9rQf+GyNqe5WI7u2+gz5o31121TlSrvLH0FUTwV7vR9AY5+qHhSqJf4tL/SA92bLSrKnRASNvpHs0zzYPaN+h1kdtwGKX/ZSFRGRRYfP+D+Z2rkURBKMvZB136eQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oZrICXkW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VDJKOjju; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZrICXkW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VDJKOjju"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993H8MZ3942582
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 04:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9d3VzjhcQcny6UxQSqI2Ryo36ZCHGGG8qlbCADHXZa0=; b=oZrICXkW3pUgJ98s
	2BaGfe1p2HGbPlgFhIp/POX4Bf+UrKR1DQFwOrrAQOHkcWERnMOy2Re51lo5MhUF
	6pesuhAbMb0PjEaTulrNP4IQv7yJdehmxJMLY4KWAg88zdfOVgzb37gpuboaZTXk
	jDYktHfL6/0OiTtKtGSzak+PFXBDLSP+rKR8tT3frqCfKEnFV1i2jEY+bPaxyZ0o
	tgibKWm7BlqCo5YKlMUG3HRjZSMNQcvFTXos4d5/BVIQHtZKbu6Y5LcMyAfxmV/U
	dfoMi74hD3aO5F6y6dMRQ9Bh/aZVD6CSkGGgo9GpRJVsKzTOR+YyoGQsA2+AvDuv
	Znxr4w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk1v0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 04:17:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35158d674e1so2652105eec.1
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791519461; x=1792124261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9d3VzjhcQcny6UxQSqI2Ryo36ZCHGGG8qlbCADHXZa0=;
        b=VDJKOjjuv/rfj5dosWWAqX8gMX7Z3MIDZIqdu8ozEJWgNmSKgDvlE4PA/21zJH/YMn
         uxRewW/qDIyF5em73tvxwn1xU0nZVwqDAAvCEz9E0rYkAIB/ROPd+twJrKdCHxDhoxHW
         BqtkYDYcv7AHOmF4kfC6EhLIHznPZtsgeJ4hUdKqQA8Vsyw7Wu6BeBWWTrtNdaKMdBU8
         ewoeVlXBtW0ofbTVUIEezJ0hvB75oEh9jlv1joWSSpRUSlLWuk7fHvP1EG+5JyFUdVOR
         gpcegrjKyrUPCUeN2E78R7NHO+ingYgc/wCSUqlIpW9RF87IIJxvJV7ZofSY8lzeK8mZ
         Nkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791519461; x=1792124261;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9d3VzjhcQcny6UxQSqI2Ryo36ZCHGGG8qlbCADHXZa0=;
        b=GHc7c/E5c/mHBGHzfdmMXMCG1Y+aNfMGuq76s6xS1o0jPWiidNlDRkNZs2u6DKqhzr
         TU3I/YYCAAX3aqYu59EIcKODsCoi9n5D5Kv0we7qWK4F02U1/wZ1xDFrsV0ExMNzrLIT
         jtdM69HdYrIRi2OVel+e4+sJ+4E21LtyLudanSTwAOoDQ/2xig8sSy4D2VP+DmQjA1F8
         bRZ9qNc8GvSwdoK00bRq6ZvJ9ZNFfbnlwJ5YbvBvw3hLKVOn9vUbyKRWqAtm1j+kSecL
         sTV9HlVGE004C7JfGaIg7FWT19U0NPnR+mss7MBvyHWWrNESqXkUULbfbVYetRPxErzV
         omGw==
X-Forwarded-Encrypted: i=1; AKwUvByzHSD7p/RCWx8zXN6pysDlWNQLeW/fgT+JHNnpYrvUbcGc70T1mUUgYsew+znDN9CEt9P3Wpl9mOZWfA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKDIKglKZmFsSY/UGv4t9GKKWYfEXUdRzq1Q4DVq9+jR3zHWVO9
	c2XireJUH/cdut1TSf/hJKHtF5NEAilya+70+ABDV8sGvviQr6H42tsE34ElV86Y0QJTcaoLqXO
	Ob8wgvRVGxpUbPChZ7zqy2cCDq4V177QkyPRTTluqZmGaxHXUqYmln7E+X2J8v8bJaME3RsBiY5
	j/
X-Gm-Gg: AYBFou3N/b3ZOvm7b2Rea3oLERx5vC55FcwK9ms/sjvB7RLB6y9Dzov5P1X/WQSL5Vr
	6ZmvOaWoH+aZfDQaa6KTfseA7v9rxu7rvnivABgpqsdS2v0phU+C95zM/buN3t9vWZ62UQj8lQR
	Kr7vtGVCV1Vl0E/sj2Lt/w3YuQf5APVCDJ8poHvIIVstBtxzfRqWgYEFAZu/dxSta7JhEXAUOVM
	hjnKtSy53oqmOVlkyfJikQdEYHivx+vEBeDVFBzoC9pGi6u7bhWCLFihByltn2JIUo/kbRWXeox
	lhz7t4qEZH01GinbsC9u8Df9pk/V9RxnDkZ/3H7GAaPOznmvsUJkCEW9wOZ89BFmcCyeAP8Ug/F
	KMDIwO8CNJESWuGD9Kfzd4jvZbUfFhoZIYdupkvbRfWBCByL1Y7dwTsBRFg==
X-Received: by 2002:a05:7301:1806:b0:342:d7a0:2f40 with SMTP id 5a478bee46e88-3537df8cdf4mr1161682eec.7.1791519460912;
        Thu, 08 Oct 2026 21:17:40 -0700 (PDT)
X-Received: by 2002:a05:7301:1806:b0:342:d7a0:2f40 with SMTP id 5a478bee46e88-3537df8cdf4mr1161639eec.7.1791519460097;
        Thu, 08 Oct 2026 21:17:40 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm3530749eec.0.2026.10.08.21.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:17:39 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] virtio_blk: Add control virtqueue support
Date: Thu,  8 Oct 2026 21:17:13 -0700
Message-ID: <20261009041727.3170811-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
References: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac86ae5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=mWMrKjBDJ3x8XhIyD1MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: GKDwGzlAJzo20v1Rvow-in5LiMco-ajb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfX/4XM+1IsYQSl
 kLZfiRwdRI8KC2EryGb1g0Qs6oQ0pe2+q85GQa0SnwXewFaNE9OY6xSmwYOB9JokWFZuCO4hztc
 qIIZppFymCF1aAM2zHQFI8bTdH0RwrE=
X-Proofpoint-ORIG-GUID: GKDwGzlAJzo20v1Rvow-in5LiMco-ajb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxNiBTYWx0ZWRfXzP+/L2byncSz
 Go/Dzrd1pB5WUrmgKv4uGLufXt6qhxbNcqL2CNLfvlxp0dNM3xh55CDh05X1suhNs+PSqQemb5j
 AJrQQn8nH7/4fzdYnGmX6+n/TjvwbSD3BwUZ5JUV+OX8Evz2YanSteHuxf/vJmEi+vQjUm0DLG0
 /yueR9LkW0RwqGn1EGIS5Fx+juOBRroO9eH55pQfkkSXynomU8day7aJDaoEouULWZnQdXcT7Mt
 98D0OsiYIzTgbMYLxUqP6Usi76Bsgxca6VOwl4bhWVdjz443mql0kaz1CRjNegoDDP8hnpvF3di
 1Gnie0+HlyitAKHDJdSfStlBMNnWPoL9seKo/ASnutvGmQT3UnZ/rRdc7XCgK9dInfT/omf0/mu
 ftD1tNtY9ZWFdNk2n7+rnBE2pg89CByDYdYGZ4ma/Nl1cpMBgUIeTZhWqwEAX3rt5QcB3nwDskc
 Vkf7GjTlmBxzNYgnjcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090016

Add support for the optional virtio-blk control virtqueue.

If control queue feature bit is negotiated, this allows the driver
to manage control-queue requests independently from the data path
and to safely handle outstanding requests during device removal
and suspend.

No control command is submitted by this change. The control virtqueue
will be used by a subsequent inline encryption implementation.

Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
---
 drivers/block/virtio_blk.c      | 244 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h |   1 +
 2 files changed, 241 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..6e9729134efa 100644
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
@@ -110,6 +123,27 @@ struct virtblk_req {
 	struct scatterlist sg[];
 };
 
+/*
+ * Software-only completion state for a control-queue request.
+ */
+struct virtblk_ctrl_completion {
+	struct completion done;
+	/*
+	 * Set when virtblk_ctrl_vq_request()'s waiter timed out and moved on
+	 * without freeing this request. Whichever of virtblk_ctrlq_callback()
+	 * or virtblk_ctrl_vq_drain() later retrieves the buffer must free
+	 * this struct and the request instead of calling complete() on it.
+	 */
+	bool abandoned;
+};
+
+struct virtblk_ctrl_request {
+	__virtio32 type;
+	u8 status;
+
+	struct virtblk_ctrl_completion *compl;
+};
+
 static inline blk_status_t virtblk_result(u8 status)
 {
 	switch (status) {
@@ -863,11 +897,181 @@ static int virtblk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 	return ret;
 }
 
+#define VIRTBLK_CTRL_VQ_TIMEOUT (10 * HZ)
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
+					  VIRTBLK_CTRL_VQ_TIMEOUT))
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
+		bool abandoned = creq->compl->abandoned;
+
+		if (!WARN_ON_ONCE(!vblk->ctrl_vq.inflight))
+			vblk->ctrl_vq.inflight--;
+
+		if (abandoned) {
+			kfree(creq->compl);
+			kfree(creq);
+		} else {
+			creq->status = VIRTIO_BLK_S_IOERR;
+			complete(&creq->compl->done);
+		}
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
+			bool abandoned = creq->compl->abandoned;
+
+			/*
+			 * Skip the inflight decrement/drained check when
+			 * inflight was already 0 (a bug, hence WARN_ON_ONCE)
+			 * — but always fall through to resolve @creq below
+			 * regardless.  Never leave a synchronous caller
+			 * blocked because the accounting state was already
+			 * inconsistent.
+			 */
+			if (!WARN_ON_ONCE(!vblk->ctrl_vq.inflight) &&
+			    --vblk->ctrl_vq.inflight == 0 && vblk->ctrl_vq.dead)
+				drained = true;
+
+			/*
+			 * Decide and act on @abandoned without dropping the lock
+			 * to avoid the memory leakage of @creq and its completion
+			 * in the race condition that virtblk_ctrl_vq_request()
+			 * wakes up from the timeout, and the callback resumes at
+			 * the same time.
+			 */
+			if (abandoned) {
+				kfree(creq->compl);
+				kfree(creq);
+			} else {
+				complete(&creq->compl->done);
+			}
+			if (drained)
+				complete(&vblk->ctrl_vq.drained);
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
+	struct virtblk_ctrl_completion *comp;
+	unsigned long flags;
+	int err;
+
+	/*
+	 * GFP_NOIO: this may be reached on the bio-submission path
+	 * (memory reclaim writing back dirty pages to this same device),
+	 * so GFP_KERNEL could self-deadlock.
+	 */
+	comp = kmalloc_obj(*comp, GFP_NOIO);
+	if (!comp)
+		return -ENOMEM;
+	init_completion(&comp->done);
+	comp->abandoned = false;
+
+	mutex_lock(&vblk->ctrl_vq.mutex);
+	creq->compl = comp;
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	if (vblk->ctrl_vq.dead) {
+		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		kfree(comp);
+		creq->compl = NULL;
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
+		kfree(comp);
+		creq->compl = NULL;
+		return err;
+	}
+
+	if (wait_for_completion_timeout(&comp->done, VIRTBLK_CTRL_VQ_TIMEOUT)) {
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		kfree(comp);
+		creq->compl = NULL;
+		return 0;
+	}
+
+	/*
+	 * The host hasn't responded within the timeout. @creq is still
+	 * owned by the device, so don't touch its DMA-target fields or
+	 * free it here. Mark it abandoned and hand ownership of both @creq
+	 * and @comp to whichever of virtblk_ctrlq_callback() or
+	 * virtblk_ctrl_vq_drain() retrieves the buffer later; unlock the
+	 * mutex so subsequent requests aren't serialized behind an
+	 * unresponsive host.
+	 */
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	comp->abandoned = true;
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+	mutex_unlock(&vblk->ctrl_vq.mutex);
+
+	dev_warn(&vblk->vdev->dev,
+		 "control queue request timed out, abandoning\n");
+	return -ETIMEDOUT;
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
@@ -965,6 +1169,8 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
+	unsigned short total_vqs;
+	bool has_ctrl_vq;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -993,12 +1199,19 @@ static int init_vq(struct virtio_blk *vblk)
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
@@ -1015,8 +1228,13 @@ static int init_vq(struct virtio_blk *vblk)
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
 
@@ -1025,6 +1243,9 @@ static int init_vq(struct virtio_blk *vblk)
 		vblk->vqs[i].vq = vqs[i];
 	}
 	vblk->num_vqs = num_vqs;
+	vblk->ctrl_vq.vq = has_ctrl_vq ? vqs[num_vqs] : NULL;
+	vblk->ctrl_vq.dead = false;
+	vblk->ctrl_vq.inflight = 0;
 
 out:
 	kfree(vqs);
@@ -1464,14 +1685,18 @@ static int virtblk_probe(struct virtio_device *vdev)
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
@@ -1553,6 +1778,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_vq:
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
+	vblk->ctrl_vq.vq = NULL;
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
@@ -1571,16 +1797,21 @@ static void virtblk_remove(struct virtio_device *vdev)
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
 
@@ -1598,8 +1829,11 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 	blk_mq_quiesce_queue_nowait(q);
 	blk_mq_unfreeze_queue(q, memflags);
 
+	virtblk_ctrl_vq_quiesce(vblk);
+
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
+	virtblk_ctrl_vq_drain(vblk);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
@@ -1612,6 +1846,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 	 * pointers safely.
 	 */
 	vblk->vqs = NULL;
+	vblk->ctrl_vq.vq = NULL;
 
 	return 0;
 }
@@ -1672,6 +1907,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
+	VIRTIO_BLK_F_CTRL_VQ,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a..1daddd259249 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -42,6 +42,7 @@
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
+#define VIRTIO_BLK_F_CTRL_VQ			20	/* Control queue */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
-- 
2.34.1

