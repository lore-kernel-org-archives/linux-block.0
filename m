Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B5312826
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763011; cv=none; b=VdIgusOVgV7sVXGTiDQMAah3vlU8WCXnbDj1fKpqCFEnQqJxJMeWCIhEv1f0HapCeWqB68VSWycM6oLUakrQb+uSFEUXWfeNf3yNZqedNyQOX4Ac4FJN0wY5oEBRhCa1Wx5+jI0R8H4tCocqd0r1BOa3hlwCU5kdPWH6u9Ss3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763011; c=relaxed/simple;
	bh=tao8YYa4885jOKKxFmvmts9XjV+qsPEtzOwhHgFmJ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlHUjbRmGLzgBLfyX8M0blQVXuq94R2nzOgFzlORPV3b7F1PojDg29Fx+2dWm6LN3oK2sEvU/cTvMnHLXmQhQzdYxKDtc55aNh2DTRrUZr1wymQEQkcDSW1z1TIVlLcg1xvucnTpxHStFEe5BXHuQfSIe6SCWkFPgLNb6ItFM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IP/O8Mp8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IP/O8Mp8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHpa0151601;
	Mon, 3 Aug 2026 13:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gtRv9c
	6XK58aYqC9FHzMi3s1UAScFzqX9ZhQTCJrbmE=; b=IP/O8Mp8ApwWMfQXmYI4ls
	cC5QpXlq22ni9ZdG2jSapoya+a6R8Ct9Nk8Fcx9GWQbY9xpL8oCuf7xYR5CgMRs+
	vDiQHXsIgclusHiDSY/ahWBHvsf/rZ4DbvCDg9wcyLyqc+yfA6ChnhzGDoXiKgBO
	I3/dCS/umGGRK+B47QrpN2m3pOiccwzv9p4z0bJpsjl4qh5h/nKs8URinnNaiP8j
	tlpuWFM3pk8wvgyuFNrqFNIeFjT8xaUebUnipwVsMJVZ/IMTFnHuhCQdr9/UBhR3
	Fx1UqlsQBFUMYJuoyrrh4wiuX7bq/uO/3Ox/14cUwIanbcfMP4RFYKT3zkykd+jA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqgvru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:16:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DBG3p017151;
	Mon, 3 Aug 2026 13:16:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyd8dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:16:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673DGQtD6619884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 13:16:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29DA358059;
	Mon,  3 Aug 2026 13:16:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141C35805F;
	Mon,  3 Aug 2026 13:16:23 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 13:16:22 +0000 (GMT)
Message-ID: <5952c14e-1d8f-4672-8153-2e150120a5cd@linux.ibm.com>
Date: Mon, 3 Aug 2026 18:46:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] mtip32: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1785440858.git.bvanassche@acm.org>
 <ee97a457fa3dc450215bb813b8dd9b0c488ec9b2.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ee97a457fa3dc450215bb813b8dd9b0c488ec9b2.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cMiCIyjrLB4m9TUKQOctFNjAxlGpgGni
X-Proofpoint-ORIG-GUID: HZpNqYoVFdu63-kJl58JZiQShKT4cO7z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX1mqpbSaQKpXJ
 NFNJfh5DJcs0Do33RydLttxW7Upj32JrlHUNCj6aZxcPg/kIV8kjUlLUCPMrFKIhubiwIy8rzwe
 cdl9+Y9Dmn1dc8JVRhZXXbz0DKIVF4M=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a7094ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=N54-gffFAAAA:8
 a=VnNF1IyMAAAA:8 a=lWicLDMDnwgBfgFa_PAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX24g0XVxNPPQN
 /TW1dZniWcipy9zfi9mEPr7Dbevff1xchXvoPlyjKnUe7bMFYcI4PNAkphyiDwRVSUD1kG+VX1V
 UZG5KCfgaxLgWODzmGq94me9hvVvE1XNQX4rRV6AZX4P1wjbVc4h8kKF1SSfDST9HaK2x5mxgBq
 IurtqfmCR0y0L1gk0gtrRAkQ+wEQNc5vYcjhkmiQRt+3ogsOWBWFz/Po88S57glglG1UAepfTCd
 tycnumoC5oSZ2FvpnFGbScrJ9XBN+/0/tUnEP8OH04G9Pr1rnVRtb3/inXb3hw4hJ/NzcD7RcCo
 kjZ7MRh5RfxqeYVZIBNBCPk+bAivAT2GxHb9r6csjNhtukxD+FVMqtM9l3qWUP3WnD4M7q1apT3
 HaERGCvmM/yb8ggtIAHlc2JyvcGscJxLiD2JkQfXFMqloqbn6SM8aAYOw889qHVwMILmvrgQwBg
 qdIKF5SnkIIYl23aeRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030115

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Let the compiler verify lock and unlock calls. Enable lock context analysis
> in the Makefile.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/mtip32xx/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/mtip32xx/Makefile b/drivers/block/mtip32xx/Makefile
> index bff32b5d3c19..233961fdb41b 100644
> --- a/drivers/block/mtip32xx/Makefile
> +++ b/drivers/block/mtip32xx/Makefile
> @@ -3,4 +3,6 @@
>   # Makefile for  Block device driver for Micron PCIe SSD
>   #
>   
> +CONTEXT_ANALYSIS := y
> +
>   obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX) += mtip32xx.o

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
