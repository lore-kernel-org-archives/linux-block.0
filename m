Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB413C00
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118741; cv=none; b=oniCOUZ8M0VsB2KOU//rzPjSvHXK6JxkNDFvkYTJq+1dEVYPedWx7Q/wrt4FxpCgeXbAl26+nKq7vQxhwguQpzAtpEqNLpI3I0Oq4T6IipbA2RwPaXRsJPJ90ChEgC+in91Tw01NM/m8khirnbo5bqqco28FdH3G7VYxJ6w8Fl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118741; c=relaxed/simple;
	bh=BZGF0yd+UgYAhiqQo9/04d836LFLbNFqUoypz5AnFb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwbII+JEN8D1wszf8zZDv5fFmgDA+n3cxhP8cCTBthScSJ+CSoCYVnj998ZfzX/rrWqPeQUE+hIFGsBK+8K3cf/VHwIPaw3st0Nw2RKisy++T10TRJdYMaYDvrq1y5/0h0oRCLRGaZrJsxXjpaKGhZf5HQBgEGP91Ig4UkaxYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fszlXrzB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fszlXrzB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CSa5w018465;
	Tue, 8 Apr 2025 13:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KMXZHA
	vR86bYEJSZRTTXqMSjtowtCTJRzLXe3ho1Jnk=; b=fszlXrzBeAoJ+7LdMnL6zJ
	BNISsoyYz/JM5srEvDYxma9hXzMPpfHfEnaurPvmDn3WI1RWZXLnsmwRdP3gdpcQ
	zThVW0e1P3niJz8K/zL9FM+rqbRqaxrkbWAJ2ztcCfE9GY4a3btXGrLkSCjKvftX
	8vDUYOmRDPUNYSh7qW6dda6Gf0Kp5ClunosspHdFxA4VzRm1EBUNrxfQrvOSMBLz
	tp2hM78aY29dmtPxSCIcF6BgqnvfOr09UuYcf0Oe84oCJSj0CDyWWYrs6zKpBulQ
	jquklpHU/GfMZKVO2lfm50RansMWsQR1rZzYVKNwsQq21RLuqEbKEgoUjLQnNSMA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u308cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 13:25:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5389IEHJ018877;
	Tue, 8 Apr 2025 13:25:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uhj2afds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 13:25:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538DPTEj33292824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 13:25:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B02458055;
	Tue,  8 Apr 2025 13:25:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66BA58059;
	Tue,  8 Apr 2025 13:25:27 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 13:25:27 +0000 (GMT)
Message-ID: <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
Date: Tue, 8 Apr 2025 18:55:26 +0530
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
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_TSYOzPI3GwVms7@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OGDeAN6SehBs2AZYRPwwyz-OEB6HX93T
X-Proofpoint-ORIG-GUID: OGDeAN6SehBs2AZYRPwwyz-OEB6HX93T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080092



On 4/8/25 1:08 PM, Ming Lei wrote:
> On Mon, Apr 07, 2025 at 01:59:48PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/7/25 8:39 AM, Ming Lei wrote:
>>> On Sat, Apr 05, 2025 at 07:44:19PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 4/4/25 2:40 PM, Christoph Hellwig wrote:
>>>>> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
>>>>>> Fixes the following lockdep warning:
>>>>>
>>>>> Please spell the actual dependency out here, links are not permanent
>>>>> and also not readable for any offline reading of the commit logs.
>>>>>
>>>>>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>>>>> +				   struct request_queue *q, bool lock)
>>>>>> +{
>>>>>> +	if (lock) {
>>>>>
>>>>> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
>>>>> screaming at you (in this case even for the right reason :))
>>>>>
>>>>>> +		/* protect against switching io scheduler  */
>>>>>> +		mutex_lock(&q->elevator_lock);
>>>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>>>>> +		mutex_unlock(&q->elevator_lock);
>>>>>> +	} else {
>>>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>>>>> +	}
>>>>>
>>>>> I think the problem here is again that because of all the other
>>>>> dependencies elevator_lock really needs to be per-set instead of
>>>>> per-queue which will allows us to have much saner locking hierarchies.
>>>>>
>>>> I believe you meant here q->tag_set->elevator_lock? 
>>>
>>> I don't know what locks you are planning to invent.
>>>
>>> For set->tag_list_lock, it has been very fragile:
>>>
>>> blk_mq_update_nr_hw_queues
>>> 	set->tag_list_lock
>>> 		freeze_queue
>>>
>>> If IO failure happens when waiting in above freeze_queue(), the nvme error
>>> handling can't provide forward progress any more, because the error
>>> handling code path requires set->tag_list_lock.
>>
>> I think you're referring here nvme_quiesce_io_queues and nvme_unquiesce_io_queues
> 
> Yes.
> 
>> which is called in nvme error handling path. If yes then I believe this function 
>> could be easily modified so that it doesn't require ->tag_list_lock. 
> 
> Not sure it is easily, ->tag_list_lock is exactly for protecting the list of "set->tag_list".
> 
Please see this, here nvme_quiesce_io_queues doen't require ->tag_list_lock:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 777db89fdaa7..002d2fd20e0c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5010,10 +5010,19 @@ void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
 {
        if (!ctrl->tagset)
                return;
-       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
-               blk_mq_quiesce_tagset(ctrl->tagset);
-       else
-               blk_mq_wait_quiesce_done(ctrl->tagset);
+       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags)) {
+               struct nvme_ns *ns;
+               int srcu_idx;
+
+               srcu_idx = srcu_read_lock(&ctrl->srcu);
+               list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+                               srcu_read_lock_held(&ctrl->srcu)) {
+                       if (!blk_queue_skip_tagset_quiesce(ns->queue))
+                               blk_mq_quiesce_queue_nowait(ns->queue);
+               }
+               srcu_read_unlock(&ctrl->srcu, srcu_idx);
+       }
+       blk_mq_wait_quiesce_done(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);

Here we iterate through ctrl->namespaces instead of relying on tag_list
and so we don't need to acquire ->tag_list_lock.

> And the same list is iterated in blk_mq_update_nr_hw_queues() too.
> 
>>
>>>
>>> So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
>>> fortunately that is what nvme is doing.
>>>
>>>
>>>> If yes then it means that we should be able to grab ->elevator_lock
>>>> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
>>>> order should be in each code path,
>>>>
>>>> __blk_mq_update_nr_hw_queues
>>>>     ->elevator_lock 
>>>>       ->freeze_lock
>>>
>>> Now tagset->elevator_lock depends on set->tag_list_lock, and this way
>>> just make things worse. Why can't we disable elevator switch during
>>> updating nr_hw_queues?
>>>
>> I couldn't quite understand this. As we already first disable the elevator
>> before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
>> Once mapping is successful we switch back the elevator.
> 
> Yes, but user still may switch elevator from none to others during the
> period, right?
> 
Yes correct, that's possible. So your suggestion was to disable elevator
update while we're running __blk_mq_update_nr_hw_queues? And that way user
couldn't update elevator through sysfs (elv_iosched_store) while we update
nr_hw_queues? If this is true then still how could it help solve lockdep
splat? 

Thanks,
--Nilay

