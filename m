Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1602566
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592603; cv=none; b=cpVD/iIqw2OkGFZHtguBcKhRF8e7EEOyREhE/pkQ2FcyEVi3b2WZNgp7XCaDXqdDeuqqU8LcBBzTExRwHxgU2fD7oJABaXoxeXr6utLGmm32Eb+4yLnP//uNXERzs7P+E1OvCnJlSGi8lrogZIp7dUJnuZt4RWVSSHH/qRWnG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592603; c=relaxed/simple;
	bh=dHgcPerfo8JTXoSDaoUwt9UMkt2gtL9c3GsBdgtWlOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByO2eSVTUoq2eE9u3RVCeVhqGYCgL80+BubEcxsmxkUkL02ohtzjvr19Gh84N19L1YT1zc9030HLIsyAwcIyolvRQOTc6MRuU/ByIFqcRppoIyUcoTr/ZDTR7xS106YnH2AcnqL669KmtZ6hlnR01TJ4R1Y4xuPm59+FQYQtcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hxsgyFii; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxsgyFii"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ74whK028343;
	Thu, 19 Dec 2024 07:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z8DSJs
	9x/jhdZXlFV0TbxbG+QqHFrkJTVUdtEE0wCaU=; b=hxsgyFiidqddT0Kv+8OXTB
	FMcK0ELqErsFnv1h0odVylVSPxiCNTswl4FeNuKRqKO/w4r+PvLkbUcBFXibgHUq
	sJeuLgrViFzoQGQ+aOWn6lpqSJW4HOG2VM7rsPfeMF2wUW+cR4Gfzs9M31Tq7J5C
	sUu1NiSCOQBb6lNmhx993OEFMgO5xF0DJ/6G2WwRoEmtuDMk+DrS7I7geq9THmAb
	BWHfOA3tfzBIpbBoBmn/ZqIhwh6Om9IRgxN31zPkPnPh+8jOphAa+miDFwcpVILO
	SdNc5I9DgnKtdCpQ2pst5XyONTFL31nMjhEqc8vdBR3uF7v2fad8bQ6ys5/ImHRw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ktk2nmc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:16:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ43jvE005491;
	Thu, 19 Dec 2024 07:16:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnc09x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 07:16:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJ7GWK062390726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 07:16:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5D4F58052;
	Thu, 19 Dec 2024 07:16:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E1735805D;
	Thu, 19 Dec 2024 07:16:31 +0000 (GMT)
Received: from [9.171.57.31] (unknown [9.171.57.31])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 07:16:30 +0000 (GMT)
Message-ID: <a9c53658-dcb0-4a65-b0cb-a2ef915998a2@linux.ibm.com>
Date: Thu, 19 Dec 2024 12:46:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
 <Z2LQ0PYmt3DYBCi0@fedora>
 <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
 <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
 <20241219062026.GC19575@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241219062026.GC19575@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jiOlwfRQYDOCA_LiRAJssVL_P2sLqXpe
X-Proofpoint-ORIG-GUID: jiOlwfRQYDOCA_LiRAJssVL_P2sLqXpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190054



On 12/19/24 11:50, Christoph Hellwig wrote:
> On Wed, Dec 18, 2024 at 06:57:45AM -0800, Damien Le Moal wrote:
>>> Yeah agreed but I see sd_revalidate_disk() is probably the only exception 
>>> which allocates the blk-mq request. Can't we fix it? 
>>
>> If we change where limits_lock is taken now, we will again introduce races
>> between user config and discovery/revalidation, which is what
>> queue_limits_start_update() and queue_limits_commit_update() intended to fix in
>> the first place.
>>
>> So changing sd_revalidate_disk() is not the right approach.
> 
> Well, sd_revalidate_disk is a bit special in that it needs a command
> on the same queue to query the information.  So it needs to be able
> to issue commands without the queue frozen.  Freezing the queue inside
> the limits lock support that, sd just can't use the convenience helpers
> that lock and freeze.
> 
>> This is overly complicated ... As I suggested, I think that a simpler approach
>> is to call blk_mq_freeze_queue() and blk_mq_unfreeze_queue() inside
>> queue_limits_commit_update(). Doing so, no driver should need to directly call
>> freeze/unfreeze. But that would be a cleanup. Let's first fix the few instances
>> that have the update/freeze order wrong. As mentioned, the pattern simply needs
> 
> Yes, the queue only needs to be frozen for the actual update,
> which would remove the need for the locking.  The big question for both
> variants is if we can get rid of all the callers that have the queue
> already frozen and then start an update.
> 
Yes agreed that in most cases we only needs the queue to be frozen while 
committing the update, however we do have few call sites (in nvme driver)
where I see we freeze queue before actually starting update. And looking 
at those call sites it seems that we probably do require freezing the 
queue. One example from NVMe driver,

nvme_update_ns_info_block()
{
    ...
    ...

    blk_mq_freeze_queue(ns->disk->queue);
    ns->head->lba_shift = id->lbaf[lbaf].ds;
    ns->head->nuse = le64_to_cpu(id->nuse);
    capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));

    lim = queue_limits_start_update(ns->disk->queue);
    ...
    ...
    queue_limits_commit_update();
    ...
    set_capacity_and_notify(ns->disk, capacity);
    ...
    set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
    set_bit(NVME_NS_READY, &ns->flags);
    blk_mq_unfreeze_queue(ns->disk->queue);
    ...
}

So looking at the above example, I earlier proposed  freezing the queue 
in queue_limits_start_update() and then unfreezing the queue in 
queue_limits_commit_update(). In the above code then we could replace 
blk_mq_freeze_queue() with queue_limits_start_update() and 
blk_mq_unfreeze_queue() with queue_limits_commit_update() and get rid 
of the original call sites of start/commit update APIs. Having said 
that, I am open for any other better suggestions and one of the suggestion 
is from Damien about calling blk_mq_freeze_queue() and blk_mq_unfreeze_queue() 
inside queue_limits_commit_update(). But then I wonder how would we fix the 
call sites as shown above with this approach.

Thanks,
--Nilay
