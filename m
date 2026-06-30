Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31A2F8EA3
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821555; cv=none; b=nEkPviEHA7hvdG3o04mNOeLWHYu/xCfGGcsHLDs/XhJTCJX0QUHA0y4sM46XuN1t8dewVa1X9Dw+03mS+vyY8uAT1qRDxJibcP7ZZhGaqKWHitKmzpYflivbRiLRYHofJgAekQ/UiBPQdtYXW3uZdLlxSl/xMZ9bwG5mQefDz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821555; c=relaxed/simple;
	bh=ICVFc88cteRkFnOqK2r8PitO/adADtUmJP+OvcK0+uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hL9rcOXnyEXrTt8CiMlxFUbtkqEOrxXptKv1cXHj4Fa67Y911ZarTThEygNPekHhQrGnGdLE2e3zAmud6Uqs79BSK03Xi4FLGRySMlgSkUoYTaDa4Cs6IPfqnYPHLkT0TbrDf7Qmrq7JuBdgSHYVpnDf7RRH972e41fiFFeziQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DeBXoe+w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ah0gOdKn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DeBXoe+w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ah0gOdKn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n8NZ1605862
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 12:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=; b=DeBXoe+wzRpw33/s
	CVnrtcqbVZXPgn6aEIn1wWBJ+E1acsLKn5JktQBYJ1c3Vx7v3bJeb6Sfff2LGCRb
	P14F9T4XdEDtgEHXToUs+n0tBfDwT6HkTBpS+QWhTgmMGmu+GVWZSKiKs/perO6v
	cnSwjD/3ISf8pOGupOwNoTC76boV1cEYQaRMzBaB9EPqLjF/YQflZlMeHBRR/V3U
	nHZG7oo43lc+J2bi2nMueoNK4Lq94vHJyWnHgDyQYnlMMhtiNY6J5ARy269uCuzO
	tduh69GbdE5Es0Th+848ztOGIcU9ec7BQmfZXeNtwJb35A3jhiKormSghdh0rA8q
	EFEcLg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5t8tn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 12:12:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8ee253caso5157691cf.0
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782821553; x=1783426353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=;
        b=Ah0gOdKnMfe1KlWAJWpaONApMSV5WXsghEC9jjVxWmMaz61UNPo7qpGw1mmrdSLd6Y
         qmiQy19dnISlpwXlvCsWoy6Xt2yh4NhusRwMS4G7SFLRZIeQcR3AgseMs5rhaLX2t24x
         Q9O2DQdyVvMxxPS0h/Alb8EtN1qjYxW84s1unN61wRVNrtfw9yeJhx6w1GA19s7j1CkD
         25SLVfXDzJbtSSHgF8isJ+C1ChfsYGcCMtzbpvJKDYsMKnoQn4hEfW9BQTQSVD2Dzb4T
         zOOzSHaQjaooztYY+rThD/t2O5O6Ion1GqXm5doD5YUp/AJ0d7tdkgmJfQZV9TRf8shv
         Wzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782821553; x=1783426353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=;
        b=U/IDcyCUgmybVEcWiPuya/tu3kYHAMDk4Jwf9EiSTJ0AS28NSuvukFjZmyRIQFhtam
         gCkK0CQNxbQ83agRSu1+YWJU+wZusuOjPjQKhjWymroJioY87bPcA5duwST2FyX57mO6
         ZRsMxCVSv1/XAYh0edF/9PdB4hIWAimeV8P0WlvS4CgABUZKuFT9OKVmWEYaFYB2WyDe
         gRDO6wfOlQ60ss+Tr9/sMtAm1hYpxc57Hgg8M8HQoqd2pb9CRG6qOJiMzVh2G+W5aSRD
         2k6EV2UUMpJmLM1xPjq2kfLtN6752YekuWo3cfy8PD58Vhmoz0gk+7zQtDhY8FvgAL/l
         5JnQ==
X-Gm-Message-State: AOJu0YxPD5cg2CyGgjC+LRWjDu+bG9JO9yC9AMeodW1x9i4zjZ4ZH4Ht
	rm5MJF01Y2TDTCKYlj0aGDaz8foxNUVxsBOLbAHJKx8pERMSZggJ7ZEJqzcsicdwXn9LaRsgUcR
	/q7uRM5ARHSohklhKjtF96W2yLbg+L+JK0E7LyWJCcY49xMs3EK9epqJiOOLqtKvPUA==
X-Gm-Gg: AfdE7ckAGtzVfcf33d7NVFP5Upy1xKmU63Y3xr8zO8UBN8xt9c1hxqmzXFv2tQ32gI/
	3B2+m/UYGwlAcwoWcnupX4PtWwQZg2vy1KY2Xtn2BuLfnmgL0NknZElMOIYlAQH5twN4tsZmr61
	1N+XLCC4LyzOyLOQuy0ab4F8D9x3obTlE0xpNhJUFOG/jfTYnq9G8ZI5XCOtJ614akAgdxhwCQ8
	wgrxn1ELC1JoIjeU8OgUBvQQiaojd07O/3rXRPkY452+1PncVKr82v4U6hRlYI/wHxYDy3K7gcN
	cDMNN1qMzYHfMlRGtwTSCQGcynIdhxD17dECX19LY4KhThm6KfJQk4NMP4UN+mmjoEAOlWPYCn7
	TD0DPSVNpSHmaNtR8xqoA6zIg5ULc863xIcs=
X-Received: by 2002:ac8:5e4e:0:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c108dd78bmr26922671cf.10.1782821552716;
        Tue, 30 Jun 2026 05:12:32 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c108dd78bmr26922291cf.10.1782821552071;
        Tue, 30 Jun 2026 05:12:32 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cc57sm113884166b.40.2026.06.30.05.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:12:31 -0700 (PDT)
Message-ID: <7d937088-fb52-4a5f-9aec-b5e2409f3cc4@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:12:27 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: George Moussalem <george.moussalem@outlook.com>,
        Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
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
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-5-02770f03b6bb@outlook.com>
 <f3c79cb4-02eb-4e4b-b5b4-9732876c075c@oss.qualcomm.com>
 <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43b2b1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=UqCG9HQmAAAA:8 a=M9FTrHVy_WBJAQrZl7sA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: dEoeD6w6bzYL95gfBol126mKYeTmgeM-
X-Proofpoint-ORIG-GUID: dEoeD6w6bzYL95gfBol126mKYeTmgeM-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMiBTYWx0ZWRfX6PjSlOME+vYi
 pneHbSnriBL7l+VWlGmtJeSSESpzMjdqRjzN/qbVRBcss9VxdbSU9pCeCNmfKW9UaRepgcqq6E+
 +bjJ2DYgqlvLND7PpsxJO3KqMJ0jvl4CUwZ/UH7zzdgixmwWiqjlrAeC3bSs2bD0bZ7d+ykEK/D
 zfLzZCP0NshgOV6jmUhTorUBik3k7DIRvi7Vfnw41IuDYAHNHrAbGFI3jDFB/eOT4etClFSsBsL
 te/++fVPHNiYNG7NzQfGKc5ic5TrLbisH9NUYVjUERUpo2PSnO8ywbyBP/zXTwE90Bab2tgqTDn
 p6GQufufIqXwMxG3hz88Y519xxm8oyXzyqishoARDVgUIyXoxR78w0rku9RI35epIPBenF0E39Z
 GHIjWSFbrPb0voutBqQFkYBS73FoNrfS43T4EtWlmwyZ9/r5pRnMnIsiy95+vZfeDyHgDyatv36
 DIN+87AKk2+GX1/BBUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMiBTYWx0ZWRfX2JpuKjA927b5
 voQzZJtEqj3jkmvtFGxjaTubBgu4RMeh3+6Mbog1B/2R5uY5UeWlXmvAtbM1VUilfzJHfqoPjJh
 p5j26GFg2dSPcIw/ZvY+nfPn5y7x92g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300112

On 6/30/26 2:09 PM, George Moussalem wrote:
> On 6/30/26 15:40, Konrad Dybcio wrote:
>> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> Add nodes for the reserved memory carveout and Bluetooth.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 25 ++++++++++++++++++++++++-
>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 6f8004a22a1f..65a47ba7d3a3 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -17,6 +17,23 @@ / {
>>>  	#address-cells = <2>;
>>>  	#size-cells = <2>;
>>>  
>>> +	bluetooth: bluetooth {
>>> +		compatible = "qcom,ipq5018-bt";
>>> +
>>> +		firmware-name = "qca/bt_fw_patch.mbn";
>>
>> Is this fw vendor-signed?
> 
> I've just analyzed the mbn file (and the mdt + b0x files): it only
> contains hashes for the mdt and b02 segments, no signature/certs at all.
> I've used your pil squasher to create the mbn file. Here are the FW files:
> https://github.com/georgemoussalem/openwrt/tree/ipq50xx-bluetooth/package/firmware/qca-bt-firmware/files
> 
> Perhaps you can double check?

Using the not very sophisticated but very quick method of running
strings on it, there's no certificate identifiers indeed

Konrad
