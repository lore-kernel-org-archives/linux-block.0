Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6B3AD50F
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083331; cv=none; b=W7o7fmTxKbMcZwBe1XzGJqi0/nwtgGxYT2i4xpSUsGj2ia8n8TjUCAGHAQADZZb2pgHmKqw0fsrB1Sths2yAsciCI53LHP5NZG2YX/2NRPYtUZGFgdJmwFsQiXADwViBM0nmriDviz1thJo2P2DLLzdl7O9v+Tkb+NB88Z4TXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083331; c=relaxed/simple;
	bh=WZ/f4xGyOTXKTzPIH4ok/foNLRs7JEcBF59bijqjrPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5ogOTMT0y5oCNyAmLu+UK2r3DdHiCGtKf40pk28jlNaq+8vzBfqSkhzifvx016IzOVIRWr3Vr8KOdVK+8Yrquc4dCecD8fOkOn3OvUO4dJyOQSHh58eu+sfQizNUhEABkhmQcv8mQuEt15oRqeGHe0SgbEhkgmC3qssdcLCPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DPlzBqJs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DPlzBqJs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6QDIH4191465;
	Wed, 10 Jun 2026 09:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4+mJdU
	Xsmaul3lxYgECAkPNJHFFj93/1JAKFXK9WzeI=; b=DPlzBqJsqrMxWPgaVQX7sn
	Xxh0xSqegb94tRsrQSaZLbDkTg9nw3WPD+8VoA8+IDoB6BccOWHDFr3SISWXbd8N
	ahNLDM3SBQ7Ng53omVG9sC715SbE3Q3ZzGHCa+urwVDi0nQKZ+kpNDHVddkEU0ka
	jEJTjmbofMEa4o828/y2/w4i7/N2PZc6aOh7gKrn8XKL2rr5rJdAfWqYfka4NCmT
	YOaYdPOLHdBgCKGoSXjiht4jjkjxstQCzrxyOHI4h67A1Dojjj4AYod+ERC2y2dn
	qZyAsWsJF772BwnK4Lvu8rMcW+hyOwwI6vgplK0PqRATckMzO4cdrCl75XhCt8PQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj074x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:22:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A94bXc021052;
	Wed, 10 Jun 2026 09:21:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w6494-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:21:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A9Lxgd29295260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:21:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06B0A58067;
	Wed, 10 Jun 2026 09:21:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B935958052;
	Wed, 10 Jun 2026 09:21:56 +0000 (GMT)
Received: from [9.43.34.89] (unknown [9.43.34.89])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 09:21:56 +0000 (GMT)
Message-ID: <c71180a3-c049-490f-a8ab-b3faa9714de1@linux.ibm.com>
Date: Wed, 10 Jun 2026 14:51:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/27] loop: Add lock context annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <1391f73ea3af981cd2e76b56cdfe47b5bb56ffa0.1781042470.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <1391f73ea3af981cd2e76b56cdfe47b5bb56ffa0.1781042470.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX0GVTFwrH2GYx
 ATHt7IffaqbvT4RYnsiL9DUKxlILY6CyKAJFiSQ3GLnanCjAeAi4IJ17cVzcGgtVa3AFlMMUMxn
 3FhXqMcWVPmDANPhLXouL0/uFhxr4t72wu0kWmBzna7Y8AqDsfi2wXs+vLiIympHd/XJg72WOG3
 Yug39Ciw/N8spdjiC2BV4jEa5VEQbK3+exd1EFDC8TKaK9FpZ8MVq8Pflnp5PFVMLRuLBylLSj+
 z5SjVVNa1znTl+/nVB74Noe7dLkRXHE6yamzkIteu58AOYF6ziVngUEDuigSErvIIIR9Q+JJEW3
 f1xsII7t0iuKLL/r/EfObxc7cMq0pj+KwGu1lHi0l0VXnW6BSm75YeMv4Q+P4dwOuDv7yKOEBl2
 f2RyBQf0sb1Qzlyb85d78fkGfQPhq/lfIw5hBecJrscayikT7XZZ7assNUw+jMY4+Kqh0AlQZre
 JGNIEpMG4EAA6dZEHkw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a292cb8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=N54-gffFAAAA:8
 a=rAO-oGg0CtVozliccvEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Bl9rAXKHXtRayGqQ33g6CgfR0F-00Q35
X-Proofpoint-GUID: Wgal2fpTSACGH_YZfIeymsiM6ImqEeRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086

On 6/10/26 3:35 AM, Bart Van Assche wrote:
> Add lock context annotations that are compatible with Clang.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/loop.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1a33536000e0..ff7eff102c5a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -106,6 +106,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
>    * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
>    */
>   static int loop_global_lock_killable(struct loop_device *lo)
> +	__cond_acquires(0, &loop_validate_mutex)
> +	__cond_acquires(0, &lo->lo_mutex)
>   {
>   	int err;
>   
> @@ -124,6 +126,8 @@ static int loop_global_lock_killable(struct loop_device *lo)
>    * @lo: struct loop_device
>    */
>   static void loop_global_unlock(struct loop_device *lo)
> +	__releases(&lo->lo_mutex)
> +	__releases(&loop_validate_mutex)
>   {
>   	mutex_unlock(&lo->lo_mutex);
>   	mutex_unlock(&loop_validate_mutex);
> 

This looks good to me.

One thing I noticed while looking through the loop driver is that it also defines
@loop_ctl_mutex, which protects @loop_index_idr. It might be worth annotating
@loop_index_idr with `__guarded_by(&loop_ctl_mutex) as well so that Clang can
validate accesses to the IDR against the corresponding locking requirements.

Thanks,
--Nilay
