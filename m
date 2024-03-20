Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2417573
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914038; cv=none; b=fYateZE0CsZgnhc0udRLGujVs11IMvMsK1FPg9L89nOANS+gUHMfPjLgkfhjZxUK1ja4GvtFqzNFJ2QaY72ZfNu2bXnoEaDFUmlYI9KS4shhH1yjROOAfhIP9yJoZaTn77fnxC7z04EnWzezvMNonsRA4AzE9LvxcGwnO+CwvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914038; c=relaxed/simple;
	bh=kC72Q3h4tUXy546tULB2wZzDaTwr0k7BoXSf5/CSh4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnF0Ky6fW+cZlPv/DRE63oOqDaEC093bsItMpCaUmjTQP1EkvpKvWQGYKr39Dz0np1n+P/30/T/wwwQF0nprAHbb1p5359SoBxLvGRofj8G8KQMjwl+0NvRrpc6wGXwIV73I0ovtZB1oBk19fF+SlIJn3qC//8AgFOGfW9DmZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FKwQzHAJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FKwQzHAJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42K3a71i021816;
	Wed, 20 Mar 2024 05:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EXlaoKWpgN6Av4BFc/ZP6+DVfwrVmD9nyb3gs1nY39w=;
 b=FKwQzHAJPI6TrFwNdtuLOxF247XTkpYCbdemW+08QhUc2InqxDB3T2FI+lvQNbaYLYmB
 0mCe096UYkZuKtnFIFpr3xX/LNomIqLzMO/v729JujyBJBAnKG+74atpBiHqsAQz0KL9
 xbnFjnYn3IaWTs2TY2512T9hFr/8PygqmPPiMjzeseAlGF70Nuo2bEqXPBNhACVlhQrT
 r81qR3LGnhRCdL2qnm6hmdrGIfbZDKj2Wz/rxDkYRaZsR9+osR1x+Sd/kUQdhbST9OV9
 3+FfbCHr019kpW4w5g0XCDpEKb2U7h/+nWh8hQrCRCzKnqGLqiCzL9H0duOzqSSywElb KQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wynmv8cpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:53:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42K41XQd015792;
	Wed, 20 Mar 2024 05:53:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp504ksn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 05:53:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42K5rV2424773322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 05:53:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3983058052;
	Wed, 20 Mar 2024 05:53:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1407A5806E;
	Wed, 20 Mar 2024 05:53:29 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Mar 2024 05:53:28 +0000 (GMT)
Message-ID: <239228ec-6c8d-432c-905d-b477014deee3@linux.ibm.com>
Date: Wed, 20 Mar 2024 11:23:27 +0530
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
 <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
 <ZfjLyfptPVT7wa0_@infradead.org> <ZfpHvyjT6kbQKrPF@infradead.org>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZfpHvyjT6kbQKrPF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 69DDn7EcV-b1ECi-aJBnjFSgviqqXVNX
X-Proofpoint-GUID: 69DDn7EcV-b1ECi-aJBnjFSgviqqXVNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_02,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403200042



On 3/20/24 07:49, Christoph Hellwig wrote:
> Can you try this patch instead?
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 00864a63447099..4bac54d4e0015b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2204,6 +2204,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  	}
>  
>  	if (!ret && nvme_ns_head_multipath(ns->head)) {
> +		struct queue_limits *ns_lim = &ns->disk->queue->limits;
>  		struct queue_limits lim;
>  
>  		blk_mq_freeze_queue(ns->head->disk->queue);
> @@ -2215,7 +2216,26 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>  		nvme_mpath_revalidate_paths(ns);
>  
> +		/*
> +		 * queue_limits mixes values that are the hardware limitations
> +		 * for bio splitting with what is the device configuration.
> +		 *
> +		 * For NVMe the device configuration can change after e.g. a
> +		 * Format command, and we really want to pick up the new format
> +		 * value here.  But we must still stack the queue limits to the
> +		 * least common denominator for multipathing to split the bios
> +		 * properly.
> +		 *
> +		 * To work around this, we explicitly set the device
> +		 * configuration to those that we just queried, but only stack
> +		 * the splitting limits in to make sure we still obey possibly
> +		 * lower limitations of other controllers.
> +		 */
>  		lim = queue_limits_start_update(ns->head->disk->queue);
> +		lim.logical_block_size = ns_lim->logical_block_size;
> +		lim.physical_block_size = ns_lim->physical_block_size;
> +		lim.io_min = ns_lim->io_min;
> +		lim.io_opt = ns_lim->io_opt;
>  		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
>  					ns->head->disk->disk_name);
>  		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
> 

I have just tested the above patch and it's working as expected. With the above patch,
I don't see any issue formatting the NVMe disk with block-size of 512. Looks good to me.

Thanks,
--Nilay

PS: For reference, please find below test result obtained using the above patch.
--------------------------------------------------------------------------------

# lspci 
0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

# nvme list 
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            S6EUNA0R500358       1.6TB NVMe Gen4 U.2 SSD                  0x1          1.60  TB /   1.60  TB      4 KiB +  0 B   REV.SN49

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0xba4d4ab0
ncap    : 0xba4d4ab0
nuse    : 0xba4d4ab0
nsfeat  : 0
  [4:4] : 0	NPWG, NPWA, NPDG, NPDA, and NOWS are Not Supported
  [3:3] : 0	NGUID and EUI64 fields if non-zero, Reused
  [2:2] : 0	Deallocated or Unwritten Logical Block error Not Supported
  [1:1] : 0	Namespace uses AWUN, AWUPF, and ACWU
  [0:0] : 0	Thin Provisioning Not Supported

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

<< The nvme disk has block size of 4096; now format it with block size of 512

# nvme format /dev/nvme0n1 --lbaf=2 --pil=0 --ms=0 --pi=0 -f 
Success formatting namespace:1

>> Success formatting; no error seen

# lsblk -t /dev/nvme0n1 
NAME    ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE  RA WSAME
nvme0n1         0    512      0     512     512    0               128    0B
                                    ^^^     ^^^
# cat /sys/block/nvme0n1/queue/logical_block_size:512
# cat /sys/block/nvme0n1/queue/physical_block_size:512
# cat /sys/block/nvme0n1/queue/optimal_io_size:0
# cat /sys/block/nvme0n1/queue/minimum_io_size:512

# cat /sys/block/nvme0c0n1/queue/logical_block_size:512
# cat /sys/block/nvme0c0n1/queue/physical_block_size:512
# cat /sys/block/nvme0c0n1/queue/optimal_io_size:0
# cat /sys/block/nvme0c0n1/queue/minimum_io_size:512

# nvme id-ns /dev/nvme0n1 -H 
NVME Identify Namespace 1:
nsze    : 0xba4d4ab0
ncap    : 0xba4d4ab0
nuse    : 0xba4d4ab0
nsfeat  : 0
  [4:4] : 0	NPWG, NPWA, NPDG, NPDA, and NOWS are Not Supported
  [3:3] : 0	NGUID and EUI64 fields if non-zero, Reused
  [2:2] : 0	Deallocated or Unwritten Logical Block error Not Supported
  [1:1] : 0	Namespace uses AWUN, AWUPF, and ACWU
  [0:0] : 0	Thin Provisioning Not Supported

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

