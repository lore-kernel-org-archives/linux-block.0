Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053D433A4
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266142; cv=none; b=VkoNQwbn9BxOGjIg9ydixuUjwUqzRk/BN1WhsQcQVIDBsxF8n5jpAR30nGfG0rJvw/Zdhkmd3NmTI+yDvI0k0k0Mq6WJe0b1EF1vtmNfHFrNo9eIOWlrrSGFDP/haYxDeWSWGDXIiJcJwWHkDF833vLT+WzOgc6/vHXaEj4ZUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266142; c=relaxed/simple;
	bh=Y+eHlr2Tncej/33t38r3q/PILvxNqsstRejziS7vKVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rucfp1n5yDA1WOdaMPbsLy43yxzbCbr9+3kQCOCMzux7J3yxGsYSZ2PaYIjiHd2wfpidk4kuQgEXCSZs3HLU18ZbzEjOnyAtOp/EqNAEzw9P4n4B0P0EiAdWiku+RTQk/ziNMx9F2DrJfLF48Z5SehBSspSAGCpzWbpD42TFXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SZ9IIX3w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SZ9IIX3w"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55THtjYs001883;
	Mon, 30 Jun 2025 06:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QfyEzW
	ssVgW3gSeyd/NPziKxryoXS2uZa2H8t410MAo=; b=SZ9IIX3wb749WE5F+WNlfW
	1AznY2VHcut5ZyRU7q8+i1kTDdELuN9S6GvDEGWcJg7eGpOHbLpyP+QiHFVJSeb4
	/TGpYBJaS1h9PsFVAtTlqW+0JFnG5jFClkudD4dykRZUwgiTbHOgb4Em5+WETlvp
	JAhp9zTjN2KDtav4SYTzaLJBt8b/HqIl0QYLqTyYMUsU+dia9hpE0F+lYIiu6wPp
	/yuaROl+A1ylXpwab8GaekbjGIoaX9j7eQ1wskGpqGuPBLJuRLQSOxVn3G1RoInO
	BiM5+GswfSEy4AeibpfPjTUhHcUDZ8wiMtcFTK7/UcDlxNrj5O+XQCy3vVeSAWmw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84cynqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:48:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U43VGj021109;
	Mon, 30 Jun 2025 06:48:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqu4vgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 06:48:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U6mloN59310576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 06:48:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75F4C5805F;
	Mon, 30 Jun 2025 06:48:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 526EE58054;
	Mon, 30 Jun 2025 06:48:44 +0000 (GMT)
Received: from [9.61.92.250] (unknown [9.61.92.250])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 06:48:43 +0000 (GMT)
Message-ID: <4bb34016-8348-4b92-aae5-0b1419db169b@linux.ibm.com>
Date: Mon, 30 Jun 2025 12:18:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
        lkp@intel.com, gjoyce@ibm.com
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-3-nilay@linux.ibm.com>
 <d8e6702d-8787-4e85-9770-e415f975e266@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d8e6702d-8787-4e85-9770-e415f975e266@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wnJ_9y_w7qdymDcw4NBAsu4AfM_CJlMo
X-Proofpoint-GUID: wnJ_9y_w7qdymDcw4NBAsu4AfM_CJlMo
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68623351 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=8oFZtg8latP6vJgDadAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1NSBTYWx0ZWRfXwxT9Hz1JbzF2 FZMWloWP9kSzQFls1MhY2K3U2Peuv8G5+47VZ5pNhWQ/CVr9DGB32qoltyGCOvlf1dz89wW+CHT mVOFuWqwB6NuRBoAHLYdqF88Cq8HIEpC8edhLaa3oJq8peUil0IOlGRBG0SUYbbmOnPmzCeX8D9
 if46MyUCh8HVbghzPsCZM8iGMIu/xP5P+fSCNM5BGFPrFuiYJjA4HUN+qeaUiKAUYapMn6r98ME +jv78jo/esIUyPJkJ8ngZ5i/A167yDKmi3QpZuN37ckgxREPQTbLhEodMrvng/Y6w1lxfdZwdgc onJ/tELsO/qOjsbgsaMSzqLlyotXe/3I8e6LQq+cLjm0COZpXzPUmVTDYT6LDQhjzfbDM1uEtx9
 YhmSqodtvU29qlm+z5SWyGxMITURMgKajsAWMy/nN3hykHmG2JKBT0UrF32FSGoK3THEzksw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=824 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300055



On 6/30/25 11:50 AM, Hannes Reinecke wrote:

>> +struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>> +        unsigned int nr_hw_queues)
>> +{
>> +    unsigned int nr_tags;
>> +    int i;
>> +    struct elevator_tags *et;
>> +    gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>> +
>> +    if (blk_mq_is_shared_tags(set->flags))
>> +        nr_tags = 1;
>> +    else
>> +        nr_tags = nr_hw_queues;
>> +
>> +    et = kmalloc(sizeof(struct elevator_tags) +
>> +            nr_tags * sizeof(struct blk_mq_tags *), gfp);
>> +    if (!et)
>> +        return NULL;
>> +    /*
>> +     * Default to double of smaller one between hw queue_depth and
>> +     * 128, since we don't split into sync/async like the old code
>> +     * did. Additionally, this is a per-hw queue depth.
>> +     */
>> +    et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
>> +            BLKDEV_DEFAULT_RQ);
>> +    et->nr_hw_queues = nr_hw_queues;
>> +
>> +    if (blk_mq_is_shared_tags(set->flags)) {
>> +        /* Shared tags are stored at index 0 in @tags. */
>> +        et->tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
>> +                    MAX_SCHED_RQ);
>> +        if (!et->tags[0])
>> +            goto out;
>> +    } else {
>> +        for (i = 0; i < et->nr_hw_queues; i++) {
>> +            et->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
>> +                    et->nr_requests);
>> +            if (!et->tags[i])
>> +                goto out_unwind;
>> +        }
>> +    }
>> +
>> +    return et;
>> +out_unwind:
>> +    while (--i >= 0)
>> +        blk_mq_free_map_and_rqs(set, et->tags[i], i);
>> +out:
>> +    kfree(et);
>> +    return NULL;
>> +}
>> +
> 
> As smatch stated, the unwind pattern is a bit odd.
> Maybe move the unwind into the 'else' branch, and us a conditional
> to invoke it:
> 
> if (i < et->nr_hw_queues)
>   while (--i >= 0)
>     blk_mq_free_map_and_request()
> 

I believe the 'if (i < et->nr_hw_queues)' check is unnecessary here. When
we jump to the @out_unwind label, @i is always less than @et->nr_hw_queues
because the for loop exits early (on allocation failure) before reaching
the upper bound. If @i had reached @et->nr_hw_queues, the loop would have
completed and we wouldn't jump to @out_unwind at all — we’d simply return 
@et instead.

The Smatch flagged the unwind loop due to the use of an unsigned @i in the 
previous patch. In that case, if the first allocation (i == 0) fails, then
'--i' underflows to UINT_MAX, and the condition '--i >= 0' is always true —
hence the warning.

This patch corrects that by declaring @i as a signed int, so that 
'--i >= 0' behaves as expected and avoids the Smatch warning.

So, I don't think an extra condition like 'if (i < et->nr_hw_queues)' is 
needed around the unwind loop. Agreed?

Thnaks,
--Nilay


