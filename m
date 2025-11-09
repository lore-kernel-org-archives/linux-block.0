Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A601F0994;
	Sun,  9 Nov 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762684699; cv=none; b=L2tCSfSn+JdIbx+enZnnbsgykTE7hQzCWtkNUHDUbCg4op9D+rCWmk6Y4vp52/IkvWDQPYTcxuiTmlpwNX9yZRcgAM1ga+wka+pXoy6SRjZtOs2lYRixtn2pfaptE+yApb0TsB1TgMcEZP3gAh7wCPVRJvke0sxG27p9fCMD3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762684699; c=relaxed/simple;
	bh=ofM+kAPSxidAttzGwGnb9gy5uKh+1uekSJ3GE5rGyEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojsurSrumuw7hQVl/Tzt4GhfuE5GaUpZDTM2Cb9iCi7B22w/HlHKdmzqfcHbC4TbxqsArl8Y98GfpuCA1eCjj6gXGfNbVSLk1vxCY930I9aUE/j9j0WLSyHASYf+rYN3uPN4zEbeF/xcuiH/4+2XkbakRdhLSVNmTpsKqzUuaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HWErHo7J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HWErHo7J"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A94FBNZ015364;
	Sun, 9 Nov 2025 10:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KZA6CO
	4X82O5E5YuSRC76+fxWN9Ob/ng9A6n3OFimrM=; b=HWErHo7Jt8wXzbFS7oB+/e
	TB/sQBUfWNbxX0jk5HYmiEUW5JaNMgtShKN7YX8IrG+hK8NKqzfIt6bM8J3tooq9
	KUo9DDzX3E3UXk+N0XiM9CrfsNGRTpFfzG0EmIkczXqnMhmr6ZGbb67UXRLeZmnZ
	SFP4QdWhCZPY2gGRFXYpn71o8mOHFuCygTF3XzflQB0sIQeUVV6F3xkwQ7PeHPPC
	yDaXU2rvm03aSA/fC7r/06XQJzivzLPy3G0dvA4sTS2FdOoDq5Xq0Vc+fL4b3Il5
	2rKUYoJMxjThthQvA21p8Hz2Fy3dMbLxRZ13Hii33AzNHHSX/Jd/t8cxjzvVY8JA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwkchr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Nov 2025 10:37:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A99JJml009576;
	Sun, 9 Nov 2025 10:37:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj118b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Nov 2025 10:37:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A9AbsW122676012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Nov 2025 10:37:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36C1C58060;
	Sun,  9 Nov 2025 10:37:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6A3B5805A;
	Sun,  9 Nov 2025 10:37:49 +0000 (GMT)
Received: from [9.61.96.116] (unknown [9.61.96.116])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Nov 2025 10:37:49 +0000 (GMT)
Message-ID: <c72447a9-73a3-42af-aae5-55c042b3974c@linux.ibm.com>
Date: Sun, 9 Nov 2025 16:07:47 +0530
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
 <096323ad-529b-4b5c-a966-ff7cd6315ecc@linux.ibm.com>
 <e7c3d79e-6557-4497-973b-5038f9f35958@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e7c3d79e-6557-4497-973b-5038f9f35958@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YSoZ0X_jibQmVKykJy5ES5q_e821vVbz
X-Proofpoint-ORIG-GUID: YSoZ0X_jibQmVKykJy5ES5q_e821vVbz
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69106f03 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rtch9BD_4Y7QLr5F-6QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX+uOQ9N3d/mLi
 RDdNoopvcLHZPAEhu2rIoNnA4aWCYHlZuZl8qdvDzcMXe6GmyP4k1jotAJqEcImYFXj5cF0al9U
 rYQFz778N2PL/p/1DaXt9URp8H3mRHNWyGVadV9chgyKLCB4nd+vdifhYMmgDgjeMMChYS4vw04
 6Z4yKr6T3OvujNGw8EcTBtSEsglLYMVg3fxA1W2W0se8ZJ/zdsgN+xFPtHo/8YWZ7lFppw8pu67
 Pb+dYnBz9Buttk2nTRnQH0rK3VyDVd/TrOG5TQ4yyoHDYGs+k3z4nP7zJ2RUjHsHjMOJJ5Q4DqG
 JeZ2Gyx5X93YyTFfNcBK3x7RsW+CO/EuRr9DD6gnd0rVcPspqkPq26kWBPMj6JmV8h05RcHdfH0
 MExnVCCco5O4Ze2dZezQVhXO6lEEZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



On 11/7/25 9:48 PM, Bart Van Assche wrote:
> On 11/7/25 2:41 AM, Nilay Shroff wrote:
>> On 11/7/25 2:19 AM, Bart Van Assche wrote:
>>> On 11/6/25 5:01 AM, Nilay Shroff wrote:
>>>>> @@ -154,10 +153,8 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
>>>>>         * calculated from the queue limits by queue_limits_commit_update.
>>>>>         */
>>>>>        mutex_lock(&q->limits_lock);
>>>>> -    memflags = blk_mq_freeze_queue(q);
>>>>> -    disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
>>>>> +    data_race(disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10));
>>>>>        mutex_unlock(&q->limits_lock);
>>>>> -    blk_mq_unfreeze_queue(q, memflags);
>>>>>          return ret;
>>>>>    }
>>>>
>>>> I think we don't need data_race() here as disk->bdi->ra_pages is already
>>>> protected by ->limits_lock. Furthermore, while you're at it, I’d suggest
>>>> protecting the set/get access of ->ra_pages using ->limits_lock when it’s
>>>> invoked from the ioctl context (BLKRASET/BLKRAGET).
>>>
>>> I think that we really need the data_race() annotation here because
>>> there is plenty of code that reads ra_pages without using any locking.
>>
>> I believe, in that case we need to annotate both reader and writer, using
>> data_race(). Annotating only writer but not reader would not help suppress
>> KCSAN reports of a data race.
> 
> No. As the comment above the data_race() macro explains, the data_race()
> macro makes memory accesses invisible to KCSAN. Hence, annotating
> writers only with data_race() is sufficient.

If the data access is marked using one of READ_ONCE(), WRITE_ONCE(), or
data_race(), then KCSAN would not instrument that access. However, plain
accesses are always instrumented.

So, if we only mark the writers but keep the readers as plain accesses, KCSAN
would likely report a race at unknown origin — because the plain read access is 
still being watched, and when the variable’s value changes, it’s detected as a
data race. This is exactly what I observed and reported earlier with this change.

>>>>> @@ -480,9 +468,7 @@ static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
>>>>>        if (err || val == 0)
>>>>>            return -EINVAL;
>>>>>    -    memflags = blk_mq_freeze_queue(q);
>>>>> -    blk_queue_rq_timeout(q, msecs_to_jiffies(val));
>>>>> -    blk_mq_unfreeze_queue(q, memflags);
>>>>> +    data_race((blk_queue_rq_timeout(q, msecs_to_jiffies(val)), 0));
>>>>>          return count;
>>>>>    }
>>>>
>>>> The use of data_race() above seems redundant, since the update to q->rq_timeout
>>>> is already marked with WRITE_ONCE(). However, the read access to q->rq_timeout
>>>> in a few places within the I/O hotpath is not marked and instead accessed directly
>>>> using plain C-language loads.
>>>
>>> That's an existing issue and an issue that falls outside the scope of my
>>> patch.
>>>
>> Hmm, I don’t think this issue falls outside the scope of the current patch.
>> Without this change, it would not be possible for queue_io_timeout_store()
>> to run concurrently with the I/O hotpath and update q->rq_timeout while it’s
>> being read. Since this patch removes queue freeze from queue_io_timeout_store(),
>> it can now potentially execute concurrently with the I/O hotpath, which could
>> then manifest the KCSAN-reported data race described above.
> Annotating all rq_timeout read accesses with READ_ONCE() would be
> cumbersome because there are plenty of direct rq_timeout accesses
> outside the block layer, e.g. in drivers/scsi/st.c (SCSI tape driver).
> 
Yes I agree there're plenty of them.

> I prefer an alternative approach: annotate the q->rq_timeout update in
> blk_queue_rq_timeout() with both data_race() and WRITE_ONCE(). That
> guarantees that rq_timeout update happens once and prevents that KCSAN
> complains about rq_timeout reads.
> 
Again if we avoid marking read access then as I mentioned above it'd 
cause a race at unknown origin. That said, you may spin a new patch
with the change (as you see fit) and I'll help test and review it.
Thanks,
--Nilay
