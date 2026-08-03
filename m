Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45840927D
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762754; cv=none; b=W1KiCfg9nYaPzP+fohc8BLcrQ9SSBeTxyFng1fAl4kc0NwWGfGP3QxPcgT7Vf5C62nFyw0Sqv3VTSb+Elprp2gNjBXjEjVOKs3JW++dmCymVzyXRf2fh2M2I8UcIJkXFgUwaMnaVwSsvP2e/J8I+XVjRCjpiappXXcOj9c/OlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762754; c=relaxed/simple;
	bh=t84agDhfViOPCV//ckccrr66yOhkTkuA5CrzU4Bp0wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnAad5YNUqyEpmRrqqvvypwL9ABNEwJfpfHhtMIbjzJH2L55R1bcAmRTpWYGIVE1I9X8L3GnLOPCMlclqfItuer7i3woPZvf21tdQWAWVtY5YR56T+RJIV6o5OqHmFoZPUiGCuANwVfXtw8PoQAK1Ask3t6fyHYG9c9bvz+KI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lg5rmc6J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lg5rmc6J"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHp6o1999331;
	Mon, 3 Aug 2026 13:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j0kHUL
	svrw2KM8Almi2p+CnpO3OVrREHphhmccmu5OM=; b=lg5rmc6J3YYKdzwGEvkcAa
	hqxdOIgtjf13fmpalTjZCL9Gv5rkOw1cy6D89194mjhUmVbONdRo3/tIkyl8lslx
	S1M7RSqtQAFs2yUHGaMFjJIH/ddBrA/IUHgP1Tuz3m0faKIjU2HS6pcAoyW84JP+
	9QMDO37f8ORvT9+5qBQ5vco6NLXDGGjWe/xsc245tLVsBCpxZ6rMZhYoMdsX6tay
	PlktBUppDTmJZsE6TKOJubuP0euXXsVUnA8UeKboHs27+lgO5a5NDiCWon9s3i1g
	uT3TsEv+OgMycqhAjbAtaxc+i/utkaxTl5aYGOfo4z4BcSSH0CV5fCxo7tIndmjg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3rwps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:12:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DBJou017354;
	Mon, 3 Aug 2026 13:12:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyd7yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:12:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673DC26W65536302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 13:12:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B74215805D;
	Mon,  3 Aug 2026 13:12:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E52958059;
	Mon,  3 Aug 2026 13:12:00 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 13:11:59 +0000 (GMT)
Message-ID: <a41ebd1f-f115-477b-a3b0-5ca9247ce465@linux.ibm.com>
Date: Mon, 3 Aug 2026 18:41:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] loop: Add lock context annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <cover.1785440858.git.bvanassche@acm.org>
 <db7c5b870df403fe97229f6bb59144122e16aa41.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <db7c5b870df403fe97229f6bb59144122e16aa41.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7093a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=N54-gffFAAAA:8 a=HTwWoRCJAxWqUFWRqVwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1WdnPKFTfgvcdK9JE3AQQfNk58qNYc5g
X-Proofpoint-GUID: m18PMBl4FS2RRDk3nqjqbjMy7_ZALCYv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfXwOZTYgrAC5YI
 JCw7oP8DrgTAQqpMorW8zJ2dm2PAa/nXc+qdESaAMMe616aVORTgNLqJJLHbTmap3BkuApirDKV
 6WSVH7P3O4VZiuJQAizeR+Q0f5qHz6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExNSBTYWx0ZWRfX/SOBgMdFiC/W
 R288Kc7eJjv/6V50aNp6TrZ+bvIdmFZ+F/RVaJPR3t82A3lORvTzm79LU+zxZRY7SY4cXD8JaK8
 j5OZCzdzau2pMwRW+Oy1widg/PZnBSiAZxMzne0MqrzVKHPIxvlnTUGQ21kWYvY7hF7t1oeKZtt
 atwBNt8zNeEBqOoPfL04UNrOw7Nq2O2yruxNsKjUI4pOsTsl5EcFkSsdn+6hEZUuJY7ZgI9WWvG
 S73fyfu07puD8Xshx7IjOmt9T64CvX6D3q7tv5VNhwvrmOkPBb1pu7nIR7uaEWuiq+bRnSYvV06
 WP3Frm4OCRYSO92J7WxriSAKo+u/5YsyKd9y7jsaQQd9jsLYurW//T4JpMdUFV29p5z4Yz2SWMW
 RE/xzxeEedzxRQ7Yk2CfuRvO/FSw0HN+b7abgswcvcNljgWJkdQ90Oa3gCCyORt2XLtM+rY2oAe
 /T0fRvlCloZVeAFlwIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030115

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Add lock context annotations that are compatible with Clang. Swap the
> loop_ctl_mutex and loop_index_idr declarations such that __guarded_by()
> can be used.
> 
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/loop.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a71fe763c933..e2ac19de11f4 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -90,8 +90,8 @@ struct loop_cmd {
>   #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
>   #define LOOP_DEFAULT_HW_Q_DEPTH 128
>   
> -static DEFINE_IDR(loop_index_idr);
>   static DEFINE_MUTEX(loop_ctl_mutex);
> +static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);

Can we define helper macro here, which is more readable?

# define DEFINE_IDR_GUARDED(name, lock)\
         __guarded_by(&(lock)) DEFINE_IDR(name);

This is similar to what we have defined for guarded LIST_HEAD here:
https://lore.kernel.org/all/20260713115444.465704-2-nilay@linux.ibm.com/

Thanks,
--Nilay
