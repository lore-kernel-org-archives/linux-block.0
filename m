Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E71EA7C9
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848180; cv=none; b=mdl0IHXKvokfUA37nPsOovd8lHLflEH63+VnAP/hiMoDdjsKNUC9mVgNbdXwFXGrguWsbzbW48Jc3HCcuvrFEj7Y6GKHvh0C10Hwuapgfpw6/DsqjlKrOxnLHIKk7znIFGfIuoyv2HYeENlq+fwjHPpmuGCM5gmlo3bJEMcD4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848180; c=relaxed/simple;
	bh=n6cta5H+OM3Q781ciRvXs7qATF0cfSg2LgxsC3hVfkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXRasEYQf3X0tPYFMqqDCntYeZoaZzCgE3vTKBExySmtiGLfG0iZrkUBF5jka2GD+iaq2u0d78iMOUYIt/DjXEKl+XmdNqGUqM3haQUB10ffx78SYN0KAxEDB8sOMu6jCK/fUhh/5L9GrniEEJEFHF9/DgjoHTJlVui/HcteK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fyGqF8vP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fyGqF8vP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5165O2Ip029253;
	Thu, 6 Feb 2025 13:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KnkE3z
	1ZGO00o3hdyqRF8m9+yIgVeM2Di78A6R/tohA=; b=fyGqF8vPQh5h9FEI3s8o8g
	Vj6toQLSz9M5rjMLgA3Hc7Yg6wyOl+sAjXp5CSLA2t+VaKjMVAk+Dm9FuWRH7pKJ
	pxwkA9FinaRO5e55jYvn1thQyPVjsEG9dYbd9GXjyqIIGyMQ6X+BMJHuyggEZ63q
	Ed63evCTQAxRa45yGXouQwfMpg2DAlaeI7AMSOL+jnCQssyYwLXFRJyvxTG8hA5+
	cXKtgB5+3sHf/LsbOxwC8CTIN1tCRXyxOdxghLO6wnrXQxm2dMHb1IRDA0LW6yj6
	p9D527YNkMmU9oJrAJWYDndSk81CuaxTNn7NV4fzDFr2rtXNXQJ5ICX15EUrpREQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mpw82ad6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 13:22:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 516B5tpC007133;
	Thu, 6 Feb 2025 13:22:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxayxk8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 13:22:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 516DMdgC33751774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 13:22:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE7A058056;
	Thu,  6 Feb 2025 13:22:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F84E58052;
	Thu,  6 Feb 2025 13:22:37 +0000 (GMT)
Received: from [9.109.198.254] (unknown [9.109.198.254])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Feb 2025 13:22:37 +0000 (GMT)
Message-ID: <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
Date: Thu, 6 Feb 2025 18:52:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-2-nilay@linux.ibm.com> <20250205155952.GB14133@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250205155952.GB14133@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GsenUgaqe6ucg8ObNolvBxJmNTnxOG_X
X-Proofpoint-ORIG-GUID: GsenUgaqe6ucg8ObNolvBxJmNTnxOG_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060107



On 2/5/25 9:29 PM, Christoph Hellwig wrote:
> On Wed, Feb 05, 2025 at 08:14:47PM +0530, Nilay Shroff wrote:
>>  
>>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>> @@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  		return;
>>  
>>  	memflags = memalloc_noio_save();
>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +		mutex_lock(&q->sysfs_lock);
> 
> This now means we hold up to number of request queues sysfs_lock
> at the same time.  I doubt lockdep will be happy about this.
> Did you test this patch with a multi-namespace nvme device or
> a multi-LU per host SCSI setup?
> 
Yeah I tested with a multi namespace NVMe disk and lockdep didn't 
complain. Agreed we need to hold up q->sysfs_lock for multiple 
request queues at the same time and that may not be elegant, but 
looking at the mess in __blk_mq_update_nr_hw_queues we may not
have other choice which could help correct the lock order.

> I suspect the answer here is to (ab)use the tag_list_lock for
> scheduler updates - while the scope is too broad for just
> changing it on a single queue it is a rate operation and it
> solves the mess in __blk_mq_update_nr_hw_queues.
> 
Yes this is probably a good idea, that instead of using q->sysfs_lock 
we may depend on q->tag_set->tag_list_lock here for sched/elevator updates
as a fact that __blk_mq_update_nr_hw_queues already runs with tag_list_lock
held. But then it also requires using the same tag_list_lock instead of 
current sysfs_lock while we update the scheduler from sysfs. But that's
a trivial change.

Thanks,
--Nilay

