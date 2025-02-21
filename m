Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B932D05E
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146589; cv=none; b=jpsMTdpqUzaCfZCIJjwaxuCB+rFwJn0Dp9kRgX1Ztb2igaw2gbOH/DnK83DChEa+gVb0SEC9YBPGhatwyUPRGBkq0jTAh4K63t45MLabovgVbm1cPbaNIrBTZ8kIuj6oh1GfYjg/rwn2x4QMqLWhLEmqMHyx+I4V3QdZfqlGm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146589; c=relaxed/simple;
	bh=5MPsDBJjOW6+Ehe+mZCU/ajKCb5hrXnXirMtYnUu+i8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fIkqRr+iPGf7D10/l6az8jQ+9YmBH0Jv0j5WYOCfE3AWuRQaRCPvbZGf7zBszpx1ZY6GvcsC+ljZMYJ6ykSi+jCJf4wftTBEiAwRyR8/LYiPdCOmhUcBvI2XJhW6p7A4h6iBuidVvE8k78qrLwO8VKzDCegoH7mGfZ+g8r6WAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gqzi/3Z5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gqzi/3Z5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBmsha027194;
	Fri, 21 Feb 2025 14:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KvBvsJ
	xif2l1vAajwL/+oAv34ymGgtR2jSx9FZbqPRI=; b=gqzi/3Z56PcoVwpkeYxca4
	4PKDurgk7hGHSskwE1C+oQife2kHrPpyGPcaPm+4urUw03i2gvI5TXAIJBsl1j49
	k6fCv1r4Qd8/AfuakpLleNOYVs3OzVN8wmLx9kcBmrdHCkmwi0dU3y7fO5uPn3vL
	54yC+EuR1yzCpBnhaJhXoMTKZJ58sBV7JATyd59jF6DabIAaH9635yN5cwkzWu0C
	9Tv9cKR/tRnxuAFLUR7KA3Zi8mkMpsMPuHNDtDK/XyG2O8s2OCIuorzo4i+gYwuN
	641dx5/NFbnDw4Jk8fOVDaSLvMz+Bckl3isn/2c158O8KI05njfT2LCML7TPleIg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xfj9uagv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 14:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBnHhb030262;
	Fri, 21 Feb 2025 14:02:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xgbu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 14:02:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LE2tZp18154190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 14:02:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B845805C;
	Fri, 21 Feb 2025 14:02:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AD6858054;
	Fri, 21 Feb 2025 14:02:54 +0000 (GMT)
Received: from [9.61.34.131] (unknown [9.61.34.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 14:02:53 +0000 (GMT)
Message-ID: <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
Date: Fri, 21 Feb 2025 19:32:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
From: Nilay Shroff <nilay@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de>
 <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x6-JhyjPjBN4Krf_6AqLkfuV_4OdwuAC
X-Proofpoint-GUID: x6-JhyjPjBN4Krf_6AqLkfuV_4OdwuAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=672 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210102


Hi Christoph, Ming and others,

On 2/18/25 4:56 PM, Nilay Shroff wrote:
> 
> 
> On 2/18/25 2:16 PM, Christoph Hellwig wrote:
>> On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
>>> There're few sysfs attributes in block layer which don't really need
>>> acquiring q->sysfs_lock while accessing it. The reason being, writing
>>> a value to such attributes are either atomic or could be easily
>>> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
>>> are inherently protected with sysfs/kernfs internal locking.
>>>
>>> So this change help segregate all existing sysfs attributes for which 
>>> we could avoid acquiring q->sysfs_lock. We group all such attributes,
>>> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
>>> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
>>> method (show_nolock/store_nolock) is assigned to attributes using these 
>>> new macros. The show_nolock/store_nolock run without holding q->sysfs_
>>> lock.
>>
>> Can you add the analys why they don't need sysfs_lock to this commit
>> message please?
> Sure will do it in next patchset.
>>
>> With that:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
> 
I think we discussed about all attributes which don't require locking,
however there's one which I was looking at "nr_zones" which we haven't
discussed. This is read-only attribute and currently protected with 
q->sysfs_lock.

Write to this attribute (nr_zones) mostly happens in the driver probe
method (except nvme) before disk is added and outside of q->sysfs_lock
or any other lock. But in case of nvme it could be updated from disk 
scan.   
nvme_validate_ns
  -> nvme_update_ns_info_block
    -> blk_revalidate_disk_zones
      -> disk_update_zone_resources

The update to disk->nr_zones is done outside of queue freeze or any 
other lock today. So do you agree if we could use READ_ONCE/WRITE_ONCE
to protect this attribute and remove q->sysfs_lock? I think, it'd be 
great if we could agree upon this one before I send the next patchset.

Thanks,
--Nilay
