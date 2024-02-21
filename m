Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CC3A269
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505196; cv=none; b=VSL6hCz+Vh00kgYAB/OF2ZzlMDamaY7+W28ohzZJ8AAUpTTymkDkkmyvnNSH695GlgrUZTvqCh0fkJuKXXGfVEKCvtz3Yq6ez9jnrCzUq0aDAjgU3NTa936l7d9OaPGOV1SrHoitRqSN4HdYpf69bhr81wUgQ+W6Qt8T+cyqbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505196; c=relaxed/simple;
	bh=HqkrB7nWTaxLzUbKFdxGXwMLGycU3FOInB4cRbIsRbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYXFdlN+TWhQopy+IZRnKBA9wM9OHdDhPxu4HeT609MAADHGnZN238j5ozRbn5XdDvf+2YZvvDNntcW7gKFO2ahIf5TrVLCc3+IGOn4eyx2mvLfzQRZWN/xi89s1jndC5D59j29QLShNKl0be3EFbQJWvmXRy900U4wsZDTp9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7kcQzoW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7kcQzoW"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L7uIps011670;
	Wed, 21 Feb 2024 08:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kEy5jd4SLor7kZl55T4ax1pl+BJ/xpy3fC6DmRrIB0Q=;
 b=R7kcQzoW29XYPo/U8GfH7EcXe/LUN4Gw+TtQfjXJV/7evVUf32F+RQ8n7kHkpb3xAQut
 +PJ0Ji7ePqod58nC0sjRBs+4Tq9olbUmJSLM6r119KxshvoWcgfBCVNu1eYNuRIXEaKt
 2ptYF5WgMHANc0iTwuhC/YhThXIEElKvCGaOe4nH03Mr3jZktsrj86R86fjEpvQWxqeL
 XmcM3ZojcyFkYDIaE4sRlzO0BenR1faAHJcMbBnXCDoJydCto2sinGicXDPHd+mU2Uml
 WewNXYMhruMz0QiJSjw14q1fFQd97fisQtjHKWymbRnyzIZKQNBHhG4P2gMoYlK3DVDY DA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdb443wrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 08:46:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41L61KF3009547;
	Wed, 21 Feb 2024 08:46:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pdw5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 08:46:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41L8kRVd11797122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 08:46:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EF5E58060;
	Wed, 21 Feb 2024 08:46:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8BA5803F;
	Wed, 21 Feb 2024 08:46:25 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 08:46:25 +0000 (GMT)
Message-ID: <1599adf2-3099-457d-a194-3be0057d344e@linux.ibm.com>
Date: Wed, 21 Feb 2024 14:16:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20240220204127.1937085-1-kbusch@meta.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240220204127.1937085-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4mnR1IsSt26dsV8BJLkTKAVYk-BpIo98
X-Proofpoint-ORIG-GUID: 4mnR1IsSt26dsV8BJLkTKAVYk-BpIo98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=911
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210068



On 2/21/24 02:11, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If a user runs something like `blkdiscard -z /dev/sda`, and the device
> does not have an efficient write zero offload, the kernel will dispatch
> long chains of bio's using the ZERO_PAGE for the entire capacity of the
> device. If the capacity is very large, this process could take a long
> time in an uninterruptable state, which the user may want to abort.
> Check between batches for the user's request to kill the process so they
> don't need to wait potentially many hours.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-lib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e59c3069e8351..d5c334aa98e0d 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -190,6 +190,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
>  				break;
>  		}
>  		cond_resched();
> +		if (fatal_signal_pending(current))
> +			break;
>  	}
>  
>  	*biop = bio;

I have an NVMe device which supports write offload. The total size of this disk is ~1.5 TB.
When I tried zero out the whole NVMe drive it took more than 10 minutes. Please see below:

# cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes 
8388608

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0x1749a956
ncap    : 0x1749a956
nuse    : 0x1749a956
<snip>
nvmcap  : 1600321314816
<snip>
LBA Format  0 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best (in use)
<snip>

# time blkdiscard -z /dev/nvme0n1 

real	10m27.514s
user	0m0.000s
sys	0m0.369s

So shouldn't we need to add the same code (allowing user to kill the process) under 
__blkdev_issue_write_zeroes()? I think even though a drive supports "write zero offload", if
drive has a very large capacity then it would take up a lot of time to zero out the complete drive. 
Yes the time required may not be in hours in this case but it could be in tens of minutes depending 
on the drive capacity.

Thanks,
--Nilay

