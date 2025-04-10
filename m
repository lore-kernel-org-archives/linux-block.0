Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC11EEA2D
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312082; cv=none; b=C6UDBSober/Z481nauH+VrkNs4vlpKGvIE7hqhW5P541yJu1qRvZuguRdgAARbkO5Mj/DF19fGdPgiIKzNUeeG9CWh6L4LdDiMEqIX3+Td8c18+UF644UgJBI9S2AK7/Snz8kRqQv25KHkVICS/gFqJd/v1YbsFo4S5xA7QDksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312082; c=relaxed/simple;
	bh=tw7z8HMWRHa9IUUpnCaEwjdPUO82JpgXgtywF82GTAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UK6Cn8v9bSzl5jPQn3/yO3w3K6kP4xNpWQ4xqtwRaeeLFl+NoMbw1DQBIy3WS7n007v2MWcrU2rsNPdLeusXjuxIKJHbeQTRKOPgBFeSFoT25c0HiB7VXrfpHt58HXQentNrYR44Oi3rs8Jed0WBUwxd0WMQABQoBod2vMrdFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N+SH1NKn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N+SH1NKn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AEASH4003383;
	Thu, 10 Apr 2025 19:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RNu3wK
	loR5xEuNuR/qpZ/8hEHHkZYBZrAmm2q6kuVOo=; b=N+SH1NKn+VpKIqeVzVsK4Y
	VdlABqngEFt2GaEGdwzNPSgCfoDlFixMmJoynQG307CrKkFf37Pkon2Xelhdt3IE
	G3C54BOdgLyNERYRDR8jULeEOWwDZ140myA11vy05zA3MUju5uf7Ks2sLcQx3d1w
	rnU6lpE8e63nwaXtLkXADUO+UQA5MRSr3gh8Abn1ByPeBtG20MEGR/UYUz0Cj9Ys
	9P++ewZIAWd5w/5JoybdvYH5vpVYv2fqyybHqZ1Gk3UqCi67vMStZAvCUbWd0bxG
	fwd360BD//ufVAHbtalh/yWoiHRrTeR7+o1rZOYT27idBtzOxTZkwlZP1+4lSDjg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0406ppr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 19:07:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG05OM011518;
	Thu, 10 Apr 2025 19:07:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yyq09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 19:07:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AJ7rtR12255922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 19:07:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8DC58054;
	Thu, 10 Apr 2025 19:07:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 155365805C;
	Thu, 10 Apr 2025 19:07:51 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 19:07:50 +0000 (GMT)
Message-ID: <567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com>
Date: Fri, 11 Apr 2025 00:37:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] block: remove several ->elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-14-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250410133029.2487054-14-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bQ5CDByL-jNrbD-QZOAaoCjf2vxlFsI2
X-Proofpoint-GUID: bQ5CDByL-jNrbD-QZOAaoCjf2vxlFsI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=852
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100137



On 4/10/25 7:00 PM, Ming Lei wrote:
> Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are only called
> from queue initialization or updating nr_hw_queues code, in which
> elevator switch can't happen any more.
> 
> So remove these ->elevator_lock uses.
> 
But what if blk_mq_map_swqueue runs in parallel, one context from
blk_mq_init_allocated_queue and another from blk_mq_update_nr_hw_queues?
It seems this is possible due to blk_mq_map_swqueue is invoked right
after queue is added in tag-set from blk_mq_init_allocated_queue.

Thanks,
--Nilay
