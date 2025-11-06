Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE832C305;
	Thu,  6 Nov 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434124; cv=none; b=Z+f33vq25441VE54HApGBoz450RD1sGLxchR+jRXV38xt1d6n337brEjr4pPKU4msxAhRd6nlS69ZnOMksyXjCtntTJ24s414P6PRDVqg58fVKpzbFaSgl3osgcPJ9fKeeo5+HKtn2n6BDscpjzmY7p3pfQEaRpL4JAFrwGNdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434124; c=relaxed/simple;
	bh=0Msik2psULPh2Ih/MH7/EDlaxGNgMadwtuVXfx6/Pcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB+JAObrb0ZOnBYOsI2L78/DfM9JvI4K3aAWXn/pPYHmx0DfLn8P1sHfN317qFrfJLaoUVGpGbqFA388vJayMaVaEWf/VBwzj+tazaFs0h0N+JlmxCRg0YNSmEbPFU7iJNPp65FSdtWvoqUn+3Dpmh6nOH1ZQ5x/2vgCvzH9cOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e2of75u4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e2of75u4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A66bAHm013986;
	Thu, 6 Nov 2025 13:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lvIC7h
	l8dkAf5eu01Joa5gEqrAJTNGfVUM9W00tHpwA=; b=e2of75u4f7xribouB6taMz
	SNPQJSojlS2x7ovCwkVeRJrhs0zuY8/t/3v66vEiz99r3MP4EdhTRSRZf9eKAV7M
	zkJ0PXt2q/8VDCAwLg3UA8v7evKo8qJej2RBQKx/1HZVUq+mTllX9klP2q/JwPtc
	BcOnxrUK/K20lPEolM7JmTGnJDhq/gfg5uZ3xK856TXSNso2vVYpkF28GmdS1eNu
	kMHZ4UE3ydU5OW8H80PctoQZmqGYOz937khzS9NOspjwUSdj+V3T9+B7LAFWfMEu
	/u4BPO3b96SVzvQfJm8NKra7Nu4J/pNLGm0af2UtrzOdDDPa39q72m3UoEKC3ajg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q976jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 13:01:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6C7gTS021467;
	Thu, 6 Nov 2025 13:01:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjwae8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 13:01:33 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6D1Ja612780280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 13:01:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F43458050;
	Thu,  6 Nov 2025 13:01:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB5E158045;
	Thu,  6 Nov 2025 13:01:28 +0000 (GMT)
Received: from [9.61.3.251] (unknown [9.61.3.251])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 13:01:28 +0000 (GMT)
Message-ID: <b556d704-dc3b-4e6c-a158-69fb5b377dac@linux.ibm.com>
Date: Thu, 6 Nov 2025 18:31:27 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Remove queue freezing from several sysfs store
 callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20251105170534.2989596-1-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251105170534.2989596-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690c9c2f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TFDWyf3hBjIInHEowKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 3k6APeHdC5-T3Z9POxx8l4be3Qep7zlr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX6nZ8Eqr3t9Pp
 zRx1m+WC1fti63D4vb49tTb0OxihIeoNwf5eJlhszsKmg3ELRkCWaV2LFq5zBu8pvJaaZ2GSEF+
 mN6Ojv8ArN/vYyCQLX1liNsCynfKCfPw58JDnA9Ghwy6J1zxllDg3HvweWiD5CxC/pWIjzIfzZ7
 nG6Q6Ci9IvUfUUUpaic8cKRiRzhZJZkP0xubuOpn3WFw/nDdWM6GVF4xTVDL/issGKqPJ2iOHDs
 4Qc8BdVbqWfmOvweeD5HxIHEYPPQ3ca3NuZ40o/CNJLdqQJ/+OhoDtKl4u6HT9wWChE94y+NJbA
 EYk7F6BmtxBreqL9QOO5PcjVTRM1DjWI440iTrqtXM50Yq9uv1+DXm3w1VHrileDLrie2+vWh1q
 d718GrKJNY203l2S2WAy99uKnZr9nw==
X-Proofpoint-GUID: 3k6APeHdC5-T3Z9POxx8l4be3Qep7zlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018



> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 76c47fe9b8d6..6eaccd18d8b4 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -143,7 +143,6 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
>  {
>  	unsigned long ra_kb;
>  	ssize_t ret;
> -	unsigned int memflags;
>  	struct request_queue *q = disk->queue;
>  
>  	ret = queue_var_store(&ra_kb, page, count);
> @@ -154,10 +153,8 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
>  	 * calculated from the queue limits by queue_limits_commit_update.
>  	 */
>  	mutex_lock(&q->limits_lock);
> -	memflags = blk_mq_freeze_queue(q);
> -	disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
> +	data_race(disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10));
>  	mutex_unlock(&q->limits_lock);
> -	blk_mq_unfreeze_queue(q, memflags);
>  
>  	return ret;
>  }

I think we don't need data_race() here as disk->bdi->ra_pages is already
protected by ->limits_lock. Furthermore, while you're at it, I’d suggest
protecting the set/get access of ->ra_pages using ->limits_lock when it’s
invoked from the ioctl context (BLKRASET/BLKRAGET).

>  
> @@ -472,7 +460,7 @@ static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
>  static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
>  				  size_t count)
>  {
> -	unsigned int val, memflags;
> +	unsigned int val;
>  	int err;
>  	struct request_queue *q = disk->queue;
>  
> @@ -480,9 +468,7 @@ static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
>  	if (err || val == 0)
>  		return -EINVAL;
>  
> -	memflags = blk_mq_freeze_queue(q);
> -	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
> -	blk_mq_unfreeze_queue(q, memflags);
> +	data_race((blk_queue_rq_timeout(q, msecs_to_jiffies(val)), 0));
>  
>  	return count;
>  }

The use of data_race() above seems redundant, since the update to q->rq_timeout
is already marked with WRITE_ONCE(). However, the read access to q->rq_timeout
in a few places within the I/O hotpath is not marked and instead accessed directly
using plain C-language loads.

When I ran this proposed change with KCSAN enabled on my system, I observed the following
warning ( when one thread was running I/O and another thread was concurrently updating 
q->rq_timeout):

BUG: KCSAN: data-race in blk_add_timer+0x74/0x1f0

race at unknown origin, with read to 0xc000000143c9c568 of 4 bytes by task 3725 on cpu 16:
 blk_add_timer+0x74/0x1f0
 blk_mq_start_request+0xe0/0x558
 nvme_prep_rq.part.0+0x300/0x194c [nvme]
 nvme_queue_rqs+0x1f0/0x4e4 [nvme]
 blk_mq_dispatch_queue_requests+0x510/0x8e0
 blk_mq_flush_plug_list+0xc0/0x3d8
 __blk_flush_plug+0x29c/0x368
 __submit_bio+0x320/0x3bc
 submit_bio_noacct_nocheck+0x604/0x94c
 submit_bio_noacct+0x3b4/0xef8
 submit_bio+0x7c/0x310
 submit_bio_wait+0xd4/0x19c
 __blkdev_direct_IO_simple+0x290/0x484
 blkdev_direct_IO+0x658/0x1000
 blkdev_write_iter+0x530/0x67c
 vfs_write+0x698/0x894
 sys_pwrite64+0x140/0x17c
 system_call_exception+0x1ac/0x520
 system_call_vectored_common+0x15c/0x2ec

value changed: 0x00000bb8 -> 0x000005dc

Reported by Kernel Concurrency Sanitizer on:
CPU: 16 UID: 0 PID: 3725 Comm: fio Kdump: loaded Not tainted 6.18.0-rc3+ #47 VOLUNTARY
Hardware name: IBM,9105-22A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RB1120_115) hv:phyp pSeries
==================================================================

Based on the gdb trace:

(gdb) info line *(blk_add_timer+0x74)
Line 138 of "block/blk-timeout.c" starts at address 0xc000000000d5637c <blk_add_timer+108> and ends at 0xc000000000d5638c <blk_add_timer+124>.

This corresponds to:

128 void blk_add_timer(struct request *req)
129 {
130         struct request_queue *q = req->q;
131         unsigned long expiry;
132 
133         /*
134          * Some LLDs, like scsi, peek at the timeout to prevent a
135          * command from being retried forever.
136          */
137         if (!req->timeout)
138                 req->timeout = q->rq_timeout;

As seen above, the read access to q->rq_timeout is unmarked. To avoid the reported
data race, we should replace this plain access with READ_ONCE(q->rq_timeout).
This is one instance in the I/O hotpath where q->rq_timeout is read without annotation,
and there are likely a few more similar cases that should be updated in the same way.

Thanks,
--Nilay

