Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D8647
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745069188; cv=none; b=SHcasiU7lLpCtin8FinfVERGgX7a2um02Y0Tgff/Bjri6NAB4+QnCbvVU5Nr3OB7edti+wQSYyicbh+p6roTqrz1gT6FoN/K6JgOkm+zCch5kSpRv6aEmz56BvwKRoJTRycWcRIp6vrXdphwqai6Zu52idQN0AK4UM+e+mvvdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745069188; c=relaxed/simple;
	bh=u9qGKIiUYnVhhs90z6tb4K0EFxFbPf1lc2E4iEOliWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+hjKlR0nZNely/BhuDVTR8hZX8dtdFlpAwXbYBl+pNGagxYfs4rmK+WCqE5AjnFFY3qpsqUzU/21PFwYLtX26vbESE9Aj7R090l3Vc2pTBNvotEq6dKp+DvqeDhA7LPfnR2P1budXe3unDVwVoO11JOt1zPhyDgxLLZD1myMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=meNAZMB8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="meNAZMB8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J3V040015097;
	Sat, 19 Apr 2025 13:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g2DZpJ
	3mW8julGKl6HsYjv8qYmhoOMnZ/d53k9ma8Cw=; b=meNAZMB87QEY8pPORd5rJ6
	SZ/tc6bJ1kw/tSGQ1nXfxU4TNglJHnhTtrtP0bsHdD5WAHmeJMpQL3iKRusBLBCN
	UeJv5dvdXQAoZwwgq6pfBmyy7GDdrm7VG8NPkIO6EsPz+b8iRFHhNnOrzYOiVrVf
	iVfSQf+siTsXAtZvf9g1i/sD/xCVX3t/qbHNX4L25nSv8/1FUola30bZ16b8F62+
	REWkDF+HQBS8Ne4KGogS9xKHfb5GsMdS1zun0Ng2iA0RQFVAGQOvAsnthISlSmUx
	4/kXSFDtHmdKFgXsRfDl/Bt30DHLsaIAPSeir5o2CzRm8UiZ9kcKRRYu0U1FX64Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643jbsfm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:26:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JCuIIv005526;
	Sat, 19 Apr 2025 13:26:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4647kx0xvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:26:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JDQHrw28836530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 13:26:17 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1EC958059;
	Sat, 19 Apr 2025 13:26:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 938FA58058;
	Sat, 19 Apr 2025 13:26:15 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 13:26:15 +0000 (GMT)
Message-ID: <28d4f3b8-1e42-451e-9754-ebf639b05aa2@linux.ibm.com>
Date: Sat, 19 Apr 2025 18:56:14 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/20] block: unifying elevator change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-14-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-14-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X8VSKHTe c=1 sm=1 tr=0 ts=6803a47b cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=0VFDDhhmsKQ8DIBxT60A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vv5TfkJa194DRxt4Mv6E9DJnIUZDRTzQ
X-Proofpoint-ORIG-GUID: Vv5TfkJa194DRxt4Mv6E9DJnIUZDRTzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190107



On 4/18/25 10:06 PM, Ming Lei wrote:
> elevator change is one well-define behavior:
> 
> - tear down current elevator if it exists
> 
> - setup new elevator
> 
> It is supposed to cover any case for changing elevator by single
> internal API, typically the following cases:
> 
> - setup default elevator in add_disk()
> 
> - switch to none in del_disk()
> 
> - reset elevator in blk_mq_update_nr_hw_queues()
> 
> - switch elevator in sysfs `store` elevator attribute
> 
> This patch uses elevator_change() to cover all above cases:
> 
> - every elevator switch is serialized with each other: add_disk/del_disk/
> store elevator is serialized already, blk_mq_update_nr_hw_queues() uses
> srcu for syncing with the other three cases
> 
> - for both add_disk()/del_disk(), queue freeze works at atomic mode
> or has been froze, so the freeze in elevator_change() won't add extra
> delay
> 
> - `struct elev_change_ctx` instance holds any info for changing elevator
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-sysfs.c | 18 ++++-------
>  block/blk.h       |  5 ++-
>  block/elevator.c  | 81 ++++++++++++++++++++++++++---------------------
>  block/elevator.h  |  1 +
>  block/genhd.c     | 19 +----------
>  5 files changed, 55 insertions(+), 69 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index a2882751f0d2..58c50709bc14 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -869,14 +869,8 @@ int blk_register_queue(struct gendisk *disk)
>  	if (ret)
>  		goto out_unregister_ia_ranges;
>  
> +	elevator_set_default(q);
>  	mutex_lock(&q->elevator_lock);
> -	if (q->elevator) {
> -		ret = elv_register_queue(q, false);
> -		if (ret) {
> -			mutex_unlock(&q->elevator_lock);
> -			goto out_crypto_sysfs_unregister;
> -		}
> -	}
>  	wbt_enable_default(disk);
>  	mutex_unlock(&q->elevator_lock);
>  
[...]
[...]
>  /*
> diff --git a/block/genhd.c b/block/genhd.c
> index 86c3db5b9305..de227aa923ed 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -438,12 +438,6 @@ static int __add_disk_fwnode(struct gendisk_data *data)
>  		 */
>  		if (disk->fops->submit_bio || disk->fops->poll_bio)
>  			return -EINVAL;
> -
> -		/*
> -		 * Initialize the I/O scheduler code and pick a default one if
> -		 * needed.
> -		 */
> -		elevator_init_mq(disk->queue);
>  	} else {
>  		if (!disk->fops->submit_bio)
>  			return -EINVAL;
> @@ -587,11 +581,7 @@ static int __add_disk_fwnode(struct gendisk_data *data)
>  	if (disk->major == BLOCK_EXT_MAJOR)
>  		blk_free_ext_minor(disk->first_minor);
>  out_exit_elevator:
> -	if (disk->queue->elevator) {
> -		mutex_lock(&disk->queue->elevator_lock);
> -		elevator_exit(disk->queue);
> -		mutex_unlock(&disk->queue->elevator_lock);
> -	}
> +	elevator_set_none(disk->queue);
>  	return ret;
>  }
As we moved elevator init function (elevator_set_default) inside blk_register_queue, 
we probably now don't need label out_exit_elevator in __add_disk_fwnode. In fact,
no code in __add_disk_fwnode shall jump to this label.
I think, elevator_set_none may be called anytime after we see failure post 
blk_register_queue returns.
Thanks,
--Nilay 
