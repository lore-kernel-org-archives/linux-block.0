Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6E1B808
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569208; cv=none; b=bRayJkbwXe+NGgsrwl+xiyY9ekpy+7C6veOVDq+bjU4BCrsdKOA3RMTPG3FWr3gnnkRvfZe3sauKTsM3W8bnF+b3FRUJfYyJepUXJIdb7T90ap4MJ2tV2jBv0OwzBt2E6qtFpiP3+/ZRfa3nfOaqtHlvo7G8WMGfWWZOadsrz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569208; c=relaxed/simple;
	bh=oIT9NnKAKwA1DDxNsTGcCwoL98ub8ni3Dxx4avhHTdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0y5eP4+NuwpX6nHvg0eaRil5lHi2/Pcu5aPmlowe5v0JRvulsZ1xIfBFBEn7oANpByNqEsy5w5CPPobVzZotOSv/7wnJq0m+NiKrdtl5UmFYGCOcMRdAm2EbA1mVT2wI0aQa+KsbUXbAB3c7giT65EMNeXZiQK9EOEPbXse/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d8CGTOog; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d8CGTOog"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MCVOhB004287;
	Wed, 22 Jan 2025 18:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JPtHxh
	+eLjGTLBGbCV19aWV2tCf9ZV++JlnfH85KXyw=; b=d8CGTOogMkkaMQ+KzoL7jf
	IKvPhn6kyxvjdUTexXVIVjdqJ3VgxP3EYpWyPjnjAUkZw/8iXcjl/ao4KvZQEtU1
	Hp6MmOqEeBWs0uLVf9VO1TzySizxVK9stm7ZIiTQ4j690w+UZ9q08/T+Dnr267ww
	zIxJ+YvQjEiPC8HD/ir+SKN/fnqslPCngDK/QFVtbHbsAUVRraQvrng7ontpsjJ5
	Fe5UxbkxAE+6sJHzlUQomxUEpPmTnA/lBhQPIpuCB3AN3LTXnUtu42iA1Ylp+Kub
	B+8QWS3saPLVktv8N/aqlBm3pjxmQFTaG7PuDP/M/WnlMhq2jfBXBLy8xqrxgkMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgym33e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 18:06:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MHXa47024307;
	Wed, 22 Jan 2025 18:06:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y9t4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 18:06:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MI6bXY27787894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 18:06:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27CD158052;
	Wed, 22 Jan 2025 18:06:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3913B58045;
	Wed, 22 Jan 2025 18:06:35 +0000 (GMT)
Received: from [9.179.4.161] (unknown [9.179.4.161])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 18:06:34 +0000 (GMT)
Message-ID: <8ed4d053-9b73-44a0-993f-817d7b772036@linux.ibm.com>
Date: Wed, 22 Jan 2025 23:36:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] block: get rid of request queue ->sysfs_dir_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250120130413.789737-1-nilay@linux.ibm.com>
 <20250120130413.789737-2-nilay@linux.ibm.com> <20250122062806.GA30750@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250122062806.GA30750@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gTlEmbJOJ5N109IKryi8vW65KVoCy4Op
X-Proofpoint-ORIG-GUID: gTlEmbJOJ5N109IKryi8vW65KVoCy4Op
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_08,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=934
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220132



On 1/22/25 11:58 AM, Christoph Hellwig wrote:
> On Mon, Jan 20, 2025 at 06:34:11PM +0530, Nilay Shroff wrote:
>> The request queue uses ->sysfs_dir_lock for protecting the addition/
>> deletion of kobject entries under sysfs while we register/unregister
>> blk-mq. However kobject addition/deletion is already protected with
>> kernfs/sysfs internal synchronization primitives. So use of q->sysfs_
>> dir_lock seems redundant.
> 
> From the pure sysfs perspective, yes.  The weird thing with block
> layer sysfs is that unregistration/registration can happen at weird
> times, though.
> 
>> Moreover, q->sysfs_dir_lock is also used at few other callsites along
>> with q->sysfs_lock for protecting the addition/deletion of kojects.
>> One such example is when we register with sysfs a set of independent
>> access ranges for a disk. Here as well we could get rid off q->sysfs_
>> dir_lock and only use q->sysfs_lock.
>>
>> The only variable which q->sysfs_dir_lock appears to protect is q->
>> mq_sysfs_init_done which is set/unset while registering/unregistering
>> blk-mq with sysfs. But this variable could be easily converted to an
>> atomic type and used safely without using q->sysfs_dir_lock.
>>
> 
> So sysfs_dir_lock absolutely should go.  OTOH relying more on sysfs_lock
> is a bad idea, as that is also serialied with the attributes, which
> again on a pure sysfs basis isn't needed.  Given that you don't add
> new critical sections for it this should be fine, though.
> 
>> So with this patch we remove q->sysfs_dir_lock from each callsite
>> and also make q->mq_sysfs_init_done an atomic variable.
> 
> Using an atomic_t for a single variable is usually not a good idea.
> Let's take a step back and look at what mq_sysfs_init_done is trying
> to do.
> 
> It is set by blk_mq_sysfs_register, which is called by
> blk_register_queue. before marking the queue registered and setting the
> disk live.  It is cleared in blk_mq_sysfs_unregister called from
> blk_unregister_queue just after clearing the queue registered bit.
>
Yeah that's good idea! Indeed, I think we can remove ->mq_sysfs_init_done and 
replace it with the QUEUE_FLAG_REGISTERED.
 
> So maybe we could do something with the queue registered bit, although
> eventually I'd like to kill that as well, but either way we need
> to explain how the flag prevents the nr_hw_queues update racing with
> disk addition/removal.  AFAICS we're not completely getting this
> right even right now.  We'd probably need to hold tag_list_lock
> over registering and unregistering the hctx sysfs files.
> 
Agreed, makes sense to hold ->tag_list_lock so that we can contain 
the race between nr_hw_queue update with registering/unregistering the 
hctx sysfs files. 

I'd spin a new patch with above changes and submit.

Thank you Christoph for your review and comments!

--Nilay

