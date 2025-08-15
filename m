Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC42FABE6
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252390; cv=none; b=jFfetv0g9f7MU+bkPsAAR7o3VySMgquWm8Nad1qScHlgosCv+QSsq3Wk0Vj/man2UPcBVf6EGv6UDtr6oa/TUV9n8ALWEskqOsvg7VDJ9Hk4YcIi6DVKW0gFmGA/SnmRmlvD77Q7JFBzcpx187mB7bOiZ/o70mBJ8NxrYGFE0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252390; c=relaxed/simple;
	bh=3sNFU3CTJ1xwIlWBqFQXvHLdkFdlvih7FntLF3A3O4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7XAoqFxmN+UQMNGqWKgZzIo2KNoKKSU7qnSv0mPTj1CqTK2I+E+KkMCYhRvux+yUJSrA5UAU6Bi5wQN5qmXArZewVUOUpitOjI74DCjDQ5VvEzJJus56OlMkm+u4bFZS2qPJ8bKpa+xob9t8wXLfxMBpC2c0Jh4Rk2i3tGfoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/2qC4o8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/2qC4o8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F463UG009774;
	Fri, 15 Aug 2025 10:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oBiI4k
	Smrq9XmNP0s4ekcm8Lf6Vy6JjQBXkDEOLijOA=; b=L/2qC4o8H6+NQOrz1YDlxJ
	iR6/GMnucItAY4NfQOchim7v10melShRVS+DQuI63thEsVoQTeZRTTWizvtxykok
	VrzOl0gr1lPVfzpzwt9fD98e0QXxjjoecVLdA2/ahNDnP6REPt/yZeQDZ+HoioAQ
	5lXFziLpKDEbppPA2VhMotxsqDj79prhr0sd0/BFmcrCSVnjF9F5Nmtw4hu7HE9w
	9zjaoNG8cKTkFviGbDswhp6KmaaR1Zlku3rH7H9Aw7u1TpyJ2igmJOGxt0tVDsW4
	JP85r/YpBqOAef42TIgXMZw6w7hmbxP4K7gXFUzfERDByLbTvSCaxYaL0RcSCJew
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudpweg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 10:06:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57F65iW9010621;
	Fri, 15 Aug 2025 10:06:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnv0m9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 10:06:11 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FA6BtU30278322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 10:06:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297855805A;
	Fri, 15 Aug 2025 10:06:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3724558062;
	Fri, 15 Aug 2025 10:06:09 +0000 (GMT)
Received: from [9.61.133.254] (unknown [9.61.133.254])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 10:06:08 +0000 (GMT)
Message-ID: <5c57a6a5-d9a4-4c21-86cd-784e4f3876fd@linux.ibm.com>
Date: Fri, 15 Aug 2025 15:36:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250815075636.304660-1-ming.lei@redhat.com>
 <ff5639d3-9a63-e26c-a062-cb8a23c0ed5d@huaweicloud.com>
 <b4183646-a5cf-1f29-5451-c63fdda7c490@huaweicloud.com>
 <aJ8AAiINKj-3c1Xw@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJ8AAiINKj-3c1Xw@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXxKdBP8M7pC+L
 bLEFDPsY9VG5LpIN/PQHYal7aDEOIrm1w/mlpttsPD5P0Q0f5cwBT3hEpHroVLLJzOgcRqHf0Y5
 8d/MjHJ13U798KHjs4DK3O60oy0Q7IetfEnYZzvT4Amm30UXV1y7pKs3ov80p3sG8ga9QYOecdf
 J+Y/yXLPPtAQukAo/gNFS6d/eatEGv2+ZFb8v8n7tDn/4/9Svz2ZuW2Lubedpa7HA4S7rKD151w
 qyKWhzJb2Q0gPyMzSz914rIW2tHb0xldiEKLh0GgUx/e87ZFPlO52Fu7O85q+pH+V0Ncqd1TLBH
 5dbRQT5T+/KJH9Vx2CDN8yBLPrqY1qlYNNUpgCwofPV9L6VM4IinGjLuqvVmEzYI7G6In02YTbY
 UYY4oK6I
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689f0694 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=M_AF7wry3HeSTSvK1a0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YVuvGtnXyvkg-UpkuiP0G4fv4U2DXJTz
X-Proofpoint-ORIG-GUID: YVuvGtnXyvkg-UpkuiP0G4fv4U2DXJTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/15/25 3:08 PM, Ming Lei wrote:
> On Fri, Aug 15, 2025 at 05:34:23PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/15 17:15, Yu Kuai 写道:
>>> Will it be simpler if we move blk_mq_freeze_queue_nomemsave() into
>>> blk_mq_elv_switch_none(), after elevator is succeed switching to none
>>> then freeze the queue.
>>>
>>> Later in blk_mq_elv_switch_back we'll know if xa_load() return valid
>>> elevator_type, related queue is already freezed.
>>
>> Like following:
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e9f037a25fe3..3640fae5707b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -5010,7 +5010,13 @@ static int blk_mq_elv_switch_none(struct
>> request_queue *q,
>>                 __elevator_get(q->elevator->type);
>>
>>                 elevator_set_none(q);
>> +       } else {
>> +               ret = xa_insert(elv_tbl, q->id, xa_mk_value(1), GFP_KERNEL);
>> +               if (WARN_ON_ONCE(ret))
>> +                       return ret;
>>         }
>> +
>> +       blk_mq_freeze_queue_nomemsave(q);
>>         return ret;
>>  }
>>
>> @@ -5045,9 +5051,6 @@ static void __blk_mq_update_nr_hw_queues(struct
>> blk_mq_tag_set *set,
>>                 blk_mq_sysfs_unregister_hctxs(q);
>>         }
>>
>> -       list_for_each_entry(q, &set->tag_list, tag_set_list)
>> -               blk_mq_freeze_queue_nomemsave(q);
>> -
>>         /*
>>          * Switch IO scheduler to 'none', cleaning up the data associated
>>          * with the previous scheduler. We will switch back once we are done
>> diff --git a/block/elevator.c b/block/elevator.c
>> index e2ebfbf107b3..9400ea9ec024 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -715,16 +715,21 @@ void elv_update_nr_hw_queues(struct request_queue *q,
>> struct elevator_type *e,
>>
>>         WARN_ON_ONCE(q->mq_freeze_depth == 0);
>>
>> -       if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
>> -               ctx.name = e->elevator_name;
>> -               ctx.et = t;
>> -
>> -               mutex_lock(&q->elevator_lock);
>> -               /* force to reattach elevator after nr_hw_queue is updated
>> */
>> -               ret = elevator_switch(q, &ctx);
>> -               mutex_unlock(&q->elevator_lock);
>> +       if (e) {
>> +               if (!xa_is_value(e) && !blk_queue_dying(q) &&
>> +                   blk_queue_registered(q)) {
>> +                       ctx.name = e->elevator_name;
>> +                       ctx.et = t;
>> +
>> +                       mutex_lock(&q->elevator_lock);
>> +                       /* force to reattach elevator after nr_hw_queue is
>> updated */
>> +                       ret = elevator_switch(q, &ctx);
>> +                       mutex_unlock(&q->elevator_lock);
>> +               }
>> +
>> +               blk_mq_unfreeze_queue_nomemrestore(q);
>>         }
>> -       blk_mq_unfreeze_queue_nomemrestore(q);
>> +
> 
> I feel it doesn't become simpler, :-(
> 
> However we still can avoid the change in elv_update_nr_hw_queues() by moving
> freeze/unfree queue to blk_mq_elv_switch_back(), which looks more readable.
> 
I think yes that seems reasonable but then we also need to move 
elevator_change_done() and blk_mq_free_sched_tags() from 
elv_update_nr_hw_queues() to blk_mq_elv_switch_back(). As you know
both these functions (elevator_change_done and blk_mq_free_sched_tags)
have to be called after we unfreeze the queue.

Thanks,
--Nilay

