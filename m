Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE062FFDEC;
	Thu, 14 Aug 2025 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176809; cv=none; b=lXnKMOLlDTStqZVteuwEn4aqxK0l/J92/PqpHRijzhkwyx/Y2qH7UBmAIndGXWBdJYreuHk3fAkhHxzj3GtYnPM3M1IdwC46N8u9UpHzLcm1yqGMZpBN0CCjIAxQIvqvw0UsZx1UBiY1MmHOOrt0jqf390CxzkPJHPDcoCqJ3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176809; c=relaxed/simple;
	bh=jOAqWxiriywVpdi5TvvVzAUwFdL9W9fDqxh9mmGsPOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kBTDpmZD553ZbmCJPMdiApxo+BHFel73Xru6piCpOpgIavNnraSIc4HRhQgSY8ivyrbf7EWis/CNNLBskEiqATTrbvKCjxn3bu4NaTW4iG+Kr2sDpOkKhvE5h6z0bWQ0wnZG9h3KIjBS7yIEvfZlkVtBeg4xnp8sSVnj90fZRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TDgXKLmO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TDgXKLmO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9FKSE027000;
	Thu, 14 Aug 2025 13:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	krCmXFTYeP7XPxF+yvCB610msvOX8qDJ7ylNRn64itE=; b=TDgXKLmOy6cQtKS7
	bQlVryepSBECdEiPJgutVSSdfJiH51n/3j2IzTAat/wzJ459HeLvlTTOGQTeGBmX
	dKBc1tHEKb9VKjCqwP5kEe80Lx0raXBhg1GzWeu+hGbAA5J0f6LAYwdIAY7N76xp
	aw4XnwNunsOTqnTiXk602sSKBCgozPoy2zz8RnIHJjzQ4vWYAGd/72w/697MAK6p
	iTWb1a6lujBLR51M9+z3X4EryTfPZPtqGYMQi5k0i37G5jbfC3UdsbFwbDsITc07
	katUi9kzYk2sKrcURepF2ce1b/PeAzm4nDBM/BY7V9p0k2RlRZ3ErumdpzVhOy+B
	bj6Rkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjukd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 13:06:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57ED6YmD008250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 13:06:34 GMT
Received: from [10.50.4.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 14 Aug
 2025 06:06:32 -0700
Message-ID: <4a898590-e1ca-41dc-b8b7-a5884d10db5d@quicinc.com>
Date: Thu, 14 Aug 2025 18:36:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in
 blk_queue_may_bounce()
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Martin K .
 Petersen" <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250814063655.1902688-1-quic_hardshar@quicinc.com>
 <2025081450-pacifist-laxative-bb4c@gregkh>
 <21bf1ed6-9343-40e1-9532-c353718aee92@quicinc.com>
 <2025081449-dangling-citation-90d7@gregkh>
Content-Language: en-US
From: Hardeep Sharma <quic_hardshar@quicinc.com>
In-Reply-To: <2025081449-dangling-citation-90d7@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX3bnogNWKfMR/
 pkUGFbI4Fa+HiSzuLOUc57yXJKys4ffNs0rDVEbdAe+5THN8SKzL1GdE0LrqQeLMW1KZ4ChpsxF
 jTwkknavvpsZr1QyDy0E2m0rAMVbB+49LcSHA4bwJ2LxWVNq/CaKbUkZCaYZMQDEJAKU0lRI/rc
 c2l6sOfzis06Tn9wTY60SjZ59w/bfbKyhcYlpEi8hPcDkwqJVRfiYh/L2lh7mBNFJB7jNNeNaik
 yL7Zp1d/8jV3Al0f8wdSc36x9qOq002vQtYuLK2wbVXhBa8QqYl2BR9YKgLcXFuKSgILaKhQB+T
 mmx9IueSqHnSylVrVn760RGV7Mjf/JAtAn2UJU/rX1OOtNnqB8gXi+KW4Rv29M1d5bhFwtFi/0F
 XDP1AHek
X-Proofpoint-GUID: bNKjm28c2Joohus3FoSjco54BNTGQihO
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689ddf5b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=8iWu0OXfL7HOh5h_90kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bNKjm28c2Joohus3FoSjco54BNTGQihO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

This change to blk_queue_may_bounce() in block/blk.h will only affect 
systems with the following configuration:

1. 32-bit ARM architecture
2. Physical DDR memory greater than 1GB
3. CONFIG_HIGHMEM enabled
4. Virtual memory split of 1GB for kernel and 3GB for userspace

Under these conditions, the logic for buffer bouncing is relevant 
because the kernel may need to handle memory above the low memory 
threshold, which is typical for highmem-enabled 32-bit systems with 
large RAM. On other architectures or configurations, this code path will 
not be exercised.

On 8/14/2025 5:06 PM, Greg KH wrote:
> On Thu, Aug 14, 2025 at 04:24:25PM +0530, Hardeep Sharma wrote:
>>
>>
>> On 8/14/2025 2:33 PM, Greg KH wrote:
>>> On Thu, Aug 14, 2025 at 12:06:55PM +0530, Hardeep Sharma wrote:
>>>> Buffer bouncing is needed only when memory exists above the lowmem region,
>>>> i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
>>>> max_pfn) was inverted and prevented bouncing when it could actually be
>>>> required.
>>>>
>>>> Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
>>>> on 32-bit ARM where not all memory is permanently mapped into the kernel’s
>>>> lowmem region.
>>>>
>>>> Branch-Specific Note:
>>>>
>>>> This fix is specific to this branch (6.6.y) only.
>>>> In the upstream “tip” kernel, bounce buffer support for highmem pages
>>>> was completely removed after kernel version 6.12. Therefore, this
>>>> modification is not possible or relevant in the tip branch.
>>>>
>>>> Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
>>>
>>> Why do you say this is only for 6.6.y, yet your Fixes: line is older
>>> than that?
>> [Hardeep Sharma]::
>>
>> Yes, the original commit was merged in kernel 5.13-rc1, as indicated by the
>> Fixes: line. However, we are currently working with kernel 6.6, where we
>> encountered the issue. While it could be merged into 6.12 and then
>> backported to earlier versions, our focus is on addressing it in 6.6.y,
>> where the problem was observed.
> 
> For obvious reasons, we can not take a patch only for one older kernel
> and not a newer (or the older ones if possible), otherwise you will have
> a regression when you move forward to the new version as you will be
> doing eventually.
> 
> So for that reason alone, we can not take this patch, NOR should you
> want us to.
> 
>>> And why wasn't this ever found or noticed before?
>> [Hardeep Sharma] ::
> 
> Odd quoting, please fix your email client :)
> 
>> This issue remained unnoticed likely because the bounce buffering logic is
>> only triggered under specific hardware and configuration
>> conditions—primarily on 32-bit ARM systems with CONFIG_HIGHMEM enabled and
>> devices requiring DMA from lowmem. Many platforms either do not use highmem
>> or have hardware that does not require bounce buffering, so the bug did not
>> manifest widely.
> 
> So no one has hit this on any 5.15 or newer devices?  I find that really
> hard to believe given the number of those devices in the world.  So what
> is unique about your platform that you are hitting this and no one else
> is?
> 
>>> Also, why can't we just remove all of the bounce buffering code in this
>>> older kernel tree?  What is wrong with doing that instead?
>>
>> [Hardeep Sharma]::
>>
>> it's too intrusive — I'd need to backport 40+ dependency patches, and I'm
>> unsure about the instability this might introduce in block layer on kernel
>> 6.6. Plus, we don't know if it'll work reliably on 32-bit with 1GB+ DDR and
>> highmem enabled. So I'd prefer to push just this single tested patch on
>> kernel 6.6 and older affected versions.
> 
> Whenever we take one-off patches, 90% of the time it causes problems,
> both with the fact that the patch is usually buggy, AND the fact that it
> now will cause merge conflicts going forward.  40+ patches is nothing in
> stable patch acceptance, please try that first as you want us to be able
> to maintain these kernels well for your devices over time, right?
> 
> So please do that first.  Only after proof that that would not work
> should you even consider a one-off patch.
> 
>> Removing bounce buffering code from older kernel trees is not feasible for
>> all use cases. Some legacy platforms and drivers still rely on bounce
>> buffering to support DMA operations with highmem pages, especially on 32-bit
>> systems.
> 
> Then how was it removed in newer kernels at all?  Did we just drop
> support for that hardware?  What happens when you move to a newer kernel
> on your hardware, does it stop working?  Based on what I have seen with
> some Android devices, they seem to work just fine on Linus's tree today,
> so what is unique about your platform that is going to break and not
> work anymore?
> 
>>> And finally, how was this tested?
>>
>> [Hardeep Sharma]:
>>
>> The patch was tested on a 32-bit ARM platform with CONFIG_HIGHMEM enabled
>> and a storage device requiring DMA from lowmem.>
> 
> So this is for a 32bit ARM system only?  Not 64bit?  If so, why is this
> also being submitted to the Android kernel tree which does not support
> 32bit ARM at all?
> 
> And again, does your system not work properly on 6.16?  If not, why not
> fix that first?
> 
> thanks,
> 
> greg k-h

