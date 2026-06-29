Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370030EF9B
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723338; cv=none; b=C52rvLVbSPp5c6cKH5/Iw/qVMmNoRar6g3oESQhyFbWvSiOsGgwml9jRQeO/twIqR7FtwdK/wOw62ALaEsgV3Y++afm5EgZjAy+fLm/TaZVw22W6eYyKy/IjzVinhnD4DS/idZF9BpVql5Ogb9gEZAnP5IW2HrUS2Sp55dzI2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723338; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nt7QajVz15B8EtdNpiFbC9ULasxhi8sMYazEzinbU8ETZq18QBe9oxvdGMYKuu8MbBpN/QsNz/zf+IlVJ4mzxnatZFMjLQASO6p/DCWlm964v78j3tebxGBPzTpT6WFjyT11nSYU+Z7jB60dBRVSj0TT37GZV2FqzVy1xyQniu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrG4Ljmj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpNdqjNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrG4Ljmj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpNdqjNL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6raDT2077441
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=BrG4LjmjGlraKZJg
	7YKOa0KPU+pIo/CUftVNyjvA96wuJtSToedDs5k0ML4/LgiRf5bzfPoIbWoG+ttL
	tKPkDMJxtZkpphNjlpCtYZ+aBtw0f0cbysEv5RTaOAEnmEd8USGoF+cwHwuu7yT1
	W4cCy0PIl6XRB+8XT7U7HMV8HAq4A8DoQb1G1msThkkDHOuLY32DGXbhX+w4o80w
	KTOGCZCHr6KcbK3i2NdQDSpcdblbUaAgu7g1DImozCazwvJ7LXeKhLi8vWpMyMHq
	S6f0XFSK9TdHYUCEH2K3h6SSwE3fvyyCcfz533343tjR052P1NxwkiGXASXSWpjv
	HGpZGg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7ggyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-969289fca9dso671260241.1
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723330; x=1783328130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=HpNdqjNLTTSixap7i45I7gMoPy1jFNr74jBZp/Q88EMcbR18fqrselDfHoX7UMkAM4
         1yhTZHqOa1y7mY4mD7PlSxgAKcy2KOaUGp7132GIz3dAbHQgGmwXmyEC26vHOS4B64ce
         K8MIOScj6gHZuAkuudivEapkJvLONgaUi9VJDBZXvJDt0fcH5iXeADn1A0DkPWjSQWSw
         r0QCAJylTbxKQokQ3leVFC8gVCWNx//jFTBN335+c8nbsPLRXcV9ilgp66un4i2fFPe6
         eXUTwdy90yZxoddlKT2x8cG4xTPhP1aCNFT8OQ4a66/TcrYBdNWyHrLF7gziKA4ZX6Zd
         XESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723330; x=1783328130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=c+AlEtHv6xDM4/OwdnS+kMv1gRTTPOnOuhOWP88H4TxodZHr8X55uVdlvU+8r+xwfn
         xeyVO5lABYxYR8WtrXhByB3PrxUQZ1YaPRIQJwS4UBr7L/RRUvTFleZqn8Mlq6+/5gWx
         HBFlfWggsW33Xc5bTZ4TU5ROOF0f80ItNbnQT3zDPBRYBXKrJiKQKr5sUMb1eOu9xUlg
         qHaowz4A0OcBBmAovXmuSOUY3aKdE6BUyB1GpRyxW/n7tkFK+zF5O2wv+3/pEzd/JTxy
         gwtK5cm0ou1A9mnM3VMyD6gYHAKHcP6pL7wN8vtcbUiH7l9P/S0Q8Jeu1pQzRimVJf1U
         J9qQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8uLBhQqsoUpbeSDIvapBs9W74KtW/qEvrKrw0S5Krv/YdA+lBI9bmjVEHYQakD32hhLNH2Vl15+WLiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySLqCfMpfO+XZes8szclMSfc24krUjnfDFUBIHsgvp71394GuA
	Fsjd+NoQkD9/Jn4Bf7xQ4WSWmcHTV1+TBx8ps7UqKA8mH1WmlUpH8UZOA+mTvCpcWdLY09iLTGw
	qul/nlwH7Ksl0Vpc+Uv1T6tJ8vKLdfkMMV94ZQwyKF3FLDez10vCl1+GdcBN3O24Igw==
X-Gm-Gg: AfdE7clTdtlj8bGadxsXOeyDAy9+Hx3LFEh7Ll1KYutZJn1PrzON7+wVHlykoe7H59X
	MBi3ScLmflwyJNCC7qRjUwZ/ni0UXmeRIrbZfIn6fpIhfic+JjQgwXzb+7h4JGm1YfkHbOHvpr6
	8K7dcRXeWZOVjjl8cMjqNAGqSXba4tsOjVNYJF2PEZyAjo3MA25d4WcVF+laaezxQP4MUabDJLv
	5IhW0FLDfeqqtR/EaN8ZmLBWnEXg12IB+86JqphdRIE8frAzSv9V0KkCOpyKvtXRkeMDZInisnN
	KGLXGz9pXVHpttwib8S8yK8o0ILB2tdaDXr33+N/tiFE9JUa7Nqy6xFBZlqVRSJ4X/jCurCio9C
	MNRPs+jLZ3ahPyK3bTIXM97SHP0R5P78Lwf6obmC8q00dmlwcSRkxo5no5bYZz4yO1c84iezMEU
	Yxr5fvHmLkPWTbmREC6mLbcSPfidKGNlYy6672jWTCCxOqyJyY/4EmkankS3eohDUAc/cBC4tKm
	JXleJsK+78qv+X+kfdE
X-Received: by 2002:a05:6122:d09:b0:5bd:a7e6:10d0 with SMTP id 71dfb90a1353d-5bda7e616b7mr934602e0c.2.1782723330370;
        Mon, 29 Jun 2026 01:55:30 -0700 (PDT)
X-Received: by 2002:a05:6122:d09:b0:5bd:a7e6:10d0 with SMTP id 71dfb90a1353d-5bda7e616b7mr934595e0c.2.1782723329904;
        Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:21 +0200
Subject: [PATCH v6 2/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-2-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX1w2UuxDCT12Y
 9s9KHTCOXuyqd+24GU8IvklYX6hZnz1YjYchbOlgq+jrxJczPcLrdUyrXPORs7MAdz/rJ7MzeO9
 xYSspFsn1C6fB/UhPsJdxLGo6sLqf9M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX2ALwPLYCigkF
 umPvhfsCNsnsb6JmxRwMwX3OGB0/ASsdDNd9cttIejFDvg3KNldChprD+PtbrAVIVM4vCNph2VQ
 3dSmGbA/QgnFqJK0SpmLwybUbbgAa1Kit58Gagj3IvGG1/NGy3vdZLBBXa++NCK88XVu0r3wiQ+
 k9cI4aWGqSHttjyJMJn4at5TdeiXVqHee08KCtOUI1uY19iD0ZmluqXMDF0F0YwLIqPZi0AThhg
 s3gjjPAHysEZfnTN1ZdHLuMXCT+icqzEV9iz1sXeuM4T7D70NqrZvuv+C+Fj0PEHGdLR9z93nGf
 sbm2mODHKqXU1DrHoIkoKZSYcaK/YoMYbXQjmLUKcjcmuKj5/oVbmVO0s+IzBegxqrZCzvkuQ5l
 l0415/3eiNHRVZGBBXgjBLt4yLNnitbGQ5AHysLcGRM/bYBdiZJoJMQXgN3TWicf8MEhsJK1UAL
 BwznfKjfOMTy4oiqhdw==
X-Proofpoint-ORIG-GUID: XPxoPaJERz81cTO6uZCajxELexUqRNDB
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423303 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: XPxoPaJERz81cTO6uZCajxELexUqRNDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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

