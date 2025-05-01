Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D2126C05
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093317; cv=none; b=gWFvOPltRn6iNY0Gb6vrOLJlYAH4ax/ubegu6D6bwB7PQjEoIb4TY+DI9n4JHlKfmKFBF9QoFrWo1otxZGkxc7vUYAz+5ctEq0S/Y8FNRvVnrozZlzSwPEYEQXtpio1pDYK0qw7Qovd2mzibEZN/S8X0+9iN5TrXcp6WqQ52cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093317; c=relaxed/simple;
	bh=chw11y8hPwTeFi21ie0qQDoHdbSqNkUWuqs7odhFKOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F89U0zMtmSro+tFuZVuZ99RX7ufwGRCQp8FsiZobTkBtF5+8iWSM+WYA3X/8nHmE7tfLddUpDaL43yWd2e51ynzdF7EaUNNcNewjxNpknTWUd4SmSi2Y0yrDtsIW5N5FGRXyXzctDTZavDuzCeNJlbX8jjuyfSom6KVMx7N8j0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=amKNUMni; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="amKNUMni"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UIimjH011486;
	Thu, 1 May 2025 09:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vhankF
	SEfnU7xZqK2KDC3JGhbMF9tTqaeK+7pgnV/Xg=; b=amKNUMniHOYzXqldAFdXBl
	q61aJ1r+eKTWR178vE6BEJKoB9f/5XAxiP3/zPS5uDWUuNrMDPxU9QB/IXJbNMKk
	Lye244XVX5piDrARM8LCqD9hMiH5NX7/1mjF/UNaZN9Bm+FDIxN2SJrFLPIg+RPF
	G539I6TIV86ZfWrbmaguKzhVQ9wER5Sdyadthc6F/6bHAxtFouQwHoC4/ZcM2Fe4
	qAsFwK7lVYS5+7xN6K4d+KhrQ7JpPqHitVllA6mnvidO/PepGNKseD3t0fVhXi1/
	7MyI8JKiEbRDYZbrqWsEOAmPzwuNg1SP70FZTmxYprR+UkF2mORNQ/HjGiLPH77g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46bjas5ae8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:55:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5416GEXc024644;
	Thu, 1 May 2025 09:55:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1mc0gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:55:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5419t63F53936532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:55:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5391858056;
	Thu,  1 May 2025 09:55:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A645805D;
	Thu,  1 May 2025 09:55:03 +0000 (GMT)
Received: from [9.43.8.50] (unknown [9.43.8.50])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 09:55:03 +0000 (GMT)
Message-ID: <1b9ddb33-2db2-490a-a3f3-cd91d8837c7a@linux.ibm.com>
Date: Thu, 1 May 2025 15:25:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/24] block: move blk_queue_registered() check into
 elv_iosched_store()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-12-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250430043529.1950194-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vK6Y0zqmTCjD0tNpwDdy9kKxiHVCuJEF
X-Proofpoint-ORIG-GUID: vK6Y0zqmTCjD0tNpwDdy9kKxiHVCuJEF
X-Authority-Analysis: v=2.4 cv=LKNmQIW9 c=1 sm=1 tr=0 ts=681344fc cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=MkBpbG05XsvgUO-hY6AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3MiBTYWx0ZWRfX+9RTdE74qlto sDEoh8EdLEEpDEcEpuDG8uIgkBaxRqQkzQK0Y+WphfGQxWHQ1hxXYd55W7xNvTgDuTSngo/l7Va YfW78uS8GikNpWvALf3S3KQDQ+6tvhp+LVoX5EcdNzhH0Lnro6M/MaaBtJrnieE5y9GoZ3nfTSN
 MLrn6bCbqiRFkzhBMNTaa6wTL3iklQizMO6jZEJxfSQNucDlLwY+wpz2jrbtS81z4kOtpef1K0S ZWpPFxzqUszl/2EyLYaU8BRkbBSUnBljUN0mebU55BHCGlOKWN2ISIbz3OrmaN6TzhO/4911Uk/ x5MQHQ0LVWSeePokUHkjJ0YIvWH6oze6rAUmPtwGccfytncBX24OMNdmaHtM4S8vt/Y3xUXgTOI
 VQn/otw1iWG5HuKV3k7SQwvD/DSyvmnpJPRNYDVJAAZBur5Z3rm1lDurYqZlkZ7MNPmAPkls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010072



On 4/30/25 10:05 AM, Ming Lei wrote:
> Move blk_queue_registered() check into elv_iosched_store() and prepare
> for using elevator_change() for covering any kind of elevator change in
> adding/deleting disk and updating nr_hw_queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/elevator.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index df3e59107a2a..ac72c4f5a542 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -676,10 +676,6 @@ int elevator_switch(struct request_queue *q, const char *name)
>   */
>  static int elevator_change(struct request_queue *q, const char *elevator_name)
>  {
> -	/* Make sure queue is not in the middle of being removed */
> -	if (!blk_queue_registered(q))
> -		return -ENOENT;
> -
>  	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
>  		return 0;
>  
> @@ -708,6 +704,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	struct request_queue *q = disk->queue;
>  	struct blk_mq_tag_set *set = q->tag_set;
>  
> +	/* Make sure queue is not in the middle of being removed */
> +	if (!blk_queue_registered(q))
> +		return -ENOENT;
> +
>  	/*
>  	 * If the attribute needs to load a module, do it before freezing the
>  	 * queue to ensure that the module file can be read when the request

Shouldn't blk_queue_registered needs protection? For instance, I see here a race 
while queue is being removed from del_gendisk and at the same time elevator is
being updated from elv_iosched_store. BTW, I saw that your patch 19/24 adds that 
protection using disable_elv_switch before deleting disk (and so you may want to
fold this patch 11/24 into patch 19/24 ?) but with that also I foresee a thin race
window. I will comment on it while reviewing the patch 19/24.

Thanks,
--Nilay
