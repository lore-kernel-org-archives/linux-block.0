Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCD15383A
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745066329; cv=none; b=F3vMI8EFWQmbntsrLoSoKgbSkNwPrZQfcSU8aIhLyYNUVsGGbVN2PsWp66sluG2jlLz+U3KxBd3mfaVOvGYb1jJXiRBawkeZvJpid6gmRMGiai1Ca5MzLVGvQRMkmOJ0mHm3EJekP4RrbJVJBBRwZVGXtySkdwJiV+ffp+i/eec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745066329; c=relaxed/simple;
	bh=ujOMY6D3mGzL9Wh0v/kz4VxzCyIgMCE/58Ps9/cBPlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv2hsuhZVYAku6HTTVRbhjVC7ZdbhswM3XJyoJdnRPNb9oIMKcJ2da1SukWsNiwnuNZUbOnSPRyCWeNmSW9I0L2jANujG9uh1Qg01LnQuv3BU1iVmYOpeLdwq4OU/k+ReQ778wA9JgcpP9cja8OY9Shlw8dyLq6z7wPfOBazOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLHW34mH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLHW34mH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAs5og016691;
	Sat, 19 Apr 2025 12:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XvMS6u
	AldUeiL+0nZ9cbiUAqFLvIUMfNPpK82c83bDA=; b=RLHW34mHCiVufZkKoPU+P0
	MrkgdYJsjuaMiEqCLNhEys2O2wzQ2cYadTUTyyett49qmvTyBqMOQRCZQt58+MRT
	jGIHRtiJxyAS5go1uDC74DHaevto5DNHqdMabdGIr99gYJ2LoTxWt10nKtr2j/ZF
	F/xSs/6qrVo7t++dwPfZx1ihWCC2Ut5vpBvIA+aZNewaQ+h+9hunr1CANnI2D87c
	EYAcWtrTLLPYOp+H00LrrdOJpnl3wuoogDU/ci3k350G3n62H0yC+EDVwzmiu2id
	zYjE1DtQdUaTbSyozWkwJNlyXv0CgDQuM1sNi9dRWQlNaa1rycNCsyWfSPU6Z1Sw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4649rj0cg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 12:38:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J7rXtU000901;
	Sat, 19 Apr 2025 12:38:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w0fkx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 12:38:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JCcXRL26804824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 12:38:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC72C5805B;
	Sat, 19 Apr 2025 12:38:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3F2A58058;
	Sat, 19 Apr 2025 12:38:31 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 12:38:31 +0000 (GMT)
Message-ID: <97eb54b7-25f1-4691-bbcb-6db18c7bd056@linux.ibm.com>
Date: Sat, 19 Apr 2025 18:08:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/20] block: move blk_unregister_queue() &
 device_del() after freeze wait
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-12-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U7hVrKzLnog_u5A7EmvRJk9qxbhCv_Cg
X-Proofpoint-GUID: U7hVrKzLnog_u5A7EmvRJk9qxbhCv_Cg
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=6803994c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=XLzEhEau88RLmSzP14cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190102



On 4/18/25 10:06 PM, Ming Lei wrote:
> Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> for unifying elevator switch.
> 
> This way is just fine, since bdev has been unhashed at the beginning of
> del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> with kobject & debugfs thing only.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/genhd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d22fdc0d5383..86c3db5b9305 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -749,8 +749,6 @@ static int __del_gendisk(struct gendisk_data *data)
>  		bdi_unregister(disk->bdi);
>  	}
>  
> -	blk_unregister_queue(disk);
> -
>  	kobject_put(disk->part0->bd_holder_dir);
>  	kobject_put(disk->slave_dir);
>  	disk->slave_dir = NULL;
> @@ -759,10 +757,12 @@ static int __del_gendisk(struct gendisk_data *data)
>  	disk->part0->bd_stamp = 0;
>  	sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
>  	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
> -	device_del(disk_to_dev(disk));
>  
>  	blk_mq_freeze_queue_wait(q);
>  
> +	blk_unregister_queue(disk);
> +	device_del(disk_to_dev(disk));
> +
>  	blk_throtl_cancel_bios(disk);
>  
>  	blk_sync_queue(q);
As we first freeze the queue and then enter blk_unregister_queue which 
deals with kobject/debufs, do we need to create memalloc GFP_NOIO scope
while running blk_unregister_queue? I see that device_del already defines
the GFP_NOIO scope. 

Thanks,
--Nilay



