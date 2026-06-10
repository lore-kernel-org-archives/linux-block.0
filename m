Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770E39E9CB
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078594; cv=none; b=HwKjKD6WOts5hDfurxMSI4ptVPt4nl0Av6oXZue9IxLkr/ObKMe3ig+MBjoYTB9+GfhVb+Nu5L22s6jIn6EcTLJPk+raI0/H+it1gWiguWcoPQbsegUMvhA9aNaJzDEmbE5yvUg2vdcRgFKXHmI+9Lo+ovfWfDKkqz6ug39xmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078594; c=relaxed/simple;
	bh=CIP8rfcFXABfykDB4gnElLlLCQHNk0ZxctvvwuHmPus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4n5MIMttp+hErF0bj3kK1p/WOuWfloqffeXyAnrnZHn+nBeQ9TwLbOB6rV4SKwlPfP2HmG9oL0l1S1mVNg6+XUROayyuWdkpyU6GMbmLyIPLsXQ0DnKrqZdwbJAQBl+GNhmB2TXBxTCmAVnsJFBFOyTD9Wqe1dLxNomXLF9VIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EJ7Fgt59; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EJ7Fgt59"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A0lmCA2990707;
	Wed, 10 Jun 2026 08:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9dEXXD
	68PnAihTFm8MOHE1m1uEeFNVUPh5IUXcnFixw=; b=EJ7Fgt59xSaJENoBRhXJ3b
	JubX7jEaw5k8PURhxBSLm6bhpDMrXCnA0YMpzrLTPHr/AAyuazm075FjOovdjt1k
	DZR0JH0PvXbISQf5gMEQbxGrb97flTyRPCfV83GrO69NIEZ7LQDa76ZMDPOw5Yoq
	A7tjC50Rb5zBOtoZheAGVBr3oLSlbfvf4npxsDR7bwA07IehIxi0wRqHfKKT65Lt
	9YWWRrEMUSNyJotbc7gz9/ItBGcrCvUGrwcuu2Hp/ELl6Xf9sbwwHtgFnN1I2+Ep
	qx2+NHtZy5bdyPVwhMJeXBWhikLpEnsYnLOXSwUzgyt8SJBBZj3TpiXKc6AVX3Hg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhyxsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 08:02:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A7nfg1028893;
	Wed, 10 Jun 2026 08:02:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjwqpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 08:02:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A82oeH6554174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 08:02:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC7A058056;
	Wed, 10 Jun 2026 08:02:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0344B58067;
	Wed, 10 Jun 2026 08:02:48 +0000 (GMT)
Received: from [9.43.34.89] (unknown [9.43.34.89])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 08:02:47 +0000 (GMT)
Message-ID: <4c8438e3-2415-43c9-ba6a-27321070c58e@linux.ibm.com>
Date: Wed, 10 Jun 2026 13:32:46 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5361809d027e772503ca3cc458aaebdf06792e3b.1781042470.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3MCBTYWx0ZWRfX/IYMU4drO+sm
 lCE9jzYfsZmhIwDjolNFfS7pts5MgRLya7hxg5/xKnpVmecTa1/TdU8xwFckMjKogAxSf9GZXOL
 3Z9vo+ETvS+LIOWx4SdubkGA9LFa5v7tAi0V7BvFver6d6Oo3cgth/ZGJ6LrqceIFucymvvFH1x
 RBCL5eqSovIBKAT+77ti5+b9Mr/ScmMADUkJYUGu2tULZBP2wndPByVvtoKlgDC+7sc4dUEQMmo
 fbqBdcuTwVhcTmaPTf5+DFKOPutWk2G6gtSQTZHQgL8zEgeDCT7jmJ2TrJZ/qHM65Q0xcPIavGk
 8p9nm9AjYrCuKdY116B8NMhUG9nAc8HJITBx6S86PQmAEef9Fnt2YUmmhUfLM40yc0wqoAfOjNx
 yxwQh3tktTfOTO/mmkl+hvXEtvwn5OkT5HMXyMPK+mJso6j2juy1Auxf5gAyR+ohoPJfdlRCqJW
 0WDF5DdLKgba2NIuplA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a291a2c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=N54-gffFAAAA:8
 a=hqoLsArdjgmXJpXO1zgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AnEI9z7iAEZm3qeoPnyDojntbbIaAoI-
X-Proofpoint-GUID: o6zVQ74Jqm_vOtLse33s0plaa6vnHlIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100070

On 6/10/26 3:35 AM, Bart Van Assche wrote:
> Add the missing __must_hold() annotations. Enable lock context analysis in
> the Makefile.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/nbd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index e2fe9e3308fc..345e4b73009d 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1469,6 +1469,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>   }
>   
>   static int nbd_start_device(struct nbd_device *nbd)
> +	__must_hold(&nbd->config_lock)
>   {
>   	struct nbd_config *config = nbd->config;
>   	int num_connections = config->num_connections;
> @@ -1541,6 +1542,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>   }
>   
>   static int nbd_start_device_ioctl(struct nbd_device *nbd)
> +	__must_hold(nbd->config_lock)
>   {
>   	struct nbd_config *config = nbd->config;
>   	int ret;
> @@ -1592,6 +1594,7 @@ static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
>   /* Must be called with config_lock held */
>   static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   		       unsigned int cmd, unsigned long arg)
> +	__must_hold(nbd->config_lock)
>   {
>   	struct nbd_config *config = nbd->config;
>   	loff_t bytesize;
> 

Above changes are good, however I see nbd also uses @nbd_index_mutex
which guards @nbd_index_idr. So should we also annotate @nbd_index_idr
using __guarded_by(&nbd_index_mutex)?

Thanks,
--Nilay

