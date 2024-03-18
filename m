Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF221101
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737836; cv=none; b=UMOCJKWXA9Pk/Vr49+trisVdj9bDQGczNZ3z2hPoE4B5lNWIRDdB64qPIe5GT/EnIE7FLXwnenWtYDoTbBCwogfARcKQEkiQkAKL85+tdcTuqeYPjHYBjTCmmnSAzB0kacfw/VmJFEAzJjSy+DJYsQPRM7hsAhXBmLA6HILkteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737836; c=relaxed/simple;
	bh=ud1/49NRfcbP8TYH5uVYmMnkQxaN4KATb++Dp+3Wlew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7Ywu5tYriCcxdpyrtNN0co8Z7S2LowKXvh25w7pv7PKbbrkegmSvprRVY6btvjkR0jnlyc2JkeEbW+IV3a6xgpBTUPpdwqEKF0zaNNPyUyaJtSyXBZ7jrSQIegnteiA6VdvHwjKkTtQqKVaAdwDzA3b6UETDUx1D/9HxZFQsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKAZqhlg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKAZqhlg"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I35ndd004365;
	Mon, 18 Mar 2024 04:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v5L7lh/a+t7eAdrypWUXnwdT7MkPeryuyuu/G85JzjE=;
 b=VKAZqhlg/z9hFwwSQbIuW46hQgYt3eCCyNDgoerzbb95JRYLPr1UFvzomNt8CFgHlMK6
 h2kP70MV/KuCy/DWw36lndR6Xp+SXUwWobcTwlz5Ocp+A82tErJbDeQ5RaHW7BZgEWou
 fJ+onngKrj0N65Mj3LIhdDQ83P0FoDA5w+Cl3wTBUpjOYbV/oC3vwkr+vPZH9wow+Ild
 gcf6RYY6fkbfCu7m5/RvN4JkvXrTd+U2f2HD+Z8U0dQKuhTn/4ZQ3BzxeYS9J5ZuOhXn
 FxkWfW36yeEgLcLtJm8bLtooH3KcB+6DDupssrsRYCjFq2Re77SJYi4Ht2T6ZGfOvpH9 tg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ww9s05jfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 04:56:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42I21KH9017242;
	Mon, 18 Mar 2024 04:56:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrsxwau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 04:56:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42I4uRm148693688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 04:56:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B9B658056;
	Mon, 18 Mar 2024 04:56:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A3FB5805A;
	Mon, 18 Mar 2024 04:56:25 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 04:56:24 +0000 (GMT)
Message-ID: <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
Date: Mon, 18 Mar 2024 10:26:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
 <Zfekbf0V5Dpsk_nf@infradead.org>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zfekbf0V5Dpsk_nf@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4qECqz-1es8RWUluMKtXKV9-i4vlPY6I
X-Proofpoint-GUID: 4qECqz-1es8RWUluMKtXKV9-i4vlPY6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180035

Hi Christoph,

On 3/18/24 07:48, Christoph Hellwig wrote:
> Hi Nilay,
> 
> thanks for the report!
> 
> I'm currently travelling without easy hardware access, but can you try
> the patch below?  This simply rebuilds the limits from scratch.  It
> probably wants a bit of a cleanup if it works, but this should be
> fine for testing:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 00864a63447099..9ef41e65fc83bd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2215,10 +2215,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>  		nvme_mpath_revalidate_paths(ns);
>  
> -		lim = queue_limits_start_update(ns->head->disk->queue);
> +		blk_set_stacking_limits(&lim);
> +		lim.dma_alignment = 3;
> +		if (info->ids.csi != NVME_CSI_ZNS)
> +			lim.max_zone_append_sectors = 0;
>  		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
>  					ns->head->disk->disk_name);
> -		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
> +		ret = queue_limits_set(ns->head->disk->queue, &lim);
>  		blk_mq_unfreeze_queue(ns->head->disk->queue);
>  	}
>  

I have just tested the above patch and it's working well as expected.
Now I don't see any issue formatting NVMe disk with the block-size of 512.
I think we should commit the above changes.

Feel free to add:

Tested-by: Nilay Shroff<nilay@linux.ibm.com>

Please find below the test result obtained using above patch for reference:
---------------------------------------------------------------------------

# lspci 
0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

# nvme list 
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            S6EUNA0R500358       1.6TB NVMe Gen4 U.2 SSD                  0x1          1.60  TB /   1.60  TB    512   B +  0 B   REV.SN49

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0xba4d4ab0
ncap    : 0xba4d4ab0
nuse    : 0xba4d4ab0

<snip>
<snip>

nlbaf   : 4
flbas   : 0
  [6:5] : 0	Most significant 2 bits of Current LBA Format Selected
  [4:4] : 0	Metadata Transferred in Separate Contiguous Buffer
  [3:0] : 0	Least significant 4 bits of Current LBA Format Selected
  
<snip>
<snip>  

LBA Format  0 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best (in use)
LBA Format  1 : Metadata Size: 8   bytes - Data Size: 4096 bytes - Relative Performance: 0x2 Good 
LBA Format  2 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x1 Better 
LBA Format  3 : Metadata Size: 8   bytes - Data Size: 512 bytes - Relative Performance: 0x3 Degraded 
LBA Format  4 : Metadata Size: 64  bytes - Data Size: 4096 bytes - Relative Performance: 0x3 Degraded 

# lsblk -t /dev/nvme0n1 
NAME    ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE  RA WSAME
nvme0n1         0   4096      0    4096    4096    0               128    0B
                                   ^^^     ^^^ 	

<<<< The nvme disk has block size of 4096, now format it with block size of 512

# nvme format /dev/nvme0n1 --lbaf=2 --pil=0 --ms=0 --pi=0 -f 
Success formatting namespace:1

>>>> Success formatting; no error seen

# lsblk -t /dev/nvme0n1 
NAME    ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE  RA WSAME
nvme0n1         0    512      0     512     512    0               128    0B
                                    ^^^     ^^^
# cat /sys/block/nvme0n1/queue/logical_block_size:512
# cat /sys/block/nvme0n1/queue/physical_block_size:512
# cat /sys/block/nvme0n1/queue/dma_alignment:3

# cat /sys/block/nvme0c0n1/queue/logical_block_size:512
# cat /sys/block/nvme0c0n1/queue/physical_block_size:512
# cat /sys/block/nvme0c0n1/queue/dma_alignment:3

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0xba4d4ab0
ncap    : 0xba4d4ab0
nuse    : 0xba4d4ab0
<snip>
<snip>
nlbaf   : 4
flbas   : 0x2
  [6:5] : 0	Most significant 2 bits of Current LBA Format Selected
  [4:4] : 0	Metadata Transferred in Separate Contiguous Buffer
  [3:0] : 0x2	Least significant 4 bits of Current LBA Format Selected
<snip>
<snip>

LBA Format  0 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0 Best 
LBA Format  1 : Metadata Size: 8   bytes - Data Size: 4096 bytes - Relative Performance: 0x2 Good 
LBA Format  2 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x1 Better (in use)
LBA Format  3 : Metadata Size: 8   bytes - Data Size: 512 bytes - Relative Performance: 0x3 Degraded 
LBA Format  4 : Metadata Size: 64  bytes - Data Size: 4096 bytes - Relative Performance: 0x3 Degraded 

Thanks,
--Nilay


