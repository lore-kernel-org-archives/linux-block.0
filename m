Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6436492D
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154317; cv=none; b=GKNGVLp5yvOCuBRwEPRrhx0r4ifvP/wl4f63dhKtiwlFAWTMDvTfIS9xN1q3PzY+uf7TjLhbWqKKF4Ofsf0HIAioURsYbskwAjsu5rp1cAsDmM6yEL8wOyDmlzTGiwT59TREer3vuFYGliD/SafC5X+h112VTIts32x0QtWy7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154317; c=relaxed/simple;
	bh=ydTlzLuv2SlLkrBHgDn+vlxdTJx3SjVzb1qBgEy7z8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scLOtxtJLdoQqnzjdtbZh5HNNeewroWbglV7JowLKyq8i+kmFm2D0hEMZrNpMd5h+3GqCpvPleImxFZfZ9NscbqdJOfoZJVsvl9kUPLdBFA0W/GozXph74d9bxD3hZ1ptSRkJDWMZhH5zx0nFeYQPTHHO174l42TBArZdsyypZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=muT3+5tv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="muT3+5tv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJuPIl723488;
	Thu, 11 Jun 2026 05:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aEWUfB
	/YL8nUsHDAfg9E3xJfHbfoKumd4Voq2nBKEgc=; b=muT3+5tvvjp8loWSX7FoSA
	zfYKMEmxPY5hIHWLZClRgfDf92R/O1WE7atfD0haD/QujOIllqbc4i9mwAkG6SJA
	feSrFQfPg+FfPwXLF3tbjR7hGhRPx4XtwUQfkH/Qy1ZQIKDokrXYA7PO4B1XduNN
	gMVRz395cmDPyiu02Ke8LE4G+BqTVvpAO9tKbkjiHQwsqaSTp7NoR+PHbV8hMSyC
	uGEmyThgirMIKrg1gRJ0KDJh8PhO/KOs2i+4557VQlIqILGgrayCEqfYotri+0HV
	AUbw6wwuPZoeXzq5OrvWkVg2xs7+iRsNv6CXOdb6qP7e4ZSIGC64L1yTIox4cEWw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8d9h2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 05:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4ndii020658;
	Thu, 11 Jun 2026 05:02:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08spy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 05:02:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B52tDb63832560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 05:02:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53BBB5805F;
	Thu, 11 Jun 2026 05:02:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8E8358059;
	Thu, 11 Jun 2026 05:02:52 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 05:02:52 +0000 (GMT)
Message-ID: <e86222df-62b2-4337-9563-f2a7eadeccbc@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:32:50 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/27] nbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <5361809d027e772503ca3cc458aaebdf06792e3b.1781042470.git.bvanassche@acm.org>
 <4c8438e3-2415-43c9-ba6a-27321070c58e@linux.ibm.com>
 <ba18cfd5-0a52-4e2e-85a1-a9f0a20ff957@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ba18cfd5-0a52-4e2e-85a1-a9f0a20ff957@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfXwM6rJDufKRdY
 ThlV3LgEUUl0fRmxxLof58A1MJQQ109KhtzXNrrDDnce43bWAfePSGYy4oIY3Y+5/VkqTrG+quL
 IchdbugWHtAMSjuTTmb0XaPMgIVdnNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX3fVDslXb+Qoi
 4Xlzs+/py9OqjqEZFpMjeXd+HzB2S9mZip/wB+5MfPaLMQaaptvu4Vg+bZMzCm0yaXvdJAE90Ko
 etGSWlPf90H1PC3rmqgy3PYf0Ah8/72qWHIA29SBtAg1SzH9YqV+6XMqv8gVjxuXoj+To7zA+Ls
 wt+24VeBl6pnZ/j43Zi3Ib4ENtR/OcGgx5FH9S7tI1lYtYuAJD/W5fwiBkrF8mdDYiRacG4Q4fC
 Nw+4TQ5x4RF8A4OugpYmAJJiuZgC3gZOLxxD+r5YJZt+/68RgGcCcdwTrQFSQJvG2WaZt53xBpS
 gyqfn/KzicAvkghpJMrBfAgXypWrFgjtt3QJpVRHM7I4GpNzi4AQJfefNy/abgzPkUNfM8UIl6l
 q/k2ryGrA5zXi0iTZGNvbn7iPsvwD28h4s9Ax0bnR3qChe74Ga6yPtwdiuJUeOfGEddKN3hNX9y
 kxM0YiRmCUcVxaS2+kQ==
X-Proofpoint-ORIG-GUID: uqZL30FtahVaSHnUIQSA6MP7kOigUyKj
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2a4181 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=nj36xHfPfgyJCzrYkp8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rfyUn3F9Pfx6iMIe0zhtTxFqyHKn7tqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110042

On 6/10/26 10:46 PM, Bart Van Assche wrote:
> On 6/10/26 1:02 AM, Nilay Shroff wrote:
>> Above changes are good, however I see nbd also uses @nbd_index_mutex
>> which guards @nbd_index_idr. So should we also annotate @nbd_index_idr
>> using __guarded_by(&nbd_index_mutex)?
> 
> How about adding these changes as an additional patch?
> 
> Thanks,
> 
> Bart.
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 345e4b73009d..b9e0ad0b3ca0 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -49,8 +49,8 @@
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/nbd.h>
> 
> -static DEFINE_IDR(nbd_index_idr);
>   static DEFINE_MUTEX(nbd_index_mutex);
> +static __guarded_by(&nbd_index_mutex) DEFINE_IDR(nbd_index_idr);
>   static struct workqueue_struct *nbd_del_wq;
>   static int nbd_total_devices = 0;
> 
> @@ -2739,7 +2739,9 @@ static void __exit nbd_cleanup(void)
>       /* Also wait for nbd_dev_remove_work() completes */
>       destroy_workqueue(nbd_del_wq);
> 
> -    idr_destroy(&nbd_index_idr);
> +    scoped_guard(mutex_init, &nbd_index_mutex)
> +        idr_destroy(&nbd_index_idr);
> +
>       unregister_blkdev(NBD_MAJOR, "nbd");
>   }
> 
> 
Looks good. But as I said earlier for similar changes in
loop driver, you may want to consider updating current
patch (instead of adding an additional patch) with the
above changes while you're enabling lock context for
nbd driver.

Thanks,
--Nilay

