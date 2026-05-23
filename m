Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19115A86D
	for <linux-block@vger.kernel.org>; Sat, 23 May 2026 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562484; cv=none; b=TDZAKJqz/o0HksQkwT63H5zZbhwqWw+cMFsdLUOqY7uytJocJH4kCY7/7t96KSCf1bdNeK9w9L0Fa7JecQHvC6dzo0c0uzztTSjrSJfkvlXVoJYkv1IJI8Ag40qKttQfNnpkkWgH1BYdCnOd3t2Hj6Sg6jKK5ujj9EiuVweIGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562484; c=relaxed/simple;
	bh=bAF4T0IBiPSNu/rEw8xFZqX1NXO5lp8/b89SINUbDsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKBWBq0Q93OhquozKxtGCXgqoQ8AdpK0+v+0y5Aqi8LkKOS4Ntq/prptkMzjNJqaxIES0irLYsj5sIHdx6lDbb6aGpjpy5oy8o/H1KFEdc2LZZeRD2gUn1AeQubHW8izdD//4FMP+HizlbG5Yd1a9YowCrtUsO/Irekv8bWd8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mxQ47kh7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mxQ47kh7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N8tdau2651203;
	Sat, 23 May 2026 18:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ZoVYh
	ptMmz0YE2dBZtksztH+TTxndTDvkJxDgStbFo=; b=mxQ47kh7S9g0Ut8GNZ9W9h
	tmB3YIMOatzZR35lDoTXgqmTmqG7OuU7XytQLoHISSzfmBlVNalVgQryJxFplmKR
	HZq9XwDtTCyyQK3Q+J3HNGJeQrdhq4FfZP6zcANnrk4rSeEOv4Wvwwbf5J06Yb+N
	wcTbcILxfc8kGoewDThfPt5U/bpruQ7Va9YSsiJy/n38+kckSPgqs17uJL9HU0ro
	87zqq2ODZZPBRoFr/Y64GBe1s5WEVMJgwllW3KSw4s8INyC5Pnj0nOEJTYW6xrex
	U8G99TJzzjCeRi/4O9DlBTPx9wEgvPFCBevMpQeIoUQ2ySN6nVPseltQ848w2KnA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4npsq51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 18:54:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NIs5o5020843;
	Sat, 23 May 2026 18:54:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb49025n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 18:54:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NIsSJa28836368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 18:54:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E50B58056;
	Sat, 23 May 2026 18:54:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1F658052;
	Sat, 23 May 2026 18:54:26 +0000 (GMT)
Received: from [9.61.182.56] (unknown [9.61.182.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 23 May 2026 18:54:26 +0000 (GMT)
Message-ID: <a5c5a183-a846-4fac-ab18-fd957bac6c20@linux.ibm.com>
Date: Sun, 24 May 2026 00:24:24 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20260522151537.1509784-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260522151537.1509784-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rT2lyHpQL3X7_M4X440TRPGbMS3fJkXK
X-Proofpoint-ORIG-GUID: rT2lyHpQL3X7_M4X440TRPGbMS3fJkXK
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a11f7e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=E1viyzfc2PkgsqfBwtAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE5MCBTYWx0ZWRfX0UX6Rh++txXW
 a2B776bgDeQdu9LLRlWTg+c2qXcYGgV4uthX1PPnIfGnOkmzVrKM82szRFQgXmoY3mJgdPYMjsS
 1QnNVqM3dQjIy0EMFZEtsY5EQjSerE7TwMjAWHVfbcvUjhQ9FGwBqpcx1B5bvTxecs3GpuVipXs
 KxhKv4XMxulhncKuAW6ASOTpb1vZNHuEfBryVQ9RtatY2r9xdilIH4u13o8sOwqfoloUtsygNSF
 zf4kGbIxRaB+9S9leuIVlxLvWTuXDj7w0P628QtlRvtQLVg89AtslsCi44yxDN/HRcgb81bNuP0
 2NN8dKplNMR8YcEmO6HQHtzss1DZpuqyLL7aQqdBHPwwfckGz7jMMVG2wIAKsfGvx4bY7iUiupF
 QxI+9ffij8z9rSBloGvoAfIMjtk2xX71lwBKspBwCYLdga6BkebimkLMmDXkzOBapuULH+VpooA
 Mi4Kb2rS1kkFbXi7lmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605230190

On 5/22/26 8:45 PM, Keith Busch wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 263161cb8ac06..435fab0be6401 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -175,9 +175,11 @@ void nvme_mpath_start_request(struct request *rq)
>   		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>   	}
>   
> -	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
> +	if (!blk_queue_io_stat(disk->queue) ||
>   	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>   		return;
> +	if (blk_rq_is_passthrough(rq) && !blk_rq_passthrough_stats(rq))
> +		return;
>   
>   	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
>   	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),

Thanks for this patch! It will be very useful for nvme top dashboard for
displaying passthru I/O stat under head node.

Well, I see an issue here with @rq being passed to blk_rq_passthrough_stats()
as the @rq->q points to nvme path queue object rather than the head node queue
object. The intention here is to account passthrough I/O statistics at the
head node level, but with the current implementation the decision depends
on the path queue's iostats_passthrough setting instead of the head queue's
setting. As a result, head-node passthrough I/O statistics may get accounted
based on whether the underlying path queue has iostats_passthrough enabled,
irrespective of the head queue configuration.

Another issue is that nvme_mpath_start_request() is only reached from
nvme_start_request() when REQ_NVME_MPATH is set. Normal bio based I/O
through the head gets that flag in nvme_ns_head_submit_bio(), but the
passthrough ioctl/uring path in the quoted patch does not set it. So
head passthrough I/O would not enter nvme_mpath_start_request() and
would not get head-node stats.

Thanks,
--Nilay
