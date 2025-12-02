Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5503274646
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764647797; cv=none; b=m6yiby9cML//jVkQ5cNDP9URUY2ElxMuJE2/0eM6NwQrIelwbzQ33pVrIcHfsA/la7McQR/5oe9LFXBVfvPSISlVtSWhemnj3WiRlyWDRpruLmAIu99kKz1nYjOsK1qFJ5bzvSehWSq4T1ImYhn4EUcPLdBQrEMogstJOGfoqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764647797; c=relaxed/simple;
	bh=7BpXbyKRd+fOGVdpYDjiUNA/8UljaPPFKtYj34FWThs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TXivgglthjyRnLBrOdYgyugMFOi2eNLpT7rHJqeDXSZUcvT5unRG6SeQVCSbo3UcAyhBWhv7s75tRFgnT8efO9pYr2augVcPNPS0h4uDOPtfD7nXEM23fpuTd8Kk/VP4k3WQaT/OCtTQ6BMy5oP5i85lZ1p2YnoJDrP8n5Wkk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QmJFZoRu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcCV8dbT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QmJFZoRu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcCV8dbT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1MncPh1906161
	for <linux-block@vger.kernel.org>; Tue, 2 Dec 2025 03:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iA7Ll5fL6RccD4MPrygDJC
	gv5QsTGkbfv/zUaUvzApU=; b=QmJFZoRuN67FvVS8Eg/mQfySc0Pc7xlbW3GJpn
	A7FovVtSZ3IlhUDzRMrQy1SbZNxmYjsevcipTbsDRibJl6Mfu5esVXIDsvbrLizp
	2hxVb3mUuqc9HdtG4dg4cvU7eewsf4anqcPjYRIPQH4SSaLshgFMgc7webqmiLtv
	k1Udljr9Z4RqVaYzVTJPxMOnGNTB6N0xYAoSpWnkUP0a+ueEvjwVwFzfAZkbEpig
	hydPadje3lzue02JKpOsdSYoALmDWx1Kk4gGR6t56iW/3ZYDkoheA4gfmGWgsmwP
	49pkLoiMPghr/kQ5CLxtT0p1dEpgPGhF1F077VJDnEVSfpXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asm5e0pk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 03:56:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e66542afso134809565ad.3
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 19:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764647792; x=1765252592; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iA7Ll5fL6RccD4MPrygDJCgv5QsTGkbfv/zUaUvzApU=;
        b=dcCV8dbTeso+LrdFdKkgHfQTKSWvRZgqLEAAvq54DfivzzT9q4HKjEZs4vtcUtlk23
         v+HmRx8YePWfI433RBOb0ntdeLFMVrsP9D/5Dyp/WZ8Rm4phngOsbTBP/J8mIqvWOOV/
         B0vSpFQ4Jr/inoGbq394OAAZvYsIaHvGFZTnUFU4JL2DxmRE7vxI9PiuAX6ZZ9+I/LxK
         TBakXtQX2tAbk7LJJ55JwwleWzinjXS+sh58yNp4iOIayFNsPqua8gf0rp4gDxP8xgRH
         nJ/UEBQtqK1WRIsjFUG/1+JWVk0EQdMOAFSZrL/FbpCf+NPf6B9ADIyeyJCjOu09hPUd
         4DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764647792; x=1765252592;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA7Ll5fL6RccD4MPrygDJCgv5QsTGkbfv/zUaUvzApU=;
        b=V2rfExW+OQ9XGJavRS32t8UAdW4zvwK8+UFp2hC/dFfsNE6b0vPP+TNIZqS4CkFOPm
         X1Wpg2AMV+Z8r8P8hP9gPakeR1BnwHrYcJFVuw/jjsCsbNBRaLvAYhYv9mcghoT+WYu0
         nIA4D658ozhMdNu2+FjKm52rgkT8oFhO659t7/iLg8HBYr+apUw6kybsStAAVnw8BHxa
         qZQ14AiTrNLfF1ZgmlTCc9kUb4vAnDPKhHL+fLOdGdKnLswAYcp0dg4D8lzwXvnLZNov
         eXOtza9n2byFbVV+BIstp+0oSuUpo3vf/ayqiZmwiVY4fbHJ0AMtVGiC4xvNjeClWylN
         yO7A==
X-Forwarded-Encrypted: i=1; AJvYcCVxjDGlyZP+0TPCtWAfJdsIxKy20DvWCsJ6jGd8z211TV6DjiSqO/zPVWsw0fUp7WDHHCLWR1jbXV2r+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQAbYnVKxj8B7EfSiI1oz6RIpbA3vZfd6N1aIKrjlUFn63ZfQ
	ePpj7KRojk1fuRcMYAxULtdO3ASuVRfx7kgp5Yyi3a7IjYjx8MLikwHPrtHH8qpeGQL7TZem36V
	CBMHqvmxvSmbRMM2SleiI9JzCAMTTgjoa6Y7n7DT/uew/Mx0SZfNOPgRs6XCoezfk4Q==
X-Gm-Gg: ASbGncuzDHq/YKQGQBj2tMsa/JIsN75rir6dQYqBoetEelrD95+bFEHx0Bgi3zcuE9U
	5DjxYxyuWQ1LzEK93V8SrvPqlxN4XUBbdhUYh8DXEXpsL6dg/Qp5F3VzsIO6sAXSCtdYLDCWnn2
	JSpbQ1UEGQnMUVO6gXpMTf5q57UY6gtMDQUwRwMm51lBPT/PKjsH5J0AdGFm33bWgxzwYWUcmg9
	6SXj4ZzPXAlDdiQCXVyCdulKmDRCt+ugWQIxsu3R4+D9LSUQKyFidFPi4P2NUmk/S+dzczbEaDH
	jG+O5XWMpGILQ36RhHdEZzoHWZiQTULynGf95j9GPEB1U8/Nqb+m37by2k7JER8D7jFekU5Y8j9
	v4NMZkWIBF9+9hCnWYCc1W3yZx0Z1UdDDWAikaeQPQLBFJnrfCYvwm3eJaQ1/diNExKBBPzObWY
	hMvgo=
X-Received: by 2002:a17:902:f70c:b0:298:6a9b:238b with SMTP id d9443c01a7336-29bab1d74ddmr290667585ad.51.1764647792545;
        Mon, 01 Dec 2025 19:56:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDdOVl+2Adomyo/VOpvbYnIsL+nbtbQvIhcGoKQDuUfpegZ0WU90gc/cg59MA2GVH+MEGimQ==
X-Received: by 2002:a17:902:f70c:b0:298:6a9b:238b with SMTP id d9443c01a7336-29bab1d74ddmr290667455ad.51.1764647792137;
        Mon, 01 Dec 2025 19:56:32 -0800 (PST)
Received: from congzhan02.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab8csm135932565ad.9.2025.12.01.19.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 19:56:31 -0800 (PST)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 11:56:12 +0800
Subject: [PATCH] blk-mq: Abort suspend when wakeup events are pending
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-blkmq_skip_waiting-v1-1-f73d8a977ce0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFxjLmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyML3aSc7NzC+OLszIL48sTMksy8dF1zY6OUxCRL08TklCQloMaCotS
 0zAqwodGxtbUAaNT2T2QAAAA=
X-Change-ID: 20251128-blkmq_skip_waiting-732dab95acdb
To: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavan.kondeti@oss.qualcomm.com,
        Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764647789; l=3095;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=7BpXbyKRd+fOGVdpYDjiUNA/8UljaPPFKtYj34FWThs=;
 b=JiKoVK4Z25FmSmgnrTPR/T3XmDums+b+p82Oz2wYsB3TQ3HFt+OuH7sz3rBO2gyydC7p3vMho
 o7Tq/5oZ8G2CgH0RpkHOz0IkHGWpmjG/YhLiy3rd2dRIs/JNn+OwM/Z
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDAyOCBTYWx0ZWRfXzapzzZZJPnb7
 kk/hFnRIux82I/3Zu6b641UVPKOGnV2kcaU7eKPmYkkuzTM/d9vcbXCfyjaMFsa6yeh6EFtxBrC
 6sRjdss4kc6p+fUVGA9rkIvnwAXOymcydkzxYxlsyXsRw7VWckCed3iORqAJYXoZABlr7gpu5WO
 ed3esjcSMrPe4uhtfKk/HHxozLyfQdiFxcWyxCpWomkrUiQ2wcNeoKCHfQ5V3YuaXRDepnwFJXH
 EyXf96AKR/jDT3VOjRS83iNFQFjNZyyIoD9AQedaUYzYzSw2sf5jlSgr4aH3zOKGtdSPtZ3I/nO
 2tYvYdory++fdwtNeuKlM5vp8LH+ivLrBXPoJfhMsHIH8s9Z7eG5T9WicJLiFKpw3RJX84s13x5
 D9tLSjoY9gYrQxn9qNzukY5kh9S1pA==
X-Proofpoint-GUID: X-1qNhAzmTLxscorDfH7HY7nK5j8VfUk
X-Proofpoint-ORIG-GUID: X-1qNhAzmTLxscorDfH7HY7nK5j8VfUk
X-Authority-Analysis: v=2.4 cv=bcxmkePB c=1 sm=1 tr=0 ts=692e6371 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NQIyLv43BouIiv1H7qwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020028

During system suspend, wakeup capable IRQs for block device can be
delayed, which can cause blk_mq_hctx_notify_offline() to hang
indefinitely while waiting for pending request to complete.
Skip the request waiting loop and abort suspend when wakeup events are
pending to prevent the deadlock.

Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
The issue was found during system suspend with a no_soft_reset
virtio-blk device. Here is the detailed analysis:
- When system suspend starts and no_soft_reset is enabled, virtio-blk
  does not call its suspend callback.
- Some requests are dispatched and queued. After sending the virtqueue
  notifier, the kernel waits for an IRQ to complete the request.
- The virtio-blk IRQ is wakeup-capable. When the IRQ is triggered, it
  remains pending because the device is in the suspend process.
- While checking blk_mq_hctx_has_requests(), it detects that there are
  still pending requests.
- Since there is no way to complete these requests, the kernel gets
  stuck in the CPU hotplug thread.

We believe this could be a common issue. If the kernel enters the
blk_mq_hctx_has_requests() loop during suspend, wakeup-capable IRQs
cannot be processed, which can lead to a deadlock in this scenario.
This also improves the latency for wakup-capable IRQs. If a non-block
wakeup IRQ is pending, suspend is going to be abort anyway after this
step. Returning early avoids unnecessary delay and improve the suspend
latency.
---
 block/blk-mq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e576f95bc68495c467a9d9c7b73a581..0cf83c2d406609181d430df163cdf2e6ef4f7c18 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -23,6 +23,7 @@
 #include <linux/cache.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
+#include <linux/suspend.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
@@ -3707,6 +3708,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 {
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
+	int ret = 0;
 
 	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
 		return 0;
@@ -3727,12 +3729,18 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	 * frozen and there are no requests.
 	 */
 	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
-		while (blk_mq_hctx_has_requests(hctx))
+		while (blk_mq_hctx_has_requests(hctx)) {
+			if (pm_wakeup_pending()) {
+				clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+				ret = -EBUSY;
+				break;
+			}
 			msleep(5);
+		}
 		percpu_ref_put(&hctx->queue->q_usage_counter);
 	}
 
-	return 0;
+	return ret;
 }
 
 /*

---
base-commit: e538109ac71d801d26776af5f3c54f548296c29c
change-id: 20251128-blkmq_skip_waiting-732dab95acdb

Best regards,
-- 
Cong Zhang <cong.zhang@oss.qualcomm.com>

