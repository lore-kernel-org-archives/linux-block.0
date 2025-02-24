Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12123BCF5
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402594; cv=none; b=lsm9ufMW3MJOLbezVf2cVmQ1tzEbMhYNdlT8CIH00zLFTCRc6YFbsn6kq74iZvZ2nB/FZgcWKXKbhTDgqmupskpjh2LUIiw0pFLt1I2YzhmICdjsiDR1E4DV3tSnOHQLJhfQp/HGsD/EkRBTOOeKjDM+186IwMA5T2VJUwhJXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402594; c=relaxed/simple;
	bh=xbsl5qGwEZ+d+XqYvEcJNBiiHiG3FYC2G6B1WR8pchc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz1boXTM4g1SCcC4asL5Jm0ypIqo194h5nEiU2Bu/XW5Q4Zm/FdU5Gp7Ddbn4pAetU65M9ccxSLZfmj8gIt47eBsye2LPkMk89nLyhuJP13w4SwQMYPHvRBVa4qtCjTghVL1+WIr/D3E1b8qwRj4RSRPF/BDVaHlcsmJuDtFn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UkwjixXo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UkwjixXo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O5O6TI012144;
	Mon, 24 Feb 2025 13:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=at5txI
	5pU+Tvo/970ELE5sVIe4IlsGH28Z7yGGro7mw=; b=UkwjixXo70B72U1GErOskP
	6ywyJitaSfTptAWmIqptjkhn+KfIMYFP1DiQ4AzwGOW3EgZttudY6TlaNJjVUmk6
	wxXbNWHyBbN5fhIijl1MslcV5px3us1P+Plip4miiGuWxKnEX7wMWJv03lCTKDRq
	rcFZOkYw+/zQVl2NeyuyoDafOcKuz06gEWcbGqAptGpm9wMZqSWrNkj8zcXcM5bW
	BNxIUky1QpyYsGZF4hW3jQLqZGTw/I7oBp4m8GGCeHIw6TYoKK2nlsmeDDdlcuEK
	jGsiJZgMqO0KY7/YPzm2PQdD4Wm/t9boVejO/G3JmE1NLmC871TyPHzgtYqXHmoA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450jk81wks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:09:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBKnN3012522;
	Mon, 24 Feb 2025 13:09:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y7dnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:09:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51OD9ggP35127840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:09:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6606258053;
	Mon, 24 Feb 2025 13:09:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44BB658043;
	Mon, 24 Feb 2025 13:09:40 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:09:39 +0000 (GMT)
Message-ID: <454d6676-ea82-454c-addb-6f080fb95ce0@linux.ibm.com>
Date: Mon, 24 Feb 2025 18:39:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de>
 <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
 <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
 <Z7nGw_PJfAld8fAz@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z7nGw_PJfAld8fAz@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2hX6k75QpjYaPGUMl-brWtDcnO-7YL5m
X-Proofpoint-GUID: 2hX6k75QpjYaPGUMl-brWtDcnO-7YL5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=809 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240095



On 2/22/25 6:14 PM, Ming Lei wrote:
> On Fri, Feb 21, 2025 at 07:32:52PM +0530, Nilay Shroff wrote:
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
>>   -> nvme_update_ns_info_block
>>     -> blk_revalidate_disk_zones
>>       -> disk_update_zone_resources
>>
>> The update to disk->nr_zones is done outside of queue freeze or any 
>> other lock today. So do you agree if we could use READ_ONCE/WRITE_ONCE
>> to protect this attribute and remove q->sysfs_lock? I think, it'd be 
>> great if we could agree upon this one before I send the next patchset.
> 
> IMO, it is fine to read it lockless without READ_ONCE/WRITE_ONCE because
> disk->nr_zones is defined as 'unsigned int', which won't return garbage
> value anytime.
> 
> But I don't object if you want to change to READ_ONCE/WRITE_ONCE.
> 
Thanks Ming! So, as it seems we can't go wrong here if we don't use
READ_ONCE/WRITE_ONCE or read/write nr_zones without any lock, I'd 
send next patchset without any protection for nr_zones. Lets see 
if Christoph or others have any objection against this.

Thanks,
--Nilay



