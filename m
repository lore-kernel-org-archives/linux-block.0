Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C77083C;
	Tue, 14 Oct 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465070; cv=none; b=Srf3hfNLBFd5iGPsksQtlsGwPEiZFGGeFzGak6rzFrxMS7NCcV1rOURQLFCpRKQUdcckxqOW09kKXKszfY8GtHkbQKEOhzPrjWGhypS/ypaS7v+FZfNmXbpHFc2XKEc7nOaK99vHBV8UR2PxOuVk5T9nL4EsNpJcSzn+fo8hums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465070; c=relaxed/simple;
	bh=n2FCB5tt5tMyA+B5nwTcqy+mEYLw/yBWRjGp55xPFHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oM4XKyXf+GIfgNWeIgAdmKVAu2Ju9lDy6n7+pKTx9uCQ/Asj1xJ/Ekx85hYn7y1giCzJMDL1Z858USqOnZw6jjiEguRlJT2nzPjB9jFk9Mg6CUCb16lqpwisPnjS6SVaaRlZxHEQm1MM/4WfKngIv7o7F7kxn1+trNQKIH+wzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JQ+bdyts; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JQ+bdyts"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EDPVQj006319;
	Tue, 14 Oct 2025 18:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DacPw1
	CbKLF2YCyDjHDBfMd5Vp0p0mGeiySJXxtK8zE=; b=JQ+bdytsz7N+XWm/Ydo2pa
	224Jun3b5wgpo50zRxB+TFUVJPJ1j3PmZoA4zXYanaYcusO6x/pqnvkqPd1v/q5C
	6YaAFiETqKTiIg+TBzozzeJtDyX4+1xP9Zvwku0mww/joZD944d1B99pvBAMBHg2
	PhcArbQnlG9HoWXgFaclep0p/+3H6OcW7dUwIq2EzC0N97ZD2M8LtdqDh6rK70fV
	nZRTQzO4TnTEOFhTI5B4jAWfM1VtjUVotaFZETZgaojvHGKe6pBWjyTvWkoopbzk
	BkxtYNt7w/3v0utvu88RwnA2PrQ515s8JAp/2uqra1gO53QQ6iM94M2RfXtvcQTQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpfub0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:04:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EHBWGp015219;
	Tue, 14 Oct 2025 18:04:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1js4j5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:04:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EI471x4850650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 18:04:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EBC058057;
	Tue, 14 Oct 2025 18:04:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C28B58061;
	Tue, 14 Oct 2025 18:04:04 +0000 (GMT)
Received: from [9.61.43.11] (unknown [9.61.43.11])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 18:04:03 +0000 (GMT)
Message-ID: <fd66fda2-8dd9-4009-9c4b-7cebaac64c05@linux.ibm.com>
Date: Tue, 14 Oct 2025 23:34:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-6.18/block 05/10] blk-mq: cleanup shared tags case
 in blk_mq_update_nr_requests()
To: Chris Mason <clm@meta.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20251014130507.4187235-2-clm@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251014130507.4187235-2-clm@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfXzVjZz0cd/wV7
 VqYXxl1kAM4SjdUmlWx3Yey0aon3u44fkHtSLlkLxaINNosKh3O/E62XFWpLzvoGHB2XB2NAeuk
 nse2WuDKxDmWgYhI5chMhMObRH1cptlfqYx3gwvheMrmPNvzgVBeOZpu4d2ierk3PSPBvaHQdJr
 7MyQOOPzG4QZaT4ayJOw39CUUW88izbfZhtAR6sAtuBb11daUaZp+MGkYB42VV6dRz7wcZLhKM6
 PyxWaTVSspDI4JGeLGPw4bqR6iCqEnPTsIsLy6PFJzpHOkW0Vuiwj2DuP9hDHw/0vh5vdo2vF65
 6t1jYdgsY5bqM0ZiqsDpR6WoyRANcVtkApkrburnEA5jvTC6bJWLjWjReXtQ8vMwaWmoMwWG5gT
 z/oVSflyTbsquBcJzAYTxBDVr6MfXQ==
X-Proofpoint-ORIG-GUID: XzKbISpeDbXNuHQQVU5viZkuYy8GjKpV
X-Proofpoint-GUID: XzKbISpeDbXNuHQQVU5viZkuYy8GjKpV
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ee9098 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=6GnhMWMtFsEvWEXV5ikA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005



On 10/14/25 6:35 PM, Chris Mason wrote:
> Hi everyone,
> 
> My review automation flagged this one in linux-next, and it looks like a
> valid bug to me:
> 
> On Wed, 10 Sep 2025 16:04:40 +0800 Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> For shared tags case, all hctx->sched_tags/tags are the same, it doesn't
>> make sense to call into blk_mq_tag_update_depth() multiple times for the
>> same tags.
>>
> 
> [ ... ]
> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 9b97f2f3f2c9..80c20700bce8 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4935,34 +4935,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>
>>  	blk_mq_quiesce_queue(q);
>>
>> -	queue_for_each_hw_ctx(q, hctx, i) {
>> -		if (!hctx->tags)
>> -			continue;
>> -		/*
>> -		 * If we're using an MQ scheduler, just update the scheduler
>> -		 * queue depth. This is similar to what the old code would do.
>> -		 */
>> -		if (hctx->sched_tags) {
>> -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
>> -						      nr);
>> -		} else {
>> -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
>> -		}
>> -		if (ret)
>> -			goto out;
>> -	}
>> -
>> -	q->nr_requests = nr;
>> -	if (q->elevator && q->elevator->type->ops.depth_updated)
>> -		q->elevator->type->ops.depth_updated(q);
>> -
>>  	if (blk_mq_is_shared_tags(set->flags)) {
>>  		if (q->elevator)
>>  			blk_mq_tag_update_sched_shared_tags(q);
>                         ^^^^
> 
> Does blk_mq_tag_update_sched_shared_tags() use the wrong value here?
> 
> In the old code, q->nr_requests was updated to nr before calling
> blk_mq_tag_update_sched_shared_tags(). But in the new code, this
> function is called while q->nr_requests still contains the old value.
> 
> Looking at blk_mq_tag_update_sched_shared_tags():
> 
>     void blk_mq_tag_update_sched_shared_tags(struct request_queue *q)
>     {
>         sbitmap_queue_resize(&q->sched_shared_tags->bitmap_tags,
>                              q->nr_requests - q->tag_set->reserved_tags);
>     }
> 
> It reads q->nr_requests to calculate the new sbitmap size. With the
> reordering, this will resize the sbitmap to the old depth instead of
> the new depth passed in nr.
> 
Good catch! Yes, I think this needs to be fixed...

Thanks,
--Nilay


