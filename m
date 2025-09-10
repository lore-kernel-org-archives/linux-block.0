Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18B1F2BA4;
	Wed, 10 Sep 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485857; cv=none; b=S3+piyl83h3HyeNpnJ+5k91gsz4tBeRXkeIh4+VmWeV0KxPcObkFIXuOvS+nv3u7Z9Olbe9jnV/yxnTg54Agw5j9G3iA4XWOOp/BWsf7HUee7vyj2U21DvarlEPuySKTxyjMAsDa+gH078L/wr+qbOwqLrDTt5h17egVrplUSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485857; c=relaxed/simple;
	bh=2UbzDj4uOafPTJkONo1CB1yVdlo16YEjBnWAyMjgrw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRMBuHcuEBf8Pi7ayC0HjKsLWg1r2HubwPbxLyv5qO3U4EFjfj36Ifn1knjVAEqVm51hjKb+032l55yFcyMRzRgwApV4oSDV53HbrRKnvPI49s41YtXgJ8Y6POC5Wc7t+BJ774n5kFQ/koecCF1zm84+TW7z+tdKfyjFEy16UyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PoYELaZU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PoYELaZU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A64sCX000646;
	Wed, 10 Sep 2025 06:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FY/EXr
	p2yH+KEZ3JsYKHI/jMOejDpaiwK892fvwEtbw=; b=PoYELaZUFSXQzs53Br/HtB
	RVjMsS/MCfLk5e/8IEulm3Nl9y1P1q3P9aDcMk+7Do/GhqB5MNTjBv6gqqVoKjX3
	HL+/NWVj+ninsaj1dsRQ3X6Y797Joojn8aaCkx+M3iKtZ8BqK4IzJj8OtV769SNN
	yX6kQuhJriVTtm13Wr27jswB2cTCdftryTR9aPvd9hWoQz6Z7waQeN9pyn3Iurn0
	gE3RJ7rJ7nK8hpOJP5ubNkfZURC9Pn2rral3RUQitElvKULjHVKuVvx3bfn7MJpT
	UFK6MEYtsGeY8SexB8fPa93Skp895MgnDm1UtYXwL76jG0BMQrQk3BHJ+fWQ9u2w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffcax0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:30:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A37LAR001156;
	Wed, 10 Sep 2025 06:30:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203er1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:30:36 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58A6UZBq33292958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 06:30:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41625805E;
	Wed, 10 Sep 2025 06:30:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 236E658045;
	Wed, 10 Sep 2025 06:30:31 +0000 (GMT)
Received: from [9.43.57.88] (unknown [9.43.57.88])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 06:30:30 +0000 (GMT)
Message-ID: <a4fd99c3-faa6-4c6d-b7a5-4f32d3eed40b@linux.ibm.com>
Date: Wed, 10 Sep 2025 12:00:28 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 06/10] blk-mq: split bitmap grow and resize
 case in blk_mq_update_nr_requests()
To: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai1@huaweicloud.com>,
        ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-7-yukuai1@huaweicloud.com>
 <85259339-d832-468a-a9b0-0c326c896370@linux.ibm.com>
 <8ab0b2e2-a3da-43b1-9fb8-141e85aee3b2@yukuai.org.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8ab0b2e2-a3da-43b1-9fb8-141e85aee3b2@yukuai.org.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vgqm4KcRGdvJU3R8Y9om_chCmL6skbHj
X-Proofpoint-GUID: Vgqm4KcRGdvJU3R8Y9om_chCmL6skbHj
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c11b0d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=MAtkmkursVBXDMlYZQEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfXzyxllk1o4YYs
 WiEnI2Cns0l+EWGlT/VrWZOJxHaGyP5uA/poPVk51CR7sLjEHCjZkyMCUrYxNfCLPc5RYFeeHWz
 PHPTt/gnzZ+02P2rNZrUSBVq7yCEMRxr79DRmjjALZMFzQifC/lUsrEDftSNaarh7UKI/+jGeI2
 gI7a/hjH+Q3ZweNMJujR6sQH5aqgxOxpRppy2gnbMiG78S5z08cQ5brxED/y2EnwFBxDPtRDykD
 oSKn9xB22utpGd9SsiH7vBzNONG9oXLb58ag/+1pO9JXRVdpOA5L0rKvVp+TindqgiSvRp7jgt2
 akUYVowhmOMHc1ol+gTkAwAGVQ6fW0mJmGxc7BfoaWeP+3qfeVpfR2nPAua1ZT0n/bSeo+U2lo5
 2HqOWU2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/9/25 10:09 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/9/9 20:18, Nilay Shroff 写道:
>>
>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> No functional changes are intended, make code cleaner and prepare to fix
>>> the grow case in following patches.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/blk-mq.c | 28 ++++++++++++++++------------
>>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 1ff6370f7314..82fa81036115 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4931,21 +4931,25 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>>               blk_mq_tag_update_sched_shared_tags(q);
>>>           else
>>>               blk_mq_tag_resize_shared_tags(set, nr);
>>> -    } else {
>>> +    } else if (!q->elevator) {
>>>           queue_for_each_hw_ctx(q, hctx, i) {
>>>               if (!hctx->tags)
>>>                   continue;
>>> -            /*
>>> -             * If we're using an MQ scheduler, just update the
>>> -             * scheduler queue depth. This is similar to what the
>>> -             * old code would do.
>>> -             */
>>> -            if (hctx->sched_tags)
>>> -                ret = blk_mq_tag_update_depth(hctx,
>>> -                            &hctx->sched_tags, nr);
>>> -            else
>>> -                ret = blk_mq_tag_update_depth(hctx,
>>> -                            &hctx->tags, nr);
>>> +            sbitmap_queue_resize(&hctx->tags->bitmap_tags,
>>> +                nr - hctx->tags->nr_reserved_tags);
>>> +        }
>>> +    } else if (nr <= q->elevator->et->nr_requests) {
>>> +        queue_for_each_hw_ctx(q, hctx, i) {
>>> +            if (!hctx->sched_tags)
>>> +                continue;
>>> +            sbitmap_queue_resize(&hctx->sched_tags->bitmap_tags,
>>> +                nr - hctx->sched_tags->nr_reserved_tags);
>>> +        }
>>> +    } else {
>>> +        queue_for_each_hw_ctx(q, hctx, i) {
>>> +            if (!hctx->sched_tags)
>>> +                continue;
>>> +            blk_mq_tag_update_depth(hctx, &hctx->sched_tags, nr);
>>>               if (ret)
>>>                   goto out;
>>>           }
>> The above code is good however can this be bit simplified?
>> It's a bit difficult to follow through all nesting and so
>> could it be simplified as below:
>>
>> if (shared-tags) {
>>      if (elevator)
>>         // resize sched-shared-tags bitmap
>>      else
>>         // resize shared-tags bitmap
>> } else {
>>      // non-shared tags
>>      if (elevator) {
>>          if (new-depth-is-less-than-the-current-depth)
>>              // resize sched-tags bitmap
>>          else
>>              // handle sched tags grow
>>      } else
>>          // resize tags bitmap
>> }
> 
> AFAIK, if - else if chain should be better than nested if - else, right?
> 
> If you don't mind, I can add comments to each else if chain to make code cleaner:
> 
> if () {
>     /* shared tags */
>     ...
> } else if () {
>     /* non-shared tags and elevator is none */
>     ...
> } else if () {
>     /* non-shared tags and elevator is not none, nr_requests doesn't grow */
>     ...
> } else () {
>     /* non-shared tags and elevator is not none, nr_requests grow */
>     ...
> }
> 
Yeah, I am good with the proper comments as well so that it'd be easy
for anyone reviewing the code later to understand what those all nested
if-else conditions meant. 

Thanks,
--Nilay

