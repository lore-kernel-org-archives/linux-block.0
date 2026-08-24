Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62C37C118
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594794; cv=none; b=kY7HW/0Uod25ssX1GLGPCLGuBK8RnXOtAziEwI2JxwWwGzoYiH5Wc6INmolq80IBv98yhEv8iASHACkHb+c23KhxP6Enz/qX313A4Mkl9NfU8WzcQuBNlCzsOTWf7u56K2gmIOeObo2Lq7GsE7+OPIfrEir5hIiTGYs3puOezo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594794; c=relaxed/simple;
	bh=+s49iw1c7y5kYuIhSDmujKfItCku/JMsaWYM4NWUAco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3YOM6VSh4JXMAOSNd62JuNB4RVbX9EYYO616XbWcbQl3QaC2XFXx+j0PoTbrdqeAGSBTxlVlv6RLv7YDvNSI6NtHRAwFwJqRP4Y5GlpzrKqAU/yLDksj0KQ1lErJ/vZso5k406FInXouhB0TBjtHLuiIV8hnw0kIIuuTKFT+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zl/MVS3v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zl/MVS3v"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1aAk2373288;
	Mon, 24 Aug 2026 18:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WIJLKl
	NyI9e3R15HAKfbM6PEDC0U9PIKNiZQCJifXp8=; b=Zl/MVS3v9roZbuz0h3ytcL
	vFOeDd6MqaKoGOeL0nUrfZj+Ew8m6IUcon/ZxP6+NvoKDp2YDHz+yI+a0cFGTICt
	Trgk+Hia1Of7fgnNFqAfzD3oMzDLGqFnb8aiBDItGQ3RFNlLIDfQEPBjy6shFHAl
	PteXkjWN1vtiawjJxdiHHn8lvJFKoKOwsIIR1Mj/XaqFSsbsDEEUUqL5Oc/1aSwJ
	FAI40l9EieBjrZ0LdXdNhYXjh92sw3aiTNazuRovFbM0YnfpxmtkBgL7gF0JWtfA
	b6eCfd6nk1ie/l8CfUvGr8Dx8rVXCOJdFhHwpLenhpoh279J6B0VU1TD1jWiJgiA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4k866-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 18:06:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OHuIDv021392;
	Mon, 24 Aug 2026 18:06:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jqnbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 18:06:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OI6OJh23921378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 18:06:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B4558056;
	Mon, 24 Aug 2026 18:06:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285C45805D;
	Mon, 24 Aug 2026 18:06:23 +0000 (GMT)
Received: from [9.61.86.249] (unknown [9.61.86.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 18:06:22 +0000 (GMT)
Message-ID: <2e6d7e6d-d6e2-4675-abc3-51f21e407ff4@linux.ibm.com>
Date: Mon, 24 Aug 2026 23:36:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] loop: Fix race conditions in loop_validate_file()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <cover.1787255652.git.bvanassche@acm.org>
 <2b6da8a843526abf58d0d591ce487533bbce805e.1787255652.git.bvanassche@acm.org>
 <b7f88eff-7886-4a85-9c97-7c88ba856780@linux.ibm.com>
 <d998a691-4c43-4feb-ac5c-d174208c01db@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d998a691-4c43-4feb-ac5c-d174208c01db@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o-KNs3GXJP-DiWwHKrREdFaKBuHFcPYL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE1MiBTYWx0ZWRfX3PJGFBhVwHR2
 CO2mEtP3a/OuMZYOay6sStUT6GM2ptKmfvOp3aR84AyOInj6ZDvrETKsmQto+n1T2ryG2jZiuWq
 CA2CPynWDy2yQffmgiVoCQGnS3QoQv8=
X-Proofpoint-GUID: o-KNs3GXJP-DiWwHKrREdFaKBuHFcPYL
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c8822 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=PEAYgb4XZHSjto8YpiEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE1MiBTYWx0ZWRfX0MLsGoNMGp6Z
 Ju5Clml/M87C+nkJ3b1ulM/TE/qTCv2C+YSfz25KpKxhy31FdaqqR0mRe93OmGwE5mudm9deENN
 yrDokVh5OmuVEVuq1PyZDwhQXYvlRJFqdPDZv/yJSiGf3m7yv7pzbS5zj3rUoT2WlU+A0R7hIz6
 Rs333uqgOJklYrsIxLu3tmthD6TPQ22/6JPsS9lHOlgzt9d1aAd1UfORTvbb0HvJsxMHKdYnnHY
 u4yNRq/pbaOG2VmakCet7HuBMo5B0ausMN42J0QaXQofJe7qpGy5Sd5rJotpF813tV5qnAyNtme
 XVwsH00iqARQGvfCFhSm4DegiYpa0dUNHdnG+zj34tQCaWdIfyL/cf0ye3eUcfYRKqYz5YBEwl7
 LgIW+eprunBHFS0zQL6cW9gLd6BZyvhVFV+BCG1NjD6R2rkQJMlZbqIXOMUJGXafWZKVrjxQsLB
 MiDgOpyG5iP6WN7KcCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240152

On 8/24/26 9:45 PM, Bart Van Assche wrote:
> On 8/23/26 11:12 PM, Nilay Shroff wrote:
>> I see that with the refactoring and the changes in this patch, where
>> we now take an explicit reference to each backing file while
>> traversing the loop-device chain and hold the corresponding lo_mutex
>> while checking lo_state and acquiring that reference,
>> loop_validate_mutex may no longer be necessary.
>>
>> In particular, loop_get_backing_file() now atomically checks that
>> the loop device is in Lo_bound state and takes a reference to
>> lo_backing_file while holding lo_mutex. Therefore, if loop_clr_fd()
>> or loop_change_fd() concurrently replaces or clears the backing
>> file, the validator still holds its own reference. It also appears
>> that loop_change_fd() and loop_clr_fd() for the same loop device are already serialized by lo_mutex.
>>
>> So I am wondering whether loop_validate_mutex now be redundant? If
>> so, it may be worth consider removing it as part of this series.
>> That would simplify the locking and make the context annotations
>> considerably cleaner as well.
> 
> Hi Nilay,
> 
> That's an interesting question. I think we still need
> loop_validate_mutex. Without that mutex the hierarchy could be
> changed from linear into recursive after loop_validate_file()
> has verified the hierarchy and before the loop fd is changed.
> Removing loop_validate_mutex might introduce other race conditions
> than the one mentioned above.
> 
Okay, that makes sense. So it looks like we can't easily get rid
of loop_validate_mutex. In that case, would it make sense to always
acquire loop_validate_mutex rather than acquiring it conditionally
only when the new backing file is a loop device?

I think loop_configure() and loop_change_fd() are control-plane
operations and are relatively infrequent, so taking
loop_validate_mutex should not add any noticeable overhead.
In return, we would have a single locking hierarchy and
the locking-context annotations would be much simpler and easier
to reason about.

What do you think?

Thanks,
--Nilay

