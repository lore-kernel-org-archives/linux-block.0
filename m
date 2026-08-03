Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342430D40B
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766961; cv=none; b=ABM9/gsGfwAFDS2vsaAIbncUHveyn+BCpJMH9B8arOnjOOIUeYjk+2hnvn9vJbYUlXv7egjgyRZ9/c5soTLReMWwWPNiPY2/JbY8aowmuw59juaewyl3xAIjqh3/gss6ta89X7ZCQxdESCHr30WeJ4UwadXVPgXhOBSbutlcAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766961; c=relaxed/simple;
	bh=YtaZwWJqS5CvG+wONyrzaRAjQm4+TRuNrXngMlAeyqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7PyDl7GggCXz72rZVASbaiXALxJTorX0dSjd0oyMg1dua7Ehe1kaHfT/qOlntEcYol2kL+DFERUNJIZCLQVv4tpqdX2lUX4LbzhMGFi2A8IdodIqgATRsTb5csQ5lRdlXLdWQYdSRNMRH1VbYJPxM6tDvUFye91tYb4fOIRe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jCT8PIWq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jCT8PIWq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHUNv2282268;
	Mon, 3 Aug 2026 14:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pHTthZ
	uBE7ZME7wvxEg49fsTuqtRmbomuOOg/QiuW+4=; b=jCT8PIWqQo2u6QidV1HPvi
	FyI1EuIljBRvS8TY2GPHcaXfLWKQc8jqrr7jxJRs0q6FrKx4oPcvtTltjGcyseDH
	69d3bNn7P9qjSjjmdZbfqxWSrvLtS/lUYVYONps+xOKExsqCGrElxJvE4kIkUJo/
	j4H6kCVqV1lz02CFoWikkgi8vAVecUOzDXdQf3ocHoXNqz3dhNz9glZ4Nl8rGdR/
	85JrBv5kEjmmgU1tZW+3ajficD5qKT1aExlO1QJ0mos01wbTCByXG/Y9cptOkS3N
	rI9IJ53uv+jjAOgNlqUh/pv4aVMZ/BuF3/vw2uWU3nTaaRJ9ZWuvuZqHa2gM8BgQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4s7ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:22:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EDMJd029815;
	Mon, 3 Aug 2026 14:22:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jwrs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:22:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673EMSw023265950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:22:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141B958054;
	Mon,  3 Aug 2026 14:22:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97B858045;
	Mon,  3 Aug 2026 14:22:25 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:22:25 +0000 (GMT)
Message-ID: <04fd9f6d-9032-4833-becd-5465c3b2b95e@linux.ibm.com>
Date: Mon, 3 Aug 2026 19:52:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Enable lock context analysis in drivers/block/
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>
References: <cover.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX/cwuUH3wi6Ct
 mjbw1dTvvv5TvCJebvlTCqlvz9u3rwKzO8PnPc9g8oJ4y/jpdFu8GrcaOhP/+Q9YmAKBSU6QsRn
 4BUZX80mzGD2T5nfZbHc/qPnWC5+010=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyOCBTYWx0ZWRfX5ItENMUCyYKZ
 urGZ6kmbKNrA19usaLJX+C+TDR33enmKLuHlCJIbB1JPhj5r1KIKZgHG/ZXndY0cnNoCOTb1TmK
 7Ni7mh6Cne2TLr8orQjlt4Dk2kGbcOAvAI5ucjYIiFp+j5LPAvVohWlmtJ9T0VgkU7U+g1n/snA
 3pz+vGa4WFtTutinrzDbRHlxgg+zG6n6V3mu/acydr/TyUXzJBrSIVjgVDpnr6E+m4tZUOLqWRB
 rM0SL+P13qApkfNnAQRQpLQeKfRYqFnbbe8xmNth467l1M9lgEABcKMJCMSn27Ix3nku0qSJs5n
 oRQgY5IJv3ELXAe4NrFT5rB912YP0M4nQ/O6Pckov+chSqWSlGozMY85UO+TbRhhfAOBgtxVy44
 qIwsxZ5eo4/n3cMbuTABfPPdbi4OGa4zmJxQ4KPWfdlnDVx3xcdUoVXRD4UoVu/AUx86ImB83jW
 PrYTnC4ewjttkh9SBhw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70a425 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=tutTO12i5-LwSZ318QYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ecXr_9g78y6ijegj_sbYvggXS1rKHYMB
X-Proofpoint-GUID: J0LscyxrWLh66RFo04dCqOYx6K3cNNPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030128

Hi Bart,

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series enables lock context analysis in all block drivers in the
> drivers/block/ directory except DRBD. Please consider these patches for the
> next merge window.
> 

One general comment I have about this series is that there are several functions
across these drivers that use the lockdep_assert_*() APIs. I think these functions
should also be annotated with the corresponding Clang lock context annotations,
such as __must_hold(...) or __must_not_hold(...), depending on the lockdep assertion
being used. This would help keep the runtime lockdep assertions and the Clang lock
context annotations consistent.

Thanks,
--Nilay
