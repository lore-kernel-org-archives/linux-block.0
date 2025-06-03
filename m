Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059C3B19A
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963801; cv=none; b=rqK+xKqNqLTYe0OZVP+7HOw/ZRFjc9RZMYxT4t3u80pWIRYSaOZINpWySIT7aM7SEb/gm7mSDyRCONduxRHu+IghFhmr7z9YiPcb4wnFHKSqXH9liUkQM2w/euKKrxZrrKw+CuyDYZQyHgkiavUCkWmmXe8oNJmPaC6+c3UChKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963801; c=relaxed/simple;
	bh=zJlC5tBPoDtywCo7mRolDZ5N/L0GtTi1kNvWbw5ISbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgBj1n3XE9EzkMW7j9BwUfuAg70KaNxUtAnuGZeJ+cm8Qm0KPEoMkgARCnNXlzSU5hXk9bKI+7+d9HaDAwkIyGIn3I7HhV7ledQU48ga1+9tVpJlI2C6Bp8JRY6P7XIbwxt741qYQopV/NGe0cQLIhfbSBnFB0lvRGnrBTdKaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C1nPE45m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C1nPE45m"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5536vSDQ019402;
	Tue, 3 Jun 2025 15:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mvap5e
	DWryfEcjBtlmWOaqSflReBdF4ZpSeVhYm2rnI=; b=C1nPE45mYh8rmSzSHsh4UO
	qGf5VQUM6ZPSXh4afpkCavdHueJZPTPRz4gu6Zl8QoF3p33of65NPUB11O1G5Wh4
	O538NviX9Xop7ty488d9MHoWcxChx+HzEfVkBiTS3mM19j5NKiQHmYK+1vCNFTkJ
	VnxulWp7kpjVOHAp1fqDN8hUWQAlFgKFG5EJDaC76U4C16C/W/7o13i6ZYvGFNf7
	oIsb/8Dt0uc1lFAE25xtDf7DNsHWaLnC08oZn9JQn8RcPn94HtBbsdHskGcEFo/g
	BCXI340HcsIcy2NBflR4qttip9+Tmwtdri455lVgpHlY/bO8oeErj+etATXTwKIw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geynajy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 15:16:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553Dpqmt024768;
	Tue, 3 Jun 2025 15:16:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmbatx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 15:16:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 553FGTIP33686236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Jun 2025 15:16:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8106458059;
	Tue,  3 Jun 2025 15:16:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FEED58043;
	Tue,  3 Jun 2025 15:16:26 +0000 (GMT)
Received: from [9.67.24.215] (unknown [9.67.24.215])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Jun 2025 15:16:26 +0000 (GMT)
Message-ID: <0747313c-a70d-482f-8ea6-ce2dff772c2c@linux.ibm.com>
Date: Tue, 3 Jun 2025 20:46:24 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix atomic write limits for stacked devices
To: John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, martin.petersen@oracle.com, axboe@kernel.dk,
        ojaswin@linux.ibm.com, gjoyce@ibm.com
References: <20250603112804.1917861-1-nilay@linux.ibm.com>
 <07cfb3a1-c410-4544-ae4d-5808114e02d7@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <07cfb3a1-c410-4544-ae4d-5808114e02d7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CD9Oinci01vfMwTpuK9Tts3T4K8M7i_o
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=683f11d0 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=k8Yt14YQ-Hjk78dn1mcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CD9Oinci01vfMwTpuK9Tts3T4K8M7i_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEzMSBTYWx0ZWRfX0VoavveMOGYq 7JSGYiA/5p3V6jioPbjY3O5AuQWTiY+rOhwsSqDFuPUnFEr/LBou1aZMef8LqpZtPoLXRySTDju Lf3E3lsKkfU1nTbk++o6xlymMEvne2v4qrNDGp9Ike4rFuTTCSVi2LrlcgT+neEoOPpV75Aw3U+
 +OcYJa07h4E5hS7L6iGWnaLBVhJtzMqQheHNX0YK0VhDkuPHZral36qM/Tb0xuI3p36TVTk5+Wj EmTr4KUU7/NDGCXXw63WQotsyTFY1HcWnH4A8/AAqeDTopkGSfH2Y8LqI98SQNabfAAB/NP8Ski x0eGTrlHL86c+1EU7/69HcVXfI5LNr2PiwHtEdEN5becx3poxPvpo0tgS9yA3wJYw+UkHSsQWSY
 GFRLoA2N/eRw/4OBEHoeoRe9U7VXHS2lPrZF5CBJLPRdULnutyl9TisphVEtAGdnvPBX0O7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030131



On 6/3/25 5:47 PM, John Garry wrote:
> On 03/06/2025 12:27, Nilay Shroff wrote:
>> The current logic applies the bottom device's atomic write limits to
>> the stacked (top) device only if the top device does not support chunk
>> sectors. However, this approach is too restrictive.
> 
> Note that the assumption is that md raid0/10 or dm-stripe chunk size is in io_min. It's not ideal, but that's the field which always holds chunk_sectors for those drivers.
> 
> max_hw_sectors would seem to be more appropriate to me...
> 
>>
>> We should also propagate the bottom device's atomic write limits to the
>> stacked device if atomic_write_hw_unit_{min,max} of the bottom device
>> are aligned with the top device's chunk size (io_min). Failing to do so
>> may unnecessarily reduce the stacked device's atomic write limits to
>> values much smaller than what the hardware can actually support.
>>
>> For example, on an NVMe disk with the following controller capability:
>> $ nvme id-ctrl /dev/nvme1  | grep awupf
>> awupf     : 63
>>
>> Without the patch applied,
>>
>> The bottom device (nvme1c1n1) atomic queue limits:
>> $ /sys/block/nvme1c1n1/queue/atomic_write_boundary_bytes:0
>> $ /sys/block/nvme1c1n1/queue/atomic_write_max_bytes:262144
>> $ /sys/block/nvme1c1n1/queue/atomic_write_unit_max_bytes:262144
>> $ /sys/block/nvme1c1n1/queue/atomic_write_unit_min_bytes:4096
>>
>> The top device (nvme1n1) atomic queue limits:
>> $ /sys/block/nvme1n1/queue/atomic_write_boundary_bytes:0
>> $ /sys/block/nvme1n1/queue/atomic_write_max_bytes:4096
>> $ /sys/block/nvme1n1/queue/atomic_write_unit_max_bytes:4096
>> $ /sys/block/nvme1n1/queue/atomic_write_unit_min_bytes:4096
>>
>> With this patch applied,
>>
>> The top device (nvme1n1) atomic queue limits:
>> /sys/block/nvme1n1/queue/atomic_write_boundary_bytes:0
>> /sys/block/nvme1n1/queue/atomic_write_max_bytes:262144
>> /sys/block/nvme1n1/queue/atomic_write_unit_max_bytes:262144
>> /sys/block/nvme1n1/queue/atomic_write_unit_min_bytes:4096
>>
>> This change ensures that the stacked device retains optimal atomic write
>> capability when alignment permits, improving overall performance and
>> correctness.
>>
>> Reported-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Fixes: d7f36dc446e8 ("block: Support atomic writes limits for stacked devices")
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   block/blk-settings.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index a000daafbfb4..35c1354dd5ae 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
>>           !blk_stack_atomic_writes_boundary_head(t, b))
>>           return false;
>>   -    if (t->io_min <= SECTOR_SIZE) {
>> -        /* No chunk sectors, so use bottom device values directly */
>> +    if (t->io_min <= SECTOR_SIZE ||
>> +        (!(t->atomic_write_hw_unit_max % t->io_min) &&
>> +         !(t->atomic_write_hw_unit_min % t->io_min))) {
> 
> So will this now break md raid0/10 or dm stripe when t->io_min is set (> SECTOR_SIZE)? I mean, for md raid0/10 or dm-stripe, we should be taking the chunk size into account there and we now don't seem to be doing so now.
> 
Shouldn't it be work good if we ensure that a bottom device atomic write unit min/max are
aligned with the top device chunk sectors then top device could simply copy and use the
bottom device atomic write limits directly? Or do we have a special case for raid0/10 and
dm-strip which can't handle atomic write if chunk size for stacked device is greater than
SECTOR_SIZE?

BTW there's a typo in the above change, we should have the above if check written as below
(my bad):
    if (t->io_min <= SECTOR_SIZE ||
        (!(b->atomic_write_hw_unit_max % t->io_min) &&
         !(b->atomic_write_hw_unit_min % t->io_min))) {
    ...
    ...

> What is the value of top device io_min and physical_block_size in your example?
The NVme disk which I am using has both t->io_min and t->physical_block_size set 
to 4096.

Thanks,
--Nilay

