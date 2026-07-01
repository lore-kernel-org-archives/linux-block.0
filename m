Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735194949F3
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921644; cv=none; b=MSXixP/sIHa0MTXOnpSZkyxtrJ2Dv/dj0AwyvV6THcdOgD+UrBiV4nVU4HXXJERClz2wRF0sLSn3ufSSHfjdqL3/KWNDMxJBrah+uRYxFElKJbfSJ9718I0deFXUt6jfacGGgHD3vHXHNg78OT3fcafLeQ10z30DAb5efcyiERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921644; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYREZXE1MUNA5RPMuAfil7n8YTUDlqG55Pxx7xGxP+JmIxAjmM3Ol6HqN+db+JoV80hEkn43c0ytcXnqDP2ENRDp7S/ZBRJsoTksDdAa0rhvrYUQEi8thRaLVgymoUISZMT/XWVyUTR1JeMynMDTVskrmvMdpT8Yab3RJzgE+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYgaxU/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJvtjfFF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYgaxU/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJvtjfFF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoJpS1547294
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 16:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=RYgaxU/5XUemkleJ
	+rGnL5+wvDRn3jX+6HhlJkaAfVY+AZvzcQXBWB4qc1A05Oz36348cY8xMTbV4J6n
	JLqnk+nD1Q34IFDibZp0WwG5205v1LtKlJtv/2Fk8XjVYR7e9Acw7hFPrSFGxPT8
	rjfGdLGJMMhP9QFUdk/CIxmQuESLSAwZhrETYVqDodpraqRtS12dzEEvLh00MwUG
	4nEj88OiIxNp4nt9yl0YqBzukogbPHUP9ZdfWnv2wzhc4wA5GsgwqtKGg5/0Ah6k
	SlnJUuDDe0qqPs5NziuQNYsdKov2JzdJLN+0gIrDakdbISMtCviZ233f9L39FB4Q
	I3KTCA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy3n2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 16:00:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92b4b575561so116390885a.1
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921636; x=1783526436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=ZJvtjfFFce9KbkQ9KHi8RxSpUhje27VdjU4yIhiNpmNv0BzGyQ24P+HloP4KbRpHCd
         rDvRZyFibrSzx6NXomDwBobTS1zA/4J4OFr4kM7MDrVTdi7VMdEhn1w0uLPFfnpAYdN9
         twcGVnh/VFUAHHSjGtYOXJVVZ6EuZTBJqQWbskzySHHO6Kj2Dexfgjzdz9EjnYIPXbpj
         3/NI2z/umA8Pn0TjNsje/HRYezEA2Y0jiB0En9lTVwr3/65oFpGp4eC4vOtUFY//nL67
         GgWSIAR2aQwQmH+UIMygyoOsVhxYVydceaJmCGTTAKAhWu46skE8bipjkZL6tAr4XP67
         KIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921636; x=1783526436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=EX9k6p0r5sYDDTYfHE5KzU1NcThdRyBW9XBkmtSDPXbmQjhUKOp8bKPlE5AaawAEZ9
         p5yxvDV1trUu45FXwEFs9+ANrW3vaINJ+XTKyCQq9/zavo9gH1khf+GDGrcnwVKUdkB+
         zrNboyztzrk86eRzupWySxpJH1MDuVYJT7es13OcEne264C1uOlVkuznl0H8LqMJyudM
         AiYVw3lT5wv8s0NJScIMx6tqn8yAQcPeiY0/6PampvljSUmzeJqLJcru1iwLmQeMlVy0
         EsswltbbfIZ+93YJ+n9RoeXIo0QVzbLGombHqtuKRyu8G6dev43jNiH1qD3F8uC/+/M3
         q8+w==
X-Forwarded-Encrypted: i=1; AFNElJ/h+3q8u1pwu6IHUJrDPRZljpphHjWVBF7GC96yqngcLRL6RRSuHg2rtlagiZOIBHpvhNCXLLOGslaCzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsWugPXXCZCAzCSkt0Ic4G0Vyj6wjcdnr0bJBwmB6aTS5Gnwl
	b8oa7/oYYpSe/m4NG5Xt7KFuyXJCqMwQpTq8SIMRvyb5tAfPGPn9pgL6PXDOCoC/wDpOoQ8CLbO
	deYOJCWtGb7Kf9RfNbx5b/wIVxy6NJO453cqlibBpY4xLtMlDYif0gqOro2O+CY8snw==
X-Gm-Gg: AfdE7cnwboTDWA06TM6ZXeQMVfB+9BGFND1rKkfKidO/wXY/UcChUE1WwL0lq+1j3U1
	0bhlpnlVhvaCMh6i/JCfx+NG/9Wj8I9m4zRTimEqBkHI/bJodWUYM0dT7KTHNARJLds5EPjk7jl
	8jZ2cbhoWcBqLvgrdUW7D3TAdLA5POIuYZ9/y/swr39tn4U7INEogCxsFhvl+RQY46/FBG6ZUSv
	/KzRpwDZo8KRsGn1V9S0LGW5Fag/hzogHnSSQknjWPmsguy5EgipYy7+pfZtibJNyShsA+Uygec
	IDXiG3gDsvdWZwnVEMh3qtMEdBQwiPfKed/Qfehrku2C3bqsTDc4lCwHlh7sJZ0FoGzRe5AsqjV
	DyR4ZuCqWl+8KOig5i56BxV7PQvwO8nMclyezcSb+rDMTVQh0wEhCg8IpC8XnRXQYO4cGbASxio
	PbQvkg2GOj92nepM9NKYUtPZjWGNHvQ8CtO6CyC3VUhb74dajiz8cXue5u2exkDE8=
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886597285a.9.1782921635982;
        Wed, 01 Jul 2026 09:00:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886542085a.9.1782921633251;
        Wed, 01 Jul 2026 09:00:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:25 +0200
Subject: [PATCH v7 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-1-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: eZjP8gtOpu4Ky2MjAnKQCJqv35velUcF
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a4539a4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX0QJuNd+1FDMl
 Ai1JnBIz9IJ2OGStXyUxE06+d21FecL7+5CrLmh7Ur2wVuOgyR4akxRuBmJXr0pasVgL8G8/iPD
 hl1PluBTcIuco3s/z8aWzbNXITpUA+QzeJXK9SX3tQt69FFoHj9wReGooAVeWsWb9j02KcpVuCw
 UIKp4cGjpFfvAN+j0VoS8zHU0VWWDmrxYpF3qY8F1Yz2dvvVOwMel4TWM1YelneHJ7oGi8cy/3o
 jKTD2DT+/CvunHstCBguQ6zVs52TQBYMqjOSQkEBk7bWazz3ulKOG1uHwZFOF+jYWZv4rOiyld3
 M8EqSoSIlcNhvppJS/o9xwQigs+jK6OUB2yoRYJhK26BdyfO5Clt9l1A47opNpLiA6eR/p/D8VC
 Bl4c6Lx1nQr9O0JtoBJqFdQqSxKKN9mpBEtGsw+HtIZhgDWzgJScAudpoWskhr3hV0aW9ax+Kkn
 Y1r07ySLm4OqC8uiaJw==
X-Proofpoint-ORIG-GUID: eZjP8gtOpu4Ky2MjAnKQCJqv35velUcF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX+941JSarCDng
 8Uj5hhyZ7kE482vMGZEZuWUC9qafjz5TxKmDoLvQk/HOzpixMRa6MTAAO5rwWcJ5sR2WClSeJS8
 NAP0kihxywAX2ja49l4dvAmnykU5FMM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1

