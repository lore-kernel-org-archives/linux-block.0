Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139146AED1
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904775; cv=none; b=lBadBYRAOP6YYOBKK27dTrsAfv7NZqrlwO+oHUBMMD67jXFgt1W2j5ydeTGkY34Xa2uRHQWQ+KTH2+zZavmEHs+2HGLWTnzmcSE04L38tBvpba99/RlXMxjwiHlbWa6bBa/NKVc9hBo5LFvXnwSpRygOCwy6rrRAn3jtP49/log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904775; c=relaxed/simple;
	bh=Ua0ef1yufrvAgyuq1JcYRzLNA3rEellk2uJBPX5w7XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtjLGBogKp51V+LTRr8k4h4oAesHqubzpp/nlwAS/ehMJ4D2kPu8tWXGp/K4DWHor+8m3Tu4DoVJFUFb3c+2lX1/RvTL68EuMaiLrwYx808XhFM++5gKcA74thKtYAXurFBWi6aJbJsLnIU5N3Ooz+P96mWcEJtYvXpgYxGrMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwxZyeyl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXQZDHdW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwxZyeyl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXQZDHdW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A9Kwv722675
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 11:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URtox8zEzP/untTK+3HtClYPfjcDlUxDwjjp/zQVHfE=; b=gwxZyeylLOdVJC5D
	nuiZH2uaPci7Kc/y5/kYSdu7RKfA7lOmveWJy1VW4oLWcuH5fgjB1NchLw0Ke0dB
	UTygydJC/Obd+YoZgeo7oAUK8CXqIFKcX/nwHed63IOvth5hm1ULhYCZe82PI5BZ
	RlRRg5A//oin8Om9NSrqlkktK7tKPHQLLLKipvVr3iYaXvt6uAtRMLVGRPINW8fk
	pBCYjpq/e/ILwtMuiDELUSRDXVl0dBy4raERAUgi8GDprDV+Hvmv7CyPETGSejji
	0A8KVrbPAPM7jw/ECj54GWkVvVpLsbR6U2kaDO/345lDmguhzCoiTY5cEcdMXOzn
	t/WJSA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwbr6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 11:19:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfd1772d8so1032761cf.1
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782904772; x=1783509572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=URtox8zEzP/untTK+3HtClYPfjcDlUxDwjjp/zQVHfE=;
        b=IXQZDHdWWTas8L/k0iV2V4Bj6gU+wziQ0NUJvzzmSwzSiZ6AfVTAFXJ0HDeJG4F93z
         gNh6+dEjVQKHMmLRK+e2958LKGgvE9VsUx1szpJN+cuKcutjuwnl5ZR0fM7EAyQBat8Y
         4CuKjD4YLtxz4qn2KKQf5duYldumaza5AJ0t1zGzBqLkCnj0peo1ZiZ1irYFxmdYvM0s
         HEbJxBt94JgbgQ/3XBFkR1Ej7NyKRqemG3Uuw90sPFA9tilVRnJDeLIf6DiNwVtuEFrZ
         PsiG+dYVN278uTNp4FlJ2JZKY+J9JltUTkNY1UOLLZHGq8g1TRXQti47QOJbYi9ovV0P
         VvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904772; x=1783509572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URtox8zEzP/untTK+3HtClYPfjcDlUxDwjjp/zQVHfE=;
        b=UKwiI5tPnaGoUowepA6g77hDQPe/jde5KN8PiSu+GmOPC3zVkgQ42fAfIx2vOXrFWn
         zNyG5wNV/Xaek9kYROgVckFpg6NY1lkgJzIa71sCx0Uc0O8ESH2Mu0LEBA65pjh4cfZi
         zwICjykWPoYIzQlJkZftWTqOChu9mNafPd8VKBmnEOatOSLYBOfx18cazWY3+HVUEx8c
         LJ8sj0SIDwW7Ghi91YThk9VmxlUo7nXn187qLdwftoKnLuIg+SNO6jOqOH8JGYxtlv2S
         N+Ds56TdZYvZh0BWDdmmlaB+f7gMF2jClqanoXifHrqnmqKXz20E5UHzAPrSJ9VWuJJv
         PDYQ==
X-Gm-Message-State: AOJu0YxtK7AA6M1W8pLickI44h5yKCljdcE1LCuUvUJW8C8iN7k3PYqz
	G1U9Pa7le1gVwajwwrkDDh0/Ly1LLpq8pRLEsvLb4wfw64WoOckDeaqh6ou1DEiN7N1htVY6/jz
	gic1laClyIr1f6IvacYbSKYch12hnMQiP96AjfFsdUm3Xk1q0EVYG8CeQB1NjQS4f0A==
X-Gm-Gg: AfdE7cncJvyxM3N03Bue33nLdkC3JbdJCEP9cGd/Oeg1UWSkcFIUx4NjUTdVVyQV8DK
	0VlXklFPF40vKSviu/dc1RgHeaLTmpAuoN8QP8L/jhnbB/Pj6Jmqp7Ueg49Hl03/s5l3ktZhmgl
	2yi6rIWbUF12q53K2Mb/I2ud+7f6FYDtS4rkCxDFav1q3DHNlSujtQw9AH+AznpS038Q3jBpWG4
	Uuc6iLTknWya+KzD9GlEnD13t3EXYCgoD+8Er3Q0JLixFM3zdTARGulvt47FhvBM9qdQOV1YnDF
	yBfn2RZ7CVDImZ+vniobyW4KvKfTrCvKtP7bYlrgGP79TtC8rMnlLi3bsqxZtAJ/YqNTbyHpTVD
	f9huuHzEfBo+eJbQgq6pGgfcP8t1/n9ZuzBw=
X-Received: by 2002:a05:622a:14d1:b0:51a:8c9b:6494 with SMTP id d75a77b69052e-51c26b42202mr8375901cf.11.1782904772024;
        Wed, 01 Jul 2026 04:19:32 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:51a:8c9b:6494 with SMTP id d75a77b69052e-51c26b42202mr8375671cf.11.1782904771316;
        Wed, 01 Jul 2026 04:19:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6b068sm261505466b.25.2026.07.01.04.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:19:30 -0700 (PDT)
Message-ID: <597fac9c-8522-449a-891c-2935382c0cd6@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:19:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] Bluetooth: Introduce Qualcomm IPQ5018 IPC based
 HCI driver
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-4-02770f03b6bb@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-4-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p0Q1KjTHgAdB8REr3wNjVTR9yUCbligG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExOSBTYWx0ZWRfXwRa8Rpy5HnnD
 /qwb3z3wqPUoJQqw4IGP1icdmQLTZ9IVj9ORnixpzW7Kfgt7Q3ZKhsoF+51CiMUs14a0rTaIS+I
 GXZbn4OkbAbyZJg5I2wp0DUKaajC088=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a44f7c4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=UqCG9HQmAAAA:8 a=ZNUA0hKuP8YIc2uBTmcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: p0Q1KjTHgAdB8REr3wNjVTR9yUCbligG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExOSBTYWx0ZWRfX5apKaAzSG0pe
 veA4nsphNKgyC1wqcunsdTsRThaJwi0J1nbFxw2cyJ41rsko4HupMDfApLoid1FdA9QG90tDL/S
 cB/hYoZOmFRAzoqOVKLbTYgW2/wB5iex+qCTh2NkTSbbw4bRqNOQdgK7LcOiu/JzEli1yFLc7Ad
 qZMjHU0zRZaQ+B1uV8n8y2Pd1vR4JXMOHU1wf2rBFqzRyCjH4YxjNdTUmUWzp48zf/+bheteaH+
 PDa6TJ+ZYu+KLC3dHhMLu84JYDrE1OBsn2ORfqdXqQspRQN2mFDBeJOz+QKXpmBdffANCRp8F1p
 O4tqlI4nhWkw6316mSpxEA56PjKJL2KOHUIHIos21AN3/MSMJ82uOMq/xO2pxUf9Nz+n+ctrkXx
 MlzhGEj4/PaXZllXmr9wAkMWf1Q9DV6+ghFhzZiFI6wwnS0rSNos4E/RO7f7bRjbf27X+urNaNx
 bmGS6rdwiKGIL6/tvuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010119

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add support for the Bluetooth controller found in the IPQ5018 SoC.
> This driver implements firmware loading and the transport layer between
> the HCI core and the Bluetooth controller.
> 
> The firmware is loaded by the host into the dedicated reserved memory
> carveout and authenticated by TrustZone. A Secure Channel Manager (SCM)
> call safely brings the peripheral core out of reset.
> 
> A shared memory ring buffer topology handles runtime data frame
> transport between the host APSS and the controller.
> 
> An outgoing APCS IPC bit and an incoming GIC interrupt handle host/guest
> signaling.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/elf.h>
> +#include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>

I don't know for sure, but the amount of the includes suggests some may
be unnecessary

[...]

> +static void btqcomipc_update_stats(struct hci_dev *hdev, struct sk_buff *skb);

I don't think the forward-declaration is necessary


> +static struct ring_buffer_info *btss_get_tx_rbuf(struct qcom_btss *desc,
> +						 bool *is_sbuf_full)
> +{
> +	u8 idx;
> +	struct ring_buffer_info *rinfo;
> +
> +	for (rinfo = &(desc->tx_ctxt->sring_buf_info);	rinfo != NULL;
> +		rinfo = (struct ring_buffer_info *)(uintptr_t)(rinfo->next)) {
> +		idx = (rinfo->widx + 1) % (desc->tx_ctxt->smsg_buf_cnt);

That's one complex for-loop! Maybe move the assignments into the loop body

[...]

> +	/* Account for HCI packet type as it's not included in the skb payload */
> +	len = (skb) ? skb->len + 1 : 0;

Unnecessary parentheses, also in some other places

> +	memset(&aux_ptr, 0, sizeof(struct ipc_aux_ptr));

You can do aux_ptr = { } at declaration

Konrad
