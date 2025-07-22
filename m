Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0D155725
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173079; cv=none; b=bzSE/uPCF9x37BFeUA1B0vj1Y2kYE5Co68E5IqUcP1ZdI/r/eF+/6l3phsgmqm5BDUCKm7clxhla/sWdh4l4q86iizFizETWuLitKYOk8asv30J/pHNVcaMdnxMLT0ajy0Mj9bgLqiMPZlY7iicUrLTnLsNbrUUCaHrnsVVnnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173079; c=relaxed/simple;
	bh=g5DShMZ9QXQ1Np4XwPFZohrFDzo5vxupWti91wsWQXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMzUMxUTvNZ+RSQkr70uAGOWjDYimpa+iU0/clYoiSVLx24wAZPkCGwlpwPieeIiWGHtQOHMaxbCvbw2wIUbh2gme3ODtB69UUIR0m+FxMrUWMBz0Wxd9Ftbkfz08KZ1rDhHWSy4q0Eg6bSeCLlVx+tltCq107MDKd0YUTbbtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JdRzIWbx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JdRzIWbx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LKtPg4015385;
	Tue, 22 Jul 2025 08:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KwwLIW
	GC2YveFJqLQzdfd4zpj0BZl375AC6aW9R6a0o=; b=JdRzIWbx+jmUprLpDhUe6M
	T/lSggecuxN4qycXXqm7gBM8Sq69IVzh2LaQGCWHRCTP3dbovwJCsYB3Krms4KhV
	IgikxoXvPYInCpGyIj8iG797F0vRiDlNWjVEWNSKvA2SXt0bi8rvTej6N+FU/VQx
	rnp/ojEumZBHnvFH6hurL9sKZcgKyrZXyUBojooD3ouVRQGhHhx/FYvAH0h/ZZH5
	Rh1nutW5Fr+ZxKGbDfFg8sfDblzTuMm4n0L6s8gZZfn6eaUANnBsyaIaxbAmYXyk
	PrxyxjDeGdQ4pnjUETcuDNV5a9FdYWIlBX3WHg1Z2iz1areHAkPPmomSxcUkIUTQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqw7qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:30:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M81sNI024975;
	Tue, 22 Jul 2025 08:30:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd29ra2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:30:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56M8Uw1v28836552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 08:30:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8604758056;
	Tue, 22 Jul 2025 08:30:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1413158052;
	Tue, 22 Jul 2025 08:30:56 +0000 (GMT)
Received: from [9.109.203.242] (unknown [9.109.203.242])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Jul 2025 08:30:55 +0000 (GMT)
Message-ID: <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
Date: Tue, 22 Jul 2025 14:00:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
        johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kLxLBr7u9JMrmLCFGvDpsnr_mSpvt9HM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA2NiBTYWx0ZWRfXzVfYMPgQziaE
 WVtCkQOs6rhFLUty93LkNSLx75oFonuhVD1qsaIpB0ATHRTid0z2ezoPjCxW+sGihZycMwksv3d
 LC429nGAJ3/LUTwajGHXA8ssW1cjD8EWFAx/BOJu2syYRJDud9Xy9EV1no9NfrWdCyrM2z5Rirs
 iV2o80cm6+146yaCf119iSZwx9RvqEHwDLpV8kKN2On5XmncHIR9f1sXnMjBa0c3Av6SIMZHqa9
 /5Dw0Ej6N+zveSAPCH+JDyOF1+y/SBZ7XtXxCDxuLe1K+5T+V72teu7LmKy4CiNpzUhP7cRNPTS
 eav5wdoAuMRLKkgcuUkSw2rzCQts3g+0i4rfJebbynA2HoHa4WMIZJS9Ug9KRzvF9xGRbL7mci6
 WmldIrdSjEdOkpGgiICEmp71bczn1U+ROX/lAEWpS8mH+jDXeCBeefe98+qLrs57R/pfF8dN
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687f4c43 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=cheBbqodGBAJMB35WJIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kLxLBr7u9JMrmLCFGvDpsnr_mSpvt9HM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220066



On 7/22/25 6:37 AM, Damien Le Moal wrote:
> On 7/21/25 11:04 PM, Nilay Shroff wrote:
>> When setting up a null block device, we initialize a tagset that
>> includes a driver_data field—typically used by block drivers to
>> store a pointer to driver-specific data. In the case of null_blk,
>> this should point to the struct nullb instance.
>>
>> However, due to recent tagset refactoring in the null_blk driver, we
>> missed initializing driver_data when creating a shared tagset. As a
>> result, software queues (ctx) fail to map correctly to new hardware
>> queues (hctx). For example, increasing the number of submit queues
>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>> remap queues. Since set->driver_data is unset, null_map_queues()
>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>> effectively making the hardware queues unusable for I/O.
>>
>> This patch fixes the issue by ensuring that set->driver_data is properly
>> initialized to point to the struct nullb during tagset setup.
>>
>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  drivers/block/null_blk/main.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index aa163ae9b2aa..fbae0427263d 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>>  {
>>  	if (nullb->dev->shared_tags) {
>>  		nullb->tag_set = &tag_set;
>> +		nullb->tag_set->driver_data = nullb;
> 
> This looks better, but in the end, why is this even needed ? Since this is a
> shared tagset, multiple nullb devices can use that same tagset, so setting the
> driver_data pointer to this device only seems incorrect.
> 
> Checking the code, the only function that makes use of this pointer is
> null_map_queues(), which correctly test for private_data being NULL.
> 
> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
> 
I think you were right — the first patch alone is sufficient to prevent the crash.
Initially, I thought the second patch might also be necessary, especially for the
scenario where the user increases the number of submit_queues for a null_blk device.
While the block layer does create a new hardware queue (hctx) in response to such
an update, null_blk (null_map_queues()) does not map any software queue (ctx) to it. 
As a result, the newly added hctx remains unused for I/O.

Given this behavior, I believe we should not allow users to update submit_queues 
on a null_blk device if it is using a shared tagset. Currently, the code allows
this update, but it’s misleading since the change has no actual effect.

Would it make sense to explicitly prevent updating submit_queues in this case?
That would align the interface with the actual behavior and avoid potential
confusion and also saves us allocating memory for hctx which remains unused.
Maybe we should have this check, in nullb_update_nr_hw_queues():

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index fbae0427263d..aed2a6904db1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
        if (!submit_queues)
                return -EINVAL;
 
+       /*
+        * Cannot update queues with shared tagset.
+        */
+       if (dev->shared_tags)
+               return -EINVAL;
+
        /*
         * Make sure that null_init_hctx() does not access nullb->queues[] past
         * the end of that array.

If the above change looks good, maybe I can update second patch with
the above change.

Thanks,
--Nilay

