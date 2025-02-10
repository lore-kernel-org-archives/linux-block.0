Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7C1B87F1
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176793; cv=none; b=H47vz3dNr2jSLEcRSXQEn6STi1ZDRJNJa7bYfFxkBs+rPJwMPQKJlXMX1V9G6D2hwgewAO1HYFauUcPnVib224ZKU0CfWlkqfBVFTqAt28lECiO07grIIgRrk8tXbvBObuXPaIuWlfQc+K5KcJYQNfnB+JaSqW/A/fXAuI852Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176793; c=relaxed/simple;
	bh=P2cmhMaRyWJ8rJf1JueVSv7Ow50cnrOojJqYAflGJ+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNgrKd8fDEBsBIHZvATXBuNI7LUtWgAt8T9txl5TPhtguyOidFm6jw/ZwRzgsEy12dz3aSVWAponR9XUjrJZ6uLYvtytMQ+Mp6+K6+SYrcF4wqUZqP9HzE5aRN0EIIWa4RMGwix3zgr/uA2/+m/Go4WxcSflXFXJDg25sF5IoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TKakyBcm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TKakyBcm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A5Nmxq014099;
	Mon, 10 Feb 2025 08:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AGAwrQ
	B/9N4W58W1ZTk5OhwONn9PaL1xWR+gAtpTI5U=; b=TKakyBcmRLDYclGYBWlaIP
	0BPYJaafxhrtPYCXVyD6OdD/l3v9po8sBQ2QEujd4AV3kJKZJYF5bXFkz8tvQGqt
	1WKhKb8VNZqn4/4ANeXhkYGwubg4WpMFaZ6144hZevpy6k6/Yo3c3oXENKacLo+E
	IfRcQBqNzcKLetUu7A016t+71E4weGqzIV2orInFuCHXvzRie2e/Fzk1N2mSjnv0
	UgrjjsZTO51R9rGLHG3jGORh6X9/dALH3CkGJlcEA4GjCupXv+5UvzSKEmZeDzVR
	uE/j0GtzLxmw1IPmxNv/T/GOkyf1MwbcKASqNirAl06BGjQTO41d34FWMZNRWIzQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qb97rtep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 08:39:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51A8KZ8v016712;
	Mon, 10 Feb 2025 08:39:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3jwa5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 08:39:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51A8dfbU29164224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 08:39:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788F558056;
	Mon, 10 Feb 2025 08:39:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7569458069;
	Mon, 10 Feb 2025 08:39:39 +0000 (GMT)
Received: from [9.109.198.172] (unknown [9.109.198.172])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 08:39:39 +0000 (GMT)
Message-ID: <ef16b84a-b286-4ed1-83c3-7f78db1203d8@linux.ibm.com>
Date: Mon, 10 Feb 2025 14:09:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        hch
 <hch@lst.de>, Ming Lei <minlei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
 <20250209122035.1327325-8-ming.lei@redhat.com>
 <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
 <CAFj5m9+-CMU52E1hpNsG+eXC4HsG82Ny7f=iJrdAfGScTFPD4Q@mail.gmail.com>
 <57253c19-1be3-496c-836b-5c56a59788f2@linux.ibm.com>
 <lspdisg5wdcfu5ldrxblxyy427gkv4kpx2siewhfubcavbnenk@lcuvmhkr6bdr>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <lspdisg5wdcfu5ldrxblxyy427gkv4kpx2siewhfubcavbnenk@lcuvmhkr6bdr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 153OrAK9h9lUMY28UiBWUKEvhJaz8pvl
X-Proofpoint-ORIG-GUID: 153OrAK9h9lUMY28UiBWUKEvhJaz8pvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=912 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100070



On 2/10/25 1:55 PM, Shinichiro Kawasaki wrote:
> On Feb 10, 2025 / 12:31, Nilay Shroff wrote:
>>
>>
>> On 2/10/25 7:12 AM, Ming Lei wrote:
>>> On Mon, Feb 10, 2025 at 8:52 AM Shinichiro Kawasaki
>>> <shinichiro.kawasaki@wdc.com> wrote:
>>>>
>>>> On Feb 09, 2025 / 20:20, Ming Lei wrote:
>>>>> All block internal state for dealing adding/removing debugfs entries
>>>>> have been removed, and debugfs can sync everything for us in fs level,
>>>>> so don't grab q->debugfs_mutex for adding/removing block internal debugfs
>>>>> entries.
>>>>>
>>>>> Now q->debugfs_mutex is only used for blktrace, meantime move creating
>>>>> queue debugfs dir code out of q->sysfs_lock. Both the two locks are
>>>>> connected with queue freeze IO lock.  Then queue freeze IO lock chain
>>>>> with debugfs lock is cut.
>>>>>
>>>>> The following lockdep report can be fixed:
>>>>>
>>>>> https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs/
>>>>>
>>>>> Follows contexts which adds/removes debugfs entries:
>>>>>
>>>>> - update nr_hw_queues
>>>>>
>>>>> - add/remove disks
>>>>>
>>>>> - elevator switch
>>>>>
>>>>> - blktrace
>>>>>
>>>>> blktrace only adds entries under disk top directory, so we can ignore it,
>>>>> because it can only work iff disk is added. Also nothing overlapped with
>>>>> the other two contex, blktrace context is fine.
>>>>>
>>>>> Elevator switch is only allowed after disk is added, so there isn't race
>>>>> with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
>>>>> previous elevator, so no race between these two. Elevator switch context
>>>>> is fine.
>>>>>
>>>>> So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
>>>>> adding/removing hctx entries, there might be race with add/remove disk,
>>>>> which is just fine in reality:
>>>>>
>>>>> - blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
>>>>> won't be added/removed at the same time
>>>>>
>>>>> - even though there is race between the two contexts, it is just fine,
>>>>> since hctx won't be freed until queue is dead
>>>>>
>>>>> - we never see reports in this area without holding debugfs in
>>>>> blk_mq_update_nr_hw_queues()
>>>>>
>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>
>>>> Ming, thank you for this quick action. I applied this series on top of
>>>> v6.14-rc1 kernel and ran the block/002 test case. Unfortunately, still if fails
>>>> occasionally with the lockdep "WARNING: possible circular locking dependency
>>>> detected" below. Now debugfs_mutex is not reported as one of the dependent
>>>> locks, then I think this fix is working as expected. Instead, eq->sysfs_lock
>>>> creates similar dependency. My mere guess is that this patch avoids one
>>>> dependency, but still another dependency is left.
>>>
>>> Indeed, this patch cuts dependency on both q->sysfs_lock and q->debugfs_lock,
>> Glad to see that with this patch we're able to cut the dependency between
>> q->sysfs_lock and q->debugfs_lock.
>>
>>> but elevator ->sysfs_lock isn't covered, :-(
>>>
>> I believe that shall be fixed with the current effort undergoing here:
>> https://lore.kernel.org/all/20250205144506.663819-1-nilay@linux.ibm.com/
> 
> Thanks Nilay for the information. I applied your patch series on top of
> v6.14-rc1 and Ming's. Then I ran block/002. Alas, still the test case fails with
> the "WARNING: possible circular locking dependency detected". The lockdep splat
> contents has changed as below:
> 
Thanks Shinichiro for trying out the patch!
However this patchset is not complete yet. I have to work on few suggestions
from Christoph and Ming and then I will re-post the patchset. We're planning 
to replace q->sysfs_lock with a new dedicated lock for elevator switch case 
and that should help cut the dependency between q->q_usage_counter(io) and 
q->sysfs_lock. So I think you need to wait for sometime before the patchest 
is ready.

Thanks,
--Nilay


