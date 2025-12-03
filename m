Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0723D294
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764733139; cv=none; b=R1tIAQclqzKxLrXMuJPl82T8rdkkgZnVobPrFaqJ4kclPhOMNSoaFwlsqSRBwrsUfB3+2VMq1EG3pV9a9EvaAlOEjQLCPy2sd3JRLt50Xx+9PNAxK6SCJFJr4m7r6Jc6VjlDJPtSZ/Dpo4j1UAcfi0H27tYxTVzpTk/xA6x9Gug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764733139; c=relaxed/simple;
	bh=be2b0468lQFmUwNQm895C5OTlX65Q56XoJN+b9VdIqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjhRczpxlnrOMmyz2KbF5Bgxe54TPM9B84CC8ev70huLSkRZ1lTXwNBVGoJdnbrxvJA9xkZEkl37PI0YaB2i2evEQED79ZFpxy48CtUuH+XYgnGoaY92rxe7Bp17yGBx3tPIWbquxIZW5rCmruV1Wm0BIC8sQSvcXvBEQhfTWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILqbO5+d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XApMPvkU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILqbO5+d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XApMPvkU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2IT2ui4130766
	for <linux-block@vger.kernel.org>; Wed, 3 Dec 2025 03:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O2b/KG4xxXm4JvsuNL1P2eQaTenX/vdWmfZj/ux0mL8=; b=ILqbO5+d2Zna4slU
	11MdNDvgXoKzIA8mqyQjwEmZagndPZPwk/5hp6CFs2ZeYXz8nhZLP2Bkq2BGKfTL
	N131KQUMbN6K0n+KrV4IhNaSyYPfmZOltwOY9CvMwp6IVPy6WAtG3rnY5ArnEWUW
	TN5CK5rqpsKj5CfgpoikA7Mc3zfnHlJN9l4NGXbR0QF3uVhBM4hA8Gh9TGgbqADR
	FT+cB8+D/Q/QbxrAJ3XMHYfMyp/Ae8VdgjAY4QluyQNUsgnJ7riTtUHZ/ozHG3wW
	Zjo0obYx5dBKyAWJBMUESullCNCizLsKHG/SNy8Zi7ITddhhGpOIbWOpjtojLaJS
	FMLo2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at5e79b18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 03:38:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29809acd049so109984115ad.3
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 19:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764733137; x=1765337937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2b/KG4xxXm4JvsuNL1P2eQaTenX/vdWmfZj/ux0mL8=;
        b=XApMPvkUlT5nE7Pp+TdhI1JSFBUZAVDGBcZbUVU2CU3t7v6XkW6C68T/2f6HeExcJ/
         AK+kqX6X26vPpepIb6Q8WhtsODJ2emA1QijzdmF+D9gyTgnwH/2iTZc5h3hwePqhyFvu
         LCdVWjofZ3FMpa7mXBw9SJUCBsAp9PBo7/ADhrD4+hMOxg6uybzwRbuyfhBzaOVyZBxs
         qVcEQtRu26MQrOKT2yPeDybT3r8aS+/Bd98fqKZadvMIrE+m39xZa0kms4PDuyCTc27g
         keOTbSwuOy9DnEbrhQC69MQnZYbYyu6Ts3f46CEOqydyL20zQs0YYOKbluRX9fCRxl2t
         k9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764733137; x=1765337937;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2b/KG4xxXm4JvsuNL1P2eQaTenX/vdWmfZj/ux0mL8=;
        b=H00ULvjTIocimekvGXrbZdAEgi1nuNw80mtZl42f+9rI7deqqjrJfrUcg1xe/bPDAP
         8/9QqM/t3Cjwk3CDTSE3TeBbqoDWutvZ1OGXkDwZUXSJzt8No7JqfJZjITgj4OPtfQNv
         vxj7qO5MDxY3svXlSEYWvRGWXevh3bXBqkROxjD0eBDSmineOhiAcqrMusc92RKLPGqQ
         LayZsdla6P4bVOYFUrWd4LgXIWOiId+ReYQOzyFf1YvUpxufaDxLNjO+ZSn94tDiI4ON
         M1LwvznxDeREEII8OdA6InsxaC8LkaWQS9KQ9FsNoH8EjWrXlJKIPcwgOszhQGsG86va
         VKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuopOEqV1sV4nfZeWNOVcXFFWZxFaXUO+vGPjst4pHjbz/ac9wugahacp557Xmil3AEH0NbdVdG+s5MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXnLLpalP1rYQXMeENuc0qS/7TLsu+CvKVAgeCVFMjd+p6PQe
	6liFtg6CuzDBc/YnLCbyh6B1FJq7Ergn8xp2U32ix1ENQTW5FxuNH2NcagEeq3ms7TCEM2rGbem
	3W5YkBZIY3aS+fV/lAtA6qI9souTy5jEnwk+qD6eQuex2hZynWtpSuov4JfiCDtoKNFbGpOxQXK
	WYq6k=
X-Gm-Gg: ASbGncuFWB4Uhghrzk+y7Gq4vVnivn0+m5kZU4WJ6PFSsOVAGI/qXWZ4olWWJnzxvOw
	GeXh4dag4zZHs/xh4HinNxPa1vTyUb9+r3+32kS7ywoZwGKp/EZjowV+9DbFPpwrHU8GiSbZRRe
	hURyIjXC1JzpXgm6o7PBwpKnpURJXJWcOMXbsR0KiF0bGn/7b2vDI6dfZ/cWIUe5yk+Ivgy2B2e
	WVaemuNmODRJzRT0hE1hT9fGueNHshAanSfa0uds34LWV9X5VDUoazvGUrEj1leCvRtj/ypvNYs
	2gyblhpl5y4R9b0b8YslrBrgRwKkHU356UbYrlWDwI6y/e80sHvPB4z4ugej5rXCqrynCZGQL6R
	433lVoWLMJnXR33cr+5J71VMYbwb27il5subYdxpnee6sb7wQVtDP58+XKCIBFkqATd9ehHEV9h
	uJnKc=
X-Received: by 2002:a17:902:e785:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-29d683b001bmr11936825ad.40.1764733136683;
        Tue, 02 Dec 2025 19:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjJ0MJu0/XDzPkMG7W1UbyoF5C/GcKgUGk1mDfhAcedcMCurYvLCL0rql5MFXz0/Phjo50Q==
X-Received: by 2002:a17:902:e785:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-29d683b001bmr11936635ad.40.1764733136238;
        Tue, 02 Dec 2025 19:38:56 -0800 (PST)
Received: from [10.249.22.154] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be508bfd8ffsm16315106a12.17.2025.12.02.19.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 19:38:55 -0800 (PST)
Message-ID: <5d71468a-e5c3-4a85-b985-466bae6af70e@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 11:38:52 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Abort suspend when wakeup events are pending
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavan.kondeti@oss.qualcomm.com
References: <20251202-blkmq_skip_waiting-v1-1-f73d8a977ce0@oss.qualcomm.com>
 <aS6vYCg2Gks2BGHn@fedora>
 <d010fa56-3c7d-428a-810c-02ff8b1091a1@oss.qualcomm.com>
 <aS7bmjmqBEV2CTEy@fedora>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aS7bmjmqBEV2CTEy@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAyNiBTYWx0ZWRfX9KlEgeLgjSD+
 qjHHmX5nAtjKSdqvoibP42OMq263uMp6des9sdp9xPpZcTp3u6JPDLgmdIFoffsSGUCj1sDqXFc
 NvJBihucCmh8healXIP4fCG1AXlAheX9NMN0kFxYP2fCjiP4TnIJkVaYTYAMv8Oe0ywAC5WqxQU
 pklRt3Yi3w/1tmdv+bHZSBrIUPoyOm7xol9mjM3m+A/88OvslPcdtAe+dldhKoSe+UvgDgQpjdm
 jrmNSiSA89p03kSdbJOEP+3U05uJ0JVoOtZ7LDwCtXY/DMSBv91avCNm2fEsD3LOJlzLlDUnH1f
 aZUaU7xdmjshnpceTIC0vO+DyLXcHyGx5zh2jSsRcU6AeC1b17OOVvsfM4NVZn57h0QZleJgeYc
 c2YXh3sG5EPfJq1G/VCmGN3zh3mxtg==
X-Authority-Analysis: v=2.4 cv=KcrfcAYD c=1 sm=1 tr=0 ts=692fb0d1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=STW2nHLoXGP7JFEkyEgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: pGkbZDZ6gihF9N2x1hv6Ff7hh1GvYKqM
X-Proofpoint-ORIG-GUID: pGkbZDZ6gihF9N2x1hv6Ff7hh1GvYKqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030026



On 12/2/2025 8:29 PM, Ming Lei wrote:
> On Tue, Dec 02, 2025 at 05:48:21PM +0800, Cong Zhang wrote:
>>
>>
>> On 12/2/2025 5:20 PM, Ming Lei wrote:
>>> On Tue, Dec 02, 2025 at 11:56:12AM +0800, Cong Zhang wrote:
>>>> During system suspend, wakeup capable IRQs for block device can be
>>>> delayed, which can cause blk_mq_hctx_notify_offline() to hang
>>>> indefinitely while waiting for pending request to complete.
>>>> Skip the request waiting loop and abort suspend when wakeup events are
>>>> pending to prevent the deadlock.
>>>>
>>>> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
>>>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>>>> ---
>>>> The issue was found during system suspend with a no_soft_reset
>>>> virtio-blk device. Here is the detailed analysis:
>>>> - When system suspend starts and no_soft_reset is enabled, virtio-blk
>>>>   does not call its suspend callback.
>>>> - Some requests are dispatched and queued. After sending the virtqueue
>>>>   notifier, the kernel waits for an IRQ to complete the request.
>>>> - The virtio-blk IRQ is wakeup-capable. When the IRQ is triggered, it
>>>>   remains pending because the device is in the suspend process.
>>>
>>> Can you explain a bit for above point? Why does the IRQ remains pending
>>> and not get handled?
>>>
>>
>> The wakeup capable IRQ is not masked during suspend. When the IRQ is
>> triggered, the kernel does not call its IRQ handler, instead kernel only
>> marks the IRQ as a wakeup event in pm_system_irq_wakeup(). By checking
>> pm_wakeup_pending() suspend process can abort if a wakeup event is
>> detected. That means the actual IRQ handler is not called during the
>> checking of blk_mq_hctx_has_requests, which cause the issue.
> 
> Thanks for the explanation!
> 
> Can you document it around `if (pm_wakeup_pending)`?
> 
> Otherwise, this patch looks fine for me.
> 

Thanks for your comments! Update in the new patchset.

> 
> Thanks,
> Ming
> 

