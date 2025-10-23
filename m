Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC4200BA1
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198844; cv=none; b=HtHqOO/NJr2RHrWQ7pceVI6ORRwExXfOS+wRcSH3B4rNKRD8Fo4eOiZKq6/cipDcWl/PDcW/O475TOIv/yp393E6La849PUevLViMvfAbopYX8IBHyOHhn6GYS8N9JWuSrz1XE9Qoz1xDu9HG/4asNco65AMjyMkJWo/YgskNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198844; c=relaxed/simple;
	bh=8ow1JAoUuodypZOddDEyC9zGxp1MeGnfnR3OkrPjVjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWwlgl197P7SWjj1zounrKhaDQczKS/JXde+pmleWELMD5ArYDgjCfxSg5CyP2oEDQAJDQb5CvVmk+ZSP6KBjf1VxqGCWEAk1sBLWVSWFpWs+8LdjwjnGHpqbZfHXllz+ViE9UNpnmaDmiaG9emQg/RGPGa6xtWUcJE6sxFP9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QWb0DCQ3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QWb0DCQ3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MKLGoJ017019;
	Thu, 23 Oct 2025 05:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B+FgxS
	53/KvXWPIIxX6zClLJ/E3wKy1QptZhfVq+44c=; b=QWb0DCQ32ou5VHaR0p1b68
	C2vubFwOoyKhU3ITJbhLNDOUzKCtH7Br7B1PWDp2aJTmvr3oQzPZCFU1JhCFDm0j
	bVpBzZ6MdQVsSfWl3ByhmyEQ1G9MKNQE+H/vpuB7PYoigqYDEfnN3WbmeTN9kDhm
	Gc9vWJY244LovQB3BXYARZ2T92CpsD3rpOJNzmN8QPvEmODZSCRWRzNahhpGqVI9
	wAqf4hMwWzzQL6Gpvf/m9IGXpqPb5IdivM9utb+igbXvjywj24uom+wwxUvTbEu9
	hqNQUoLlC+Jre94Zd8vEZya/OcsQ7nyl/A17j8RjnNLFfrmRz+LDVfXpxZ6iLRKg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hq16p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 05:53:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N1kosG002926;
	Thu, 23 Oct 2025 05:53:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejm14k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 05:53:46 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59N5rjkT47382978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 05:53:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 467685805A;
	Thu, 23 Oct 2025 05:53:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ED5F58051;
	Thu, 23 Oct 2025 05:53:42 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 05:53:42 +0000 (GMT)
Message-ID: <0baa8908-529b-45e9-87b5-3c229aecdc52@linux.ibm.com>
Date: Thu, 23 Oct 2025 11:23:40 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: unify elevator tags and type xarrays into
 struct elv_change_ctx
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
        axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
        gjoyce@ibm.com
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-2-nilay@linux.ibm.com> <aPhZVS9H6mdTaDv_@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aPhZVS9H6mdTaDv_@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1iCkb+mDGxAA
 gqHqsTqzHS7WmyrG3gEi1JZLHF8QY6/N+EDoWHJfQ38vEM9JEFUPsrdaca8cjAu7DEbPCFwzLuF
 EkJTS1+PV29wXY+1nPccaIA/ODB5z3UqU8ekVSAOzXqWxzOkc2pw2Y/5xiaILXSyviSiBhaiXlA
 Ney4blYVJEPftdaOSqiBfJr44TeClGWjhqv3QIeWGDScvgjn8AnBykBWsAfmhkDvDPGL8BE84Vi
 pFPORfDUPRqlVNEBC/k7c8sXN+ZOYZwRi1MWu87ooyKHwQn08HZsQuW663JfPY7e/c3N9GYriYM
 tZdc3pg+FjodgGuQYUrWTAOfEyXt/lk0yM9q7rh3KXI+nH7Ig4eL0Vb8eNBw+wdVIhOXk3Z0HgK
 kvI6hlxzgWMakcoutgpo9lalnyz9aw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f9c2eb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CA3WoMP3M7Mil-wWCVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: mGWyFKvd2aR1DJjOqxoYNc-_21d69u0s
X-Proofpoint-ORIG-GUID: mGWyFKvd2aR1DJjOqxoYNc-_21d69u0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/22/25 9:41 AM, Ming Lei wrote:
> On Thu, Oct 16, 2025 at 11:00:47AM +0530, Nilay Shroff wrote:

>>  
>> +int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
>> +		struct blk_mq_tag_set *set)
>> +{
>> +	struct request_queue *q;
>> +	struct elv_change_ctx *ctx;
>> +
>> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
>> +
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +		ctx = kzalloc(sizeof(struct elv_change_ctx), GFP_KERNEL);
>> +		if (!ctx)
>> +			goto out_unwind;
>> +
>> +		if (xa_insert(elv_tbl, q->id, ctx, GFP_KERNEL)) {
>> +			kfree(ctx);
>> +			goto out_unwind;
>> +		}
>> +	}
>> +	return 0;
>> +out_unwind:
>> +	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
>> +		ctx = xa_load(elv_tbl, q->id);
>> +		kfree(ctx);
>> +	}
> 
> No need to unwind, you can let blk_mq_free_sched_ctx_batch cover cleanup from
> callsite.
Yes, that makes sense. I’ll drop the unwind logic and rely on 
blk_mq_free_sched_ctx_batch() for cleanup at the callsite in the next version.

> Not mention you leave freed `ctx` into xarray, which is fragile.
Good catch! Removing the unwind block will naturally avoid that issue as well.

>> @@ -530,12 +563,12 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
>>  out_unwind:
>>  	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
>>  		if (q->elevator) {
>> -			et = xa_load(et_table, q->id);
>> -			if (et)
>> -				blk_mq_free_sched_tags(et, set);
>> +			ctx = xa_load(elv_tbl, q->id);
>> +			if (ctx && ctx->et)
>> +				blk_mq_free_sched_tags(ctx->et, set);
> 
> please clear ctx->et when it is freed.
Ack, will fix it in next version.

>> +static inline void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl)
>> +{
>> +	unsigned long i;
>> +	struct elv_change_ctx *ctx;
>> +
>> +	xa_for_each(elv_tbl, i, ctx) {
>> +		xa_erase(elv_tbl, i);
>> +		kfree(ctx);
>> +	}
>> +}
>> +
> 
> It could be more readable to move blk_mq_free_sched_ctx_batch() with
> blk_mq_alloc_sched_ctx_batch() together.
> 
Agreed — I’ll move blk_mq_free_sched_ctx_batch() next to
blk_mq_alloc_sched_ctx_batch() for better readability.

Thanks,
--Nilay

