Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F81F3FDD
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686358; cv=none; b=XdSfRkQI4TKKd8B9RaNOkaPxT5rQhdVWQHhojrWlPA3j42X7Sw62ouRI0p/LpR/P0x02mdze4TzD8KxD+G/CgfelvCcKlhewmpj3gfxC7+uiSBe7/FbZ6O2TCY8DP6OTKrLy0qaS1+WBYa7cItU0JF8a4C2nyRz2v83/ejj/G4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686358; c=relaxed/simple;
	bh=Nk5J7mK/1uhR46mBH+wSE5TyYE294XcuFTebsdkfoYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBUUj2IPjDx3+IH8GqEToU4Y9rX3yOUUXhAQ0+/nDla3BaVcoZ/l10ZaD1PHLL2+4jFIWiZB7Es5NhD9uMNb3c6c67VX7PEOUqRSjD1miKjuKyJ405DPVBMSZEIjRclppF8azS72TMNgmHJvXjAcDhPSibYt6Qs+WoToM3++Z54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lH/0s0os; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lH/0s0os"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5337AV1I020570;
	Thu, 3 Apr 2025 13:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l/BSSh
	mFEPd/h467zREUEhe9OaMWifXWIHMy/xSoWBE=; b=lH/0s0os7xn1/Yl3d7n0t0
	NHMeJHrgaSwqE0pRrLUoDOEKVA77lMOWw+zvnKIRysATmYHZ4YpCmXSCREBxwTz2
	geJ3qkwpqGFYnBOF7cboGOCFKi1rczQlhMBc45Inco6xYyxn6lBdPsRYwSqsEUKT
	dxMWr1j6DV28I9v6xBDfXydLQ1SIQoPVyca/uoIpMct902RDsJPffRDTk0NqLwDH
	IcwZzdLewdqBYlD57tI/1Dd7ZITtIdZDc62IT2frJaOlH95ZiiHoVkUDqHNXBF+O
	VJM6BIYkZCvmQFLYfjdOLWjtHauWvbwMoIRo6dHpPAAjgCFn0FRglxRBHFtuHmGw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s9dxcqrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 13:19:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 533AlHxu010394;
	Thu, 3 Apr 2025 13:19:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6p4xca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 13:19:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 533DJ8oE6423218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Apr 2025 13:19:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3B4558064;
	Thu,  3 Apr 2025 13:19:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F5D58056;
	Thu,  3 Apr 2025 13:19:07 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Apr 2025 13:19:06 +0000 (GMT)
Message-ID: <9933c2e6-1cbd-464c-a519-b7fa722a8e4d@linux.ibm.com>
Date: Thu, 3 Apr 2025 18:49:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250403105402.1334206-1-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250403105402.1334206-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j1SYRR__7Vf-8hC7rSrKQI-V1pFZw662
X-Proofpoint-ORIG-GUID: j1SYRR__7Vf-8hC7rSrKQI-V1pFZw662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_05,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=751 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030057



On 4/3/25 4:24 PM, Ming Lei wrote:
> ->elevator_lock depends on queue freeze lock, see block/blk-sysfs.c.
> 
> queue freeze lock depends on fs_reclaim.
> 
> So don't grab elevator lock during queue initialization which needs to
> call kmalloc(GFP_KERNEL), and we can cut the dependency between
> ->elevator_lock and fs_reclaim, then the lockdep warning can be killed.
> 
> This way is safe because elevator setting isn't ready to run during
> queue initialization.
> 
> There isn't such issue in __blk_mq_update_nr_hw_queues() because
> memalloc_noio_save() is called before acquiring elevator lock.
> 
> Fixes the following lockdep warning:
> 
> https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
> 
> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
I think you earlier posted this same patch here:
https://lore.kernel.org/linux-block/Z-dUCLvf06SfTOHy@fedora/

I tested that earlier patch and got into another lockdep splat as reported here: 
https://lore.kernel.org/linux-block/462d4e8a-dd95-48fe-b9fe-a558057f9595@linux.ibm.com/

I don't know why we think your earlier fix which cut dependency between 
->elevator_lock and ->freeze_lock doesn't work. But anyways, my view
is that we've got into these lock chains from two different code paths:

path1: elevator_lock 
         -> fs_reclaim (GFP_KERNEL)
           -> freeze_lock

path2: freeze_lock(memalloc_noio) 
         -> elevator_lock 
           -> fs_reclaim (this becomes NOP in this case due to memalloc_noio)

As you could see above, we've got into circular dependency between 
->elevator_lock and ->freeze_lock. I thought with your earlier patch
we were able to cut that dependency using blk_mq_enter_no_io and 
blk_mq_exit_no_io. But I'm not sure why we think that won't work?

Thanks,
--Nilay

