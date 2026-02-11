Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAC2C0F69
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794594; cv=none; b=ozZUMs8CRl0Rw/Ii9Fj++06zDKkud7PMla79O9Hz2DZsjQpmOwPmAbSyh99BEllE+awh5zm/NE5rG8a+A/RJeTgXnelfcPWsVMvheGujj3Vq4XwfNfwY4jfmkScaZXFBdMDBBfz9HgH/fZs9JkEfrRkbRZiWqM6BsPlfN5BBc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794594; c=relaxed/simple;
	bh=91WwRyjFJunvmYThvRRh6utZhXKXYEEWIKOeEQ7IcM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANOdK3KYoTa21M3xq5s+WXYpOT9sUNOzMs2ERbORzhpJTFHNzrdeKsnGCt1p6LCQZhPoocn+oV8Wj/wHifYzT3MLAxIy248C2jwa3BvGUz3ls3F6/55zQ4Yjjihwh5cyE65mF5SaqkRZiw/lL89GBbKNxYtZd8rc87cXFSLu0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p1QwC9B7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p1QwC9B7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AMKF55397449;
	Wed, 11 Feb 2026 07:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DEmcRV
	Snp49021txy4iu1RoFcUOhQ4Kp+IxBbTWsnCU=; b=p1QwC9B777F2qHuEn3RgRP
	PdpAxa5QIXFgGe3Sf1EpG1ccmZ1J61X53ihFyHHJYoz0m2AdAA46cftE1/VXL3nA
	LF5mcHoE57ytrwxW1xNZkZCcLqPbnnOFmZqVcWLRWOvJ6lc9e97iTuP68ZALvqjY
	iw1+8CqV96W7v0Q4VIF7XenCqZZ13yOVP4by6x8/tzfnir7xcmhx07uQvnbulHLM
	nE9/b860GGDuPMTM6YBnn6fSKiA5DSp3oPiyhPaxbkl3yEAE+H46NA4ZUz0vptag
	qFUkXyqDIOVM5Wv1pfZe1Xo6SBvBjLiVK7zM9atblw/8mTtrxNQdfQxWyin0zfzg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w816e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:22:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B4xZY4012611;
	Wed, 11 Feb 2026 07:22:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kcqpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:22:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61B7Mh8228967640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 07:22:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0485805E;
	Wed, 11 Feb 2026 07:22:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAEBF5805C;
	Wed, 11 Feb 2026 07:22:36 +0000 (GMT)
Received: from [9.111.95.190] (unknown [9.111.95.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 07:22:36 +0000 (GMT)
Message-ID: <5bfbb122-d073-4a5d-b955-74a1570b3649@linux.ibm.com>
Date: Wed, 11 Feb 2026 12:52:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, sven@kernel.org, j@jannau.net,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: tj@kernel.org, ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-3-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260209082953.3053721-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698c2e45 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8
 a=MQnJZRgATxulN8aL5nkA:9 a=QEXdDO2ut3YA:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: gpacypDhKfnPoV9UQLZ8GXzWzREFdbR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1OCBTYWx0ZWRfX983Q80k7vKem
 3ah7oBaHX/DwaAWA1Mhm/hzRJd+sPt6udeXt6uhAlLer4hkf1ihp/6u5Alum8+HxWit/gd2U8Gy
 cp0cQLoqFkaz1BIYssb9i2GEsWkhQSgp9AVHwL3DMd1xyjfmXbh8fRkwKfTKSwBvzEG7UfP+5vy
 SrcpSq8vkTUne2SiuxVms14eNya10JsE1GDU40T1V5VoO+/71j2rR5DlmDd7jDTVK8aSmoOSHyi
 k6fQiHRHzg9epX02QL6zPva7R9GcLu7xri1JyDDd6VmjLB9scEcZXIb2mu/KKjNKf2hX1oZMLhq
 0a9PKCnFtIHegXp4UpqwQjUlmpBWFfGP19lGN8qNYimS1MCrOhzUCvsCILdQzE5vWPz3xdETVas
 O/0Gp4JGFN7GnUlgqJG2iHDuiLel0KMfmD7HDSxlIYVaxPF8rTHNVxcW98v+NmimIl/OLdwfCX7
 j87Oxn5MOFP3DS7Vu/Q==
X-Proofpoint-ORIG-GUID: gpacypDhKfnPoV9UQLZ8GXzWzREFdbR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110058



On 2/9/26 1:59 PM, Yu Kuai wrote:
> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> When the queue is already frozen before this call, the freeze depth
> becomes 2. The internal unfreeze only decrements it to 1, leaving the
> queue still frozen when debugfs_create_files() is called.
> 
> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> debugfs_create_files() and risks deadlock.
> 
> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> so the queue is unfrozen before the call, allowing the internal
> freeze/unfreeze to work correctly.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
