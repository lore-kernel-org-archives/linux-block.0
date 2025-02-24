Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39323C8B6
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402779; cv=none; b=mA2ETPx2Q9jsBsVRnqg7pm84Gii5PZUe4CdYGBLCzJJCLiZ+uFLlUdYxPxoJ4w0ylTPh/RPJvLNyMrXT2W7hw6O6Fe98lL2n+TKOCU3JClU5q50wP1HNkc7PuaVABj5JbalOiXaiCeAUek/gTXa2JbfDMHoUPxPHfXkdwGk1QBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402779; c=relaxed/simple;
	bh=HcaDA+FVTlLW/ij7FsReMlZG6z4oWsMkf0Q/S1VL3DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7sHBLsPtksty2C6Ps3tv56nr8hO3GQV6TqzpYnPINGU4AAnhMLI4Ou9sXYrtQPNK9V3NLs9Gua+KVTisze0XOPKFQOpHEXPBaPG9Hm5BePablfWR7ozBWxvIkFRooZE0uFlSkBEVJi9QoamreRKMP56IpAzxlZSP0FTpiwdSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tPZBOd8w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tPZBOd8w"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O6Pb0m019737;
	Mon, 24 Feb 2025 13:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ToOf30
	JxnthxStb7ro2WsTkj6SRvLtI4oqZ/HjNpgzM=; b=tPZBOd8wgI/49p4c0nQIq3
	ALM56cmP3mtUveyCdiBZO7j0Oo+Esrv28lCMRtBlnQRQOjw1C9Si0jnQ7hs5qSI8
	aJk1D/mCEWGkQ+a8j9WTG+cid9i/7XoKTNpB0CIJ2dThfI/XkfQ2SDdQeOw0QRCe
	pUhW2IKmANg+B0N+DeZAUyMD1YlSTG2O+JkGFMWtIOzVYmOr14Fz5Ceh2TipHwVj
	75DMDVrSe8VAaZYk3GCdRfcJjXk0ICDt5DlqcweI1bPFh1bJlWC/XIqRUbAjefa/
	xmaaZnHG/1dAgXY1KI12dfDkxxcpKcCvNR6aIJFeqHvViaoYOLYZxqwFY6uvqBpA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450kg69p6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:12:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCII2v026287;
	Mon, 24 Feb 2025 13:12:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswn787e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:12:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ODClmS28639998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:12:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27ECA58043;
	Mon, 24 Feb 2025 13:12:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C96458053;
	Mon, 24 Feb 2025 13:12:44 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:12:44 +0000 (GMT)
Message-ID: <5ef25cc6-f466-4094-bea1-d97e02661d22@linux.ibm.com>
Date: Mon, 24 Feb 2025 18:42:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de>
 <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
 <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
 <6084e145-0347-4dd5-83c7-2704a846896d@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6084e145-0347-4dd5-83c7-2704a846896d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jjh6L1PK886vqbZl8X9zOc7R01K-ySbM
X-Proofpoint-GUID: jjh6L1PK886vqbZl8X9zOc7R01K-ySbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=701 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240095



On 2/24/25 2:11 PM, Hannes Reinecke wrote:
> On 2/21/25 15:02, Nilay Shroff wrote:
>>
>> Hi Christoph, Ming and others,
>>
>> On 2/18/25 4:56 PM, Nilay Shroff wrote:
>>>
>>>
>>> On 2/18/25 2:16 PM, Christoph Hellwig wrote:
>>>> On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
>>>>> There're few sysfs attributes in block layer which don't really need
>>>>> acquiring q->sysfs_lock while accessing it. The reason being, writing
>>>>> a value to such attributes are either atomic or could be easily
>>>>> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
>>>>> are inherently protected with sysfs/kernfs internal locking.
>>>>>
>>>>> So this change help segregate all existing sysfs attributes for which
>>>>> we could avoid acquiring q->sysfs_lock. We group all such attributes,
>>>>> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
>>>>> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store
>>>>> method (show_nolock/store_nolock) is assigned to attributes using these
>>>>> new macros. The show_nolock/store_nolock run without holding q->sysfs_
>>>>> lock.
>>>>
>>>> Can you add the analys why they don't need sysfs_lock to this commit
>>>> message please?
>>> Sure will do it in next patchset.
>>>>
>>>> With that:
>>>>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>
>>>
>> I think we discussed about all attributes which don't require locking,
>> however there's one which I was looking at "nr_zones" which we haven't
>> discussed. This is read-only attribute and currently protected with
>> q->sysfs_lock.
>>
>> Write to this attribute (nr_zones) mostly happens in the driver probe
>> method (except nvme) before disk is added and outside of q->sysfs_lock
>> or any other lock. But in case of nvme it could be updated from disk
>> scan.
>> nvme_validate_ns
>>    -> nvme_update_ns_info_block
>>      -> blk_revalidate_disk_zones
>>        -> disk_update_zone_resources
>>
>> The update to disk->nr_zones is done outside of queue freeze or any
>> other lock today. So do you agree if we could use READ_ONCE/WRITE_ONCE
>> to protect this attribute and remove q->sysfs_lock? I think, it'd be
>> great if we could agree upon this one before I send the next patchset.
>>
> READ_ONCE should be fine here. 'nr_zones' is unlikely to change, and
> if that is updated we've done a full disk revalidation including a read
> of all zones. So not a critical operation, and nothing which needs to be
> protected.
> 
Thanks Hannes! As you as well as Ming pointed out that it's unlikely to go
wrong here with nr_zones even if we read/write it without any protection, 
I'd send next patchset without using READ_ONCE/WRITE_ONCE. 

Thanks,
--Nilay


