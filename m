Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA142FC898;
	Thu, 14 Aug 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168886; cv=none; b=PZIvxTRUpGGS6PINg/AaA+JCBTgcZOhXx8X6Txn7E1BRE2LU9AUyBLfQkhpo8Lj4f35BqZzHDLzqXRfbzKQeGjb3jL/ujfkJ80iC+uM/lhdSPr5OM5Z7XYvo8Wp4a451KqC1PLgnwRKSjAcnrYr6J2Y2DWvMldSWR+7TpUWp/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168886; c=relaxed/simple;
	bh=/Jt/VvPHfcOxLL/uY9EPpog2kBoY+v8VaA1FtdGFLB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oqTq1B20ChJant1k6cMDUkGNb/CMAsuhVp8+vMHiBN0IBt9+acbN1PSoCzk2zFqddePxRv56/lBtFl2npojlTCSsZpbkT9n4IMv6oXPpHd8WN+gLnSyGnBz/iFuDnQiYtbcsaE0ao99d5JRAzgtAL8DtXKxnKP90Sge1LUTeZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ek46LP1B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ek46LP1B"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E98juh012959;
	Thu, 14 Aug 2025 10:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iAu6t9KixteDwsIhkvnJpX7+H6rs9d4kiPwt4KhmhGQ=; b=Ek46LP1Bo+xsNBIP
	3si4f6Ddn8LxmJuOXXlq1+ACeKFftemNSEPa1/tb3TD+/FX2DawscKJtC4Y+EmwW
	otw6sSFo36reJ6rabUYTxOvu28ndTQ1kk95QhAy4UzT+FApEzse2EVr9tz0D5x/Q
	hzcueiWUxCtk/LDWC9kD8qRIlwLZwO1TwwdQL2mARRLVqu3mYe3H4tXlUIBcp4y7
	qYWWqjJ7qEfXtaGOUUbUSQ7Bb4+hfRdgXEV2TFmwZurfeFMm0uaUl57ESIFQoGgs
	pu+0glduPb1CPA2vLsaBPDGfFeEnP++wiAaH1hM2NDRrjkrWdUUSxcicrXRd8HvJ
	m/fbPw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6u8mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:54:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57EAsctN023580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:54:38 GMT
Received: from [10.50.4.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 14 Aug
 2025 03:54:36 -0700
Message-ID: <21bf1ed6-9343-40e1-9532-c353718aee92@quicinc.com>
Date: Thu, 14 Aug 2025 16:24:25 +0530
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
Content-Language: en-US
From: Hardeep Sharma <quic_hardshar@quicinc.com>
In-Reply-To: <2025081450-pacifist-laxative-bb4c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX9Jdtps2lTmLX
 Og+U5DtEBm7QIrsVaKpcT38Y7/1PrE6pnA+VowumSlsKjXDmkU2bR28I0sYSix4+EZxwpgyw6tN
 VdU8HRqUqhnrdBQrj+CPy/DXTQymmV4ndWcl+zkvJC6M6aQGvnx2Ixw7FdubfY6BBRSSVK4j04V
 a+ut8ZUwVF/xxak1Wn1DMFz22PYqZaT7dbZHI4bJI5GVA+WtQGx6RVtpNjr3vwsC2kszdZOc9zO
 EDyWZVAfXzqG+34gEaFrz78aXjxUK0LlntKzn/zqkDo1063VxZFK0hrYAEeGvaRgKUKYjhxUKPR
 bBXgTfV49eO900p/kTzDDAGtIC+fvwWBvHlN8yZt9TzEj+pAh4GfGoqaYXXQBO5L4O3DHlRJmRi
 iju2nmq1
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689dc06e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=JQxddNvltgY3yC4srtIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cCMPdCj4G8B63rKTjGbZYrKiU-7-vOtF
X-Proofpoint-ORIG-GUID: cCMPdCj4G8B63rKTjGbZYrKiU-7-vOtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075



On 8/14/2025 2:33 PM, Greg KH wrote:
> On Thu, Aug 14, 2025 at 12:06:55PM +0530, Hardeep Sharma wrote:
>> Buffer bouncing is needed only when memory exists above the lowmem region,
>> i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
>> max_pfn) was inverted and prevented bouncing when it could actually be
>> required.
>>
>> Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
>> on 32-bit ARM where not all memory is permanently mapped into the kernel’s
>> lowmem region.
>>
>> Branch-Specific Note:
>>
>> This fix is specific to this branch (6.6.y) only.
>> In the upstream “tip” kernel, bounce buffer support for highmem pages
>> was completely removed after kernel version 6.12. Therefore, this
>> modification is not possible or relevant in the tip branch.
>>
>> Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
> 
> Why do you say this is only for 6.6.y, yet your Fixes: line is older
> than that?
[Hardeep Sharma]::

Yes, the original commit was merged in kernel 5.13-rc1, as indicated by 
the Fixes: line. However, we are currently working with kernel 6.6, 
where we encountered the issue. While it could be merged into 6.12 and 
then backported to earlier versions, our focus is on addressing it in 
6.6.y, where the problem was observed.

> 
> And why wasn't this ever found or noticed before?
[Hardeep Sharma] ::

This issue remained unnoticed likely because the bounce buffering logic 
is only triggered under specific hardware and configuration 
conditions—primarily on 32-bit ARM systems with CONFIG_HIGHMEM enabled 
and devices requiring DMA from lowmem. Many platforms either do not use 
highmem or have hardware that does not require bounce buffering, so the 
bug did not manifest widely.

> 
> Also, why can't we just remove all of the bounce buffering code in this
> older kernel tree?  What is wrong with doing that instead?

[Hardeep Sharma]::

it's too intrusive — I'd need to backport 40+ dependency patches, and 
I'm unsure about the instability this might introduce in block layer on 
kernel 6.6. Plus, we don't know if it'll work reliably on 32-bit with 
1GB+ DDR and highmem enabled. So I'd prefer to push just this single 
tested patch on kernel 6.6 and older affected versions.

Removing bounce buffering code from older kernel trees is not feasible 
for all use cases. Some legacy platforms and drivers still rely on 
bounce buffering to support DMA operations with highmem pages, 
especially on 32-bit systems.

> 
> And finally, how was this tested?

[Hardeep Sharma]:

The patch was tested on a 32-bit ARM platform with CONFIG_HIGHMEM 
enabled and a storage device requiring DMA from lowmem.>
> thanks,
> 
> greg k-h



