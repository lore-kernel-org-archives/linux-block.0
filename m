Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218B4A49B4
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361452; cv=none; b=Sb7en1lGX+semvuZBsRbtq6LWGI9TqPdfkZJtrQW9KaA7yP3y3LITCeYacEFedyUNm0kmyYG6lk/f70GDPA3GlfGoXPEjINd4sSi7Aj0G8j74amsjErUuCjFNoAKI0rJs82XCAFUBTzFosIa8XlPnVp+v2Lq/Vpve1vpqEVc598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361452; c=relaxed/simple;
	bh=wCCHaHjAyebRsmsmEX2icSW1s+oMksjOOy7EFoGCWjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZDxZ6SFzDe6k6huXm19OwMgUk0GCvFTQqksHl5HEpnyjp+XpVR/mhJrRIIPfr0Ab8Q3W12nvWfsxQCiUDwQU+okduWznD3EisJcIXdT7tKiw5ykvZKmD2fl7UUsNsKbZFEnUIOIhrr7pSRz5E/mxEjaOCL7sTlMuXmZpbvot4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gslt+rWg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QLL7R71v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gslt+rWg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QLL7R71v"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CRHpA2001810
	for <linux-block@vger.kernel.org>; Wed, 2 Sep 2026 15:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8d/HYLVaYKgSu6VLD4TUXAuT+WMimsoAlFLEDX6rbHM=; b=Gslt+rWgaEkn8Wtt
	/GY4xVCimRHa2DbrI8POvL6E7qeLQdytf4vC+D7M9SyKb63Zk/egQ/aHObhm5XSu
	34V9wJoSKIIdXswfhBcglWSNWtlppU0yMF0W8bzoiG+2wlczpOXtKelwdMeoD7kG
	d2XmgIofGoxkaz/bwRWU2k0qB2J8ejlZxWBqPkI9Ixy6ZmNh3yRWAZ43JOXZ+/Hn
	ORx3Onu4LCsoqeCGG3G6B246sbXK2ZAX9tO4Ur3C7Qn/lcj48kj66sch0Cd5xSB0
	JlKyaBGQHkbbv7QF0r0IxAZU9Hy5IWzu3aVlynpWBl4F4bzz+a15q0OtyyAOOMPc
	y+04jA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy1cxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 15:04:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1714300a91.1
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788361447; x=1788966247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8d/HYLVaYKgSu6VLD4TUXAuT+WMimsoAlFLEDX6rbHM=;
        b=QLL7R71vk+9dM6BX418uUmxUvVjifKFKHpa7akYe3DcSLr8z7gRRd3D5IjmCyPfQyc
         trLKA/KfiUXR+Z4Z7ZecNA7vfj8SrmEHjMz8ZVMMiG1m6WsnndCnQdO05zf3gn0nesUQ
         tOLKYY5Bj5DMUX57LYcxUPqgOCfj+jurg+HWVKHzrrbvjWLo5c5REAZIcB3zKjkaJae0
         E3w5gDBEa5LdY+fOEFY21asg3wvEYl6QgG/+Mfhq+O54jynKC1FsTqY363Lp/ZZBvq1O
         +oPDlLjyWmae4CtN5KufKG/dI2RmQibic76TDHTA6O06dQ5R2FGPqs0DgogZsyJZtGCM
         EDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361447; x=1788966247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8d/HYLVaYKgSu6VLD4TUXAuT+WMimsoAlFLEDX6rbHM=;
        b=plfKpyn3RP2V2UGkMrEykBTbJhR66wzYv8TXlGt05ud7KNLSB9FBmK+aJixlVz+WSw
         XET92ff5FpsUaHqExHVwMZmPO21rOfhVxQ3m67EzbcngcDTRhx2Z/kp8YopspSaPAUod
         Ip6i0Dce1h/QRc9fZ1JLlOWwM/JKzcpKB7gOH41EhxE0fmJSLp6bDn8SCL+Wt0d4fZjF
         r7BD5TkjpjScJdqRiThu6hks6YrUhOdlOtNl/HfB3fNMht7xRV84C3Lg9ljWmCduvxHu
         cZZIfDj5PMezqnJPNs/Z2htvwu6r9nGG3cB1Cw870F+q+x0FntUm8k8FR5vW84AqdgWz
         BHgA==
X-Forwarded-Encrypted: i=1; AKwUvBytoSXLxKaWuRDDpqub3dwfJvEz5lJFarUOuLwvzupXdGAozIPf9iWOiqX+0+coiG/S6Jq4ERikGn3V1w==@vger.kernel.org
X-Gm-Message-State: AFuF++mV9l7cW1DiMktRtJldcPkrX6PP+NpHZk39GaZ1kcWg449bJiNl
	NHwv1vgFSPvutlnPGCq1z4r87zmW6BB4DMckkd4L4XG7DTvsrK85vE0tUA5qG77Xo1bjhEjBs3i
	V6xEprXrbRa40iF8PoucHl4Sppy/sQBaF+xSl65h0iGXOpM8wIUWFXcDWWV3lVUPkyA==
X-Gm-Gg: AYBFou2J3rQ4Ici7IXUojvfJ4wPLmAG5/oTt+Mps3gEYgT5DV9G59D9Lt3wjo+TgISI
	Xaoc9a/Bj89EtqjwQB3dLDUBS/m9U5u/u0M88Yy7KE0kMaQIj2QXYIgMisTS2N4KewR9cRKsT8q
	kekyfIpLoNHSKbidwtfzAHUS675yzc6yO4d9O3vR/o+pYRoS8D9k6dmyiwI8lL+SDuK4AT8FZTt
	9oghT9sJ0y+Lnq5Zb21ilVfLRNvpk75hD8bUvf6IP68QKP/FBCT100w5yUnFXhJx/kCPQHUy40Q
	GYcQvk2O1DyHGASXiKfZCDr/qeh1Eck5TD85KGeqrhh5GW4tUi1WjboOoyZ+mPpwU0ZeHtDJ2Jo
	2hbxCvOlV99HpPbpmdd015o0JSgWiGgYzttjoBQr6EILc98wjFQZDQ/loPA==
X-Received: by 2002:a17:90b:2ccd:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39aedf77333mr8400144a91.11.1788361446263;
        Wed, 02 Sep 2026 08:04:06 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccd:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39aedf77333mr8399969a91.11.1788361445459;
        Wed, 02 Sep 2026 08:04:05 -0700 (PDT)
Received: from [10.110.114.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f1f4fsm7552713eec.11.2026.09.02.08.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:04:05 -0700 (PDT)
Message-ID: <d530f962-4fd0-4897-8022-c7335167f450@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:03:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] scsi: ufs: ufs-qcom: support ICE keyslot
 partitioning for guest VMs
To: Krzysztof Kozlowski <krzk@kernel.org>, ebiggers@kernel.org,
        axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
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
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827160806.1295313-12-linlin.zhang@oss.qualcomm.com>
 <046e4b62-6d25-40fc-baa3-2978eb96eb70@kernel.org>
 <b571ea8a-4434-45e0-958f-20b2f83ced24@oss.qualcomm.com>
 <ff869d8a-85d1-4148-b19d-af3a70fcc904@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <ff869d8a-85d1-4148-b19d-af3a70fcc904@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a983ae8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Vihkso_W4dyqxCYGQKUA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: rpnilnfsPHGGpdg2aj08iJhzNKiWVfUE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX2TGV6EVa5ygf
 GgYEq2wK9AraPJej31DOrd1OYQBDreqS55rRlUiVFnjuyPpUK2eY9TBMYrzBpotT0N9ekbFb4Z4
 Cn7ewRJ1lJKZ+iMTFk07DZUNca/Rta4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX8dHutuJLDeNN
 xnLexSzj8A7yfsnM9pnbAIFBSTX83t80mA1fSRsE1WLnMRedahNZCl2UhlBzLZ8gD2dOQuu794H
 iipfJMTFv69Yb/u7bGAKPsB/AwzHtmuwgR1sFNp8HHCE5JLXyTNnu5UMBXKRuANfo85FvyZSXMa
 JG7gtjRORwfx9RJyLJqx1l42IQIepKgzyPhHtQhPQqkr5R2ECneCV6K8IkXkGL95VEWNRB1ShKm
 i0qPJNQAJ536MT4eXDxUwlIiln6avVNBICpMG/EYf+PtQvOProkGVHrIM9PuRUXZf52RUSPKxZd
 Kvf+17Z87ojAQiF3O8AMOUAnT6sh+FupMzvb360DEns0GVywFmEcGe358k74Z9JxTzSWGAufql2
 R68kYgPbHiQ5qmkq17EcEIfshN3QkOw2YcJJMq5xm2fjcMyP17ZR65qTVjXSCyedH7w7VhywUEt
 q3Hz2DOe7wV1aH0YD4g==
X-Proofpoint-ORIG-GUID: rpnilnfsPHGGpdg2aj08iJhzNKiWVfUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020133



On 9/1/2026 10:02 PM, Krzysztof Kozlowski wrote:
> On 01/09/2026 12:54, Linlin Zhang wrote:
>>>> +		u32 off, max;
>>>> +
>>>> +		if (of_property_read_u32(child, "qcom,ice-slot-offset", &off) ||
>>>> +		    of_property_read_u32(child, "qcom,max-ice-slots", &max))
>>>
>>> No, there is no such ABI.
>>>
>>
>> ACK
>>
>> This is submitted for visibility. It may be revised in a future version to use
>> a TZ SCM query interface if current out-of-band key operation in the guest is
>> approved.
> 
> Don't submit downstream code for visibility. It just clutters review and
> wastes our time.
> 

ACK, thanks for pointing that out.

> Such code IS NOT ACCEPTED to upstream, thus posting it is absolutely
> pointless.
> 
> Best regards,
> Krzysztof

