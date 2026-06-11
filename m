Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E83630B3
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154112; cv=none; b=HAOz+5tOecgWzMm/xFxyPrMiFfulxJJ6MW7edX4djOP14QsdaJ6xuSblzphilFlVUxRgtMqLqEClZWXnGu7md8Z51KPZFJiV3pBawRyYA5cbU7jhAyTc1IUAurbwCCMVBoFyn691gcwghOjUvRFiKKIT1Us8+un99o0L3ik9AdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154112; c=relaxed/simple;
	bh=tDAx8/p6WqXvjT+S9X1cZFwe162dxVkrMOFMYoKnktg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqTe4mxHfrlrB3mveFuyj/uYthrKHbUgLMkB5KEKJRz1srnHJrJDfcF/n3nPUF4Hcwhbk6Y7mBdw076pd6tfYtI3Iz1Jw3buuxBgPlm1TRyIuAKBDeAmw8Shr85RNVnhtaJ+QVTSwnyOz8dSlgdRtQlaTEVcEU31U8NHOOtyC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X8kQECqu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X8kQECqu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu4Oe1741947;
	Thu, 11 Jun 2026 05:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yoeQYb
	u/qLsyXwYxwAywQwWfH3/tMpMapUjq9KZiEhQ=; b=X8kQECqurVOsTIyAYRdgUI
	G/PeYtA4sqELLyPma6iCJ+rv3vcKXw65G/ODCowBetb2X9SCgeV6dtS+URxZQRo7
	L0OSl4wj18m7QNA4xY42d8VPalZ6b2I1lDZUwDM+lHPZdJHWRqLmTYwqIBWHhMvS
	vHCPZDD/5nowx7ACj7HvXpjVnmGMnxDii2RmGoeGnCP2ii2Z4bMflZoJwGDhI3IU
	WpyMwmZcM5qCEI7ufaAAduApQT5UhJFBNzMNzaKdkorvIl3qBgYJEoUmh4iglP7b
	aCiK0otUqNz9aVZ0l1vNUd6JLLH3qMSb+Zk9EzA8W2+UHoaLiGETb3kfVUhwLG3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bhf8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 05:00:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4ni96020673;
	Thu, 11 Jun 2026 05:00:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08spjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 05:00:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B50B3619530328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 05:00:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41D1B5805D;
	Thu, 11 Jun 2026 05:00:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B89F58059;
	Thu, 11 Jun 2026 05:00:08 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 05:00:08 +0000 (GMT)
Message-ID: <37b6d919-6b1e-459d-bf1f-0df7989e2329@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:30:06 +0530
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
 <c71180a3-c049-490f-a8ab-b3faa9714de1@linux.ibm.com>
 <63ffdebb-24f2-4842-8e65-53045d74dace@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <63ffdebb-24f2-4842-8e65-53045d74dace@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2a40dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ebNBYZgGUKrOgGt2wSAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfXzIFKPc3QwcQh
 +yET6SV603URJPPA/ObR7urisos/LZo8UPRz5J9dzzlmzx70AbJeg7KozEDS1ENwR3I+KFDyfjx
 ryxM89jLdW8TckB7FPSnwyp8L0Cs0gUobuZDZKdKe/yG0NqKsK4BOkQdPf7jgFWlDl04cc24lL9
 5Hhvlb711qYl/37vv5bUL2B27JOJ3juDSvLRjk9Nj6Cung3rYlzdGhhIrDIpFWt0azXTAmloA2I
 zVTZgHNOsEqZCXPbfq8txDH6PiI7L3l0lrPNEalZxaKieIy9EvIzBurrY6QDfodgMBbjqzsK3gL
 f+Mr2QxN4oCC0koWhSkVZ9AArcNQLGrD2fxx+jHYutqaatRKpr0YwKe4bjGRdEa/yqW1HyjSXGA
 n55I4G6+UPOIeBg6ZBkG0DGEN9TU+wFq50sNYklMKwNKUC0ligUFERdC84G/ccs0B5/otkhnLTE
 P+Tj9mD0iniLSQAwI3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX2QaaJnP1eRbF
 A6MfdTu+n96+iv4VqadzypeiFWhHjw/nLbL52pqGRZLy6AkyHjIY/zimix5Z3crBywBvQucAz3W
 DY0fvKaRvf1IZDHjbXgl6ciTfE5D6XQ=
X-Proofpoint-ORIG-GUID: trhR4DDQu_l2StA3x3SeuOEtfoIEpF1K
X-Proofpoint-GUID: Q4dwFIwSXDY1N0sPTTnyq2ty3tgPGxv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110042

On 6/10/26 10:43 PM, Bart Van Assche wrote:
> On 6/10/26 2:21 AM, Nilay Shroff wrote:
>> One thing I noticed while looking through the loop driver is that it also defines
>> @loop_ctl_mutex, which protects @loop_index_idr. It might be worth annotating
>> @loop_index_idr with `__guarded_by(&loop_ctl_mutex) as well so that Clang can
>> validate accesses to the IDR against the corresponding locking requirements.
> 
> I'm considering to add the changes below as an additional patch:
> 
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ff7eff102c5a..30a2b2696368 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -90,8 +90,8 @@ struct loop_cmd {
>   #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
>   #define LOOP_DEFAULT_HW_Q_DEPTH 128
> 
> -static DEFINE_IDR(loop_index_idr);
>   static DEFINE_MUTEX(loop_ctl_mutex);
> +static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);
>   static DEFINE_MUTEX(loop_validate_mutex);
> 
>   /**
> @@ -2326,6 +2326,8 @@ static void __exit loop_exit(void)
>       struct loop_device *lo;
>       int id;
> 
> +    guard(mutex_init)(&loop_ctl_mutex);
> +
>       unregister_blkdev(LOOP_MAJOR, "loop");
>       misc_deregister(&loop_misc);
> 
> 
Okay looks good. Alternatively, I think you may also consider
updating existing patch with above change while you're adding
lock context annotation for loop driver. But anything is
fine for me either updating current patch or add it in a new
patch.

Thanks,
--Nilay
