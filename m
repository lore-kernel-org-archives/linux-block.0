Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D940F729
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763622; cv=none; b=CImb3gagKb//EbFKi4yn8+6HeVvNp4ViiAEawNyWgPodkaojrb/AUePHPKzkJOdQaL5xVekZ1WA3n7gO/+dKugr3C8XBMtycTBSDDPS2DEjUk4mDqUworkRgKfhiWCritv2Ni6jG7F4ElZ9eVKjxKMhsSuhppNnZMkjQToLAA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763622; c=relaxed/simple;
	bh=yQAbZOFg2yDrHgMd9qvGhecjm5L9JQrMdGMnoqQ9o+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsSdOJHd3k3jRZAmp+H6MFz8JY4Ljrbbifvb3mAMg2bDh0KhOe1K9kwSYlHSoQfqYvX7JKqEWarSFANYGuryhtK9cbufqMBmKwL1RaTCPjwKXbTRXkirJwEhS3l7Rm6gMimx9dwcg/6QRqyMBv/5wLR8zcP+qtSljlMgvlPNZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=meBDflo0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="meBDflo0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHt1f2018658;
	Mon, 3 Aug 2026 13:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3erGmi
	EgFDq7EGQMWOX9kAXJ0SAkGsVhvijWo8EAnr4=; b=meBDflo0F+lrpQXYvrJRJv
	qeZHt6zF9eRYYYrW90/UrLTVIhKnbC38Zb5Gs9D9RDTQl4nmoXGycYl7xVS8tz5K
	IFkAfrtPtbOp52HxaHu+36I85hB0LiM675d8Jaz+vSvwm7056ZoY4Rkk0W4fLZGb
	tt0XvMZJ2STnrMWkjzcw89l0We9uQwjx0FxU6h0TM/dhXvQC2abaKukgwX9DuC/T
	ulG1x/F6fpYuuU/IULZqcFbI2YaEGhNEX/bo+MldWnHxlXqA5GXRgNciNKMUA1Hi
	QvhUrWTPUg8ClraxeS0edSkuZFCCCoI8PDeVVE9Nu/hi5VZWGP0K6zWankYW7fmw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4ry4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:26:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DBDvo019020;
	Mon, 3 Aug 2026 13:26:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qdprs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:26:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673DQjYV64749956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 13:26:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4746F58059;
	Mon,  3 Aug 2026 13:26:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D969058043;
	Mon,  3 Aug 2026 13:26:42 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 13:26:42 +0000 (GMT)
Message-ID: <a438f0ba-e2b0-4fa5-920c-bdbf49769674@linux.ibm.com>
Date: Mon, 3 Aug 2026 18:56:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] nbd: Enable lock context analysis
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5e1f54d3826b0d479242a9886ca2c7b6eb8cedaf.1785440858.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExOSBTYWx0ZWRfXx7J7dFnMcek/
 YM1xDNE8Hwbm6rRJ6ET/uTmIBAwxVq/xCiLhp1b7tKe+8Ood7uKwrJ5JuIcQ6Odu8UVhmVJxOaQ
 QVdZ5IPQGmL0QWfJwNGI+WCm/FdJJeQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExOSBTYWx0ZWRfX9j+1aBJfofd+
 RAXhD+yufD0IyNIZVIenb4YthWgF81xEe93q/s0KnRl3lc7Kusga+C55PMCDUvpvx+Mr4q3cyOq
 3mKrVgMsv2B9yV1tmwlvbxGZV2H4Ras4tARrOQuydKIPNA5bBkBdR0IXCL/it5dDKX39hD0hJii
 I6T5MS9RCzN602/pZnlGn6rbiKwKJeJmUlNBiT5zdXkGdX3GZ/nK9Td4pm4LpVe3eH7uJIGitMr
 BC+OVQIzuThY4Zp4L4gp+IaBOWm4TnSNIHzBpjQEP0wmt93IOmdxDgkOfkET123Ad1nWo7qsWFg
 F4O7P8pWWbE8DTvEP2daah9MczXl8z3f/Noph1wx/2yp1gNsaTVCG2VZOxqXFhuXUYIJP3d1OxJ
 uQv6OLgDzfqvUnUA4a9hQ2EdHuceBsaTjYilfFvKm8pViwf/8Q7rU1q3bWDzZEL1tsvzDVGSkTn
 XxAM2lWBvt1+mUxomGA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a709717 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=N54-gffFAAAA:8
 a=RSw-Qr0oGjKtSaTCu8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Sj6QDZdugX7W5wnCZoGaMxbC7cBiaXFx
X-Proofpoint-GUID: zx2aXnfDv9ZVGy3306eHiup2f739DB2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030119

On 7/31/26 1:28 AM, Bart Van Assche wrote:
> Add __must_hold() annotations where these are missing. Document which mutex
> protects nbd_index_idr.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/nbd.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8f10762e90ef..751449d362b0 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -49,8 +49,8 @@
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/nbd.h>
>   
> -static DEFINE_IDR(nbd_index_idr);
>   static DEFINE_MUTEX(nbd_index_mutex);
> +static __guarded_by(&nbd_index_mutex) DEFINE_IDR(nbd_index_idr);

Maybe we should replace this with DEFINE_IDR_GUARDED() as I mentioned
in previous email.

>   static struct workqueue_struct *nbd_del_wq;
>   static int nbd_total_devices = 0;
>   
> @@ -1506,6 +1506,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>   }
>   
>   static int nbd_start_device(struct nbd_device *nbd)
> +	__must_hold(&nbd->config_lock)
>   {
>   	struct nbd_config *config = nbd->config;
>   	int num_connections = config->num_connections;
> @@ -1578,6 +1579,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>   }
>   
>   static int nbd_start_device_ioctl(struct nbd_device *nbd)
> +	__must_hold(&nbd->config_lock)
>   {
>   	struct nbd_config *config = nbd->config;
>   	int ret;
> @@ -1629,6 +1631,7 @@ static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
>   /* Must be called with config_lock held */
>   static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   		       unsigned int cmd, unsigned long arg)
> +	__must_hold(&nbd->config_lock)
>   {
>   	struct nbd_config *config = nbd->config;
>   	loff_t bytesize;
> @@ -2773,7 +2776,11 @@ static void __exit nbd_cleanup(void)
>   	/* Also wait for nbd_dev_remove_work() completes */
>   	destroy_workqueue(nbd_del_wq);
>   
> -	idr_destroy(&nbd_index_idr);
> +	{
> +		__assume_ctx_lock(&nbd_index_mutex);
> +		idr_destroy(&nbd_index_idr);
> +	}
> +

Could we instead introduce a scoped __assume_ctx_lock() helper so we don't need the
explicit scope here? Alternatively, would annotating nbd_cleanup() with __context_unsafe
be a better fit?

Thanks,
--Nilay




