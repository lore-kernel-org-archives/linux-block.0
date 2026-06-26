Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1343F44DB
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473421; cv=none; b=kcWbyGN/nakpXD/5WaxAlmgclnzX1BVQz78WIdbQYsGLdSL1t1Ow26+9HvNyqw9bjXu7JGz7UgCzm5oR8WBM+SJ9EkM0VjS5f9IX+t/iDSlr/88POvdO1kxqpSqWLtRqTf9oMn1gDTkzFyYPfRw9puSMviAU5p7TitNqD30rsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473421; c=relaxed/simple;
	bh=xgMVoshPZPknzHZ+9CuinjN4yQSdGGJbwz7w1W7rtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTCAoUB3zgcdAZNLvzPbDhYAJevzNdQzY0EtCcTE3TrFmy+5XqU10+F1W9Pla73sVQ0PurhTfqKwPl1oY8BMZ7+TimekOvAUJM4Qz9m2TfSzSsUiySWm6Xqsa6Gf26T3tCHOaak2zvhUZfRQYWxlpWtONli9y+07rWbREMwiKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W47d+RMw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+NHnjqS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W47d+RMw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+NHnjqS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAcsYL1069946
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 11:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=; b=W47d+RMwTjTeZNM7
	xMtbtiXinzbPJz87HGvheabfsgn3iVn94I2ENTawJkdofoNGG8fc4ivtY19cieHG
	aPhRmH1F3YsHIfFuvzxwXQkPPyDiNGN8W2jG35fI9XP3rT1pIeUGG2px0zMXPSC2
	th9sHWIccMnG6MinJeG0xRFQZMlrM1GNOz/g+WJXmVurl1MnrUBxgO3zXlmwd+9v
	beu6+tllmi1dq77WYXqQqTJGs5ho8iQipCRjFcEUSURA0nMftySN8DhPJmluIFa3
	NH3Qu4TVsKkljVBBKIvwwbWTgr80/uUr4k2vyMwBCuCggR4iXVAJJZU52CZd8ibd
	BSa3mg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fcta4bb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-734fbe0e6afso30634137.3
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782473417; x=1783078217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=U+NHnjqSWHSnWqSm6a+nrpFTXYjjijBenODKlghspEZOvzHb8ip+vBaLQmgKWckQIe
         aU66QLA/STnYPqEr5qqAhb1KeCmBIEFCf4UdVPO0/tM5DbB6n4wk23dUNQCZpzjzpNr5
         p/p8EmpYELMJkvS+ZELmouq4WmH2bU12LnvNZwvYj6qKp56wFrsx0HvEEAnQFOsymnct
         Wo28H9ZEmTCFujdfBLOGjHeg7edeMZsw082Ka6K1nn4W2kkRufNBfsLFs8BNLSpgvA1K
         b2q2bmNlaT/RoWOLmT734G/uDJGIFdssOsIyWqLsks33VmCyGL8n3yQp9ZYLY5rJ386S
         WQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473417; x=1783078217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=BVdF/NKXrsh9Y5bSXpRYqQ3L8D8wiSkqY68vD+i0UVLfUCTCNOaXDIq9YFeLCkd5Lg
         xDHrkSeXqwa50/7gRdUNMYMxecrE5FNRT/8YO/l1GfVlNWsm5MGm31UwwV3O6y0q8KSF
         LsTd3x417WZfMIhpBqE4vzj1iN4+9jQcIfAbN4wxuUrbWvOo4JvvtilfwbudZvga9G7L
         omqutKnjPw+oaYS8bk6+PO5+esRcPTkeKCXgRNNpBQQ2Xn41uIlDiHFis+qDaqWnYDBo
         uo5S2pM765iADj+qNXWW15fNN6wj53+DL2FvQlpqYJkbMUztLa7yfFdFmwTOig1yrT0C
         XanA==
X-Forwarded-Encrypted: i=1; AHgh+Rqa1pCCnkxyW50WNCulqq7C49cl9zQQBeUgndKfbSHDFIrzwBhd+DR0gUDfILZ3Z960AN5XUZ7/jRi1iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTOfzADibB0axXKv88qQ0mD0Dt/Rl1LP9Pz2po5bGCtTqQkqC
	XWm44CFrmtbIad7vU62g+jHeSzgX1WhKEUPXojWj8QV79zvdiheBGCr93RvE+VOuMuW3ybpyJDz
	WctB/VCqfIRgFYO1eAxYGCEkwTNsOtsqeWAe5z2OxkDZkaarZBh0qPgKGzrWGHzX+qoGoGzDjHg
	==
X-Gm-Gg: AfdE7cnilwneu+jJrk2m4phuQdmPZRzWiavcgL7xuO2aIBzau7adBPk6Z+BoarLfW1C
	ks6YJJ7oEjnQ5veFIcMaK9/x0NHvTm99HMjo5Yvpxjn4wjHWWm8TnOJ9aRxKH2t8/xh+fiJ9EB9
	F6VJDEezPTcQ4Up4CdG7R8HoKH2til91Ekp+2NwmthiXKfxYvMjgvS15k6E/c/dVERYTCutWRC+
	Ls9hxhUIMHYP/ylK5VoXief2+AuLSOaQgci8BhmC8Krz8G0N9AWTDFkDmQ7L0yKkEL947Da1IZx
	8vhwa428CccMwytdZeJ2KINuP8NiLNINYufJHA1YIv/ovGw06eK955xa5Ll8C2xUS/JHwId1+gn
	K2lCFhnsZZd3AxDd92mK1aL9IX8PsY5t0ozo=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074136137.1.1782473417316;
        Fri, 26 Jun 2026 04:30:17 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074124137.1.1782473416719;
        Fri, 26 Jun 2026 04:30:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm2774228a12.3.2026.06.26.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:30:15 -0700 (PDT)
Message-ID: <0e0fb3af-968f-46d2-be6c-18b76c7d2a1a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 13:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: George Moussalem <george.moussalem@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
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
        Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
 <20260626-discerning-light-swan-6b599c@quoll>
 <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tHGf5GTVUnN5J17ajc6eQ56aOj7YV2Su
X-Proofpoint-ORIG-GUID: tHGf5GTVUnN5J17ajc6eQ56aOj7YV2Su
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfXw1Fqv+cUqdqR
 r7OjkpuXlZhRmlS48c/B29vrmHF0RGCaDtNTD+qfi58rgVkmnD1/RXefy24kRCNkkK80CcC5rzU
 cGvGLvkJvfcDmGZqzgjq3S6iChEVb1JuU7rOy8sY1rQ2JjhUJh5r7RBrhvBeZbky9BN/yiZwgTj
 Vn/nRfUEY9RNvL+pc9YT1xCX0w9OpNF4VT/bE446ehf9fksCD9xnA175cwFg4Ob5NfnTbwD/6v9
 LmE0il8aqoTJ+f9hzcbao5jB3XfRuN756MhMYP69+BFjWEl0Ub0IfkAzCKCRSYhNLpH3gxEj1A+
 cT5r61QTPy5lp3eg+eAknf8PVTK1aE4MmfRPrXQDI1pYoZ6tuS8JfuCOw/o8dF0hKRvFhyxuhDP
 oHzSGUEfsckpbQdKylsqmcYEnpUCSnFnj1P1hUpAvMZ4zXDZTnOb+IW1ldJE6x7HNLVNVvp3YF1
 /utQouQqBtZu5GmFAFQ==
X-Authority-Analysis: v=2.4 cv=FPkrAeos c=1 sm=1 tr=0 ts=6a3e62ca cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=UqCG9HQmAAAA:8 a=Q5Orqy1XeLiTHnkJztkA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfXzHK3cXQLXpxw
 3CR9l01PoaKm3vWRuMeOvdWnaaqpSds9MKJpeJ+Jk776FuJ6KYfmUCTjxOBskLDxwSzXall7IbU
 87hQr2Jmi5NENqWOON6ErsjIZzEqRts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260093

On 6/26/26 1:20 PM, George Moussalem wrote:
> On 6/26/26 14:53, Krzysztof Kozlowski wrote:
>> On Thu, Jun 25, 2026 at 06:10:08PM +0400, George Moussalem wrote:
>>> Document the Qualcomm IPQ5018 Bluetooth controller.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---

[...]

>>> +      compatible = "qcom,ipq5018-bt";
>>> +
>>> +      qcom,ipc = <&apcs_glb 8 23>;
>>> +      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
>>
>> No firmware to load?
> 
> firmware is loaded by the remoteproc in patch 1
> 
>>
>> It feels like remoteproc node split is fake. The property qcom,rproc is
>> even more supporting that case. Shouldn't this be simply one device -
>> bluetooth? What sort of two devices do you have exactly? How can I
>> identify them in the hardware?
> 
> I wasn't sure how to represent the HW. Should I make this bluetooth node
> a childnode of the rproc? Essentially, this is the transport layer
> (using shared memory space and IPC/interrupt).
> 
> Most QCA BT controllers are also childnodes of a serdev/uart node as
> they use serdev for transport.
> 
> From what I understand, it's simply BT firmware running on this
> dedicated M0 core in the SoC itself connected to an RF.

Seems like this rhymes with the WPSS remoteproc +ATH1xK_AHB situation
- the Q6 core power sequences and manages the wireless controller,
while Linux gets to drive the device as it would if it were connected
over PCIe/ UART respectively, just with MMIO writes instead.

Konrad
