Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B761A316A
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513386; cv=none; b=huKd7skd4iS8PtSpbE74JyVIm2ic5oRfyWBO+XeX4fAT03CtoFj4XWExraA+/6fIIKS4TP5QgqDbzI9tZbOAXYksJxbniAQrJBOnyoX7vXnq33yy607gSXkyw32ofVaHZuMtOp+wBa0XIksBFJoq/b46Z7J49B2ZlCbfa26e+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513386; c=relaxed/simple;
	bh=IFBGRnKBpN49Se0HZ/69gVNyuL8ahsfqWo2RTRcLF0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGcorj9VKutnfooHoOCLK7Eu+SMwasUIwnSmQewTAOHWbF2CmwOysp4YYVlxMKnGsKBH2ZVEA5bmI70jehjeK+oRYITjHAe6SBHppZZ2OPL7leNkpm1GeXRqEwv9MG0w7f/gxbmk/XG2XEspHpyz+5Qi0C/A9urDU1mIoyWRo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P5nExNQt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P5nExNQt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L3GSd017998;
	Tue, 6 May 2025 06:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eP+2fv
	HYoFLnZb2lKQHZmPwQsF38tVStqekuS8Xwv0E=; b=P5nExNQtDO89peI/Q8HxZR
	CcSi0Qi60W5ixd/B1vrRA+vmI+qQp1YZ4aSqdvrmZZQmuvgq/Hn5ieWcjdlse48m
	UVGRFUZr2jPUQCrDwpgCPDBODYFSmdOol2sJ3Eu5sdakA8RJByVG3pSy7PjsAIqB
	o89pKe9jqAePXfeZ9r4U+QOOUU/hW26HNXLBg86p3FS69CiyfSMWil1m5cZnuDLU
	r2X//Y56SMr8oI7Trj9THDQjJ7opB4j3kozxORpVfu9XPRyXuQAQ4PCux7D7m+hx
	ibEKObp4BS5RgI8EMdAxmSjzRZOagRyJmoug3oiRyXOYeDOfDGVFaFHxjZLK3Djg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f4wkhr1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:36:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5463w8aT025798;
	Tue, 6 May 2025 06:36:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyt9ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:36:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5466aD9K63373744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 06:36:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 579765806D;
	Tue,  6 May 2025 06:36:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D91645805E;
	Tue,  6 May 2025 06:36:10 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 06:36:10 +0000 (GMT)
Message-ID: <de283dfa-b72c-456b-9809-7ba62fb2d4be@linux.ibm.com>
Date: Tue, 6 May 2025 12:06:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 21/25] block: move elv_register[unregister]_queue out
 of elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
 <20250505141805.2751237-22-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250505141805.2751237-22-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Up9jN/wB c=1 sm=1 tr=0 ts=6819addf cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=H82auua0CvPxHtOQ3OUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OwR_bHb_Wvy8c9fuiqwl5yHQ_UtY_XJp
X-Proofpoint-GUID: OwR_bHb_Wvy8c9fuiqwl5yHQ_UtY_XJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2MSBTYWx0ZWRfX8qgXW+GteIvI Q9Gn9NEKsTg+g7/kaiv5EIPfKxJCODcozS/NhtrAHmM9f3A2ANGOLDuRRvIaXTtfVFFhUPNl2Lo fFKll2rDM2VgiZc6Jvody2axReWkCRmkHsyxkOyQ7NgF42RRsJAKFPVOYep3WBqBg4ISml67HUK
 h1xSGQuo85DK+CxSTCgzVA0HCZcUGmH/MKX5SjgX5/kKXtnA//7WmR+Ahc3mPt+2Xdp+2Ddxf0v Xx17sjIgqOL4hNRmp8fQfHBIYkwXXSVqX3vigyC30GX3pjeUk80FHxptduqM4ceMPt/LROFY1ZK JrYaVrADBkBFdGOlgZmCvLGTtTuCd0zWgUc0CzMW93IpQuAlWQ2hcRgC7UTgrX2xxpfllAXckTV
 JKwy6yGFihFWxMjYzaBdvNLfjvE0A88zZFxZxAtibxJZiCFqQWW9GjIkn6B/sQuc5J0F2VFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060061



On 5/5/25 7:47 PM, Ming Lei wrote:
> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> so we can kill many lockdep warnings.
> 
> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> debugfs things, no need to be done with queue frozen:
> 
> - when it is called from adding disk, elevator switch isn't possible
>   because ->queue_kobj isn't added yet
> 
> - when it is called from deleting disk, disable_elv_switch() is
>   responsible for preventing new elevator switch and draining old
>   elevator switch.
> 
> - when it is called from blk_mq_update_nr_hw_queues(), adding/removing
>   disk and elevator switch can't be allowed or in-progress
> 
> With this change, elevator's ->exit() is called before calling
> elv_unregister_queue, then user may call into ->show()/store() of elevator's
> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> 
> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> there isn't such issue.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
