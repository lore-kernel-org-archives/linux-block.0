Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8439C64E
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455082; cv=none; b=ez2T1bQ5NTgR/Sugh6CF1Uon6xs2mKk1NrMqxqTzNwMNpDzeIvhkpW576bmz/+RET7H1P8wZnD4g7mCxR14FKcB4dcxA1RKH9IPcYyAN7C+rpdyJeDTvkfikQZAm3mzzqKIGyP6TMunOzrITLwVLBssJopWqazaIlLp8sJvK/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455082; c=relaxed/simple;
	bh=dm+dFwxdW3sm7O8MhecoTv5j4K6D1iGc6ODb47RC1e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sd0uvSZ0X26poSs5yvPVV8vxvcjLdrucKNfrm/5Se2PwAdR2CDLdaVjz5EzmkuDEoCMYx80f94cxZ0+PekQ9tb3n13QmuK8k4Xs7GcU/Bkt35E/hGV0uzSFhj1GKUXE/w5sVRaeWq2PL8Nrj1GSJlAp0v2s8VfKBY3hnK3p2Ii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYEMryoF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UxVcAZMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYEMryoF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxVcAZMR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pqrf1641533
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=; b=GYEMryoFXAFAlD/r
	JQitAg82qq4PHjoHkSE55CsuTKzpGQUiy7rQ4Om3REMbKJz5QB7BFnkvoO1pnfSP
	D7SaZE4jl6GkEvVnOb3lLu1B1h3Olq1gHBW/DB6dHat1v7r6hb4jGKY7Bc133C1n
	9Fq8uy8EKP/D0F/UZNBc2d8iJSVSLLUGDsiyeVZPa8hPSrVFSxzecAzI9Rq8wyWw
	7w1OojyVxAHVt9MWsToAYKpb3NHdrefL/9F/gSkLvemplm6pCGe74AUsIpt0yJ+Z
	1CxRYMd0VjerRP4J9xDaJOwDdhjBcDs+/YT5Irq8WWFF868FngTnJ426wPF29Bxi
	J++cXQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj80ucp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:31:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8edcc885cd3so221143085a.2
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455079; x=1778059879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=;
        b=UxVcAZMRoxQFFUSoaNJKcxm6IoRSu13yEDXjb+2JiSkk6atr+Ij0jAqwkLDf4UJCUR
         YtfvpNvsIU450ihHmyerBupVG3g/E5dHjnjnnpm+SlcSEMiJ1z1V/OoVppFcVkffOmA8
         D8sl46UdArSC7uYibdsY5diuNDMbeLoGp7yttlQooc+RqXzt0bnnr6Dfrf7NcwQWPRRy
         IVFSc32tFRKuSeHR63tN5qAJZQ71/3ZV8sCM6OneIrrc+rIZAYzFzzWft87KEhnGbXli
         M7PPgUogDa/elhlA3M8BWxksr2UGEbcorvZDuNeBS8t7Qm7xXx8xMtF11iiJdf9q//Sa
         1uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455079; x=1778059879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=;
        b=aXxfJU35cgXIMLotWV4X6zSwfyvc1CdjehpI7r7F/w5+6H8HgaJRCInvZ6ffN3tRAr
         nSRZVniirRkxO9uwi9GUVGRiDIPtRaF9Jnu1Lj0r16HFFPAbnsVQdo2ath3/0HGkZJuk
         9xeNCtc9ajdmvDbWAjMtRWGGgtDs9G4y0WahMYmKthZaVSfQUpz+U9CdJXyZjYGUNDUQ
         qOoON98UM3KNh7dYU06Tpyr9whHprcLdl0N0NYSRbzzMKZO200RwrKMLXtCJg9Ybe3cU
         92yzo/51SrRPJlvcmtm7Jv7aklIwU1ke8AK2VQECD3YS8Og+E/dtBR0PxNyAQvuGLsM/
         fxmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ix6q7yGn/CJ0+/bo5JY14TdYjVfXLYxC62d9UTr0jGn4fMoJZ/42CahgJzvvxFialtj8HAvN25Q88+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48F9E/3sbS0xeVtBwdYAaGUAXM9zuHRXuVT2FB3Xatc1YRk8L
	Eormz3RpX46o1zXtEr6OC9mSnBXUWRrWr74Ot2KnKz7IK01z2H55P+tTJ50vZo3eyLtCkNwmKrY
	R6TjPZBM/hPTAow6yCS756sUTWrXdnMPHUQeymCLDZplYMe2hj9a5nWiNY/SJJWF0hg==
X-Gm-Gg: AeBDieuHQmLXh+sE8LxP83iXNAuUQq8MdYPdoNHDlDknWXFKTWaZrZNTtH4nc2FYK3L
	nSxXJQxv0Bl27Ny1FvyX35gelZ2JCDqO8nTy4PwNnezTaFaosalzMSGe/jX5avgAuxqn+gSpf8s
	hkkh4lmS8X0LGWc0q/z18ivUcgk0qzr8vLqXm1eNUso9S+tqSew156APFcsRDeIMiXceGr34EcK
	1WrJl+xM+tvJ8snsRoNCb7ZkQvYwEP60LUOAn8Lnj6Q4+MnejNr2YTrMkRk2FG/UesR0mgfpQOs
	Q6xHHE17bm/8fjg2psjYCFZ3lCiL999g+JeIQ4iDR/eEvQ7FY5EeOh5XMjn0xoqbVVBd8/MzNbv
	YQ9VOmsHcy+aujuOFkR5KCcX4/NPmtdYZuTxE3VyWp4oWCFlFzsLP/4A1d+svH9yAGFkV96IgGF
	/S8DLxhPMc1JZ81g==
X-Received: by 2002:a05:620a:2692:b0:8f8:6b36:fad3 with SMTP id af79cd13be357-8f86b36fd47mr469940185a.8.1777455079098;
        Wed, 29 Apr 2026 02:31:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2692:b0:8f8:6b36:fad3 with SMTP id af79cd13be357-8f86b36fd47mr469935785a.8.1777455078612;
        Wed, 29 Apr 2026 02:31:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22154e9csm478955a12.15.2026.04.29.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:31:17 -0700 (PDT)
Message-ID: <3c6308f9-3758-4bbd-ae24-d9a02f0aa241@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM
 MAC address cell
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gyeEmwkmbnjElxF0pqL03SZ4b__-wYNU
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1cfe7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jzu5v5LO8FXgj-oZCtwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gyeEmwkmbnjElxF0pqL03SZ4b__-wYNU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX0WwABQMArF1w
 UOu59T6mNxN3jpwxYSqCGPgPXGofS+gxrNc1tZyqtv4UCH1OSZP+7CKYr5iv9J2N6Dayp0g9wPN
 ASc1+GIDZRrwITSMhXFDSxePyqLLGAuJYY6zr34a0EEtLYqj9iOy8grYEI96zelqdFM+3GwRdMr
 PT6wup1nhvLf+RAY1R40YJQsNvrSin7/YlDQzy/+Fe2aXIuxLPPqB7WP3FnLdMDtNLWhLmrWjj7
 MggHk7kPPxBUYLH9icC+3gcBhf8/ILEBB/8ALyi5qZcVE2vCg1i9p5RlgKNO8H90X/Qp3iA+TcA
 FsVLacLAVm9L0wVOC0NkazbuVDIwid+kyDDyCvV9OndsQt/XofK0lM1Ssb8YPeFaNomRjwcxTXx
 p5cZNsfv+xCl9LKid9ho/qKHzVk2DLo9MIsE2FDpszPHxVmVgoFdIpuzXmsmnM1Q9HCu/5e9Ll1
 ilP+ucTat4Tgr8g5pxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290095

On 4/28/26 4:23 PM, Loic Poulain wrote:
> Add support for an NVMEM cell provider with the standard "mac-address"
> cell name. This allows the ath10k device to retrieve its MAC address
> from non-volatile storage such as an EEPROM or an eMMC partition.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> index c21d66c7cd558ab792524be9afec8b79272d1c87..7155d8b15cc145c3a7d703db0c9c3e056a54c07e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> @@ -92,6 +92,16 @@ properties:
>  
>    ieee80211-freq-limit: true
>  
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Nvmem data cell that contains a 6 byte MAC address with the most
> +      significant byte first (big-endian).
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: mac-address

This can just be "const: mac-address" if you don't expect any additional
entries

Konrad
