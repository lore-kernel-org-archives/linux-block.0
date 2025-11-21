Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C6346A06
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722024; cv=none; b=PJNwsG9+/j+qb5iPhBvrla9uElSytUV8AFb97Mccp05vXeokrL3uCtH0h54wTE+9o+ilA5sGcWIro4HNwcHr9+cTLpv26EDvuQiC1cmL/a5fRAewlmxDCWQ7y4qBpJ0xcgaJCkLSmq6MNAqQPRBnLwdp39n63e39Q/G7zKcoU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722024; c=relaxed/simple;
	bh=ZlK+iwdDfrexS5Y8UTAGEZzrs97uAoDsD+uF+L1vSSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=GFH7wP//alzSR2bPonDTxrmGKWnx/L22JdMI+Zn5veDKSyjyQe5pNtI/he7kUTOsvunuHfDea7wWZn075ogEucDgTfIr5t2lr6CwA4NZ1bZpWbud0B6I2Yzc2mL0HaafN36U7APaRiVeaGQuzRpdG7V1OGeRWS24I0oh3537wZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PmFpbA5s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PmFpbA5s"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL10Kjv003780;
	Fri, 21 Nov 2025 10:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k0Sz/G
	5Pdd2cuOn/DZTfdggAWZs+tcPAsoAqL3vf+w0=; b=PmFpbA5sAd75qzze0t/n6G
	oZDfiuiPtF9YlzPZlIpwpGlSHNWVKjv9Bw0o9JH9d42BYTQ9O/aujFM7VavQQ8X9
	cjez+/iFo9rg12SCA5xIXoTyI13mQkAPlI+xSuK1FD89dIhAT5vBTr1vuRIZW6kp
	36z1B4s6jNz5xVg/MWOuF6v35k5TpHBpU6ITQsWDOuY9BFCaq99cawDiDwzymm3M
	jrs3UWEn43MlondXJ/DCbfWJp/mDSLPxNK/lKfOZ8QY0KT0X4ReAcLfanKhMQq2p
	VjrH6zeo6eQPD6UTp+KFsoP5iJaMujsAG+DM4rMMnvyxpaYf/SpQfhmVwnsL3Kxg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju9tm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:46:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL9lims017318;
	Fri, 21 Nov 2025 10:46:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j23edu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:46:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALAkWH34981636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 10:46:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C97A58058;
	Fri, 21 Nov 2025 10:46:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 699D85805F;
	Fri, 21 Nov 2025 10:46:30 +0000 (GMT)
Received: from [9.61.88.15] (unknown [9.61.88.15])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 10:46:30 +0000 (GMT)
Message-ID: <010b72c0-b623-4f9f-b6de-267d5765960f@linux.ibm.com>
Date: Fri, 21 Nov 2025 16:16:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] blk-mq-debugfs: make
 blk_mq_debugfs_register_rqos() static
To: Yu Kuai <yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
 <20251121062829.1433332-4-yukuai@fnnas.com>
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251121062829.1433332-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SzdENuEtAokp_B_2DYJNJhTmeAQeAxLy
X-Proofpoint-ORIG-GUID: SzdENuEtAokp_B_2DYJNJhTmeAQeAxLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3QdcbRAJ9BmO
 5fF2w8MFUtgJGcd/Q8wXCHuGN3zdbQ958or5FAujgMq23ynnR9M19rQ3sdey8fHAUsJNo3yzyxP
 LMzh2IgAUmnVTCjO0G3/ISErKo3v7oim08LC5P1lYOVTaBbCbBecUI68Ta66vwmVeHKlUJ35r/U
 d7GEDDPniNABJIY78Plgtz3zKz1/xiIvO2sL4qpyu8UfsDICv5KblCxhDfE/WlhusHnipMYgXqA
 lCpxOHSReJCFo7cDyBrD2997Pght8Kb9YipH1MqONCEGiMGWJYpuBPwvtklaqkUmdo3xvpebZCx
 GEQ9V/4RvKjyVEMyylzTFsAKx8MfDfGK2++CrKzVAIllnq/l2obBfi69gyDnLikT65quE2kHW/d
 UrO9Q8AUOo+P3cMU0Wcqy2nbUyoIcw==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=69204317 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=3e9V9G4FY_kv0RvyeOkA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/21/25 11:58 AM, Yu Kuai wrote:
> Because it's only used inside blk-mq-debugfs.c now.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  block/blk-mq-debugfs.h | 5 -----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 128d2aa6a20d..99466595c0a4 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -14,6 +14,8 @@
>  #include "blk-mq-sched.h"
>  #include "blk-rq-qos.h"
>  
> +static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
> +
If you define blk_mq_debugfs_register_rqos() before it is invoked
by blk_mq_debugfs_register_rq_qos(), then this change becomes unnecessary
and can be avoided.

Thanks,
--Nilay
