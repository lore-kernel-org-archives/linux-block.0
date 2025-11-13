Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB0331A56
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023783; cv=none; b=fv4oRLCtpsj3Mhil9tIRebDYSbA75mCJLdMI1/iTKeGFsrMZ8AA19eOdTQQqpSjQF9tDe6jt7aVMxYNY9HPjmWn9hPheFAZgs0GRymwZZqUZND7q9N2KInPNB88RBAhL9ft8qKCZX27WDCDTv/0/dOZ9CVPp9scPKQY8DiAfMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023783; c=relaxed/simple;
	bh=WABqBvnf40xuNML8etL1KBAMBM0JbL6h/eVyMiTy6KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjs5BdIZ+YT9AdVeJcJbh5NT6VVlFTWNPGm7tCEzDeIsnmVQzEIOgwZKMyOfG9IXTwQT2udps/imCZczeajw6aFd16fSk0c4go3D844Lbu2pmZNyANaaJ1ZpLEyBzbQnw2d51jym6/2pILZyjnqncOBUsS7NUOJ3uRCT1pIOiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtY/EZaq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtY/EZaq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD82NBK002270;
	Thu, 13 Nov 2025 08:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KlIIQT
	60m62NZxWxSfb+RplrxBGZq3xEb+iIOrekQ6E=; b=qtY/EZaqVr+caUslo+7rK0
	wT6GN/erd0wmA8rfLKCdDEcH6nrXoEBmmduT1nS4fqZANygN2eeUthhyCPlsV2fg
	u2b3/fj4lyStmYtv1D4uytqliM+yUEFie+9waOP1stZKOw0eWrqO7EX8VXrKWxI3
	6r7JxBkhlCwVi8IalcGK3x5TVeEnZpFuXr0DvbnWOo3by7IORSpoE/Xm0+sjzPCy
	Lao5WZN2y9FVNmawQ+jLsr4icoKgKBNP05JOsBc0V8U+/HgBLtm/rHRSaezRdF6n
	9q9bD+4fT1Dyjx0ESyCEtjor6dfDg+mGnXEmyjgxR9Wv+E8WS5T1DLlvoN31nvmA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx5c7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:49:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4tdFp028880;
	Thu, 13 Nov 2025 08:49:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sn29d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:49:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD8mtfU36241884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:48:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 432305804B;
	Thu, 13 Nov 2025 08:49:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62DCD58065;
	Thu, 13 Nov 2025 08:49:06 +0000 (GMT)
Received: from [9.109.198.209] (unknown [9.109.198.209])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 08:49:06 +0000 (GMT)
Message-ID: <b2dbf740-f2a3-4451-8f44-e35c7173bdf4@linux.ibm.com>
Date: Thu, 13 Nov 2025 14:19:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 3/5] block: introduce alloc_sched_data and
 free_sched_data elevator methods
To: yukuai@fnnas.com, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, yi.zhang@redhat.com,
        czhong@redhat.com, gjoyce@ibm.com
References: <20251112132249.1791304-1-nilay@linux.ibm.com>
 <20251112132249.1791304-4-nilay@linux.ibm.com>
 <f4490af5-e198-4d30-84e2-f33c70935de7@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f4490af5-e198-4d30-84e2-f33c70935de7@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JQLzxVT9BngPa5EJ37luhwxV2nvVSkoS
X-Proofpoint-ORIG-GUID: JQLzxVT9BngPa5EJ37luhwxV2nvVSkoS
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69159b86 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VbHPKtdFqRduu5zKMNEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX09oCh73a61X8
 reX0iXuLmVH0sMTBEznI6CgcMdB4jMaAFKsGhl+qhIJ1IqC97DOHVhCWyRsRR3P2DZkkZ0Bwp6k
 v7Uyw2oVxUYLxAJaPza8fK3loom+hOebdXICZQjTR9gkgB3J6bvl/j4uV9Qr3iTZCszonWhc5gd
 NvUP/hX+ZY38Uf5G0FP/lAQkG+pdKpNt5I9RVUHbqj8fn1Cdymrj3J4L3aLhrgr31Q8Y+XfjBR+
 yEaSUGr/fuVp9PVmMmB+nGfPKv51aqd2I/FtB2WztKiYH0F9lkS4cPcB+j8mU3NiqEsUc7vMo7Q
 M9kVaUJs5cbG+uVgqLkqpuyzfxTG87pEOIJt447r6MRcQoiU7JRRXl4tt6F+ucf0Oo23s0HUTvN
 jqPQkvM0xgO/mZQCt55rWS18msot0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



On 11/13/25 12:05 PM, Yu Kuai wrote:
>> +/*
>> + * blk_mq_alloc_sched_data() - Allocates scheduler specific data
>> + * Returns:
>> + *         - Pointer to allocated data on success
>> + *         - &blk_mq_sched_data sentinel if no allocation needed
>> + *         - ERR_PTR(-ENOMEM) in case of failure
>> + */
>> +static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
>> +		struct elevator_type *e)
>> +{
>> +	void *sched_data;
>> +	static char blk_mq_sched_data;	/* act as a success sentinel */
>> +
>> +	if (!e || !e->ops.alloc_sched_data)
>> +		return &blk_mq_sched_data;
> Looks to me it's fine to return NULL here, if so, I don't like this
> hacky value. Otherwise LGTM.

Yeah, you’re right. The only reason I used a sentinel pointer was
to distinguish the “no allocation needed” case from an actual
allocation failure, since returning NULL can look like an error.
That said, given the context, returning NULL here would also work.
So I’ll update it accordingly.

Thanks,
--Nilay
