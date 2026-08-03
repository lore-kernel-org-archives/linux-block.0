Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0635C183
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761642; cv=none; b=H7m1b1lQSxU47Mjq632L/uPRiest/U/GfHhlC4FQjQUQvmndCyBeMxGpIaswDHpCn1Hrl3QRV9+HAxxRr7fiDpIzoSWdc/DprpOTuqPeeuJO8CBpF6YNDyh6hrq2QbcXmH8jaD2BccKUFBxlc4DXCBYnkU9YdkW7Ib8SCkUGgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761642; c=relaxed/simple;
	bh=Iji8GvWTCitUoLAz/wbBssN+rZqqGGiNJ+gj6EJDlFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOyu6InUu/16m26CAuaLzF+IAmrZKlvDaYQvXKe6cR2H9t9kgodXCjqSWyvBGMamfmwM3Wlb0iozvJd8BeQkCjjhhUI8OTLNdlxWKSuozOMfU4i4+rxKZvXszaTkojFJrrGKRWIfG+/4gGJ81rjqLL2RptvadSkoS7Ye6UqvNN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LaSCj4q2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LaSCj4q2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHeJh2018378;
	Mon, 3 Aug 2026 12:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EE1fs8
	+82DvUPU0+AgQt7JvV5iwIaNIvrg53RCsLRto=; b=LaSCj4q2Ubn09qepieK29E
	xgE5DZPiUpcsx4X2z79J9PxeJWS76x/OBwyXyeakD/NtmD8/IlDt7dxMvtdVohgB
	h2Qxj6UllirSuebXCc18LYKJr6+qQeRuxRsR61/GUJJfGWuYvF0J0IPohnm2ChzJ
	vnoKaRMrAw+gR5RP5coQQLbmpWcqKD4DdwQuQxmppLNlp/O44AR2UQJnR9Xfw3vm
	edtFqW0pDdPsc13dV3jmfVkBdS9InY6dv9VAYEhs5OBvWvj7QFaj0yjQ3mqXF+7z
	E9IibEEndouVa31lh0/hFZb1xrgQbSGUegZzvfVmoZrYl7mfdn557SXS1kcFFoUQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rsu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:53:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CfS6p019495;
	Mon, 3 Aug 2026 12:53:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwfng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:53:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Crfwa62128542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:53:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F6958043;
	Mon,  3 Aug 2026 12:53:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CACC58059;
	Mon,  3 Aug 2026 12:53:38 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:53:38 +0000 (GMT)
Message-ID: <38edbd6c-c0bc-4d87-af0b-ec5f6be27f0d@linux.ibm.com>
Date: Mon, 3 Aug 2026 18:23:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] aoe: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Christoph Hellwig <hch@lst.de>, Justin Sanders <justin@coraid.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <a5fdc2b4d52006c20e2519f2c395d5d5102cb52b.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a5fdc2b4d52006c20e2519f2c395d5d5102cb52b.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX4VbVL5nrbpgA
 DN/s/f9OT2mhreavh906c80gDAoT0zCqfN6/4+hlvMcK+dr3WC7OxVQ+qJ9W8wOBzAF7DLyGXQK
 z9YY7BFvxlH8Bql0yCV1YbbuQO+v7eA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX2r/VICnjXdeH
 zrntxF3StVSPahBb/ewvweRWxWSzhYSKD9Xwu0q7Kf63obTLShqT/TAyNVHCFPtevV1rJviMN3y
 gu0N2UyFDIW9NPyLz5C7mez4TcKrwGRiIEepjzXtsO9sSj3lZWxtbrfYdBqtGOIjk97T94aMC4s
 IUNiyDX4bgO14OZFQnmx5zJFbr6YFb8meDeOLRHSmIpsDxQEJn25f21MrRyVjEMrZ4NrFe/7laf
 ke8CaDAXhXRI+bFhO+iC0Kf4TdPb9ZeWeg2KErxuAMw23xvVYk4E+PJBhUcUGsA7n6Cf0lewbK7
 coT/rjxhPDE0v6Rv3etKtJQH3McznlbrVCkF8Xr1tW83Ma+JabJUntRg+OWIBADtw9p28Ey6UyC
 IcTf3bsBi9iM9fqYFlrtSTcEo9UaEi9Yu6AVnT07jUzpA87e/dvPlvsBxMniu1M4ZB9uFbXPoYN
 9Sy2/zlTbEfoK4xrlhg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a708f57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=N54-gffFAAAA:8
 a=J4q1TFsJvW6VmrfiHvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DIT4FXbT7q8cCdjTaoG7BmpWURqM8BsE
X-Proofpoint-GUID: rMs8xQDiwCexdW9TI0K0H5OVLnmWK5j_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030115

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Add a missing __must_hold() annotation. Enable lock context analysis in the
> Makefile.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/aoe/Makefile | 2 ++
>   drivers/block/aoe/aoecmd.c | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/block/aoe/Makefile b/drivers/block/aoe/Makefile
> index b7545ce2f1b0..27bff6359a56 100644
> --- a/drivers/block/aoe/Makefile
> +++ b/drivers/block/aoe/Makefile
> @@ -3,5 +3,7 @@
>   # Makefile for ATA over Ethernet
>   #
>   
> +CONTEXT_ANALYSIS := y
> +
>   obj-$(CONFIG_ATA_OVER_ETH)	+= aoe.o
>   aoe-y := aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index a4744a30a8af..54c57b9f8894 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -1193,6 +1193,7 @@ noskb:		if (buf)
>    */
>   static int
>   ktio(int id)
> +	__must_hold(&iocq[id].lock)
>   {
>   	struct frame *f;
>   	struct list_head *pos;

As I see, iocq->lock guards iocq->head. So shouldn't we annotate
iocq->head with __guarded_by(iocq->lock)? For instance,

struct iocq_ktio {
	struct list_head head;
                 __guarded_by(&lock);
	spinlock_t lock;
};

Thanks,
--Nilay
