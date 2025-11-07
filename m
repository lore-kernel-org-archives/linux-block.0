Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3731BC85;
	Fri,  7 Nov 2025 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512095; cv=none; b=HCHgzcbEmucosSdh5sAu6eFArM/cCEb+QiJWEqQCgkas/GP5h+hZ8GYemROLCzoKJN+dPwRFhy8y32avkKWLnSIbQf+iusLlya1XAoYomwXwgpAfMLA09/Akd/5SzN0ckj8MJ7xprvvIS0LbgJjSQaYXvJReizqRsuCiy1t0vUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512095; c=relaxed/simple;
	bh=x3xfEJjsq+90MqQHycYpk6tGt7j/nlcynzGU7Sk/V5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2pOJk/kLyg65to1Zo3aViGuxrlrq6RTFMt5PDnFNXyyq55Z4FCCKFQEsXmsS6AhXj+CY2ntVQWNQOAMM1oLGNMEepe+lWSTds3xPs/2enCYT0GIxYiq0z94lDqrk/gvO3xWasEHRC04sJl7JUx6N3iiOg/oxPJUFTL3ynjsBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cI9ctnXI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cI9ctnXI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7679Ds030815;
	Fri, 7 Nov 2025 10:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FQfKCs
	u2JMigErayMP5cI5pbifx5TVI3qW+Q7KoPDgg=; b=cI9ctnXIbgOtcbnJ0ESWbG
	HwCFZ70eAKf0HUMlLMGtPcuIvpePmF82x/K5byai/kqRMywVg5rlx1Opxhw08f1X
	N0rBHuVHceUURLMUs090grRajG5M2SCF/q3EKiaFBKOcKaCz6UECmjx4G1WadhP3
	/yCuNGbhft0oHQ7li8Lzcwva2xSqviKgzPJ5o1bPk/mAQHiHcTKCa29kl0fXhzrO
	1c99NlES5rqDj7Nqt0K3+mRBZj1o+7G2312/fiVJ+d2Ce+YMvCMCc3pw2qlfLqHB
	IIigQLBmjPkuNttXs79/9hyenDHmXnXOijyVarImA93QXT7ywwIXbiWqU33Cfp2w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v2au80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 10:41:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78jm7T021491;
	Fri, 7 Nov 2025 10:41:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrk20hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 10:41:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A7AfESR30343722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 10:41:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF39458052;
	Fri,  7 Nov 2025 10:41:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7307A5805E;
	Fri,  7 Nov 2025 10:41:10 +0000 (GMT)
Received: from [9.61.79.219] (unknown [9.61.79.219])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 10:41:10 +0000 (GMT)
Message-ID: <096323ad-529b-4b5c-a966-ff7cd6315ecc@linux.ibm.com>
Date: Fri, 7 Nov 2025 16:11:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Remove queue freezing from several sysfs store
 callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20251105170534.2989596-1-bvanassche@acm.org>
 <b556d704-dc3b-4e6c-a158-69fb5b377dac@linux.ibm.com>
 <7f2d2486-6b74-4ed1-81c8-2aa584cfe264@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7f2d2486-6b74-4ed1-81c8-2aa584cfe264@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D7oNcefHysAjdWrrLK5KlKsBilAj5YEM
X-Proofpoint-ORIG-GUID: D7oNcefHysAjdWrrLK5KlKsBilAj5YEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXyTpMcHJQaW2i
 om2zAxkr2GXaMfI6Ro1hnsJ7wAQ0MdWSr+Jl6uWYrCrI/0LCaRBDyoi1ozkERRJSAFMZhbxV9nC
 s/ekVp4ZqhP42VtCZyvBGcvBlGqbdgZ3EVDwF62s46O1aofluEuSimLnKJtnoA2Bb7cvDndknBx
 1Me47hAgmgNtpFHr/RKuBKwU6NfwBJZCSdxvm65ssG8o7fUqbmLKkq2OEuDePKN6RL5myrCCjRn
 juXQ2LbniZ2dK0GO5WWiQWuH8iAUhmSvYg1Q2ZwP0RsFTGFh4heA97oQLVmUJLWgS6HE15nO7fX
 87sygwPG/2Lk3/nowxazR+d5EO9TauzxXlfLUbkLJY9bjgky83qF66dVOC6XmmnZ6iOsscS2015
 bqKQVFaOfRqd6cc9k3PcHAJ5zF5cng==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690dcccc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=slnAk8qkVrWKiL5MmmsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021



On 11/7/25 2:19 AM, Bart Van Assche wrote:
> On 11/6/25 5:01 AM, Nilay Shroff wrote:
>>> @@ -154,10 +153,8 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
>>>        * calculated from the queue limits by queue_limits_commit_update.
>>>        */
>>>       mutex_lock(&q->limits_lock);
>>> -    memflags = blk_mq_freeze_queue(q);
>>> -    disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
>>> +    data_race(disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10));
>>>       mutex_unlock(&q->limits_lock);
>>> -    blk_mq_unfreeze_queue(q, memflags);
>>>         return ret;
>>>   }
>>
>> I think we don't need data_race() here as disk->bdi->ra_pages is already
>> protected by ->limits_lock. Furthermore, while you're at it, I’d suggest
>> protecting the set/get access of ->ra_pages using ->limits_lock when it’s
>> invoked from the ioctl context (BLKRASET/BLKRAGET).
> 
> I think that we really need the data_race() annotation here because
> there is plenty of code that reads ra_pages without using any locking.

I believe, in that case we need to annotate both reader and writer, using
data_race(). Annotating only writer but not reader would not help suppress
KCSAN reports of a data race.

>>> @@ -480,9 +468,7 @@ static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
>>>       if (err || val == 0)
>>>           return -EINVAL;
>>>   -    memflags = blk_mq_freeze_queue(q);
>>> -    blk_queue_rq_timeout(q, msecs_to_jiffies(val));
>>> -    blk_mq_unfreeze_queue(q, memflags);
>>> +    data_race((blk_queue_rq_timeout(q, msecs_to_jiffies(val)), 0));
>>>         return count;
>>>   }
>>
>> The use of data_race() above seems redundant, since the update to q->rq_timeout
>> is already marked with WRITE_ONCE(). However, the read access to q->rq_timeout
>> in a few places within the I/O hotpath is not marked and instead accessed directly
>> using plain C-language loads.
> 
> That's fair. I will remove data_race() again from
> queue_io_timeout_store().
>> BUG: KCSAN: data-race in blk_add_timer+0x74/0x1f0
>>
>> Based on the gdb trace:
>>
>> (gdb) info line *(blk_add_timer+0x74)
>> Line 138 of "block/blk-timeout.c" starts at address 0xc000000000d5637c <blk_add_timer+108> and ends at 0xc000000000d5638c <blk_add_timer+124>.
>>
>> This corresponds to:
>>
>> 128 void blk_add_timer(struct request *req)
>> 129 {
>> 130         struct request_queue *q = req->q;
>> 131         unsigned long expiry;
>> 132
>> 133         /*
>> 134          * Some LLDs, like scsi, peek at the timeout to prevent a
>> 135          * command from being retried forever.
>> 136          */
>> 137         if (!req->timeout)
>> 138                 req->timeout = q->rq_timeout;
>>
>> As seen above, the read access to q->rq_timeout is unmarked. To avoid the reported
>> data race, we should replace this plain access with READ_ONCE(q->rq_timeout).
>> This is one instance in the I/O hotpath where q->rq_timeout is read without annotation,
>> and there are likely a few more similar cases that should be updated in the same way.
> 
> That's an existing issue and an issue that falls outside the scope of my
> patch.
> 
Hmm, I don’t think this issue falls outside the scope of the current patch. 
Without this change, it would not be possible for queue_io_timeout_store()
to run concurrently with the I/O hotpath and update q->rq_timeout while it’s
being read. Since this patch removes queue freeze from queue_io_timeout_store(),
it can now potentially execute concurrently with the I/O hotpath, which could
then manifest the KCSAN-reported data race described above.

Thanks,--Nilay
