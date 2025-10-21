Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F113A3F7
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044896; cv=none; b=HBd/jPQyz4ndZlZ/CPJwix6QpxCOagltwDe2n2wtCNNu5xIaxKVY/7KsUzsU1jez5WXLNs3PCZDVU960bzsImgABmWWdv4UT3ISw/2GakA7HVxG7T+LklN4fT/6XS7M5wo6r57fLetK9peS901y2KipZ9BKsRB/f5dYBgjQjuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044896; c=relaxed/simple;
	bh=UVetEv7dc6qihnycViKp+IETEpl1ulKaq7ZGfb1R8FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e8oJw4mBW/ZDTUBZOGCbCc8HjK0XoJqPrkFLBUGWux2K/rr7ANRPV/8g33dl9dRHnV4GoeRM2xaflBp+R/AXyvN17HR65561N08NN2w3WbxaLZa+dl9Um4iLPPAk6zhJM0ij37YFb69w0mXJwLsp5wB2nyDlZ+XyscQkDQCo0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ndahmqtw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ndahmqtw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8Pf7R031269
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 11:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3l5wVw7h7ylz9wNIp6CE9w
	dtrkbAP3+wCVWYI2nSXCM=; b=NdahmqtwjblekxRkqHW7183Km/jykVarFC1wrQ
	rpL1OyI+Klk2mm/NzRaGWKp6JbYyH/m/QieGIDJO1BajPmDHg2l2QEkOQ7JIYvt4
	lp5OWtf+SdDkhR6E+khwz3Vfd+wrbFPgZarKjXm6sLJVbcgfFra0f8EomxXrX1xs
	bNVprTcz2gEUo02K1AVOhhytqTtRtsyFJkoAfdaV4sYcvSGH963JSdG5put1dCdr
	Z/zTyOO68MYcW96eqVsKCbf6yDqMBpS3z+SUklBQwVEnelCLhWeoK4u1PHaXKJi2
	IVYdQUuXOCSg09heJCes+dNgU+jDUZ+SNnKOyZGc/RMFeBqg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k8avs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 11:08:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f610f7325so4682455b3a.1
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 04:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044893; x=1761649693;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3l5wVw7h7ylz9wNIp6CE9wdtrkbAP3+wCVWYI2nSXCM=;
        b=pDZvh8f0indyN0uyhfEkCgrHbx05GPhZUWXS7UBR8o75SXb995owiW5U0De1Lpbks+
         glAhH2nNuTKviQtz4zWNfbJmAujjeUn1zmUT98FJi/GvvVwtLFNkfEZnFIPoGAit3dEc
         zkv6cM0KZuVBkm/x6j8UOzw7TOxbUjM7Fpz0oaGfEPYT4bqHQJ+vfC6Y7/LmwYT4Ap70
         2QTIgI2QFRVHMrkXsR2lbyxF8JDrtA0SiRpUuOrXnaA52vqcmHwS8CDN5gcOEDP6jKY9
         XQ4kKP5oxAzYmZ5f283dfKOKzkeSnkd/r37Rjn7IcpcLceqs+z8njVRJacaCIJEkaUDD
         LAtw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Et5BfRkolCGy5BAlOIAqcRrwfyxEuIbq+075szItstJCLOfUvqf2NANMOoalEcZkGHzFWsPAktP2bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJlmo30dyzvV8y0xupRr89SInbEET+i0BxvMingl+peA/LysK
	TIb1kog/jZcSfyeo/ifcjD2EvYGxXhmhmFU6OHwGknB+2sRB6IE7VSv705zZXR+MRDSMdsvNUfd
	Q07W0Ji4aro1OJArHvv/fe+OZhQtVNYvcUzC4oFtTqHUhxgCm/ku1chGDqB3lCO8MFg==
X-Gm-Gg: ASbGnctvezWzQL6CdzeZCD0sMp/3wsx3VmYRTvufvzA1uWZ/Vbqfc6GGiI2unK5gnp9
	k5BpGgA/F56LAwrrsagyPpVgsJHl0gGseovR1rs104nHHJeO4dLj4Iimfgn2nR5/81KQPb/n82W
	HhEdB+dxLojlkQfpysrpRd7cFS6xTEX059BnQuCreQuXb7JHNtZsO8AV0Ev1aX4Sd/5RBR2qPtC
	XzENYUSCgPSjXLzewCyYeti7UOvyXKETSFxDxMLmumWyFMC43MXWCDsHKyGOMM3TnXCx2LXpYbk
	6+Wa8U03mBDMGJOX5nBbzKswgBEu1swKngXxgb3ulPTh1jfN2ut0Iw+q5d2QEBLCtEOm5qPOv1l
	Dtt4K08p5sBPP4oScYjowF8L2WTFo723Wf2XcPAuIDvQXEHUppqQB/Q4k7zzPFFuvtzsn
X-Received: by 2002:a05:6a00:238b:b0:77c:64d8:3afd with SMTP id d2e1a72fcca58-7a220b214b5mr21094115b3a.28.1761044893380;
        Tue, 21 Oct 2025 04:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf15yzlCVmkR3EWNDWylnvBCSoHMHlENggLmfDiluhkXBb7QFn5SPjGtfMYoMRyy8Lh7Ek5w==
X-Received: by 2002:a05:6a00:238b:b0:77c:64d8:3afd with SMTP id d2e1a72fcca58-7a220b214b5mr21094067b3a.28.1761044892936;
        Tue, 21 Oct 2025 04:08:12 -0700 (PDT)
Received: from congzhan02.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm11057337b3a.22.2025.10.21.04.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:08:12 -0700 (PDT)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 19:07:56 +0800
Subject: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAItp92gC/33NwQqDMAyA4VeRnldJ21XrTnuPMaRqnAW1W6tlQ
 3z3VQ87yS6BP5AvC/HoDHpySRbiMBhv7BiDnRJSd3p8IDVNbMKBSyh4RoNxk7FlY+eqx7J1iDT
 XlVLQKK5ZTuLh02Fr3jt6u8fujJ+s++w/Atu2f7nAKFApMXJnUIWEq/U+fc26r+0wpHGQTQ38J
 zFg4lDiURKFLgQILTLUB9K6rl8bkiQoBQEAAA==
X-Change-ID: 20250926-virtio_double_free-7ab880d82a17
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavan.kondeti@oss.qualcomm.com,
        Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761044889; l=1781;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=UVetEv7dc6qihnycViKp+IETEpl1ulKaq7ZGfb1R8FA=;
 b=+2jE96K3P2nEDXz2nqE32h52ySapgBjuDfpmmaxvxcyWPTxgX5cVa+SqtSFX28dIRkmrmz6yb
 Jdz/4pJqCx6ADrZYPgriwtXjoi41c4t2eZrsNiJTuuDbB4J+X2dr/fb
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Proofpoint-GUID: B4Ih4I3qjV-aFTzOkaHSNhGg9a76xDYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX0yjE7TjPF1es
 DsitZMcRO6fdOEaMV4j2FiNAekUuy+taPyQ2pV1ZgIlSEpOGnAFTaOhlONn/G6udCNCT8F5DyIs
 sD6t3BUMkTHxcXhA0e3VToPvgoGasb9xc3bIlXAlK/ZO5Ai3f9bhmihzOcWP5rbhhLOy5o641+t
 yZXufzKRA3+A2uNW1MmjqQ7MASMdDiAezJeIkwjFF8M8aDsxH/OsmxqzBRmEVsJi9WdwXUiQhRg
 lTo0p3JVq9/5kSVA/IE+OltSBBboOu04e3fKxT5kTYQFab7N7ZZ7+uBMwWl6ZYTFgSEPUmvQEPV
 q157gabJ/0BC/VS2THODnEfMuNUMGXpPCbtf7p40YNTbcPVexDxngebz6D7j4AzpYRx4/CcLEqP
 S+AB+1Pz9zSRxw2Qn6jxRSccSWPKdg==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f7699e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=47QlDNkPX5KzPiwYzcgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: B4Ih4I3qjV-aFTzOkaHSNhGg9a76xDYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

The vblk->vqs releases during freeze. If resume fails before vblk->vqs
is allocated, later freeze/remove may attempt to free vqs again.
Set vblk->vqs to NULL after freeing to avoid double free.

Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
The patch fixes a double free issue that occurs in virtio_blk during
freeze/resume.
The issue is caused by:
1. During the first freeze, vblk->vqs is freed but pointer is not set to
   NULL.
2. Virtio block device fails before vblk->vqs is allocated during resume.
3. During the next freeze, vblk->vqs gets freed again, causing the
   double free crash.
---
 drivers/block/virtio_blk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
 out:
 	kfree(vqs);
 	kfree(vqs_info);
-	if (err)
+	if (err) {
 		kfree(vblk->vqs);
+		/*
+		 * Set to NULL to prevent freeing vqs again during freezing.
+		 */
+		vblk->vqs = NULL;
+	}
 	return err;
 }
 
@@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
+	/*
+	 * Set to NULL to prevent freeing vqs again after a failed vqs
+	 * allocation during resume. Note that kfree() already handles NULL
+	 * pointers safely.
+	 */
+	vblk->vqs = NULL;
 
 	return 0;
 }

---
base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
change-id: 20250926-virtio_double_free-7ab880d82a17

Best regards,
-- 
Cong Zhang <cong.zhang@oss.qualcomm.com>

