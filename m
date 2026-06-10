Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7EC2D9787
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076518; cv=none; b=G1Uezr/bYtcUPRqXOqxbMA+uD+uHrWCLUfRm5BbgxZbzyLmSAWRKJvbMzNq5oRYxwQkfptkrXWugyFOGnukcGyc77P026haN8ygkZ54Dk4MVdezNTUfJV6+LVbKdo1TtGyB4hq1D/QQWwjRelNQOKQkLM36WowSYyfIvCBwJS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076518; c=relaxed/simple;
	bh=zR2CpRBE8uqB+148RiY88lhFlrMpiUDuwfcf62SEo1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kjb3137VeR+arUUGXa8iKFVE5YvzhGRcJe9dwr57W3GHiTMdyhnq/ifKIMzjQLc1VR6TUvifv38zMnki6S6t3NSbppOhjdqMsEdp6jKKhay4ScHLA038OdKB1b46dYGQPEE53ZWn3Ab1HNOBaEMdVXyKlxa/ueBiZG7+r7o6MgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lm6rVkBF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lm6rVkBF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659IWXfM3398572;
	Wed, 10 Jun 2026 07:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ankVWJ
	aX/HuXXQzpo01Nk7fS3MBXJyvpxkZu+IJAc+k=; b=lm6rVkBFmbMx4pr/4e/Jlc
	aHNdtRvtHKc3YJMKbQXalqUMBGTaRNje0C9/hr0AS9GOghc4PBemuBD7cYhrnGNe
	soplX8+KA09GL/cQ9369lwv2siX/IEy48re+3OOyVQ4v4B+GMDtuoidhyJmMX2ev
	95karKK6NZaki0z8EQ0RKZMqlgWgcfpcE50Us1VIb/VTQdirr0b2KLkZ7JKvUqgZ
	+CFsBOun9PcHQy8CrSrLyND7GR+H6TvwgWP0gtcQ3Q1OGqA6JQQl3iGxjjTpPZqt
	MzXFvLaEToM6UZv2F/ZQt2tKP4lV+D9onQ8AaVdoAy7o8gH18Ju1pbsdJO7C3edA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qr08c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 07:28:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A7Jm3E024507;
	Wed, 10 Jun 2026 07:28:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych5hdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 07:28:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A7RbH021234212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 07:27:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD73458056;
	Wed, 10 Jun 2026 07:28:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E636D58052;
	Wed, 10 Jun 2026 07:28:04 +0000 (GMT)
Received: from [9.43.34.89] (unknown [9.43.34.89])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 07:28:04 +0000 (GMT)
Message-ID: <c8d3607c-7854-4723-9f68-2425066beead@linux.ibm.com>
Date: Wed, 10 Jun 2026 12:58:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] null_blk: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Marco Elver <elver@google.com>, Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>, Kees Cook <kees@kernel.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a29120a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=N54-gffFAAAA:8
 a=VnNF1IyMAAAA:8 a=clIS_Zq-ZQfnoPMRsucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jn_tT_VEQaV1g58aocUyLu78AeZ6w6Lp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA2NSBTYWx0ZWRfX/+Qg6iJINCJu
 y4r2Q3sB5wA5wH9+dWfzRkl/06GRS/gYjnT4p7RNFRMiYrRfBlE/CDVxsis2B35hLfBAWFKKDOn
 wZgdnmQGfImlzHSzYTHuifuHN247xxT17uPk5hfJS5a+X2IhKDiItM3/Vj2Yc0qI6ZAzUFzx+Ww
 y8RN4bt078Lug7Uu1Tms9PteC63SIpOQ1IEg0XWcLoIq2l59CYIGCmf1KURadTxoRafWBIemvhI
 QaC1nhFgw4o/cpmVJgygfRqw5L2FQJEchbyL4RL8xhgNR12vwZaBjCS9vbYrpSFKPKVNNSGVKYc
 5bvFhMqd6tFBleP2LmiA9IS8DcPBwskzwhCBGfHULHKw180PMhgRYp3Va7LcWN/zU/r7AvSxUPZ
 xga+LD3UjBi+bngfiZw0TQLu6q9xml+pEEcLNl+dXin7eQhw8lclqziz2FHm/ENKYSu+jXn2Wzh
 cUx2rV1Rxg+JXOeh4jA==
X-Proofpoint-ORIG-GUID: DTxs39tfNDZ-x-W4m6Z0IbNKtMokjwBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100065

On 6/10/26 3:35 AM, Bart Van Assche wrote:
> Add __must_hold() annotations where these are missing. Annotate two
> functions that use conditional locking with __context_unsafe(). Enable lock
> context analysis in the Makefile.
> 
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> ---
Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
