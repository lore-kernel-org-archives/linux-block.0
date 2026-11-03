Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701959;
	b=VQ/R7f77spFRPBOJi9IxAPPjhJeRJPkigg7mvyMzhl5d1efbKPO9NBgtiQfcwTcSIgMV
	 stkVMXrH1qtVNBT7JbxeIa1SYzzfZuMXNbiMtAA6cEo8vgmQf6VX808HstTVSHdF4cfQY
	 mV2kaLgIyY6IV1s26+7Bnhh/T2X/pTZQCzSYyZpOsuYMovyJD4HuNzNYHhUWQDODm632o
	 T2gip/yCIZpgR+Sk9nToubEdh2+dhU1pOz5uTIx3Wm27gFWnPZWzp9PT+GAAx03yP5BNB
	 ordPbh8Cr9r5TwKqsUTCpURMROK1wFLAV/Z4TY4vQ0fzI7OAgFVE7IdKidb4WFttKFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
	b=UsRM90OXR8v3Vjk5kCydHfVeiTRCpmm/+5Unksw2oG2uwPXR7e3h7PUTBMSq9pdTowxF
	 KrUAQaX4bWfoJLjax4sy81WlzU2Qmb3scmHUnhzhbM+5Lc6wB2uUdN83oU8EnvPt19nGV
	 S2qoO2xyQ+zj7ItzvnwuBVCrTcse+8Tp80Y0bvdqBfCl8XW82inyjxnwTXGT0n/jn5d6H
	 DPHHEBwYKEXafgqCQKl709L0fWTdSP64ZKCcfQxFHD9UeR7fVJ1rtI2X+RDtVT7ejCRWj
	 SxhW44Bf6zkeC/ryWPxp1UPofqBSADumFmVE6k8RU8hZjtQ3P1sZHvaweLdlyUzdHnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="oUoSKOU/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hb2xmngy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E73606A833
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E73606A833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oUoSKOU/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hb2xmngy
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAHAF2522092
	for <linux-block@vger.kernel.org>; Tue, 3 Nov 2026 10:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9OTHugQliWNMFHV9r9MfN3
	kHQpTez4X3FtLgUfekNy4=; b=oUoSKOU/WSY8TyBJ7fYAgtZ2ukVbmoEFhacU/E
	pFUbBsoA0DUyxE2U7gz6X9Uz/XUlt3MtOEIN5Z5KZWYjWq+FCNx94Lt5JwbFqFDf
	+vpHiQ+FtlrT4kBi52kyFiIx/IHtXXuquhpalp5tzk55E0J22GMxhYQbNMeC//Uq
	F47yyh2MQrOv92J+g0PrwkbXwbBVDAu8qR0cpJaZG7va3P3jqDL/M8QJ857S4foS
	6Lnzkbf5iAAfgtfv9GKxKFyC/+FKvSDp3Adk/qg6A21MGXyA7ka+a/aeyrNzcLq2
	xQRuDDSs8dZUxLdcOwEVCGmsPGxPMEkLLreWgkMQ/dNCcOBA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5j7sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 10:32:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so3544245a91.3
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793701957; x=1794306757; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
        b=Hb2xmngyhlLSIVdAk6SLafRLebLIo4wfzrKXn6/RQJTRXODvaQWhTybUalRBhqzjzv
         OIZeroiz+VRs/Nf0tNdQXzXjyUHBEgEHJPDMixp8Lg4HKhGVAlX3jfW63T1CmDnznT+3
         VvzNFp43+grWZ/OiTRfW00K3W6bTAGoLXCHL8dqC94zGHRO2kD/Ui3XWDG2fvJAE4513
         GK+ugQBxl+j3Vj+hNmgKQ5AZ28aWK2YBQDh81yxdNdETgRa25fc52SvrlsfrESi3WLpo
         rTCKH/H3mRPhJUmBKJ3OzwY9LoSdno/xfNaMbIiDRRvFAnG2ykcIhhs+IEHLiYH1c2QT
         ROsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701957; x=1794306757;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
        b=psnicAuNS+3fwOi6kO4fS+zd64bcvL3pj82JQkDLRdkPBAsYcbD937qON7BE1rFEwt
         QrA+gSW2Ct0XDjjBGjv5kM/mn0rKdJ25uHTzeXBKSRGf8ShBi/ovL9iYQKCUYPFRngL5
         3KVcrSVVW/+f59sjdkSqvAGXA5LmgGXSRGVhwlkrr9qxZQoQMBZz4r0X80r8MhX7b08V
         LpB5c2hku8oQckC3P4uRcOLYN2ze3Vt+8BEX5ePh7ls+jdUuZlV3k1qDrR3htPpAj+oy
         udjxs9gsZ4Ml8//Jfrekc8NpiHiojFABj46S6f1UAQHxj351QgCREZ8Vd9HLiHJd3er8
         gFWg==
X-Forwarded-Encrypted: i=1; AKwUvBwZinmdL+9VsYNvgcWCSy3jzqKfBZO7XBudlbvnvwHe94212oElbIfbHFJfep7cmxShtm/hh8HxA46NYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z//ERjacEv1JZtjxRB+MlGxOiQTN8WEUyYwqeYfLrfmfRv/jNmA
	75/hrg4gO0hU+O3Y8V78631i/RAm1fDgOXRjpbi7QdtxN9cYo1Z1ncqKFG4JaLHgdpUlZo8xqLf
	hq3C6XzHvO25Uep0xAWHU/8aipY+KT3DJebqO4CDzodMQCmirzzA5wNgAQSPfQRqhhw==
X-Gm-Gg: AYBFou1qL2pbnSyktmoJgnp203LojBU9B4u6srSQmCulBJjZXM1yXWBdrwplM/nnjlg
	9pkvXXalgFCfjXuW9MOT87aqtGIOjWN8Mpprz25Bg/5sk7ijTXBzcxcr2X9DrJB+GEUe4l3VYr9
	+AYThGgeWPfnUmNSuqO2WMjzc9KM/Gav4NhQftTOT9sCQMNhO2VTOYQkcxRgnnTl+jmBYE3flRw
	mnLBGefgfCu3zAfQHWzv/DIF2iERBkw/WuxWwsPvUsSmJQ3HJJr73mhfm5gnq24Q+J4IQOgGYZZ
	iT4wNPPVmqZZvWkkVk+AaoMTczYhS4czfDNmZcV68hWeMCsGH+XaOqNEWQz8EnwkLyZSQ9ARHsU
	UvpKMPp/dqCcMdQnAdsMogS/y/XrPqqCXWZaowChyL+LGyGnuBB301IsyYQ3284JrugWZOJoQLi
	nU
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9604452a91.6.1793701957182;
        Tue, 03 Nov 2026 02:32:37 -0800 (PST)
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9604430a91.6.1793701956680;
        Tue, 03 Nov 2026 02:32:36 -0800 (PST)
Received: from congzhan02.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm3740814a91.8.2026.11.03.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:32:36 -0800 (PST)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 18:32:21 +0800
Subject: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-38bf1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793701952; l=2531;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=GA7vQS8Tiz0/LgX66p7Nd9+W/EfJ3aiCYcUb5tpLGpQ=;
 b=LbXB6Q5QCzunltowh2X7OUgrJOoa7ZCDRcYJximUm767xh12vRbVj9yQba6diwAiYryTaRG+W
 eTQIzHhKcO8DAINJrvgq0uE8bVDzdsSuasQJVRd2EDSj9cg1dYIik2U
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Proofpoint-ORIG-GUID: FaLmbteFrR9pKoE9UocFqZx8kEyvdJeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MSBTYWx0ZWRfX9Y+AidGU/2Tv
 cWffaTYJEGQb7K1uczYQanUyaotNkf9i/LsOUP5S3OjMphRu1bMFdWpaOAX8s4s/r/DmAY72mCn
 vR6JZ2gGwfkyWMs5ocYzFc2cTXNwhKWqh9XUBaYdY9o9yA46RLdpa7eUo8FosUKuLNFJ65Sv5eo
 o4hlokKFXrEvjJmT/2yfll4VfzKNC0vXPCa6waTaG/ElxzG+0GZq4iEKpo4mksMmo7pDWgbPwiA
 3sWFPHU3VMh7FQwLewIfIYTrcTC5DotIrYkHCUrzyuRs8Jbgxb8z9Z3zya9bDnuCBBbA3eIWjYr
 agLlTaQJPkLgHScMyUCyGg5viO7PvSwKVZMNtvifLrNp5iM1pqgyJFNJlcJxM5fpzwHIXD6Dh77
 QYhfo2IwC+8OOY7RW2gxziOAx+2/EAskleQirdL0/EtzaiTbICWFMcFhKvcBdLNYSPYr0b8hTtG
 LafkZ224GEJPZysgedQ==
X-Proofpoint-GUID: FaLmbteFrR9pKoE9UocFqZx8kEyvdJeH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MSBTYWx0ZWRfXzzIAyFXWX225
 fJFL3WaibA/i8viHRSQtTe7goB7ga4pUw0mI6KPFgEFtupsWLF701Gy4ijka+gq0KgSdovIjOAy
 K1zhPE+1GR7JEAscVjVFjD24+45bt84=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9b845 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=kkXLOB11zRU5SlhL2XgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030041

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

Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
that was already running. Keep the existing freeze and unfreeze order.
The queue remains quiesced until virtblk_restore_priv() calls
blk_mq_unquiesce_queue().

Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
Cc: stable@vger.kernel.org
Acked-by: Jason Wang <jasowangio@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
Changes in v3:
- Move the race description into the commit log.
- Remove the blank line between tags.
- Add Cc: stable@vger.kernel.org to the commit trailers.
- Link to v2: https://lore.kernel.org/20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com

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
-- 
Cong Zhang <cong.zhang@oss.qualcomm.com>

