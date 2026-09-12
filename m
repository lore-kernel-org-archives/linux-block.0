Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B20372691
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203174; cv=none; b=Nmr6Le933LHQD6hxlSQ4WcO/cBIq6qa98RW/kMqKy3UHoXTVMHCW9YzHgGRqRoAQwahKbhggoVl/C4ce4MynQGbUVqc/x0IfQBWD1sjWUmPTxMGeSGGapEMa7eyutzOwOAo4V2D+mYlqNhAkBkE4qJ/y2sNMSxYYOWGVmsYH0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203174; c=relaxed/simple;
	bh=dquZraZjSq1eNM+T01tcQIrz2JYvFIRH7UkrcXngR/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ERQMp4zbbm0j46TYFHwZqVGq+HyouvTxUij9xQRMmM5dRvXvX9+cL5P+3BDH8xFB4OFj/MxbD3zYRJsqHOcAhrelqq0c1P5UvgBLlDURD5R28yU/R3bUPxT79t6U2EMsI7E8n/b/DbhZB6mkkB1vhbeKAPwiROU3pQomSopLTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cAAHydwN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e18SaTpT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAAHydwN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e18SaTpT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C85BY72833070
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 08:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JBHFKISvb5GpVQD3ZIst72
	axNU1WVodRSK6PtMFk5sM=; b=cAAHydwN5dNGUGUMFXpisq/Iq0RO/ru1PTNKhK
	zgjYiDXkNln1quw5I50Sb0gMm+HcficYy3izkgODOkw/NFQtwDGX1JXUJUIWz3Mo
	/Wtf23DYrFhkN87N6yvH+3JCLxQIBjEZ9NQTMydXhjCjkveTbXv7HxuUHO8YoIAQ
	zvuWkUX6hPc1M1/no8didy0oBYmUOSZZFBQZfU65re+5FtB1p3HSWXGcfy6rMANp
	ctPggWEuW9xwZ9MqREqofKCXa+zTGNYOXEYgadusZpCdb2iRvMfNBEklVP6pEqPq
	Gv9PKaEPu83VwK43p0Fce7HgvaylYYroKO7/TOuO5DLUwjxQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgj1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 08:52:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39dc5d85a9cso52943a91.2
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789203171; x=1789807971; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JBHFKISvb5GpVQD3ZIst72axNU1WVodRSK6PtMFk5sM=;
        b=e18SaTpT7w9K4ZnNcaORhoMNCx76gTmRjQv3GXtA5M3MNxNXXsnXnc3RhP5ObMAqnW
         1OJD/XoQ0hiOUCF8ObU0gxA2S4y1sjOEs9OQIn4nfkE7KTvdRwHXAW1XlC3auW8egpgK
         1qp7z+JjE7gLrugInazxiL59UF2nisF725LV2CWsCyLG8OBxfk3Pg6TEyun+SOiasS2F
         vS0+L+uSsBJGNk5QSiRi0yflc6Nl0C03oV3F4CrPbms6+uDmFoje2PASpmd3ky/ZHZLN
         ZwW/sJ7neqmT4uHEo/C+sm3th2/Kaaz/R6OcrBq1p2HE1Z/RCTxoFGXjXJUHpUhukpTp
         jdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203171; x=1789807971;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JBHFKISvb5GpVQD3ZIst72axNU1WVodRSK6PtMFk5sM=;
        b=PcQy2xtjzAJtqKgb7Yynf7YYlUCy7MQ8A8Xln4aBezB9WtVk8z0seIuqBshP8A9IeA
         EyKwhCeueza53EIgTGdQ8uXJYIm/dpJC7Po26Kkd2z0x+40nADqz9y9MTqC/jFg8Gf4f
         0yhBa510N832D1a01WwMc4Db9b37Ol1/RKJQIhfvsaKdPt+YoB0xz0I3rJRYIq3fZ4G+
         ZHrrp12hVW3JC3G7e4p9ry70aXamdN0FuXXZaMC9UeuIgLQ31iyYGLaawcvRpmVg151G
         vSg5fXcVcTMQ9GRxzeIMMTG8U+tQDTQr49GHJK4+N52YXzXmj/sswgVRbGnzxlWo1ZAr
         8VMg==
X-Forwarded-Encrypted: i=1; AKwUvBxrMUwuKRChE5TXMreGKQhmyAMHyMXWKGNjPiu1CkU3HBdqvF9L9Yq+LJlJoLsFN63RmV97MkJ/9yzroA==@vger.kernel.org
X-Gm-Message-State: AFuF++mipLCnPyfHF4PQexICy2MOR8+K2BWjLkA69HQZrTEh5/ixL7Zh
	s23jdT/h6Eai3wVHqJMVErCgLzMUEtRL1yt8X+Ig9K2Shfj75mmNL2USWlIzoj8HVh2hwJeg7ty
	2PMB35lC9FSNltBrYgWrAe9KxeoRSACIgXOUmLnFIp2AUZZzWbR2dcKnLGPJP2Opw5Q==
X-Gm-Gg: AYBFou1uTlewE4pyDskcGtOaJOKFyOdwgWQUE1kE5Ezsry6XKA/OtV451vbHD0UDB6k
	9cGyPA/rjZ14ZgSA2gTEj9tJikePZfsKxDb8nov/gZF45VQgaCq86D7TANM5xrx3BxL8fu8BBy5
	/vH/p/wb5X+z5WVukQouLAsbdZyvM2p0Qc7rOnjSVa4KrAyxmQBY6vE/nX+sZsXGyfDm7BOJ1SF
	ahy/ABqaCg5QFfxKdvndcQDO7sl6wKBYnHkDYLG0lHWbF68WctLWi9vPef4aILF14xfCyqWTi3Q
	qiOA6V15bHOSbAMGFcIRaK7ctbhojhNNF9NzFidhUlTq9MWIRBmW8WjMbTjV39m6MNK2vL2gGs7
	4qDZgpyYcoKhKa8yCFYUiKYHaJuC8ZOPbefYtR6tkCyFFk1CkaRLTkQ1yb83cA2dLrgLy5tA2oQ
	==
X-Received: by 2002:a17:90a:da8f:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39d9bd6976amr12162610a91.9.1789203170747;
        Sat, 12 Sep 2026 01:52:50 -0700 (PDT)
X-Received: by 2002:a17:90a:da8f:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39d9bd6976amr12162576a91.9.1789203170296;
        Sat, 12 Sep 2026 01:52:50 -0700 (PDT)
Received: from congzhan02.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9afa367bsm2721832a91.0.2026.09.12.01.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:52:49 -0700 (PDT)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 16:52:44 +0800
Subject: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANsSpWoC/22Nyw6CMBREf8XctSW0PFJc+R+GEChFrgKVXmgkh
 H+3YNy5meQkM3NWIG1RE1xOK1jtkNAMHsT5BKoth7tmWHsGEYo0zHjIHNqp6p4FLYMqxtlvlWZ
 ZJZSUdZzEPAU/fVnd4Pu4veVfprl6aDXtX3ujRZqMXQ6v43vvp+D/FY4zzkopo0Y2EReJvBqiY
 JzLTpm+D3xAvm3bByMsulHRAAAA
X-Change-ID: 20260910-virtblk_sync_quiesce-9b2c88d45416
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-38bf1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789203166; l=2165;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=dquZraZjSq1eNM+T01tcQIrz2JYvFIRH7UkrcXngR/g=;
 b=0Ru6H5o7DriZH6nGIn+WEPZQ8StS9Rizbxvz8EIwzzUUBVZ0EF77mcdQDEO7uy9EnjUAdZw7+
 t7tYlt2DxODCqquyJaKo7mzhK7StK0v9KpZ9C/U5sLB8hfQCB4cYQMQ
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDEyNSBTYWx0ZWRfX0lt2HP9MjYxE
 63lmslWXFr2f9ma2lKd3OHyxVSXZ58ZXruFNxUD0meAZsLPGzFZ2QqQzdiH+eUzppZPI++mhuk5
 brMfGqrro0y3zdUMVE3ob/Ll7Z6KTPBITIoM4cN8Y3ZiaEsIJISJ2lDLn4IAqxuOK4r6oQmtkKK
 FYQy/AYXiZfdb51Nwm4C/jq624WinzFsvS7AXoUAJ/zKGkeunBCW7aJBh7pttPqhfGwYkL+LZqe
 4Zf5xv1noeLrX1hG43ZNgKPzVyRf3/6Z14ogy3VATSdR+C/l59RLH8D8NSDRgZoaDHxRpWmXNaG
 KxMPltjUTZLb5+BXMZ+d3ueLEaVsQmriyojXwh72SlVyDledkIUA1+fFzjJAJfjW2deWjAYBUaL
 FE1U9DxOTfa/mpBy++rt/GogMF15D6FQPjmrOZ51ckCLhRwTDtunI4UlMih5If7hF229hOYFLWb
 r/xRFWKn+ZVGFxM3TlA==
X-Proofpoint-ORIG-GUID: GVbAGdo6833lNiDZB0V3LW3eEZUtOXUc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDEyNSBTYWx0ZWRfX7qPQuvt7eafl
 NsVcDWI5an30VojJN6pvzU2mG56Msw5sg1WiKDgH53rQFlWpteV0XeMUfxQdQQaMCYz095IXvus
 ZZzC/65GPhA09DNrg231s4jqR/mJ4H0=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa512e3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=roso6HiFfYj01OpyUwUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: GVbAGdo6833lNiDZB0V3LW3eEZUtOXUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120125

Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
virtblk_freeze_priv().

Keep the existing freeze and unfreeze order. The synchronous call waits
for dispatch code that was already running. The queue remains quiesced
until virtblk_restore_priv() calls blk_mq_unquiesce_queue().

Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")

Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
while the flag is clear. It can then be preempted before it gets a
request. At that time, it has no queue usage reference, so
blk_mq_freeze_queue() does not wait for it.

virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
blk_mq_unfreeze_queue(). A new request can enter the queue. The old
dispatcher can run again, use its old flag check, get the new request,
and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
reset the device, delete the virtqueues, and free vblk->vqs. The old
dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
kernel can crash.
---
Changes in v2:
- Cc stable@vger.kernel.org.
- Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..7a570591e040 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	memflags = blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	/* Ensure we don't receive any more interrupts */

---
base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416

Best regards,
--  
Cong Zhang <cong.zhang@oss.qualcomm.com>

