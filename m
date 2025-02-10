Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5A1A8409
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170894; cv=none; b=gR3raur5a9c1oifG1vpI+JPDSGoZHKS9+yDq6Qyp1+Ol6RsuUU2/5PUKVQ538z4cGpkLD4hAIbhWONTYAiygxaDAHKLZxtcmUP4fhbRWsaGOj1bNKUvaGW/+tM7BrHIeVs+oBg9fHQXGBFFMUzGi1skC6YovSWDZdVavy3wKhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170894; c=relaxed/simple;
	bh=LoMvoeRF4uUDxuvCSM4rmxXzOM0vpVvrWk0rJuhYrpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCFX4Vq5a2sJiNRdOOtCdEg7PrKyVwRzxMa9C2BQZlxigB96Tamrx0FWnX3OM9eCegpA97pToDNbG8uij542ZwfxF/CVI1IW4qFe+zjwHtioev0b95ToqFUo9W3IpADRwtPt6FMeimjGggUwUFNO29WMqWc53uHJmbIslmGaBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MtVbtURT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MtVbtURT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A1EwSx015736;
	Mon, 10 Feb 2025 07:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vrWjxY
	X8p3u23AT354tTRUOsLFM9hH9mjLT0tecP+M8=; b=MtVbtURTS2QbZtJIxUn0xK
	R+IbePZYdda7nzglMWZP/XbiCQzVGFyWLB84z56xwCf0F8n3xLi5IFYiCiEkCDPp
	y4fVeXAalmtDRMhwdcffy7No4LOtj6kxS6fHXmDIj8DSP5u2AsDRLqBdgHH3PuFH
	DfChiwmTbbm3RmGmazMZanWbZ6nVHjxKp0iRVm9Kv8D/zjk0MybFtNt23Jhj4eQi
	TxelUKW8rOgHsjDn7hDbRtiehS+04h094YGPXf/4lGA00zPyeSpa67TGt5EbFiSj
	VXhNllfQekUO0qPCHK/4k6Jkh/WM0SsfZtz4wXuoVCcqUoL9BmKbwDQpJyeEH8cg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44pr2nuvc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 07:01:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51A5Rjdv028721;
	Mon, 10 Feb 2025 07:01:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1cnud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 07:01:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51A71MLs6291996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 07:01:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71C958062;
	Mon, 10 Feb 2025 07:01:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95FD45805A;
	Mon, 10 Feb 2025 07:01:21 +0000 (GMT)
Received: from [9.109.198.172] (unknown [9.109.198.172])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 07:01:21 +0000 (GMT)
Message-ID: <57253c19-1be3-496c-836b-5c56a59788f2@linux.ibm.com>
Date: Mon, 10 Feb 2025 12:31:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
To: Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        hch
 <hch@lst.de>, Ming Lei <minlei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
 <20250209122035.1327325-8-ming.lei@redhat.com>
 <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
 <CAFj5m9+-CMU52E1hpNsG+eXC4HsG82Ny7f=iJrdAfGScTFPD4Q@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9+-CMU52E1hpNsG+eXC4HsG82Ny7f=iJrdAfGScTFPD4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -xlhMC4pebI1Dg3_AN18oLtP4eDW2gJT
X-Proofpoint-ORIG-GUID: -xlhMC4pebI1Dg3_AN18oLtP4eDW2gJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_03,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=830
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100057



On 2/10/25 7:12 AM, Ming Lei wrote:
> On Mon, Feb 10, 2025 at 8:52 AM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
>>
>> On Feb 09, 2025 / 20:20, Ming Lei wrote:
>>> All block internal state for dealing adding/removing debugfs entries
>>> have been removed, and debugfs can sync everything for us in fs level,
>>> so don't grab q->debugfs_mutex for adding/removing block internal debugfs
>>> entries.
>>>
>>> Now q->debugfs_mutex is only used for blktrace, meantime move creating
>>> queue debugfs dir code out of q->sysfs_lock. Both the two locks are
>>> connected with queue freeze IO lock.  Then queue freeze IO lock chain
>>> with debugfs lock is cut.
>>>
>>> The following lockdep report can be fixed:
>>>
>>> https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs/
>>>
>>> Follows contexts which adds/removes debugfs entries:
>>>
>>> - update nr_hw_queues
>>>
>>> - add/remove disks
>>>
>>> - elevator switch
>>>
>>> - blktrace
>>>
>>> blktrace only adds entries under disk top directory, so we can ignore it,
>>> because it can only work iff disk is added. Also nothing overlapped with
>>> the other two contex, blktrace context is fine.
>>>
>>> Elevator switch is only allowed after disk is added, so there isn't race
>>> with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
>>> previous elevator, so no race between these two. Elevator switch context
>>> is fine.
>>>
>>> So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
>>> adding/removing hctx entries, there might be race with add/remove disk,
>>> which is just fine in reality:
>>>
>>> - blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
>>> won't be added/removed at the same time
>>>
>>> - even though there is race between the two contexts, it is just fine,
>>> since hctx won't be freed until queue is dead
>>>
>>> - we never see reports in this area without holding debugfs in
>>> blk_mq_update_nr_hw_queues()
>>>
>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> Ming, thank you for this quick action. I applied this series on top of
>> v6.14-rc1 kernel and ran the block/002 test case. Unfortunately, still if fails
>> occasionally with the lockdep "WARNING: possible circular locking dependency
>> detected" below. Now debugfs_mutex is not reported as one of the dependent
>> locks, then I think this fix is working as expected. Instead, eq->sysfs_lock
>> creates similar dependency. My mere guess is that this patch avoids one
>> dependency, but still another dependency is left.
> 
> Indeed, this patch cuts dependency on both q->sysfs_lock and q->debugfs_lock,
Glad to see that with this patch we're able to cut the dependency between
q->sysfs_lock and q->debugfs_lock.

> but elevator ->sysfs_lock isn't covered, :-(
> 
I believe that shall be fixed with the current effort undergoing here:
https://lore.kernel.org/all/20250205144506.663819-1-nilay@linux.ibm.com/

Thanks,
--Nilay
