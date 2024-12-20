Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E674218E95
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707891; cv=none; b=j+TMN9EifT5Qp4DpGAXh38FpdWsoJI4vkrZQ7YVPB0xSBBB6kofz1hvf7dolR3v/OTRRYwdtYci17I0ajM1lELEOXOz/aLD71gbxXv8FhduAb9R09rfjgESEsg/5eeEKclcMz81iXyAudL2KBY5jA6zEgc9yZRSPfqFk3islck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707891; c=relaxed/simple;
	bh=hnUL113ABOb6xlgfEv3Qo/WW8wDFu+XH4auf9YO02Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GVSnoJKyZROOBqAL2Iq+Z/YvymJZ+0IXPCAOyoili/dA0urA9DWmblNg2m0XZib7YscZ1y8/HwEy6C8TUVraNL0rf20kXmA4zulB4o2HNSwZeB1/zMaDcTIiBaSRhI6yir8WtEizyxHMYkkNEBLSNmFy4YzIwIKJwm6KJSzFR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sk9mIjhv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sk9mIjhv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKE6qQh022901;
	Fri, 20 Dec 2024 15:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4evOy1
	/bJXnFEaDOG+8UqlMQlK/T+NrLkK2gCZCfq30=; b=Sk9mIjhvTEUj6TXYXlsUAe
	VlJqcIi5zEl/ZCjLuQtgkGvErgNs+kyyVTjExF5z0m89JuT2OLDpse70K8N5+O9J
	PCfmWMmvQgorfYvS1cJ1/OALloWdkbEJWAu6r6ug26R7bvT0Pgw0ij/SkIg/1qPi
	t1ruC+d0mDMn+F1TD4RS2oWBjL6oedUzp0+k01ca0wFdPrGjSnKH3oFiPfagjXpU
	R1n4faC9oPTh0YeMEYmx2JUY0GtTWQvSCSyk7z7jpCIBwAZXnvfv3gJXW1mLyXuA
	JcIawW9O3Ep28H5jCXeNDfHTPEB6kNmjrBZBUFsBSk2fwAIi4odZ6mp2rPZn/Jpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43na258cgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 15:18:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKFE3qX011249;
	Fri, 20 Dec 2024 15:18:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkjec1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 15:18:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKFI3it11076220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 15:18:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA2558059;
	Fri, 20 Dec 2024 15:18:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A69FD58043;
	Fri, 20 Dec 2024 15:18:02 +0000 (GMT)
Received: from [9.171.21.204] (unknown [9.171.21.204])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Dec 2024 15:18:02 +0000 (GMT)
Message-ID: <8a70f3cc-eaa2-4bf2-82fb-da01b3de7ba8@linux.ibm.com>
Date: Fri, 20 Dec 2024 20:48:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Revert "block: Fix potential deadlock while
 freezing queue and acquiring sysfs_lock"
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
References: <20241218101617.3275704-1-ming.lei@redhat.com>
 <20241218101617.3275704-2-ming.lei@redhat.com>
 <23c3e917-9dd3-4a0f-8bf4-0a6f421aae0e@linux.ibm.com>
 <d48795a6-cb9f-4649-8c43-e36639a39721@kernel.dk>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d48795a6-cb9f-4649-8c43-e36639a39721@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T8Q8oE6LMY_-Z_7qruBQOawfgei4T0Bs
X-Proofpoint-ORIG-GUID: T8Q8oE6LMY_-Z_7qruBQOawfgei4T0Bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200123



On 12/20/24 20:39, Jens Axboe wrote:
> On 12/20/24 3:23 AM, Nilay Shroff wrote:
>> On 12/18/24 15:46, Ming Lei wrote:
>>> This reverts commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2.
>>>
>>> Commit be26ba96421a ("block: Fix potential deadlock while freezing queue and
>>> acquiring sysfs_loc") actually reverts commit 22465bbac53c ("blk-mq: move cpuhp
>>> callback registering out of q->sysfs_lock"), and causes the original resctrl
>>> lockdep warning.
>>>
>>> So revert it and we need to fix the issue in another way.
>>>
>> Hi Ming,
>>
>> Can we wait here for some more time before we revert this as this is
>> currently being discussed[1] and we don't know yet how we may fix it?
>>
>> [1]https://lore.kernel.org/all/20241219061514.GA19575@lst.de/
> 
> It's already queued up and will go out today. Doesn't exclude people
> working on solving this for real.
> 
Sure, my bad. I will ensure this in future.

Thanks,
--Nilay
