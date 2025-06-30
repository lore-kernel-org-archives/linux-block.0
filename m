Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38DF1A257D
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266680; cv=none; b=NoC9j/quqjBGgBp21D15071d7Ei15+a/BqOBn9Ao0BnCt/i3kaxuoEHPU3yOxf5EedfZBcJFeNWV6TcWAwaOBIFKgHAyzx2AyLxjRZtChCmC0qhsepJXzc6WCjARR8T3eY8F5rI4/blH2m3jywFeGlEk3MvNc22c+4yGRPYVBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266680; c=relaxed/simple;
	bh=xPzJqy4MGT6PuJlHkqyeDVxafAN7MwJZhGezyJYVFNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/9peb+mnTVIluUfr7MGt6A5ZJf/fMqqYAoCJnpJwCbYU7d1a9G2BjPgYRtwd0Inwl8kc8hlJL07ObxJlKgog5UAYfwdybNMWqyLjw5kMCkzqxQLpZ93PfVMRBYRa2nVGzUa4WU3W3rRDDeejfJDezCa2kAoloEJgmNEmkh+9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWA2TUo/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWA2TUo/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TJl2pO032737;
	Mon, 30 Jun 2025 06:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RwvbTl
	PjxRQqdP1zndA8c7ySNyPDUuKoCZOZYYRfLZo=; b=AWA2TUo/dj4LHViA8I4/V7
	2xlRqmD6M7vwXC6cMUeQld0escfOP4yYooffv7fhVN3yzoTQ1MKTi/sjeSI2HNo1
	jjbCVd48cdk++KeUiqAYMoKK9GLwR7yey5SFBfo3yYpNypigbCdh8AMohUprLTbw
	OlOodsDxws9z22GXNED/W2gvYiRvVH6uGmILSqKykyGqhJrVfzxaEuPj7qE83x8i
	p1Gi/FFFOcUVgTkx71HxHManm2k3KvMz9tMY8SJUeHOc+6JRz/Mcjs1v/XVvjATi
	SPKsrDP2g4StiWnvSGR7nbEWCiO4a7om56dVBgjEq1MEbQDZuyELliN/sTD70h1Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82ffh1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:57:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U6kMqW021430;
	Mon, 30 Jun 2025 06:57:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe34eaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:57:49 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U6vgDS29950538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 06:57:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56F458054;
	Mon, 30 Jun 2025 06:57:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3450F58045;
	Mon, 30 Jun 2025 06:57:44 +0000 (GMT)
Received: from [9.61.92.250] (unknown [9.61.92.250])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 06:57:43 +0000 (GMT)
Message-ID: <b7c33614-68f1-491a-a8c3-30b2784ddb62@linux.ibm.com>
Date: Mon, 30 Jun 2025 12:27:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 3/3] block: fix potential deadlock while running
 nr_hw_queue update
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        lkp@intel.com, gjoyce@ibm.com
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-4-nilay@linux.ibm.com>
 <07d77cbb-f2fe-4193-b027-039166f5540f@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <07d77cbb-f2fe-4193-b027-039166f5540f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V4JzivNt4FMNn7R08ce65fizwo3zoQ9g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NSBTYWx0ZWRfX2UWn/cYJpCSt ZF/yr05iNnkAXVq/9ENfYY2yec9K+Opgd00fmhnFK30u3JtbqKOVxStgjuCsKaIvOISMexFtxxe DyWOofh4A4XKMBoqA6b/pxRZPdCoIDBDyf8o3pInbJtfzTvbVxQ8noN8msZHZcb/ddg1KU2KzJk
 gyW+pquxP96xFzkzfIahjCduQmfDo19rr2xXbyNl0s+7+Vf0su+/Jf6ZInMIWlgmr5eEGaVrncj pTBEqloKdZ5UvrYmGZugbIMjln/K1XSt6z4SaWgxRG5hh5DBCIPgzXmwhY1H7ugbRg8lJCLSCbf BTSULZ/sAJNC2uUMS/rNvnR7Pm7Pwz/M+mnECBrW3g4UCrGqSs9AQO7OMz2ec+3n1jgenlBHOSW
 LMsmjxkjLyjHHjAwKnP9b+gdQY8cgK6smv7nV+tEwnvwl7Woa4zi+LMHywlsZYZ/Hnq7jUV/
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=6862356e cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=BT52IIPirWrEiQDZj9sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: V4JzivNt4FMNn7R08ce65fizwo3zoQ9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300055



On 6/30/25 11:54 AM, Hannes Reinecke wrote:
> On 6/30/25 07:21, Nilay Shroff wrote:
>> Move scheduler tags (sched_tags) allocation and deallocation outside
>> both the ->elevator_lock and ->freeze_lock when updating nr_hw_queues.
>> This change breaks the dependency chain from the percpu allocator lock
>> to the elevator lock, helping to prevent potential deadlocks, as
>> observed in the reported lockdep splat[1].
>>
>> This commit introduces batch allocation and deallocation helpers for
>> sched_tags, which are now used from within __blk_mq_update_nr_hw_queues
>> routine while iterating through the tagset.
>>
>> With this change, all sched_tags memory management is handled entirely
>> outside the ->elevator_lock and the ->freeze_lock context, thereby
>> eliminating the lock dependency that could otherwise manifest during
>> nr_hw_queues updates.
>>
>> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
>>
>> Reported-by: Stefan Haberland <sth@linux.ibm.com>
>> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   block/blk-mq-sched.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
>>   block/blk-mq-sched.h |  4 +++
>>   block/blk-mq.c       | 11 +++++++-
>>   block/blk.h          |  2 +-
>>   block/elevator.c     |  4 +--
>>   5 files changed, 80 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 2d6d1ebdd8fb..da802df34a8c 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -427,6 +427,30 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
>>       kfree(et);
>>   }
>>   +void blk_mq_free_sched_tags_batch(struct xarray *et_table,
>> +        struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +    struct elevator_tags *et;
>> +
>> +    lockdep_assert_held_write(&set->update_nr_hwq_lock);
>> +
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +        /*
>> +         * Accessing q->elevator without holding q->elevator_lock is
>> +         * safe because we're holding here set->update_nr_hwq_lock in
>> +         * the writer context. So, scheduler update/switch code (which
>> +         * acquires the same lock but in the reader context) can't run
>> +         * concurrently.
>> +         */
>> +        if (q->elevator) {
>> +            et = xa_load(et_table, q->id);
>> +            if (et)
>> +                blk_mq_free_sched_tags(et, set);
>> +        }
>> +    }
>> +}
>> +
> Odd. Do we allow empty sched_tags?
> Why isn't this an error (or at least a warning)?
> 
We don't allow empty sched_tags and xa_load is not supposed to return an
empty sched_tags. It's just a paranoia guard that we evaluate whether @et
is non-NULL. As this function returns nothing we don't return any error 
code to the caller here. But yes, we may add a warning here if that seems
reasonable. I'd add a 'WARN_ON(!et)' and update it in the next patch.

Thanks,
--Nilay
