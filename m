Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AD4A5C3C
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363226; cv=none; b=sCaCZ9kVJ/2iNEZ/XoDMtehDRD/OMWmK7mHSxbcOgtQ7Khho8wEJRRCXxegHaiZCDjmNBrP5bWaCgY4egSdpcQIPmDoqmAVM3PB04UAOmlsVeXFxOdKRixK8AIg12J3Ol8AMEDidxAxi60mAwA8atmIbjv9cAnzBM5oJm5amINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363226; c=relaxed/simple;
	bh=6lYF9KV2HEwLFq6+al6aDkTRtGMquGYtFJdFYnQXEN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpuXA95wlmp02sZ9g/tegVhhHRXU0wETJgAbIlTKfnugijxEeRNQBBH8LWIQDga2FQb09zCSWI9zv5Rlczvl7QcQZwWy+9p/XWpKbaV2kNq9JbdkxCEXMmDWHrVBzXrs8rSRLzMZw3/30Th19W5M3gMr3DY98NxB00VtlmONUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GE5dYC28; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ektIQOEE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GE5dYC28";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ektIQOEE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CRJsE1491381
	for <linux-block@vger.kernel.org>; Wed, 2 Sep 2026 15:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEUZ3PVE55ql740l9KlzWi1uLalDgnols2pTFF/fh60=; b=GE5dYC28o04T50C0
	MXh94TFSKPDeiSYrFJ1HggyWYY2E7z2bj12OGdQ9WZVTbNggrcxgO57Nb2usJh1o
	N/1ujNarxL4hmJeNoiMB1634vamDrENqIR30vnWvna+bPUUs4gKUVQr3Wjphgjpv
	+9ICOfwtZ4C7UREApQ0jio9n0N9EXHu/Q9Em9LqQKjIBun/kwmJv1vV1LjokUGjt
	uPtIX0yx9J35OEPpdfGMHgPybL7JNDjhVQlpX5wzKxOVMY7bV2bfY67irjMEt2xS
	2le7WpLIxdWm589t5rXlUrwQTiJF2g/qzPJUdrCIHZUnkR7kSg8fMNtg+wqdpws/
	0mNTUQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geb562ue3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 15:33:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1c1cc5206so1473204a12.3
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788363222; x=1788968022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEUZ3PVE55ql740l9KlzWi1uLalDgnols2pTFF/fh60=;
        b=ektIQOEExPBBQ8KqOSt0nLpKal2fSowYr+3KxPBDKTMXkWt/N8874yWx4a7gvhVrD3
         sjhQ8BDTTyxI0tpUs4HPvdmTxMCsBHh8NdEVUw9pGImUvTJy4+5PO/vF7nx3jAVlDW/l
         uq2gUXqC6+/dL9k2ZxrUq8ANVLV7GpzObOqmOTbHCXg0QH/AIeF8zf8NwHlGOnyDj/pE
         O59JtNShILPXlw270cBlBn33lxo8aK3hXDq2Zcs7B0PlxFarepIhkx2wgvPuWBSj4VeP
         2LPg/eHMGV+cOANNbMMYGat8/Qg7swHXv+rccXNvG3XeUyHf8JfRMBcHlnaPQcxZ2lon
         qvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363222; x=1788968022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEUZ3PVE55ql740l9KlzWi1uLalDgnols2pTFF/fh60=;
        b=YMvtMY1V19iSHsYpP4ciGrH+hnhm8UBRww8iVbwTr+deUIBhR0TguOnbNmjOGVa/h1
         8k4YUMVidG6phuGR7ZHZC089x4G7ql04r/DjYdzX1YSGHDyr4diiuGaHFF7C2PBKkfdJ
         uW3io5ZWUioAYJSR/H9sEx6dojHpt1QXu5GTcvyVmgbLgccYs9407el5S8MWCe6bNkKy
         4TKhc6tXibs9/N3oUvYJpdr5XRUVvcKXWVilRhiBrBC9YKr7e4KdDh6VfrSPSthMSsFz
         BgSgNITpvdAKE5jFIzWlR+YcI4OJ7lYAMmAL8USJ1LhBOhUB1FGCFtu2IW17CBvO/vGk
         Ui7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrf64PfpwKk9w8BksZDugB6dObmdXmG6yz0mc6Woe3U1Fupl/zOP9xSjrqzMym3LcfOs4tTujDeGh9Og==@vger.kernel.org
X-Gm-Message-State: AFuF++n2mJSshIIvJ6XJj4pMJqIL0i4/52Zerp3Pr8wfeNSYYSfzlgxF
	AEwPrN/kZbFUounCbvnaZ+rXemvqDWASwm6CvcdX3/3No1fUuvU3nQMlneDoFl8H39a1v/P3N53
	4K7lcw+LYJwMpHnWZIhx38KgGK+3Q75GFjxOJay6R/gCmN+6wrGY2vfUr0fZ3SWWBIA==
X-Gm-Gg: AR+sD11zy5EcXyKYa182l7ZiC0a6c7lBglKpKnAmLKLr6LwVKYx5Xew6WXEELKmsX0V
	ZGe8ah9jr2rBagbcmfiVqgPAEiKeim8eRJpQ2PdBGnIqa8IZy4UwnL4631jJjcTAbYIpCybkWuI
	XkmPrDxVTWwTgiEgYIgqPvIL8u7IgyZlwVgzwKPFmkBylv1SvZuJy1tYHyuH0XkihuecJuUOiQ5
	CgC3bsSAK02Q51ttl3t/vx7ixTUIemdJo+qIiYFqhwV0mdTLXhq0hv1MosdMAmVtyAYr4+gVRIu
	0l2I/sIw2SsUwRlEZNNn8P95WRh6cZz4shZRlOjrhqcMYQNBdnpPUVPEAMPOApp8eKc2Ku9zEt+
	vtql9NV5ZsV5UyHx8E+NoYdGpBvH230xfmhTGRE/2dD6JE/DI7hWZIqx5bQ==
X-Received: by 2002:a05:6a20:9f43:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3d9aecf72e3mr9896587637.24.1788363222096;
        Wed, 02 Sep 2026 08:33:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f43:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3d9aecf72e3mr9896470637.24.1788363221571;
        Wed, 02 Sep 2026 08:33:41 -0700 (PDT)
Received: from [10.110.114.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079ee369sm7964033eec.7.2026.09.02.08.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:33:41 -0700 (PDT)
Message-ID: <418e2285-bb95-42cc-8543-bd540df9d0b5@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:33:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] soc: qcom: crypto_virt: add support for create,
 prepare and import keys
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
 <20260827160806.1295313-4-linlin.zhang@oss.qualcomm.com>
 <4594e3db-a8e3-4f8d-95c2-a4edcbc8ca7c@kernel.org>
 <40156974-6637-49b7-8629-11e7d0d4e55d@oss.qualcomm.com>
 <650ac172-312f-43a3-ab5f-82318796472d@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <650ac172-312f-43a3-ab5f-82318796472d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfXxeH+CGCgSXK4
 AZAQZtaqSMcEN/O+qSW6GuK++RU/cbQTq6qLjAo2o/F9sU0L+h6GaZ6ZU00fq1+wlr3w8LNY9wf
 HVVB8U18dW2oo/5EAZofbJhTBLxAMfP+QT03xOwzJw9y5Da7VHZ6GnhcvwcIS9n45zOBlyt6/22
 10J9h310v7sAUMHxmCXoDVlj1T/DIO9FayE7u8q75SDnVRBzJmRs8OAEL0BgQPS3lRWPUtcYKSt
 ZYDGUfPTFl2qvtL9FRVZWM6ZwsCyX5kmp/hDKrwBSFVZmru8V980P394262w9vlH+7/vZTKARah
 dk45v1E4UwhzOjrmH4RZYzDH9OyE8bAwBWIh+nZ4yfU1gBS+WRtcxqZnYNySdr7zuQEyqdVmlo8
 3ZLolJBMcDE5NtMzhQkm6MPkvOYia1pVuADHq2omWI95b37uZHI04qDKAdNw+n0FErqr9SMA831
 89yR3vkuN02j7HePMpQ==
X-Proofpoint-GUID: 50u6adMAWtWHKRSTvkF75__LxfW3F5As
X-Authority-Analysis: v=2.4 cv=D8N37PRj c=1 sm=1 tr=0 ts=6a9841d7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7gRScLy_F1O9BZcavHAA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 50u6adMAWtWHKRSTvkF75__LxfW3F5As
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX/lKfxtABY91B
 FFX7AYmxmC8R3vKmv5MsGlpocVxBaQqfGD5auPO0RUvTA7OBTLVcBdV0AX2JqA9Tus8qZXZ+NAr
 fsq6Oh5KCCyVmskiU2ueuz5nfoXFABU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020136



On 9/1/2026 10:01 PM, Krzysztof Kozlowski wrote:
> On 01/09/2026 12:31, Linlin Zhang wrote:
>>
>>
>> On 8/31/2026 2:58 PM, Krzysztof Kozlowski wrote:
>>> On 27/08/2026 18:07, Linlin Zhang wrote:
>>>> +static void crypto_virt_remove(struct platform_device *pdev)
>>>> +{
>>>> +	virtblk_set_crypto_ops(NULL);
>>>> +}
>>>> +
>>>> +static const struct of_device_id crypto_virt_of_match[] = {
>>>> +	{ .compatible = "qcom,crypto-virt" },
>>>
>>> Undocumented ABI, also not really allowed. We don't take bindings for
>>> drivers.
>>>
>>
>> The dt-binding document is included in another patch in this series.
> 
> And what does the submitting patches document ask you?
> 
> 
>> The concern about introducing a DT binding for a software-only driver.
>> The underlying problem I am trying to solve is how to communicate the
>> wrapped-key size to the guest.
> 
> I am not asking about your problem. Can you please stop answering to
> actual problems with irrelevant other aspects?
> 
> You cannot have DT for a driver.

ACK

I'll drop the DT binding and this patch, and look for an alternative
mechanism to convey the wrapped-key size and key relevant requests.

> 
> That's it, please read DTS101 slides.
> 
> 
>>
>> Because the guest has no access to the ICE hardware, it cannot get
>> the key size by reading the ICE hardware directly. In the other hand,
>> the wrapped key size may vary across ICE versions, it's infeasible
>> to have a fixed wrapped key size in the code. Additionally, wrapped
>> key size is vendor-specific, it's nor proper to pass it via virtio.
>>
>> As an experiment, I used a DT property to set this wrapped key and
>> wanted to get feedback on whether this is a reasonable approach.
>>
>> Is there a preferred mechanism for handling this kind of vendor-specific
>> configuration, or are there similar examples elsewhere in the kernel
>> that I should follow?
> 
> Not DT. Use whatever other mechanism kernel provides.
> 
> 
>>
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, crypto_virt_of_match);
>>>> +
>>>> +static struct platform_driver crypto_virt_driver = {
>>>> +	.probe = crypto_virt_probe,
>>>> +	.remove = crypto_virt_remove,
>>>> +	.driver = {
>>>> +		.name = "crypto_virt",
>>>> +		.of_match_table = crypto_virt_of_match,
>>>> +	},
>>>> +};
>>>> +
>>>> +static int __init crypto_virt_init(void)
>>>> +{
>>>> +	return platform_driver_register(&crypto_virt_driver);
>>>> +}
>>>>  module_init(crypto_virt_init);
>>>>  
>>>>  #if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
>>>>  static void __exit crypto_virt_exit(void)
>>>>  {
>>>> -	virtblk_set_crypto_ops(NULL);
>>>> +	platform_driver_unregister(&crypto_virt_driver);
>>>
>>> You just added this line, so previous code was simply wrong?
>> No. In previous patch, virtblk_set_crypto_ops is called in
>> crypto_virt_init and crypto_virt_exit. This patch moves the caller
>> to the driver probe and remove APIs.
> 
> Heh?
> 
> Let's look at your previous patch:
> 
> +#if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
> +static void __exit crypto_virt_exit(void)
> +{
> +	virtblk_set_crypto_ops(NULL);
> +}
> +module_exit(crypto_virt_exit);
> +#endif
> 
> And you claim that you did not add this line?
> 
> Do you understand how diff format works?
> 
> Best regards,
> Krzysztof

