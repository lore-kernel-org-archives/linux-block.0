Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998C101E6
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745061630; cv=none; b=o1XwqzM3q5z0/whVbdnPIXlkxmb/yo8quStDHo7HjTOAfLIZV7cw+aSADn51lazjt15uRwqRRLN5XTBL1B40e4ie/ORy1+ZWpu25nYMR9gQpVG2M5VphtWtnn2zhJkieT1i8P4AOlxyDTrBUUGVf/FPx/1s6nxCK52ELbq/V21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745061630; c=relaxed/simple;
	bh=uXQzYtJSJGN5gO1+Kfx1gyv/euzc3+Ce+/WRZ9d6jXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paqE4iSTpndvZYjt8spvC0EcmIuubd8vhIZ7Yn+djnO8QrGFJcSK045c/vlhB57pQhaOBNp4OBb1vYGL1SHb1QJZwuUe1h52tGoh0Mg0fUj5F1wizNBbc+5j4Ojt7NWYXZXomRXQH4F1SMTO012sGHMhr0uFzhtXJugvWWVTkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jcOBSrlU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jcOBSrlU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J3VC3J003542;
	Sat, 19 Apr 2025 11:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LaBtsA
	fUSzNn/pg9m2gQRPN0T/T8Z3ogUSp0OFpdFW8=; b=jcOBSrlUrwoKRZrX704uQu
	yJHpTOgd/kw1+N9CkbwIVPUKOBpdi/5IIEUs8nywobeo5os9R/XFJfBkRo8cB+Bh
	Qzm3jNF1rgkEJnZ1WE3BpdllPe4kCv1CZuJfkpKGpXROx8dXuacqErMSKFHlMZSq
	Tmc6Kgtz19gGOI4VP+T9b7x1l/IFrxZdRvrVXDJAjKTltfDU0Ny5EkIrRpsgxKYr
	H62oOinemScu6asMlycs9NXM5Vnl94bX1is+ga38XnTKgLG96JG/A6KzIahhA/4j
	c5iOVY6I+qq0JB+kr8V2jV5v1KWIxfX+qZXou+b/qT4XbYOadvz1ikH14iwVth7Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643gxs6jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 11:20:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAklQ1016703;
	Sat, 19 Apr 2025 11:20:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572puus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 11:20:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JBKJxv6947400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 11:20:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91DD95805B;
	Sat, 19 Apr 2025 11:20:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E7FA58058;
	Sat, 19 Apr 2025 11:20:17 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 11:20:17 +0000 (GMT)
Message-ID: <094c312a-38ec-4c5b-9db3-2269c37de36a@linux.ibm.com>
Date: Sat, 19 Apr 2025 16:50:15 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-8-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zdEXIlbwnBJIqAYYBWyx-64Y8JQHl7Ql
X-Proofpoint-ORIG-GUID: zdEXIlbwnBJIqAYYBWyx-64Y8JQHl7Ql
X-Authority-Analysis: v=2.4 cv=I8llRMgg c=1 sm=1 tr=0 ts=680386f5 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=R2Tci1Go_5vh-wF9Tf0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190090



On 4/18/25 10:06 PM, Ming Lei wrote:
> Both adding/deleting disk code are reader of `nr_hw_queues`, so we can't
> allow them in-progress when updating nr_hw_queues, kernel panic and
> kasan has been reported in [1].
> 
> Prevent adding/deleting disk during updating nr_hw_queues by setting
> set->updating_nr_hwq, and use SRCU to fail & retry to add/delete disk.
> 
> This way avoids lot of trouble.
> 
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-block/a5896cdb-a59a-4a37-9f99-20522f5d2987@linux.ibm.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
[...]
[...]
>  
> +static int retry_on_updating_nr_hwq(struct gendisk_data *data,
> +				    int (*cb)(struct gendisk_data *data))
> +{
> +	struct gendisk *disk = data->disk;
> +	struct blk_mq_tag_set *set;
> +
> +	if (!queue_is_mq(disk->queue))
> +		return cb(data);
> +
> +	set = disk->queue->tag_set;
> +	do {
> +		int idx, ret;
> +
> +		idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> +		if (set->updating_nr_hwq) {
> +			srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
> +			goto wait;
> +		}
> +		ret = cb(data);
> +		srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
> +		return ret;
> + wait:
> +		wait_event_interruptible(set->update_nr_hwq_wq,
> +				!set->updating_nr_hwq);
> +	} while (true);
> +}
> +
Yes using srcu with wait event would fix this. However after looking through 
changes it seems to me that the current changes are now modeled as below:

- Writer(blk_mq_update_nr_hw_queues) must wait until all readers are done 
  (or prior SRCU read-side critical-section complete)
- Readers (add/del disk) must wait until a writer(blk_mq_update_nr_hw_queues)
  finishes

And IMO, this behavior is best modeled with a reader-writer lock, rather than 
(S)RCU. 

In my view, RCU is optimized for read-heavy workloads with:
- Non-blocking readers
- Deferred updates by writers
- Writers don’t block readers and readers don’t block writers.

So I believe the simpler choice shall be using reader-writer lock instead of srcu. 
With reader-writer lock we should be also able to get away with implementing wait 
queue for add/del disk. Moreover, the reader-writer lock shall also work well with 
the another reader elv_iosched_store. 

Thanks,
--Nilay 

