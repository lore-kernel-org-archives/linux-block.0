Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764C24BC10
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586667; cv=none; b=eDam2ZtkqajDoqFOOGgPx/JcNC7EPFMJAGtvh7dBYWSNFS7P9JZT52TD4EOCNZDYMkRZiJsXn0qFrH+9FUST+OGokUZpkbekQms7ElRdCq0s35TYkDzZ1SR9zQoVIOEYgo5QqdWSSV/V3+SaNmaWs51vyK/VvcBUr3j8N0UvKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586667; c=relaxed/simple;
	bh=3N9E2prn0qcL54+15ca1Az8tEo6s1ExRRAAxD+4HuVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEVpeBhrLRBjYUS6TFt9rCzvl9NtEGeBWygSw5nsHgxt+xFUx+jU4P2wP//P/xw2SaRGkHMO8fYIU5dF7GAUtKHfxz7b+JiIlejEF/NnzclTMY/4xK0PKZchNLSMtNPJXfeLkAosfJSPWvTcR6se7soBDxumuIRhmMkqjaHeN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuO7WbR5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuO7WbR5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAehik022707;
	Fri, 25 Apr 2025 13:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qt3gZM
	Etlx09J2dxIWgYsk+TYyNIUua91hZy3B282O8=; b=FuO7WbR5HIIK+Kqsew6Aw8
	aPxUZNcrCDnV4+zomXUbtxpqDCCDWT1ndDS9oPvEmhH4EnSvOgUbw7za0qn1dC37
	wiODUjMELjm2BHgc1+zXV2/h07+g26P8Ivls1cDXMLiOM0BOf3eHZmuPfCSCfexj
	VvZnAc6Jkseda1xYfUjiTRJgt9ELGgGzJzhOZ8BiHn7nqtUYxxdv2DiH5nU1jQLy
	pAVX21GTc2e1iKSBWl0DeEIexLsI5PJRZ41OvTvcCN3dG3r0+xFAcB1e+Lk83pQR
	B41T/hd/TwVw0bGDmPQ96spff5mTvratTyApy1oY071yUnf/nTe1dZR3J+ZRAT9A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688usgkwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 13:10:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCDQvl005861;
	Fri, 25 Apr 2025 13:10:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxn9rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 13:10:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PDAml810093302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 13:10:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67BA158058;
	Fri, 25 Apr 2025 13:10:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE3F158059;
	Fri, 25 Apr 2025 13:10:45 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 13:10:45 +0000 (GMT)
Message-ID: <c595b0bb-4d01-49f4-ae62-9da45e194839@linux.ibm.com>
Date: Fri, 25 Apr 2025 18:40:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-21-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-21-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=680b89d9 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=gI2BpVEeF5L0_ZfhzhMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5NCBTYWx0ZWRfX8ABsaGhjQY7A p8/K2VVUohtjD/fazxB5ctcvcuygUG6hkgg3CxbyGk5s8VvzmCTtv5FrX1skIicqLHPSlOfAugF OckNcCNkG3/zVe4VtehACStujRRcrTuOcPvovnox5dsgemi/9J/bZVU2IFxGr8dYvFC5szzNG+q
 1D26Uquzg5IKBdyG7ZSh5o9eoQWbXN5Nh45yl1qXjPW5jWYmMyJ/ve403t6ws+HGEtpAY8exNgj Vo/368a8dAHxbfZTaX9z3n088wZl+w9h0DMXXqRU7tgw7OcmNbKLP+4Zg/drruK3HswzO7vV8pn cPPtyLPiysP5QHe68ul7k89I9asR2bYZBQb93NzLVhtQ8ex1tboVQA4dSWXdpq+YpQ+bEkEH/gh
 CxbshiNwYri191ZyWakT4G/JhWWnQA2w6Bv2cuzdMTquSF0CzM5uv3HNTAXkE2598TXJA0yk
X-Proofpoint-ORIG-GUID: 0XEDroFzj7abyXx7nvC72P5hNwLcpleI
X-Proofpoint-GUID: 0XEDroFzj7abyXx7nvC72P5hNwLcpleI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250094



On 4/24/25 8:51 PM, Ming Lei wrote:
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
> 
> Meantime add disk->rqos_state_mutex for covering wbt state change, which
> matches the purpose more than ->elevator_lock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
