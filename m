Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B02512C5
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792793; cv=none; b=TuIWaIjxvXLtliJE119JNzBUFqNnzXvJYJ2NB+UtyOMeovRG2W75poKJMICOODHdcWIc7zm3bnKNxnB58Vpjb2DAwoVfYSFfe4m18sBUviy8Q82tYcnwiDCaCzK/8bHZSCm79d6dd10DaSH2y+TH3qhcvhK6bL+nlCri4gul2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792793; c=relaxed/simple;
	bh=IkBLvmDITnyPBUUbc0HneErGyCPjUNDYRBIFFpOeaS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmIzK+4uGTg+TpPtKIfCCtP0WfHnVy3ZfPUxPo8Ws2LChb8kGcy/FhqA10sm8LElo7d5EwDnCm0P5stRXXMcQ0l3qMAK4HdsRRPBRhrDTXmkGOnl9iUhCVDj6qXnPqAUbvomonF1cMDsbzkI3G76rD9c1+JbgQTkMFM8ih0AK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SJ+mzjZM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SJ+mzjZM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdnq6028667;
	Wed, 12 Mar 2025 15:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CfiSmE
	amRd3ACvm3B1lU8m6rJNAK/6qer0yMaBEUWog=; b=SJ+mzjZM9yD8VZY/58B5Ob
	zQZhlHXv6njBItIwcRSTHE5E21Z+20HbWVo685PULWFcOiNZgy92dr7NMCT1Ie7e
	R5eabxsb7Rz3yucVSdXegdwqKOzxpvfLInzr/mpMUAB49XOa+jUVSsUHE0oWdxBl
	RR57QuZ6q6fRyMglE7esBcqS4Iph9y+0OgtTuFOCq+zBmmHnghBc1KL40sGB2ivW
	rwAAqrHUGY2oYt0Mlmyo3MT0xZvVD1QDj2BBXBlGiV26hu31KxyOKMuc6FIo7wba
	7B6Xgwd2R9upb0snym4OSvpwFzRh/blE96DDs+EV0ATN1aly1klQfDndRvR1jJLQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45b2n9b8n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:19:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CDv8NZ027172;
	Wed, 12 Mar 2025 15:19:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsqvqys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:19:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CFJb9x25428552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:19:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E92558052;
	Wed, 12 Mar 2025 15:19:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0024158056;
	Wed, 12 Mar 2025 15:19:34 +0000 (GMT)
Received: from [9.61.69.177] (unknown [9.61.69.177])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 15:19:34 +0000 (GMT)
Message-ID: <9e5fd5f1-1564-4a99-aeb4-6d8d9d765db7@linux.ibm.com>
Date: Wed, 12 Mar 2025 20:49:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: protect debugfs attributes using q->elevator_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20250312102903.3584358-1-nilay@linux.ibm.com>
 <20250312141251.GA13250@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250312141251.GA13250@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kB1EMD0VIIMdupKUK-cRq33mtTLgW7_y
X-Proofpoint-ORIG-GUID: kB1EMD0VIIMdupKUK-cRq33mtTLgW7_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=687 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120102



On 3/12/25 7:42 PM, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 03:58:38PM +0530, Nilay Shroff wrote:
>> Additionally, debugfs attribute "busy" is currently unprotected. This
>> attribute iterates over all started requests in a tagset and prints them. 
>> However, the tags can be updated simultaneously via the sysfs attribute 
>> "nr_requests" or "scheduler" (elevator switch), leading to potential race 
>> conditions. Since the sysfs attributes "nr_requests" and "scheduler" are 
>> already protected using q->elevator_lock, extend this protection to the 
>> debugfs "busy" attribute as well.
> 
> I'd split that into a separate patch for bisectability.
Ok I will split it.
> 
>>  	struct show_busy_params params = { .m = m, .hctx = hctx };
>> +	int res;
>>  
>> +	res = mutex_lock_interruptible(&hctx->queue->elevator_lock);
>> +	if (res)
>> +		goto out;
> 
> Is mutex_lock_interruptible really the right primitive here?  We don't
> really want this read system call interrupted by random signals, do
> we?  I guess this should be mutex_lock_killable.
> 
> (and the same for the existing methods this is copy and pasted from).
> 
I thought we wanted to interrupt using SIGINT (CTRL+C) in case user opens 
this file using cat. Maybe that's more convenient than sending SIGKILL. 
And yes I used mutex_lock_interruptible because for other attributes we are 
already using it. But if mutex_lock_killable is preferred then I'd change it
for all methods.

>>  	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
>>  				&params);
>> -
>> -	return 0;
>> +	mutex_unlock(&hctx->queue->elevator_lock);
>> +out:
>> +	return res;
> 
> And as Damien already said, no need for the labels here, including for
> the existing code.  That should probably be alsot changed in an extra
> patch for the existing code while you're at it.
> 
Okay will do in next patch.

Thanks,
--Nilay

