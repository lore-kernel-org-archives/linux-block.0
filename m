Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403412FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544725; cv=none; b=bx/gw2QP1qu3iiaQ6+XTm/jumjSC0Lk/pjW6IOaMWVEMQqRubyMXIoKobglSsdgjT4dHGnyaknXR/3nmpM+QftM6DxYWkURTx9BTmwE7Nr8b1e/EW5NCEeS6P5qZ31vPfuVjAYTR9SY/dmAIvXPqINBvLk8JhdIHHPDC5jn2aZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544725; c=relaxed/simple;
	bh=NgogtSB8QWe7SsEauyIPF2/v8ThW3ASaMOjEc/ztyvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cdpVRkXc6UDv2e9jDKj89ta3EaXGjiNwwu+S1s8ZuHpHbGPExyZ6aL2dPsQeqsFSDUc8m+UXIo8keSOMBuWmt0jjWUW6kXw4oT0GnKecMg89/6yF9UYUvq1HqeUqpyc9l5dG4mi7v6nL+dCGvdtrZqOoJ5TxOvbnZWI+o5QFbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KuQDZWw3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KuQDZWw3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604707Am011523;
	Sun, 4 Jan 2026 16:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3vIJVa
	+c4Me7A0KNxgO8HY6eoemSJgztA/bvsZEeMOw=; b=KuQDZWw3OYzPOIyLRLmmpd
	fL9OlZjHof66o+RpRQJj4ezmRVvNBNVXsrsOCBoKIsnAddq1UT+olQdPv/o7DmML
	U9GNneP6oLYzQiTsXNRTvM+0Va+R03LvCBC9OgyxEgs8bOo3LYyADQBw5z12ofPY
	5ek1yAZpBKe/fGcBxo2Ogl1hSUyncWzJwkwvdvkma7bbppTSBN+EQPc6gxER5YPa
	w4geSQWNjZUaVKyW2e5n4o8h90sdhQg9A87AF4zA2OmFiSZunstfKND31y3TRMCp
	XAJOFvg+AZAch+gPR8ByzvEZjUV9JnwX9ilt5TCofH/EIim1G2e3uIv1ilX5Y/nQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5v3xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:38:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604EueLG005274;
	Sun, 4 Jan 2026 16:38:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexjt0tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:38:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GcAhY14942732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:38:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAE4558053;
	Sun,  4 Jan 2026 16:38:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8109158043;
	Sun,  4 Jan 2026 16:38:25 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:38:25 +0000 (GMT)
Message-ID: <e841a29d-e2f7-4328-9d3b-e2e8bd9d3bb1@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:08:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] blk-mq-debugfs: warn about possible deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-9-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-9-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695a9785 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=7Y_5505qTC2uMQweyC4A:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: kq2jJKXEEdrHn5iXB6ZN7usQCU_HCKQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX9GcnuYOSBz4Q
 x9d5cYeWLyyGuPkbWenZvUaw+4lHyCrgge+5+9pdi+WNOrBjNlh6z9ekTMt8u0BB472mhDctS7F
 3tFa8RTw7qNsy+7/hSYxM8iecqb2O5ATsq/BPO/rG6CCjFIamOuXwM1Xt/oZ2VvgzV1ZqLupKKb
 GV32TmXP6v5TjCV/fBqaOmevt4LyZnjzLAZmSww8b6umdd8Gv0m+bR+sQzRVz3cPHxaH4pFN9jW
 4smmlxK3dsOZF5iqO/2KSBkO+AZwh4NN9KvlUPpg75hPaAKHMlXN/oZ1JimIuDv3KPrDQxB8Cya
 vAPDxiXRBYaFrDogZBTTcw+rz4LVLtuyxuaTX/MQd17UwFjrEmML9NWHUusnbu+9nDPkH6CBTVB
 022XOhQ4YYoZs+DWG5b0plQ6d/oh63vp7OGURlDla9oSutCMZT+2FLqXxRSTCOvshKTguuuajw3
 5gTYSHTmkA68WuAeVlQ==
X-Proofpoint-GUID: kq2jJKXEEdrHn5iXB6ZN7usQCU_HCKQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> Creating new debugfs entries can trigger fs reclaim, hence we can't do
> this with queue frozen, meanwhile, other locks that can be held while
> queue is frozen should not be held as well.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
