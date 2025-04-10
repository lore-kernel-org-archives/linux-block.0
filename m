Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A397293468
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312855; cv=none; b=tu16iIhDtat1/G7F2cTq5UAojDGsBus4OqS04k4P+7VngP85YXGZf9xnMOH+MRLevBdinukqZ5KosiD6/1MYBhYpQAqMCpX7GYFm13COTp3JMQfanks6NKM/W2Mp6NQ0q+x1I4IDPC26QL7+Dyv9X295dNWJjjbHgReh3JIcTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312855; c=relaxed/simple;
	bh=X/X63ItRzX69zndA70NxRdwonGXnGVVxEINumyGVu/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5XSM9XwN91AII5bSdVOvXkNdV3vuQm8pIoxDiW7lkec7YuOkV54opJtRDKERiHSEbX5qKhfllZSvPhRKq5x9m4x0uAb/+TJdviEKTYNOhcgutGm8WXfpD28yDJf1JBEJ5t2bXlDDOBJ67Hb7fXbieHeQq8F1zhgK07nzf1gp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BLqW1BtK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BLqW1BtK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AE3N1T010720;
	Thu, 10 Apr 2025 19:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zTlzU5
	tHER5KWMmlkOGI+Mgwf7sRVHzqlk7ozJpeDmk=; b=BLqW1BtKkS91XOtplfhkKO
	cOPpJQGw5QAa7DNRj1H+/3ymc9xVrW0DZyFyjVJ591RW0Y8eHc5IGJ9BZ+iJgssd
	FKZGqmM6x6CT4/z8H7hhVriU2Pej1sSXCFqvM+/p2PnYT5zfUeMVIjnTwwvESfzP
	8hpzW4C3xNuloTqtqFQP/T67dubiFuDRZGKPdLp7ZGw6F+/IY84CZXswQKiusXBW
	3K33xtPEm3mIDTaRtqOuTkBn5xDd+IHJ2vztq5ucbwfYGDtuzOXFHALWpFwEi3if
	EnzfXO716yIkek4DfBCJqvQ/A2b1rpwUo/tVUx4IgEKm0sXjdFcT4PbbT08cMRzw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xfdqhraf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 19:20:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AIKacD029517;
	Thu, 10 Apr 2025 19:20:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k75fas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 19:20:46 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AJKj3F23003708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 19:20:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4365805A;
	Thu, 10 Apr 2025 19:20:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 666CF5805C;
	Thu, 10 Apr 2025 19:20:43 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 19:20:43 +0000 (GMT)
Message-ID: <d3f8673e-682f-41a2-bcae-d256e3b26746@linux.ibm.com>
Date: Fri, 11 Apr 2025 00:50:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] block: move wbt_enable_default() out of queue
 freezing from scheduler's ->exit()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-16-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250410133029.2487054-16-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T2zOuOD9_w8--fjbLpvCdLjHOk3K46WA
X-Proofpoint-ORIG-GUID: T2zOuOD9_w8--fjbLpvCdLjHOk3K46WA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100133



On 4/10/25 7:00 PM, Ming Lei wrote:
> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
> wbt_enable_default() can't be called with queue frozen, otherwise the
> following lockdep warning is triggered:
> 
> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> 	#2 (fs_reclaim){+.+.}-{0:0}:
> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
> 
> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
> call it from elevator_change_done().

[...]

> diff --git a/block/elevator.c b/block/elevator.c
> index 1cc640a9db3e..9cf78db4d6a4 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -676,8 +676,13 @@ int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
>  	int ret = 0;
>  
>  	if (ctx->old) {
> +		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
> +				&ctx->old->flags);
> +
>  		elv_unregister_queue(q, ctx->old);
>  		kobject_put(&ctx->old->kobj);
> +		if (enable_wbt)
> +			wbt_enable_default(q->disk);
>  	}
wbt_enable_default is also called from ioc_qos_write and blk_register_queue 
with ->elevator_lock protection. So avoiding protection here doesn't seem
correct.

Thanks,
--Nilay
