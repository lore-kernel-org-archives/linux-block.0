Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3721A447
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095322; cv=none; b=ekGb6m3dYYjmsCR8h+KXp/3eYqNsvDuZ9ECWPCJW+ghiVQEQWwL/iC3Ju11wx+WHpBTAW4JXxzxuIsHy+l7scyuFDev/66Zl11y6mEDM65k312Sb4JmCYv/Rg2w6xzy1HFQ7fSmt/3gnM/zmLlSXNEaNdPtiiNl1NE8VX9gGyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095322; c=relaxed/simple;
	bh=EYsSjizv3w9ABb/iwr41+vLdqGtnMie8z7iuiF6u11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlFpGhPm7LauLkhVbE5Tq9K1Qet02/Ajx2y0Yh43mW+fY3mc3d/jHEH2FZIu1Lowtss57tKpUrtUFNorFace9TpGNvv/4BFc94bPPrhhfPPdZiDv/BbMlQlPqr1mMbJTVH3x74Mi/wc1TvjMCdSbrIuP+o49VU9qtScRL3MTDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VjyOr5um; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VjyOr5um"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541A3wHL000738;
	Thu, 1 May 2025 10:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tdfSkh
	mANeiVkDdOC4Fy/QpjzprAYoiHR96SX3FAlSI=; b=VjyOr5umUKa9iImoEqZ+hb
	BofSvzB3JLkrqbXlfyPCGKsLBzxxOtxUjjgUJ2YDsG1tt4U56Go51Fit0VAi10Pe
	dXDUUhTfPU8w71k/FCcYSNzd3XdDrVEpiXqXahV7UQHV3gmxXkiUFvh2lEkAzXad
	nerSOU/qSNWzLb/7m78B7jlBzS5JdJFTJEp2w7FusCEMDiSzDx36XMAK7TOr/QUu
	Iqu7s3/ODuKmTyJs8ROrEB6AesycMM2VqLZSMQ1ixf+6QYI/VekZk7wjgIzylBIQ
	upd8PU8Xv+g95pKP/jeDMiI12JhfS4gAge2eKAHmTLHVdKIQAClc8D57MZ/eUWUw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46c6vjg26n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:28:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 541AQUvd024634;
	Thu, 1 May 2025 10:28:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1mc3x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:28:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 541AST9i66126144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 10:28:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6A558056;
	Thu,  1 May 2025 10:28:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B5558052;
	Thu,  1 May 2025 10:28:26 +0000 (GMT)
Received: from [9.43.8.50] (unknown [9.43.8.50])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 10:28:26 +0000 (GMT)
Message-ID: <06aa7604-bf57-421c-8906-bc4162e665cd@linux.ibm.com>
Date: Thu, 1 May 2025 15:58:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 15/24] block: unifying elevator change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-16-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250430043529.1950194-16-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3NyBTYWx0ZWRfXzyCBsaA7zCAA FXhDtmXS0dfbgWFyA09A7yrzbS00QWSQIBRBgYv5lG6AMAJtOUB+bgHURD71CqOu8ox07varbyF RdgIk4prxjh94YgIDPEMrVvl8vXJePUWpe5cYKbUVMOnH3K/xcbi8rwIyKluniV4C6/QpTL/E2Z
 uXdBec3a47/GzLImAQjvVOzqUM32ZTO+MnJjTzYEDnh0DmXNylyr522aM6r2vkSUPs1Q0sbxvSj 7ZQ67i/2w0cJjYMr6Rg4RfQbPAiyK1nfgSGOzRkE/4w/d5BhgWBESWoencCU0VDGlxb2BBoUMYV 8B0bk3YyRnDLv0YiZlGpvNVlWZe+bCC2go3BD/qzXty6Tgpoq+upVb+m3ofbeH0ZbWLsXnvE9TV
 Vsg0tNw4iUT7nZCwAqeGilIPOQ45AnVp/7JKcG937PVZeHTbFoxlw5hwokgXtnhbdFtS1pIG
X-Authority-Analysis: v=2.4 cv=GI8IEvNK c=1 sm=1 tr=0 ts=68134ccf cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=RyKiTIznjPsxi7qa8aUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GnGjNbvotHjEmLIFR9Sy5_U8ZCJlwmZo
X-Proofpoint-ORIG-GUID: GnGjNbvotHjEmLIFR9Sy5_U8ZCJlwmZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010077



On 4/30/25 10:05 AM, Ming Lei wrote:
> Elevator change is one well-define behavior:
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
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
