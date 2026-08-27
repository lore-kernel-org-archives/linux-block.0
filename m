Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5848BD35
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846915; cv=none; b=NkUi6WdLtPdZJJnO6wOQED+JJJpPVQr2ScRA6qCC5YvFIaOcnwFGIjp7EPBeQIK+c4R6ipQS4xOZlNILNgBeTj86XerzrfjA6SSkXdk1iFffl1F6fHOuq6vE0KD4Q4xd2GJYYb3+A8IlWcbNfKHXnKaYjfCECrA7wrQ1ovNbCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846915; c=relaxed/simple;
	bh=Ro1Tw7bimijLX+zSbVZzcIcnTuF4NWioN9yBfIv7fvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7b+11/ryVncGVgjo4sbBVpNPfVLgcH7JcahvdvpRafzoDlCrvJrQ7JJLe7WdFsvF/33UVuiFYYdiXOcE69LtPW/KZMiz/+Hh+2dz76zcvP9PgG22yThJOgC+dp/wI1BuJPUKP2X9QTTR3R+ycPqpUK2fbXeQTdDCOBJ0gQPWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c2BXcxZ5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YwnJeKO2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c2BXcxZ5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YwnJeKO2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbrtc618146
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=szEkNwgY771
	Xv6m8T3J/mh1f/ayBeeTB35yTWk5lZdE=; b=c2BXcxZ5dH6V7p/j2Ymmx/kbwuk
	5ypm5J+Gy/Xe/Rzmh16ripn5C4xaaNvcWhKVxilUrwSyL8ZaX1EONIWOJxKjHI6C
	9r8+zMkdIft7vyYF67XPAqAb/fze38RxCGxangfO7+n4KFZc/us+ZyuwC1j8Pr3q
	nXuWhE9t3ykQ9oKvWijc/LsP+z+xEZF0jnxEn6d6IoUsbP/bqvHFOuCzr7iOGEzf
	VCs/kF+aS58KXOsQVJPfBiAwXVM6ag2XRg296GLNCNw+hk8XAYYcFSzNfjV+8JVZ
	KwOz7DPYZ1w7iq4y7PTnCS311Urm9TKF4Q9jj4hYpivdxTMopVBqWIF3hQQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egmkv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 16:08:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso158558a91.1
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787846910; x=1788451710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szEkNwgY771Xv6m8T3J/mh1f/ayBeeTB35yTWk5lZdE=;
        b=YwnJeKO2/tETm1YssmAf9TuooyWNueZxp1Euin/EvJkcr3V5Xs00frbqR/HUafhpsR
         eN+sfQu3vXfq3oDcqTmu5aKObZrHfsqjOLbWr2+fP+2ctrl9Q6EQfNI4bVW+9mwqo86u
         9KEnHqd3ndoKfKYaSfAUVR0ekjhqLxODL1hUGbwWCpu64rmILLLv9NHqQK9+DRfCXIml
         l/uBJ1mR6aXlfnxxf5NfGKq3epzIVB0nSp72EsyYQFNenrjr64mzNQZYYKMQESJ7qhhT
         mUJthEbCcqc5YlGie7Sm+IuA05xiMz9RCUJ7d/oAwdpFNpRgy9i4xuRhKA0YOqK2pK2n
         W2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846910; x=1788451710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szEkNwgY771Xv6m8T3J/mh1f/ayBeeTB35yTWk5lZdE=;
        b=Mm6TSZbElghWiE0CTsFl6ogm2LrvXYWZ7YsWiwoVDVd4T/6ChXR6Xs/eKJFvJdd50s
         BhJjXlrou/b8lM1qgriuJupRdm4bBOrPUVaC/N+cv5enRcwI1QmpsYj0jKqgldEYKz36
         +7eQLP7JoYxyceHgPhj6WbYsc2nIwFcXVV6B7PvnEszP12pzeXIzm8m+24CSL03XD2tG
         9P0DvkGc670SI8mxfD9llkAgfPUreRfkqi4Dk8w2065V228ZkBkY5/BgV9J8PVud/eT4
         t4ea8lwOTo899boBCLBuw8I8TBK1EWrpBSZk/eN0DPov750xXT1w0yjrgntjWzM8/ryO
         9VcQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0WoCe+l1ymEAiPn2w1X7s/zfQ57rTPbse7wGouPWBKPjUtl4ifE1660F5TkiFwlfNoKDd1gwlIiYmsA==@vger.kernel.org
X-Gm-Message-State: AFuF++lHe9pvEVUuI37MySYkzI9LnHUpzdHJtu/w+ULA5E3BpYQLIXrf
	NrUQhSXHr+D5f7S/BN0GyQf6oNsC7zrpiYffYFFWZNP1LT0f3OEY7gPCf9UcHgwLaD1Q6mYiQZk
	30Wslfief86uSCrt9zleD811GCCWmlXN1lgqeISRH7vZGIY8MTfFvhIfR+GqhBJG+Ig==
X-Gm-Gg: AR+sD11J9grkK0YnVMQhJihSkjT8gEx4XySYoirSk4NaT132y7Y/hYeuHd9dRV9qc5k
	Ta368q298siQxGjRiGK2t6Q6uB8ocj40Yj0+zDxq+RNC4qgAbFQPNr5xmznDyTSUlntQrYtgwP9
	cPyUm+BT+lnY3SjKoIgGImP6um+YkbVrxKRkPpaybShsIA8CvG9kz6RDIYDtMajV2Ut7hnRINZa
	e752HDv8QJTAqsMZHD28QF7qH8X6HmAuB/sqwNCDgiAjug1rcjlw40AgZZ6upkVcdmxqHT5T9iz
	HsFYvJrDrXEn3Qvl1FJHsz9JQOv1+daQxhFiv8TPTpe4nSeomE7FMR6tDPZGMl3vDwGleZJ2j1y
	mYE8P9tTeV8s5G4gLxThgOr1iSz4GQ4XHewG3ATDOaMw3jq5kcbJl+m9vh3E=
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-396d0e27e11mr634853a91.1.1787846910200;
        Thu, 27 Aug 2026 09:08:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-396d0e27e11mr634645a91.1.1787846909524;
        Thu, 27 Aug 2026 09:08:29 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd9085sm3245892a91.12.2026.08.27.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:08:29 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: ebiggers@kernel.org, axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/11] dt-bindings: soc: qcom: add binding for qcom,crypto-virt
Date: Thu, 27 Aug 2026 09:07:13 -0700
Message-ID: <20260827160806.1295313-5-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GCwkWWIq1RimP23_Va7dCVG-24V99GXn
X-Proofpoint-ORIG-GUID: GCwkWWIq1RimP23_Va7dCVG-24V99GXn
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a9060ff cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=S71HXAmslS2k5ljwlz8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfXx/rBg91trPQg
 Pr8QBbEvUQbii8Xcb3gCtzEgRTAtvzNU4nCQ+476pKYkkOTW2mQIuBwl10+3+Qk6ZAc2Wa4C+Hi
 rdWZ91NWBnfMXU0sdlxr/31ffN/+7Ba16g7Rt7GstRgxyoZ6CMv8Hs2xQyKpMuxPOg9tVQ085P0
 y0U17nHvB7jFCr28rea2OfkgbOQretQcU4x3db4uWSZz/1Zu7Q53Z7GsZNX+B6q53jmQtL9coni
 ntO7NKQkM+tED3wQHcFkWQ5Wq+bKhKRyOav3mOJ0F/ZTlHFTeTj48iBUc621VjqucmCy3wYxqu6
 Q4FQAvnr03Jxp3V56y6rSBa1SbsrOUD75pSw/zd0o/6pXq6VnWliORKgi9h7f/BdI1kye8OMUdw
 6kAbCi2BECLLjiQgcvSsnFOfglcfP5XgYSRwQAzNW2uRa2zqOfXmSdob4m1Z5PGDgv7XD5EdpiN
 EpHNurxYlbAlodnccDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX7/VvwpDTbaov
 gVmQILrrC0xT2hfvJt4RVryzt7LZa4bx8edE5li6lmN526wxrMnVi4e8OjN7F40CwUuA50qSXZk
 DDOXTlQkGnYXLWkZwRLWzcxziGsaq8w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Document the device tree binding for the Qualcomm GVM crypto-virt node,
which provides the wrapped-key buffer size needed by the QCOM_CRYPTO_VIRT
driver to perform hardware-wrapped-key SCM operations backing virtio_blk's
inline crypto layer.

The host does not report this size over virtio, so it is supplied via DT
through the optional qcom,wrapped-key-size property.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 .../bindings/soc/qcom/qcom,crypto-virt.yaml   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
new file mode 100644
index 000000000000..5eb204f29762
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,crypto-virt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM GVM Crypto Virt driver
+
+description: |
+  GVM-side hardware-wrapped-key SCM operations backing virtio_blk's inline
+  crypto layer. The host does not report a wrapped key size over virtio, so
+  it is provided here instead.
+
+maintainers:
+  - Linlin Zhang <linlin.zhang@oss.qualcomm.com>
+
+properties:
+  compatible:
+    const: qcom,crypto-virt
+
+  qcom,wrapped-key-size:
+    description: |
+      Size, in bytes, of the hardware-wrapped key generated/prepared/imported
+      via SCM calls.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 64
+    maximum: 128
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto_virt {
+        compatible = "qcom,crypto-virt";
+        qcom,wrapped-key-size = <100>;
+    };
-- 
2.34.1

