Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839A48A2A3;
	Wed, 15 Jul 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130460; cv=none; b=lVgjghWYksC+noLc753d6JmeWc2OeRfGJaqieXzNvwCyEU0YwdGDCF84agw/VWiowI+hjxJv+tMryf+C+8lQLMtDokDGK0gy1oe887BMm2PQThm+5iWwGhk1pz3gTx/A6NZ7y+Cll5qN+HKgl3tUjwlbN3Obc2dOxWSPzCvyUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130460; c=relaxed/simple;
	bh=/xC2WGDNLvQzAimd6hKP2dg2bLuehJ+Iq7jh5SpJA2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShllHS8c2xHyFK/uwc7JBcOH48H6TFyWzacZQHu8bexWegoVJiKTjY5mBclxg9NEVwf3mx7z4QH8vtQJKGBgl0/uqiwqsqg3JVzpluMLHxEgHna4B+NRGQMzTprD74vcAH5ljht5qAqof19DFUTak9hbgzl7OCV9sBzw1jOxvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WSoiT7XY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WSoiT7XY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FEBwVU381413;
	Wed, 15 Jul 2026 15:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=35wtI0
	BkWrzWzWrTR8z5SkAaND2VzkmJ5qaRGOp68yA=; b=WSoiT7XYt2t6oiwtIKObm3
	uIiJBAbIdY23PNtmtYOoGdUkskMMjptBieTKaCObH2E/ure2q+PCeXo/4j8RgTiU
	tDemU5KtoWypQvYNwftlPUXpgLMHdyUKF3twgxefacAO64aC+yAVS7xM5chZrNU0
	BVzGD18Thy1xBGcwuApIighYHiMRvKhiQEWSjJugUwB3RVL2OyLYWzsaV33A/nSa
	90PAfez2Q0Gh7s9LStmekA70iBGFIn58USEhHskripcjEGZHCPG7NsMgX7k980fN
	a7uRCczvbwnjNivxvkQQsYPEx8PYZZ9NK99U1chTyB5jW5cuaRhL+M3WhQ/rBIMg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbusn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 15:47:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FFYaAW020029;
	Wed, 15 Jul 2026 15:47:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k0qd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 15:47:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FFlOKt40960486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 15:47:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EC8720043;
	Wed, 15 Jul 2026 15:47:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5173920040;
	Wed, 15 Jul 2026 15:47:24 +0000 (GMT)
Received: from [9.87.130.177] (unknown [9.87.130.177])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 15:47:24 +0000 (GMT)
Message-ID: <cd1aa844-72bc-45af-a907-98baa234c510@linux.ibm.com>
Date: Wed, 15 Jul 2026 17:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: reclassify u->iolock of AF_UNIX sockets
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
References: <20260713181401.11088-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260713181401.11088-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a57ab8f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=5468bmbA8M3FRU0-7hsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX/Lw+ARBgyxkv
 3MNeOXkoAEuFfVBgJY9D3vumhrhHitlLTJ9s2daBvzBDpcUhRgtTJmdBoCma0GTH41NJGxNN3Gx
 /ekiOcVK2b7BUS4UIoHOm5sZvJ9oqkgWROkG171MmLkh1l4ergUrpJ4CRzOL5s0f144m2+r7UG8
 DMveYxyHs581AFjz/ZXI5bSS21acZpDh9AYvBx3dcXB/Cos1+lrKOYQ1khVXqaXZ7awksD/xLKr
 BYJ803kGlB/5dBLTAARZUiBvhESVObegPDSXnfHTZDUM6mg153VvUX5ttKUqK/jDH7DeZwutBdg
 FbwVKv3bzeeaNIn5pCWuAQmiyC0nroP3LbYgiLf2v9vnSUqeBZ/uwbogYQfeFNZX+zHVjKWsWHO
 LqsQdFIPOikzY86x/0JcMkoUSj9Anz0i4kVIA0YscFoCTJh2A+GvJYiLU455G8BQqK2JjZ4a7RA
 XiCRlVMbvPPi66YppNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfXz/wCgYlkx2mH
 B373Q2OTFNa6otHAwoj/IJWzhj27jeH2tNBfPX/r+HAIrJvOnmO9fArIPj1jWjydWcaPvdwuy7g
 aRGYuBu72IjI/1Ybmmfzth8gcWZV8Kg=
X-Proofpoint-GUID: TnhTNyQXiC6lqG9aiFpBKjjU2JfvXyCS
X-Proofpoint-ORIG-GUID: Q1K_-aQwUXmt2bXPqC8GRLNANVgiMytF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150156

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8f10762e90ef..a811e431b47a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -32,6 +32,7 @@
>   #include <linux/err.h>
>   #include <linux/kernel.h>
>   #include <linux/slab.h>
> +#include <net/af_unix.h>
>   #include <net/sock.h>
>   #include <linux/net.h>
>   #include <linux/kthread.h>
> @@ -1241,6 +1242,7 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   static struct lock_class_key nbd_key[3];
>   static struct lock_class_key nbd_slock_key[3];
> +static struct lock_class_key nbd_unix_iolock_key;
>   
>   static void nbd_reclassify_socket(struct socket *sock)
>   {
> @@ -1267,6 +1269,17 @@ static void nbd_reclassify_socket(struct socket *sock)
>   					      &nbd_slock_key[2],
>   					      "sk_lock-AF_UNIX-NBD",
>   					      &nbd_key[2]);
> +		/*
> +		 * The AF_UNIX stream recvmsg/sendmsg paths serialize on
> +		 * u->iolock, not sk_lock, so it must be reclassified as
> +		 * well.  A held mutex cannot be reclassified; skip it in
> +		 * that case, as sock_allow_reclassification() does for
> +		 * sk_lock.
> +		 */
> +		if (!mutex_is_locked(&unix_sk(sk)->iolock))
> +			lockdep_set_class_and_name(&unix_sk(sk)->iolock,
> +						   &nbd_unix_iolock_key,
> +						   "&u->iolock-NBD");
>   		break;
>   	}
>   }


FWIW, as sashiko pointed out, the mutex_lock check is racy;
it narrows the window but does not close it. In mirrors the existing
sk_lock path, which has the same property.

AFAIK, the consequences are confined to lockdep bookkeeping.
In practice the window is one-shot and unreachable for a functioning
client: the reclassification runs once at socket hand-over, and a
thread concurrently doing recvmsg() on the socket it just handed to
nbd would destroy the NBD protocol framing anyway.

So the patch is basically best effort to avoid lockdep being turned
off - which is my concern since this happens early during our CI runs.
