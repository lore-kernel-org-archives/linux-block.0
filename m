Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAF165F16
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521601; cv=none; b=SCUZ3uGs9LQnQ4eyDTggZ7v0h2wqykIjAJPQhSbJLNJPkeZozGkOkJ73Xy900EhQgXu5XLOv7KAgsSEKanhjsnlT2yaf4BNJ7IRPQ/7FwPkExnTV3ha7iG7DVYa6BiGzvh84ILCYRLrCRq9vAHZx1u0+Ei6EASqn1F9amrFFjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521601; c=relaxed/simple;
	bh=rKgQo2uYwJ++Lxo1zga1R/IXmckHhm1S4X3iIuQmPrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRglf3H9luIWOWwiTO9b6V460YF80OjBU2ym5R62hx22YnRinZVKJxuzliC8hFEtjFMNNcMv6nfSR1PF8OfZ9szYsXnTP6lzyw4//zrfqP6KJpVCPuBTI0AAoUWJw5Xr6kAbE1ZmdwUwSU0J4PU9QZoeBmRJQXf6CPDh/mYNhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qR5pQ5CO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qR5pQ5CO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNaoeG019936;
	Wed, 18 Dec 2024 11:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5f/Obz
	zvl/1D0uronusMmqdY9mvTjRk9BTYNJkgwKpw=; b=qR5pQ5COvFQTmzp7eFBZKf
	Zp6sqsV21KbbzHlMah2r63+ayPR5l+XzK2HKmB7eFP46SZ9MQgm+fqadQwX0QyqW
	/kQiZWADF+AEHU5OjhoIEZ4olx3l1D3hwM9OtviXGAwyjiolo08xU3Kh6ahwdBre
	kFCM/tF7T0X9sMZ3VxCoghJoGErZs4NHY+DI8+XQ48W3XNusMqXWw3EN1KJ9+rF9
	tNdbne/eciW1Ok9famUrazQeoMSylITDj4lxr3eau1oxNkr9QRT501UOmX5hKO/Z
	Pl3aqguO0ROsyfCRCLNFQydaNrE9yGl5Ybl2gcXaYWiBg2Y59wLFbv8VyY8YMPeA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kk4aajkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:33:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIBL4sk029338;
	Wed, 18 Dec 2024 11:33:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsqtj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 11:33:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIBX4uN26935844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 11:33:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAFDB58056;
	Wed, 18 Dec 2024 11:33:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE32758052;
	Wed, 18 Dec 2024 11:33:01 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 11:33:01 +0000 (GMT)
Message-ID: <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
Date: Wed, 18 Dec 2024 17:03:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Ming Lei <ming.lei@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20241216080206.2850773-1-ming.lei@redhat.com>
 <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z2Iu1CAAC-nE-5Av@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 25U2pEtph9IiRoSJ6d92e11ZY95MR--h
X-Proofpoint-ORIG-GUID: 25U2pEtph9IiRoSJ6d92e11ZY95MR--h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=815 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180093



On 12/18/24 07:39, Ming Lei wrote:
> On Tue, Dec 17, 2024 at 08:07:06AM -0800, Damien Le Moal wrote:
>> On 2024/12/16 23:30, Ming Lei wrote:
>>> On Tue, Dec 17, 2024 at 08:19:28AM +0100, Christoph Hellwig wrote:
>>>> On Tue, Dec 17, 2024 at 03:05:48PM +0800, Ming Lei wrote:
>>>>> On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
>>>>>> On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
>>>>>>> The local copy can be updated in any way with any data, so does another
>>>>>>> concurrent update on q->limits really matter?
>>>>>>
>>>>>> Yes, because that means one of the updates get lost even if it is
>>>>>> for entirely separate fields.
>>>>>
>>>>> Right, but the limits are still valid anytime.
>>>>>
>>>>> Any suggestion for fixing this deadlock?
>>>>
>>>> What is "this deadlock"?
>>>
>>> The commit log provides two reports:
>>>
>>> - lockdep warning
>>>
>>> https://lore.kernel.org/linux-block/Z1A8fai9_fQFhs1s@hovoldconsulting.com/
>>>
>>> - real deadlock report
>>>
>>> https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
>>>
>>> It is actually one simple ABBA lock:
>>>
>>> 1) queue_attr_store()
>>>
>>>       blk_mq_freeze_queue(q);					//queue freeze lock
>>>       res = entry->store(disk, page, length);
>>> 	  			queue_limits_start_update		//->limits_lock
>>> 				...
>>> 				queue_limits_commit_update
>>>       blk_mq_unfreeze_queue(q);
>>
>> The locking + freeze pattern should be:
>>
>> 	lim = queue_limits_start_update(q);
>> 	...
>> 	blk_mq_freeze_queue(q);
>> 	ret = queue_limits_commit_update(q, &lim);
>> 	blk_mq_unfreeze_queue(q);
>>
>> This pattern is used in most places and anything that does not use it is likely
>> susceptible to a similar ABBA deadlock. We should probably look into trying to
>> integrate the freeze/unfreeze calls directly into queue_limits_commit_update().
>>
>> Fixing queue_attr_store() to use this pattern seems simpler than trying to fix
>> sd_revalidate_disk().
> 
> This way looks good, just commit af2814149883 ("block: freeze the queue in
> queue_attr_store") needs to be reverted, and freeze/unfreeze has to be
> added to each queue attribute .store() handler.
> 
Wouldn't it be feasible to add blk-mq freeze in queue_limits_start_update()
and blk-mq unfreeze in queue_limits_commit_update()? If we do this then 
the pattern would be, 

queue_limits_start_update(): limit-lock + freeze
queue_limits_commit_update() : unfreeze + limit-unlock  

Then in queue_attr_store() we shall just remove freeze/unfreeze.

We also need to fix few call sites where we've code block,

{
    blk_mq_freeze_queue()
    ...
    queue_limits_start_update()
    ...    
    queue_limits_commit_update()
    ...
    blk_mq_unfreeze_queue()
    
}

In the above code block, we may then replace blk_mq_freeze_queue() with
queue_limits_commit_update() and similarly replace blk_mq_unfreeze_queue() 
with queue_limits_commit_update().

{
    queue_limits_start_update()
    ...
    ...
    ...
    queue_limits_commit_update()

}

Thanks,
--Nilay


