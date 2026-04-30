Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C741B37C
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554811; cv=pass; b=t5TGhL0gygOCKOxHaXAN0IBvpkVhPqQuS2XAuKWBUV7MKgtZsTw2Y2WqpYvsBNQoNKvLd9gTn+tDp3jv7ww16XvRXm7k/0iUn8RtnouqALuXdIHNpblunOk/BQAgJzIjt3YI3ecww6+Qqwv4SEkfWhQdOH5t231BB+zxG/pLFrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554811; c=relaxed/simple;
	bh=uOBwc+Vl17MdUv77w9tKQsD4/qPdD6T614WQexS4A50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/YBluWoPrliUg54KelWL1EaLJbgYcQ2B7xXInyAnMvunrJ3gS7IXI6fyNWTatgv+MdGKL5phhkof2RVAF4JTPmcTVE6K4VuHW4jzDsK/d755gJCUCAN+TbplhDcWhalBnO1JQ+tdBokSFLda19vcDK9W2V8iZS9ZlSapMuog6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wv4+57bH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FwcyrArf; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wv4+57bH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwcyrArf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UALTlt3729488
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=; b=Wv4+57bHKS59t2pn
	l788D+Bh3SNVywmZLGOHfFpV5gix7UmN+Hbdo/rkaV907faoB34D6MoaRtws6I/F
	v30P+s1u0dEaN27jtCCPCVVP+r7L4EEy0FvbN7cRN35CSHU9XxqTb32ZATl5T86t
	UrmjKIcb1J8hNdRzni/k+tZLpRqGXhoJRr92bkpFOWRdgTmqxOYvkyjH1cO6GXnx
	iRe4KV/oP4i6FXY0oe260zuknkGUSwIURJlJbrNK3gxPYKc7iPfxfqQqhZFkUzNG
	0yB8b1v+rCFij5Gpwopcwf+oxHOaJvlbverrXg4+0dPQ0rN+GBwkFpQ3zascOloc
	t7rLFA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duy1wabr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-650709ef300so2494683d50.0
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554807; cv=none;
        d=google.com; s=arc-20240605;
        b=RThyp+p+E+boo30MUPMfBxYcSTdeCs99nXY9aZqQQzeA2/2JtNtLrgM6uzZcOCP0+B
         xd657Mp+EyS9m5vN9Z0IeNF/BLFKraxGXrLhTirDj5rdx8y4xVyZl/DJk5WiumUfd7L4
         EVNaV/1uncWacCec5pNi+Ca/nmHHhci8ng4Hk1E897V9V7LSzH/xjyKUKtzOxTSwOMJW
         lETn7hlVF5ljmQQ5vyVOB1a1JltKQZvQg74YM/DceM+vUo8nTIUplhkpCKaURP++horM
         jDisUJMcl/FFn9GydP1W5LoIOE41opViAePxM2N7/a8sYWENHF/kXqQ2g6UbLmBycMVA
         pOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        fh=W5/rLTv8QsRF4+onyHt40a7FRDrMiD5HhqnWE1zFNgs=;
        b=kurv1Xx8SRqJFVazaEI4OzjKZ1vPbBEOE42ML9rUMKpL5fpXo8uzn1CttZiuR3JIK4
         KcFrhCN+4SGvD9wsy4dROVMthpeviqf/p9Tt2UsZuWEcvJbxPGyOJxwv7SQmMYMq5Jak
         7/hJNHuPKzYxeJWNyKPaDPMF3YEwfHUNicGVWZM8VPZnC94Hfa2oGkMHFS5E3hhG1M4E
         fkNu6UEgnbJLtTwhauW9xoows7c834zCB+preHGsBsBMhIHhctAsLq4xBO8J/0dhFjjZ
         Wr1F9q/3xi+eab5kGSelk/wJEeR7E7JbzMa0E98oZx+EK3ePiNIWcSNvgTcnI+jJVJmZ
         TNYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777554807; x=1778159607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=FwcyrArfxVUEmUhB3u8Cd1zaLyprWFV/8QsAGr64S3i1OKV1YWT5ge6d65LkrBgQtj
         i7VvtXz4aCnaUNAKiQA9yIRIXzjfEDIZTvDcxoq+VaoSJx7Z0sngsyGGBstj8Zvk3Feh
         kPWTRxJ3uWdlF7uGPCQIIJ9C1SFAWMCMuvsid+MwkkbpU6eefPGaUbvLCRJjnsjgxu0x
         3lLI9mQiZy3HPWt8t6c/kcOEehIRou+EqkUsyxNXO1QEQ+p+8pLFv4Pyjak72Qz8q/d0
         VkOwBvmM06nD8NE6SpVnDntC1KIyiiFErPPHhQmuZfcxGiVvQiTSqraGm/aAFjVkqurK
         oXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554807; x=1778159607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=UqskxoLZh68DC6WG3JzbM1Rps8HPaixR+6FP0O8ljsY+BKFWbtw+xFcXTYr7QRnFED
         AdZBLpVWevF6dOrQFl930WAubmpYeTUH4zc9DoScJAtjOGmidU3amzxV0N8/1BwSAjrH
         1hPludhT0uvTCmEOmqJLGolEG0r+DAd3Zkp03a/flplyl1flIezSCWC110bKaBJTxQ7h
         nP+BOvCnvEtU9QtXRF6kdpr7J3LcVXXI4ENWRLg/2GFi1zWzoh9XZ5HGArd8ZQxvHQrX
         rwpaw6RQoObjn6ws6V+h7GV0RcGRm9lBOfSN737bVGJGI1v1NnIH+rsLbN5yp1Tx6Uq1
         WDGg==
X-Forwarded-Encrypted: i=1; AFNElJ9/hOQlFJ3j1v9Oan76zsKn5SuoGuSkmvyxcNwPjZU1uYjdM0BuhbOKeWAEPtyKGMooJXp+pKBH/gcLiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTOArpHSjFg8zqo+X/0+lUH8FgxaThgxi1uyqxRGcqB100lsh
	rdIEhSWtBKxL4epEpRexi1Mc+M6HbJvd5hi2jkLi7nhPj8jKHjape2AgaWD9hnxdO6ZUbqO1iVx
	RncHpqVPDLr1Q+awcKoqpThgDI6Uh4moTSj+gFXpCvBepXm18UuoYP6bw7LBaT2P0JP5AGOYZ4T
	Vl7utT19o6SPBqk3xk++wOSIcBH5bm+nPoHNJcZz0h
X-Gm-Gg: AeBDievUzMeZf6JMUXncnZOLEfJhqM2/KtH4zFE8HGCp2apVtM++KD2rocjh6BNsoM2
	bS9XaFn1ovHRPhuV6DAR+Qv93QEGNtRvCfAL+jxosO/NbbP6HuSb4jiStS2l53SY7NzRkPLqSBz
	B9kvcW+I8IudPnJ9H+lPcbC/cAdaZBYgMbbOs6yUsWZomp2QBL8hL0OhE6jDO+a8WMSfbtNj3tz
	dsmKz1bfvkRrTgoqcJ0gts0w+PZD3Q8WryQxthQwfVqEbJTob4=
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id 956f58d0204a3-65c1b0a4185mr1181513d50.27.1777554806653;
        Thu, 30 Apr 2026 06:13:26 -0700 (PDT)
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id
 956f58d0204a3-65c1b0a4185mr1181471d50.27.1777554806063; Thu, 30 Apr 2026
 06:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com> <20260430-bird-of-sheer-ampleness-744e7f@quoll>
In-Reply-To: <20260430-bird-of-sheer-ampleness-744e7f@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 15:13:15 +0200
X-Gm-Features: AVHnY4I6bR6fdSxJnXBrJdTY4FKOp8Nu9g27U_d0aw_5w0XdML8zMEtBVrvqIXA
Message-ID: <CAFEp6-25Xad_LT8L-HPpOpXf7j1S=Vew=iSgxEmAHd_on+jkcA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 4vAdPl797ByBpGOEqw-IjUhVaEpafjir
X-Proofpoint-ORIG-GUID: 4vAdPl797ByBpGOEqw-IjUhVaEpafjir
X-Authority-Analysis: v=2.4 cv=DPy/JSNb c=1 sm=1 tr=0 ts=69f35577 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=Q8QnmAOcOvJ-T5SqZIoA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEzNSBTYWx0ZWRfX29y6j9J2qZ6I
 WrJGG+xYD7Tug6Yn3QJ1kFdRq0yOSnocYEoaznnIiYRPBrPO/vI0u77WneiJnXqPMdipE7snIgJ
 doHoGiQiv6y1UaXtFQ2ZJdtcU91aOAQ9PujUgLmZz8n8NA2VxbqHqlbtPEmOsukcfM+/T5CKy/a
 wO0RVGdzhR09NDO1R0223qf6seh643Zt68JlLm+lMbhRwPYU7XWQ4cHUI2CI0Op2cWhX88Jdtdi
 cmS64ksADVIBJjjAMICgsftOBo43qrXmvChFUbP5YEBILWtFlqJvDtsO0XpOecAS37u6GvEpO7F
 x1ltDa3/UBiF6+GtnRS4LOHDqHZRRBFwOoi8tkAXyFWXOpkrgpTnDvl3Gq4Opp371EyoaYsGxRn
 VENb008FHPH1U7axQ9vnyAl7dp2xmNpcJ4ZCFe3WOpoVRf4U7eFxDG+OjwWwPfUHvGuGKTHjVYa
 hkUYshl3fvVNNSdOmjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300135

Hi Krzysztof,

On Thu, Apr 30, 2026 at 11:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Apr 28, 2026 at 04:23:06PM +0200, Loic Poulain wrote:
>
> > +                    compatible =3D "fixed-layout";
> > +
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <1>;
> > +
> > +                    mac-addr@4400 {
> > +                        reg =3D <0x4400 0x6>;
>
> This looks incomplete. Why isn't this mac-base type of entry? And how do
> you address it from NVMEM consumer?

This indeed falls under the fixed-cell/mac-base type, thanks for
pointing that out.
NVMEM consumers reference these entries using the nvmem-cells
property, via the corresponding label/phandle.

>
> > +                    };
> > +
> > +                    bd-addr@5400 {
> > +                        reg =3D <0x5400 0x6>;
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.34.1
> >
