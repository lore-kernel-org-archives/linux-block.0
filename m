Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC3225A48
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014601; cv=none; b=AUIkdrRdFKHcnYEuypbaHhNqKeZO9EoRP5IIe6cxxsQVN/69w849337X1dLEuqLPd7S6nn9r80v4Wi4cS1W17euJu+qsIjLIvRYaGGLF18OxbPfR/qHRyHBvXX6se1JIrxSU+UUYbRmqD+80OuygUba+mVUh4taKESAKbGMLOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014601; c=relaxed/simple;
	bh=fYorlydkSm1Zpx1VbQOeY9ygFcL/XJwPm3X8oJ48F6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OR+q8vtCYLTaki01BehZzS6pw7Gx2JOp2oCjmV5it6wRlgz0h8NnWEhGcFut1XFowffIX3DBdVPvcEcwdspmxlKqYJ4k3zwsa6lEIML/24Ap20hllG/XVotTa3EPKEkny9DirbaUlbwD/NOFLk/hASDVFMeXjGWANgGmxmVIOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ctTMx3Ua; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ctTMx3Ua"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 536Ke03X022723;
	Mon, 7 Apr 2025 08:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R0Kuh7
	u/WFHIe6v8XPfJRfEtVNWoIXIEnkY8Ce4DjG8=; b=ctTMx3UaZ/wqWzvwMPGRrV
	5Tz6ro8cAbIcP0732+OfOEnbgluCimaDPqAJx9jeqkMD4BeLmsFV/ebv9lpw1gfX
	uQbmg4/6OguTL0+9k3K5JG8I6baG3YyzmRh+mhPNV4mlShUZrA5VjVJcydaYgn7q
	JBTtD1l6zrJiJ6yYsZ8bzjrz9q2wcO6vKZAtm3b2XsywFyJECJ42conSoRrVqttX
	N5vyTIZO2r1Y+SgS5q/de9zf/xC+Vg749uuzNXkRB4UFsOHRjjl3LfpHOrMWNDVm
	tSBHPn2LlHKpBldRwHPx2Opdfbo6J0sdvWnWhPqi/eECH/BwYLj8s2WGRadh01jQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45v0u0j6sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 08:29:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5376KTZF017702;
	Mon, 7 Apr 2025 08:29:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kcsjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 08:29:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5378TqK926346210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Apr 2025 08:29:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7318558052;
	Mon,  7 Apr 2025 08:29:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C1035805A;
	Mon,  7 Apr 2025 08:29:50 +0000 (GMT)
Received: from [9.171.84.95] (unknown [9.171.84.95])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Apr 2025 08:29:49 +0000 (GMT)
Message-ID: <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
Date: Mon, 7 Apr 2025 13:59:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
 <Z_NB2VA9D5eqf0yH@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_NB2VA9D5eqf0yH@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sh3OAn4MRmxD4PE7hB8y8CsK9leC4d8T
X-Proofpoint-GUID: sh3OAn4MRmxD4PE7hB8y8CsK9leC4d8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070056



On 4/7/25 8:39 AM, Ming Lei wrote:
> On Sat, Apr 05, 2025 at 07:44:19PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/4/25 2:40 PM, Christoph Hellwig wrote:
>>> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
>>>> Fixes the following lockdep warning:
>>>
>>> Please spell the actual dependency out here, links are not permanent
>>> and also not readable for any offline reading of the commit logs.
>>>
>>>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>>> +				   struct request_queue *q, bool lock)
>>>> +{
>>>> +	if (lock) {
>>>
>>> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
>>> screaming at you (in this case even for the right reason :))
>>>
>>>> +		/* protect against switching io scheduler  */
>>>> +		mutex_lock(&q->elevator_lock);
>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>>> +		mutex_unlock(&q->elevator_lock);
>>>> +	} else {
>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>>> +	}
>>>
>>> I think the problem here is again that because of all the other
>>> dependencies elevator_lock really needs to be per-set instead of
>>> per-queue which will allows us to have much saner locking hierarchies.
>>>
>> I believe you meant here q->tag_set->elevator_lock? 
> 
> I don't know what locks you are planning to invent.
> 
> For set->tag_list_lock, it has been very fragile:
> 
> blk_mq_update_nr_hw_queues
> 	set->tag_list_lock
> 		freeze_queue
> 
> If IO failure happens when waiting in above freeze_queue(), the nvme error
> handling can't provide forward progress any more, because the error
> handling code path requires set->tag_list_lock.

I think you're referring here nvme_quiesce_io_queues and nvme_unquiesce_io_queues
which is called in nvme error handling path. If yes then I believe this function 
could be easily modified so that it doesn't require ->tag_list_lock. 

> 
> So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
> fortunately that is what nvme is doing.
> 
> 
>> If yes then it means that we should be able to grab ->elevator_lock
>> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
>> order should be in each code path,
>>
>> __blk_mq_update_nr_hw_queues
>>     ->elevator_lock 
>>       ->freeze_lock
> 
> Now tagset->elevator_lock depends on set->tag_list_lock, and this way
> just make things worse. Why can't we disable elevator switch during
> updating nr_hw_queues?
> 
I couldn't quite understand this. As we already first disable the elevator
before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
Once mapping is successful we switch back the elevator.

Thanks,
--Nilay

