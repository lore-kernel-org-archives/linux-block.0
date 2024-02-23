Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059D67E8A
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686149; cv=none; b=NO/UMOoK9UN3Jn6SnGBmRs0BtfTgtVJ/2m9oLXbJh6M02pPOAKcAEz6jMoxspTQfk74Ip0D1czw4PP/TwOm6624pZWaMmfLjuRDUuKI9hPgCPz5GjQLtyodtag8spyv+xfiaYNlDo+RCULUiou0V5CgviV2i6nBk7tYHW6l65So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686149; c=relaxed/simple;
	bh=w63yswG8lGrkf2M87zGIE16vi99FM/aje6Ew5jN1v/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1Y+T0jhFWBzbBnzcBTxUe1sxGSQSIUhzmr4kSxqiZrwjrgUAbkcEJC9tgJNV5UGhN0mfE9nMJyEmNhRUZsf5Y+kPaNHCOXyAbh+4ZqbfbIPu1ardE0d0vDD/GgCkc6mH1IcLdP1sL7rlVzAmDHsxB5+3qnMtJpDAT470Twb36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J7VHH3kb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J7VHH3kb"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NAvRSG012354;
	Fri, 23 Feb 2024 11:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5WRc2gTyI5CWluuu1yTf9ff0mo1UJm9yTlV2dIupfY0=;
 b=J7VHH3kbELZo8yzHtAp1sF/sGSZ7RwxaGiCuX7T/cyisYmKd8eGQuuJBm50SfxAtG+Ie
 uHeTPEn+Jy0t+UzcyFjLzYWDIvXc8QArYr7UtcxlV51sdVBKgz0SUDzio3eLv7dfeVvj
 3FltNFFwMHM4+DYWOazDBwqmoTgrtHOkENoxESqzQmyllGDLtqtwqfVWCkY66/s7nJwO
 Ox9ReZXI4T5aNV14AzYAky/TwaCMXPwIh+aAZqYJM4uLBWpG+GDvkFeVsliiXuGZvkpp
 x0CgRak4PsIp+Txd971P0rkncGvYi2tyHbtgeScR3DzR+5ePAEuqWhhIbyxofBx8LeGC aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wet2drbp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:02:19 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NAvagE013321;
	Fri, 23 Feb 2024 11:01:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wet2dr9wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:01:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N9bd58031153;
	Fri, 23 Feb 2024 11:00:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmce45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:00:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NB0KMp20710058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 11:00:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4B9B58063;
	Fri, 23 Feb 2024 11:00:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 968EF58065;
	Fri, 23 Feb 2024 11:00:16 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 11:00:16 +0000 (GMT)
Message-ID: <50f7c805-d562-4084-8f4f-4bf0e223ddde@linux.ibm.com>
Date: Fri, 23 Feb 2024 16:30:14 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 4/4] blk-lib: check for kill signal
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.org, ming.lei@redhat.com, chaitanyak@nvidia.com,
        Keith Busch <kbusch@kernel.org>, Conrad Meyer <conradmeyer@meta.com>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <20240222191922.2130580-5-kbusch@meta.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240222191922.2130580-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 85qhkmu3EA1_LTC4hRazysYrPjxBdpve
X-Proofpoint-ORIG-GUID: oW_bM5d0Av-mJZNjCRVmn3UeiZq0u0Fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230078



On 2/23/24 00:49, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some of these block operations can access a significant capacity and
> take longer than the user expected. A user may change their mind about
> wanting to run that command and attempt to kill the process and do
> something else with their device. But since the task is uninterruptable,
> they have to wait for it to finish, which could be many hours.
> 
> Check for a fatal signal at each iteration so the user doesn't have to
> wait for their regretted operation to complete naturally.
> 
> Reported-by: Conrad Meyer <conradmeyer@meta.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-lib.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index d4c476cf3784a..9e594f641ce72 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -35,6 +35,23 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
>  	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
>  }
>  
> +static void abort_bio_endio(struct bio *bio)
> +{
> +	complete(bio->bi_private);
> +	bio_put(bio);
> +}
> +
> +static void abort_bio(struct bio *bio)
> +{
> +	DECLARE_COMPLETION_ONSTACK_MAP(done,
> +			bio->bi_bdev->bd_disk->lockdep_map);
> +
> +	bio->bi_private = &done;
> +	bio->bi_end_io = abort_bio_endio;
> +	bio_endio(bio);
> +	blk_wait_io(&done);
> +}
> +

> @@ -143,6 +164,10 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		nr_sects -= len;
>  		sector += len;
>  		cond_resched();
> +		if (fatal_signal_pending(current)) {
> +			abort_bio(bio);
> +			return -EINTR;
> +		}
>  	}
>  
>  	*biop = bio;
> @@ -187,6 +212,10 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
>  				break;
>  		}
>  		cond_resched();
> +		if (fatal_signal_pending(current)) {
> +			abort_bio(bio);
> +			return -EINTR;
> +		}
>  	}
>  

If a device with large capacity supports write zero offload and user kills that
long outstanding write zero operation then it appears we run through the fatal_signal_pending()
and abort_bio() twice: once under __blkdev_issue_write_zeroes() and then latter under 
__blkdev_issue_zero_pages(). The entry to __blkdev_issue_zero_pages() happens if 
__blkdev_issue_write_zeroes() returns the error code and BLKDEV_ZERO_NOFALLBACK is NOT 
specified in flags.

I think if fatal signal is intercepted while running __blkdev_issue_write_zeroes() then we 
shouldn't need to re-enter the __blkdev_issue_zero_pages(). We may want to add following code:

@@ -280,7 +306,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
                bio_put(bio);
        }
        blk_finish_plug(&plug);
-       if (ret && try_write_zeroes) {
+       if (ret && ret != -EINTR && try_write_zeroes) {
                if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
                        try_write_zeroes = false;
                        goto retry;

Thanks,
--Nilay


















