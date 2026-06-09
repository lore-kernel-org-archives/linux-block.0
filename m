Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16533EAC86
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991599; cv=none; b=K/25xCaTC7QfaAU2qTYQWHTqw296XhfBo7z1/klC88LDB48NxFCrPmeRYz07NEKdg4lhk9kuiuS/iEyPivW9CO17UW+PYISwJJ1RmD5l5sFLo0nCFRNWlP11BJYCwPteW+sCiP9VPb5s4TkgKR44OPAtSamYOydL1hNKj/Xmzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991599; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAK2VCECVAy+QRyHqYgESSZUmKW2zs/sAw7/zzIpwWTFja6nVDG7lnUmT8J5s5U18GrFeKhe+/oEcMkrehJbIw0VdpMpDuqEdOWT782piSXCXR6ZJ0gsE39rY8J2cMOyZmHxSgy/l+wvTNWWWtgtVPiAwRe9P2pk3fV0hAtIGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqtE24s7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ty8fvoxX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqtE24s7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ty8fvoxX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596xeDS1878367
	for <linux-block@vger.kernel.org>; Tue, 9 Jun 2026 07:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=SqtE24s7100dyZVA
	kTClwnOzW+aY/y+IrQvA5ZuVMmk1ZOt1sngQs7WnSevZ3aqCRg5Cihoa/loxIg+u
	t3Ru/iPPVx61+14JjwffwlWZ+cKt5bOzhddi9aByGOfrSA0sc0Ie9aB3VDpvhKaF
	AiDEm4eplPJ+c0qRUnpRGz7DnmIl7lhYgv1Z7+QcMGgR0aJIlUINw7yrp+76RSlN
	4zeRYaz0U+6sWsAMDijaGiT5YVm8P30VNOGvyfJN6I+uHpugUFRyJSsROI6vKP6h
	qWd4kKHfEXmpsaq18yY1I0kyTytX5hjNTIlTvzqqQhk/0DASXo4/pgwokj0YDOKn
	7WZBDQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25r720-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 07:53:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51760f997fdso160836971cf.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991596; x=1781596396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=Ty8fvoxX3z9+aGVH7nrS5wdzT/sN4UXtzTsyATMGtOik0OSqGOAJibNhzJwWtdqUWK
         HL1FHKzInEaiIJzbjLJICVCb2x9BiPUmINBFHma/p+XfbLH54XUbC5sJP7K3FJxafVNq
         VNA7jU7jsxRcyiKAeuSVCwuBWcU5ONC+fuGN62nf67r4XHhjkXQ4Ty64K97X0Tjraic9
         NGTNjfnaAhTwAw2bbbD5Ph0e7H1VvEHkDKiTen6IXXP8GHekK3XbVX7m3qK1VMfLBPXq
         YKuvIsBq96gHmC2hqDxym83+E8A1qJ3MvyYE0w5kOVj0BleecEszd5XsN624lmJTbSQ+
         YZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991596; x=1781596396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=SFsvwJyioTly9t9z6Oa8RfBDlNRHY+OIXCVMd9T2uJL0SNUf7lQRLHkTkM92pwXqzk
         sQD0eiRAybJD08rNfMCKYNEqE879N70NIsQge9M9Yf17IhTx/g+DpR1bftCMTPsqScNo
         pV/bJ4MUO2+OCXLbNiR6dAc0GgkjtiYkLmb5fCXquxV80P2LDN8Vqe69DttDNQaOw7Rs
         v3JPCbQyYR9deswopZHp0KfnQNsiqUwFkDGjRD95EK7t2QrtrSTT3fq2SjAJuqu6XJDh
         zS0cS3ctKFrpc9KgYeqyCKT++vZS5Dncq0+Rf5qYkn6hwb9dIPs7n7JNPgmNga3XsUuX
         hWsA==
X-Forwarded-Encrypted: i=1; AFNElJ9ArkrHWj+Kaz8ut0X0lqe6G96TlfcUWUkQHoUJIXDzpO2eCk6zvyfnH8bf6SGMn/xGeJ+C9n3TvrgOfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ViYtajXa4pS3WHYjacG5ZEs59+/ZIpzS0xr84uRk5z0Gwzam
	jZCNtwJO7NloTDR9L1Vd63KB1SnO2RTpwfpdfTwDLhb6duA2no+ZOmuw3oU/5gcpjm0YgNU4Tkm
	PgVerNyG2CxbzoH9EiYhSE9DyGIthq3QuOTqh78Y+wtKtLIDH19IYIVykbJMjxJZWsg==
X-Gm-Gg: Acq92OHOZ82PYtLnwzDCPRUs5D09H/2lA8FZ/HEk5San6uPGpNESSOGucc8VfNs3HgD
	DtRXuoF6MbHBRz6yhVKz+hfWIK/942czGJ5gtg+bd90usYbOv2J1EZwRWMxcVv6/YeDB+WJTAXh
	LjCqLeqXKbooa12Gby1b2HOpanvecFLQhZoo3zRBUL+VxRzb+jUFfRCY5kB3PGfiujFLaBJv39H
	/QJYeT+KeIfdI33BDKnBdgONYqADYosh8+cc7sVIRjQJPNlj51B5cbgQqk9wrTSEU5UZoQzIjI3
	lzxD3ETJ+iL+ADSPr9o9tjnE5RQi+JIBXC9ygriRxgZO0V8Vc/DAz5UZx7/SL2EePJcQfZUiDnO
	LdAE9k86/P5BjQFcLJtYHIfUEGJa5ThBLoU9UwCwlv7l/1wiZJEe14eATyyf3CV/lRe/J0NCArw
	W10+CIdHOTkTVfqbFFvWS6unULX7fdyL6OgaXFyDQxiVGr0qebLuLsUuj/du5a6p5eMq38mO665
	AjgaKKt+Uc8
X-Received: by 2002:ac8:5852:0:b0:517:599d:ce19 with SMTP id d75a77b69052e-51795cb7901mr276093681cf.48.1780991596100;
        Tue, 09 Jun 2026 00:53:16 -0700 (PDT)
X-Received: by 2002:ac8:5852:0:b0:517:599d:ce19 with SMTP id d75a77b69052e-51795cb7901mr276093471cf.48.1780991595695;
        Tue, 09 Jun 2026 00:53:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:26 +0200
Subject: [PATCH v4 1/8] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-1-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: yt7qM2jlPop4QLnV_4LtC629Z7ugSIKa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX5oiFUEJiN7Jb
 3Gvz/vV+KPlf1Xhh4me24nENB8c26ygWvxBIFXwy9lzcxjqY/4VQ7pZzdi9+WlhD8BZ8JygymWw
 JFxx8DvMMHJuwDlEjKv5vAMipYmSKTkyRlKkj+KTAxoQz9NKbI0ros1e84tVCRB8ZNTcRbIghWH
 v60qUoIITQAjMloCpz4RQ9PCgEUXN11gOQQ4BiDO0pLxmn6bDjTT0Wpep8JxnRBIG5RLSQ+Xbpm
 6JcXS1g0F1ellHM0c6ruSMEMBnsJqB/5hiQTWv8EUqBDCjWLd/0WHVHhGDXvdnZrVSqm+z4TfhC
 mG9lZDo8M/scdKZrGkqWzvwu0uKTY/ae0Zgi8QicJcxVoQt7t7HXJ52kUz1g4poSZ8aK7X+6olO
 30BZVaIycYf0Cb43fnYNLRrvPAnWwzz1DYrveep/we6+6HmPREuYPH+enFnnfuu9/fvKfoMnbge
 RRdm2mCJc4qixxSlaSA==
X-Proofpoint-GUID: yt7qM2jlPop4QLnV_4LtC629Z7ugSIKa
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27c66c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..ca907ad73095925b234b119948f94ae81e698c86 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -40,6 +40,9 @@ patternProperties:
         contains:
           const: fixed-partitions
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 required:
   - compatible
   - reg
@@ -86,6 +89,32 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    mac-addr@4400 {
+                        compatible = "mac-base";
+                        reg = <0x4400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+
+                    bd-addr@5400 {
+                        compatible = "mac-base";
+                        reg = <0x5400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1

