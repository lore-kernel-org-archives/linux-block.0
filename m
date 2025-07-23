Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EED185E4A
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251907; cv=none; b=bdLvF4Zb1emTozyCYw0R/Hl3SKwSyTtcYzWszG1gebf2Qd5SwkRpo4O2naSPijibUSNkYh3qhl+ISAFQpOfZn++wpRtSPLcIGQtDFpKw0sWGCFJ1F/5H2XbZhfp1r0SgnjnFSqy7a+wKtJBuUWR/pVOWaZ2akLPkhzfFv/tu1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251907; c=relaxed/simple;
	bh=+3SM9mdR6NYAyYrBULUq4R8F1Soaa4whX+dPO73m1L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvEopB0FIhfSXnrXJ4k6Ngyu5akqVE6iIERHjpVAs/nVUaqJoyxScMeBDvjend7t1GWKVg/ZN8p0SOMr3E02oFTT+xs5KE10QrS5c3DF/96Jku9WYC4gGZuVtCIYBfjzP3e+jeKKfJlv0BBy5gcd0sx+9ldCl/fSWXYhVS+mWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BlZWvUNl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BlZWvUNl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N5wKH5005334;
	Wed, 23 Jul 2025 06:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SgAGqD
	JG6H3uHZg7IYxsK5NupChbUw748QMbhOT1pdA=; b=BlZWvUNl1kPUpQGtTn62RD
	oZwY98N6CjxHN36Mx++CmHuxnK2hI1efz00Y/U2X7zcnz/UR4euuKOAAJnmhOKNy
	XpF8FEsazrMzTEQSLVhvexzb00pyiTD6WlmOKwvVPglKOMRrf3tW6sA4tFzbjgkZ
	slZ6J3EvGAWrZSmsa/oQOr487rGsjwB7E9zd8qst9yFBobjrTBgSf68DaKrdOpL4
	FOY1cGgWyHRNW58F78EWktrFeDL87TFR9MvbngYOzlhCvPRLJuUsBFn30vQz8Twa
	LmqaOzGezx1wcRVcibw598iOLgg+wybwyYU+FChY+A4oUqPBBsMO8rYk4usXBBow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff4ty26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:24:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N5EHpt024985;
	Wed, 23 Jul 2025 06:24:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2eas4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:24:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N6OdMT37814972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 06:24:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7195E581CF;
	Wed, 23 Jul 2025 06:24:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7664581D7;
	Wed, 23 Jul 2025 06:24:35 +0000 (GMT)
Received: from [9.43.41.196] (unknown [9.43.41.196])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 06:24:35 +0000 (GMT)
Message-ID: <50fc4df5-991d-4076-ab72-eea33b9e5e07@linux.ibm.com>
Date: Wed, 23 Jul 2025 11:54:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
        "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250718133232.626418-1-nilay@linux.ibm.com>
 <b7cc0c1c-6027-4f1a-8ca1-e7ac4ae9e5ec@huaweicloud.com>
 <43099391-2279-473d-8c13-70486b96f50f@linux.ibm.com>
 <c339715d-4a4b-0a4a-4d53-86eabe7b5d97@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <c339715d-4a4b-0a4a-4d53-86eabe7b5d97@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BeW6InLnlTvjP25VK1T-6G8l0EXHqATn
X-Proofpoint-ORIG-GUID: BeW6InLnlTvjP25VK1T-6G8l0EXHqATn
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=68808029 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=WiRIdjSEyPfa8R3VNdAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1MCBTYWx0ZWRfX7MWFdwGKenQX
 42PuYiFIUXQCv4H9HQ217q/0Xyy3zQkH24dI9lHGxDNGbM0wIKYAKkZNKqvWEAcG9vXhKQ0RyET
 15yTTBZFu1kcaoHzKaymnYvipQr9kStZ9YGxZTfT1Bw+Veg52XIS9z66vH9+CSAdyijIko1wXhy
 hLuZXt4/CqtweYbr++sntsKpRjHxunPRJueoKsek7UejBM7HS8mQLepbRDXkLhRg/NubHJPTlBL
 pQgzzirEtnyx+c4aOCh+VnqdEcdVxCRT3HKrVXFllEh+5Irl4DyAftVY6PdPEzXxiay9gzFyY5P
 bVSCkge9XAkqPbwm7ylIAH/LixPl6+PYb0oTjGbbpdBjuilDLh8ZYXsxNevLpMFMuHXnDgsOVK1
 7jFiCXt6yKbwr7FNtrg64/w3x3fU9A3hlS4kCuRCGQM/5phvog5S0cs+h0nLcfT7MWiM0sQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230050



On 7/23/25 6:07 AM, Yu Kuai wrote:
>>>>    static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>                                int nr_hw_queues)
>>>>    {
>>>> @@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>        int prev_nr_hw_queues = set->nr_hw_queues;
>>>>        unsigned int memflags;
>>>>        int i;
>>>> +    struct xarray elv_tbl;
>>>
>>> Perhaps:
>>>
>>> DEFINE_XARRAY(elv_tbl)
>> It may not work because then we have to initialize it at compile time
>> at file scope. Then if we've multiple threads running nr_hw_queue update
>> (for different tagsets) then we can't use that shared copy of elv_tbl
>> as is and we've to protect it with another lock. So, IMO, instead creating
>> xarray locally here makes sense.
> 
> I'm confused, I don't add static and this should still be a stack value,
> I mean use this help to initialize it is simpler :)

Using DEFINE_XARRAY() to initialize a local(stack) variable is not safe because
the xarray structure embeds a spinlock (.xa_lock), and initializing spinlocks
in local scope can cause issues when lockdep is enabled.
Lockdep expects lock objects to be initialized at static file scope to correctly
track lock dependencies, specifically, when locks are initialized at compile time.
Please note that lockdep assigns unique keys to lock object created at compile time 
which it can use for analysis. This mechanism does not work properly with local
compile time initialization, and attempting to do so triggers warnings or errors
from lockdep.

Therefore, DEFINE_XARRAY() should only be used for static/global declarations. For
local usage, it's safer to use xa_init() or xa_init_flags() to initialize the xarray
dynamically at runtime.

>>> BTW, this is not related to this patch. Should we handle fall_back
>>> failure like blk_mq_sysfs_register_hctxs()?
>>>
>> OKay I guess you meant here handle failure case by unwinding the
>> queue instead of looping through it from start to end. If yes, then
>> it could be done but again we may not want to do it the bug fix patch.
>>
> 
> Not like that, actually I don't have any ideas for now, the hctxs is
> unregistered first, and if register failed, for example, due to -ENOMEM,
> I can't find a way to fallback :(
> 
If registering new hctxs fails, we fall back to the previous value of 
nr_hw_queues (prev_nr_hw_queues). When prev_nr_hw_queues is less than
the new nr_hw_queues, we do not reallocate memory for the existing hctxs—
instead, we reuse the memory that was already allocated.

Memory allocation is only attempted for the additional hctxs beyond
prev_nr_hw_queues. Therefore, if memory allocation for these new hctxs
fails, we can safely fall back to prev_nr_hw_queues because the memory
of the previously allocated hctxs remains intact.

Thanks,
--Nilay
