Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025938A70B
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427256; cv=none; b=aWQNRjd1Tu7zL1kGki9uTKNEyVVKY8aXMvrVKI0vY5sDPH6e0IgDjpzaOqdDJS+OEbV7aea7I4+7jWJlUVIUdAwBe9xK5Ms2wrg27RTpFtCIlMEUx6RxKusYVQvjPT5ooB+aPcY/BSBK5nmVpYYHeQgveod+36mixlajb7DPxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427256; c=relaxed/simple;
	bh=NYZrwdZQ8Unx+4+MfgqEtix1DA4oaM8IOP1pJXmdN5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bv+YjP8mlcqO+xaEIACLmrosOc7ofy85LbxFj80bPilU5eI9Q8aM4mCfIRuQuuBF74fSAnS3ZKxKlMxt01cALEN0y7VGMjd03Z8hQHThFKeExuzm3QrwwUW2sO2Mu8nasBqSuhOv+VFCPLxKjv5r8b1A8nZt22tCOa82TsPwN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/jRX1Tp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/pJ9Zsr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/jRX1Tp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/pJ9Zsr"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQrEq1225785
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=; b=M/jRX1TpvMeqUO/P
	PVSImvtbdOfYbcOhO0VXezo+gXswQjqaHNvsJ3Mbp0b8x8Kyeye2BSJbUG+/C4Rt
	9KdEnjt9DqMob4WOB+dpqLM+JfKHUAxy5gSjY/BtUJQncrKHUO3/rZv5R7u03tOr
	AXHcTNZy+Q2+koiThYECm5Vu07/NgdJWrdfhJ3F7qhjr9L6LeZ5c50O+NZVOiuce
	JCPyjNPfpScmNOyxtR2uei4gtyrYng/bz0zpFaKDRapZKZNBpGa0ocmPhQ/ESFPY
	ubUJ+4lOJYsrXa2QlWRB0oI7usRTN7gqiJfSihZeCr9DbkBPMJ1bF3tPXJbYuewE
	5jcxEQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn0es3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso24483431cf.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427252; x=1786032052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=a/pJ9ZsrhOmMRU9FoPQR6x8VhHL2NXztqxJbHBClWmZCsGaifmSkgoT26DIye6jg8H
         1HPYGoBCT6ENWwfnbuKOxxvVxYLxm5ec3Lcqe7rzh8HW2Exooboc6aVKe0UKar5nvvGh
         tX52XPrCFlHlvghGPcBQknnrFJxItyqS3ezHWPePiIShcTxFYvfeHLqbfCcDehZclCuq
         +cyFkfTexoD9XRmMxD0k99NbgmBbAn38AGfYbkfnG7xBVRUN1uDXogOdYoqH7MLZOZb5
         rqbNMvcptI+grRALRNyBfLHG76sWlqbnmYyNLaAE4G7lQRNfVxy80rH2VIecGLHX98ku
         xRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427252; x=1786032052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=CWVXN2PcziE3KjccZqJxcr5MyM4FcHeyO5rUGGdjFGW3HtLYMqd5wXr8a9bQAhEOG5
         r51ZnUC5aclXCOMF+Hae1J2zAqRxA7NjwSxJiAr+Ot3335v3wjwLCGdDuouChVgaMJWO
         pNLpwiO+/C6dLLQRJscRtvmkrPhg60Z/YAHIYDTIA4CfZHeaqAS/YbBDTNFEL0KVA5wc
         OniBH24X7J3nLJfBl2c9MjbLzlmwiIWX/7nRKpVXfZf9kyp9MlEPGGZv6RTQjeBLFP+f
         IfkcJ0Gw58niMR1aY+GWh6MYl/fMO5CmokQh1qboGJz2HWX+nv0rIR8fvyIncLn6yWz/
         evdw==
X-Forwarded-Encrypted: i=1; AHgh+RpP9lveL9B8p3+iE3ofW+YAD1vn07U0C16B6e/eQN0Fz8ErGfPz0PdLBtoNo7nYU8oYMP7mN7m+NUshzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65ORSUuqs3sP+251EDgvvFFM3aJbCOF3ni5hedeKZ54aVj+9V
	plj3i97L07GVzP1c9knwsvLB9nlDumb2VEIIOhEQu4QvAAonVSnJRZhBlgTulbBmDsMt8H74Loy
	9Y7/O4hHxVpgkkvKb6HpvrhxU/n/C7+7Da7AlJ++EJX9pfP3/CsRknyEvZboGyNi53A==
X-Gm-Gg: AR+sD10FQ851wUHk3sdENYnfejvE6xp+8eobj0c9zgUc2q31dcwDKIiZScIBaSusYNF
	5tMt6/CbCU1JTnhTwKDm79UIApbRXsIqk0q/Jll4O7l+ExZG5jDLPFOnOEncpgeZsYHuySGF55p
	P8V3OjmafIWDYyRYLQcrSv11FnYrHJuLcg5mgbo3nhWaosJCnbhVwfD/BP3DF54Ix8uouM0wpU1
	z/ZhlyFlKWl25SAoX26Ve5WjgWT2FmKhMSwN9PIPlZSgSfWNmqr24DlC4O5PbP1/wzWcU0DcWu5
	XXd06sQVXl4bPfp/AfpQF8W4CxcyyAgRpisAYP+0SU7qRu2zkQSRY4xs9iH2VbQIt0k3kURLEbI
	07mRhm619CCN3PFnxThGenbT7ZEIlWPw4e4DAY9SsYht8SoXvF6/SDaEWNxA+hlyqXVkS9C3qSF
	mzgvoLP0LLN93rjbQN4jaRYJV8StgRzAT5a8yroB+MEJsGSLb+xoFv
X-Received: by 2002:a05:622a:4d8a:b0:527:73a7:ee21 with SMTP id d75a77b69052e-52b3871bcddmr35047251cf.86.1785427252264;
        Thu, 30 Jul 2026 09:00:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8a:b0:527:73a7:ee21 with SMTP id d75a77b69052e-52b3871bcddmr35046061cf.86.1785427251550;
        Thu, 30 Jul 2026 09:00:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:34 +0200
Subject: [PATCH v9 04/10] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-4-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX0HET8QwPC9DG
 6hyv+uPAoHn3Zc8oepe0V/C0pVoXRmp4ZXLSihSASX1r6em20WPUEmEZNWVWT8Jfmu8u8PEEZC0
 mztRIPX3zvs0imS7kfoPfAiSISy/DRA=
X-Proofpoint-GUID: Zjnyxr_g9e1-giAUhfp_FFLOZxHlHtRy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX2cf2FydSvQrQ
 K50TYnja5HZwkz7N+Jmf1BMcWrVGK44bji5yMMSX91M189RbhtpWYd5lrrouXLu2idGWNaFW+k6
 8k0XwZ20aQUihgi6A55/TxwYXHI2KlMIhs2pO+YB6NuDZeM+3CbvmItuHpviyMjcYlrcOpRc0RK
 f9RJHf4tynx6aNJ3b9mYIdmekxxa9Ad/7xnY/hQqXLVjtpvNpsubWctbbagZ8erMQsWllRRRXAo
 8RUIj9SH2aa6fExvXHgEBaB6IaN/BLdDwpwkOs419aqojxrv9RiyQMwUT5a7deCLcVubbB4YAFF
 7YwakfMRM6kOxVxmAqZ8vtjAK4eS+OVuFuL2BRDGG2WWjX+McTBw5SmJm47jT/lnsLhKckU9Xm3
 491DruvzvZo9gcaXkVGU0ozcLsuRymGCFRu5UiW4w0nqrV5Qgx5gxpN9ZUfD+q4h9XPHm4kF+oe
 TSEinDOa5/Xphl/Onmw==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b7535 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Zjnyxr_g9e1-giAUhfp_FFLOZxHlHtRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

