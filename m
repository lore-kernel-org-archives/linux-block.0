Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7579DDC
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688972; cv=none; b=lqX4thXzLZ0HVVDI/KdkSW4MhiTyRmhh1jGLKTkOnDvtUxtB71omWQBoB3q/DdbbB79Y+X/2/ymVg4HcBL8l2I1ahDIduz6S6/1mUVcKsEU8LRieE/uv1k6JbhoVb7lp+PkM6NDtc+dHP8+AG04h0UB0bgod/AghR5P8Qalpsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688972; c=relaxed/simple;
	bh=LIU7ZwH2LxKHaOVl/nXw+ot3M1oDUr/PXjzC8M99ShU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgaOtvG29Qf7VB2KHS1GUShLgqliEoMg8K2BTb489o7VgKDn46goeYQnQRKaJCbvbG7OExoHFomtFe/0hS44ctslFatniFZ1GeJKDqXW3xZ4paGnUZ91ehYR6woTCBMFF8fVG20boxT/n5oEDpqE6W731cJs4TOVqgSJ808LuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HKFwG7V4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HKFwG7V4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NBR5mW029496;
	Fri, 23 Feb 2024 11:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sFD2eZnC3tk/j2TaPXyLNAKg8WTUz+YtR7YTCrrixr4=;
 b=HKFwG7V4akcl/TrxxFAnqdAxO249KwY5huH8Qy1ch/6ctiGuNKGM/K624Unm/hTwzo5g
 KDSGw1qOLxePqjdMz6wFxby39HjHkXsZ/Sf7BjkCxIxlfNZOLyqd0DsqS/pn2jdULoQU
 vpev9P80J6saEcthibccHiYb26AgrsbeWPOGDSCqLil/nN5E5ovKstM/QSJq2K/IpUCl
 hgql1ugFk/VbzKr5o2r1TaBu/UFdN/4pkk1nLwdkJD0iex6p1YfHNUo5mTAzO2g5Hzvm
 loxZ3SDAcTrh4NjtbDl3XpYjKt287NyB/yCFcoBJ8qVhe3F1k82yT4S0ZSxWwYFfxnTs kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wet9ngvn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:49:24 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NBRBMH030352;
	Fri, 23 Feb 2024 11:49:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wet9ngvmm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:49:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N8jOaT009577;
	Fri, 23 Feb 2024 11:25:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pvysv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:25:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NBPt8i28901868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 11:25:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316BE58064;
	Fri, 23 Feb 2024 11:25:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 257A258052;
	Fri, 23 Feb 2024 11:25:53 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 11:25:52 +0000 (GMT)
Message-ID: <a17a6587-7565-46ee-a321-2ffce9ce7d86@linux.ibm.com>
Date: Fri, 23 Feb 2024 16:55:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/4] block: make long runnint operations killable
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.org, ming.lei@redhat.com, chaitanyak@nvidia.com,
        Keith Busch <kbusch@kernel.org>
References: <20240222191922.2130580-1-kbusch@meta.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240222191922.2130580-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NR3BDJNO-GQvdKjoi6aQhMMtkgEYKKNO
X-Proofpoint-ORIG-GUID: 83RuZ10oiZlaISzcCtKSeco-QwEwadIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230084



On 2/23/24 00:49, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Changes from v2:
> 
>   Wait for chained bio's to complete before returning from kill signal.
> 
>   Miscellaneous cleanup patches for style and consistency.
> 
> Keith Busch (4):
>   block: blkdev_issue_secure_erase loop style
>   block: cleanup __blkdev_issue_write_zeroes
>   block: io wait hang check helper
>   blk-lib: check for kill signal
> 
>  block/bio.c     | 12 +----------
>  block/blk-lib.c | 57 ++++++++++++++++++++++++++++++++++++++-----------
>  block/blk-mq.c  | 19 +++--------------
>  block/blk.h     | 13 +++++++++++
>  4 files changed, 61 insertions(+), 40 deletions(-)
> 

I tried applying patchset using "git am" but it failed to apply. Was the patchset 
created against the latest v6.8-rc5? Latter I applied the patchet manually. 

I have tested the changes on my NVMe with ~1.5 TB capacity and verified that
the patch fixed the reported issue.

NVMe details:

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

# cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes 
8388608
# cat /sys/block/nvme0n1/queue/discard_granularity 
4096
# cat /sys/block/nvme0n1/queue/discard_max_bytes 
2199023255040
 
I tested following cases:
1) Zero-fill all sectors of NVMe using blkdiscard; While test is running 
   kill the 'blkdiscard' from other terminal and check the return status

   # blkdiscars -z /dev/nvme0n1
   Killed
   # echo $?
   137

2) Discard all sectors of NVMe using blkdiscard, While test is running kill 
   the 'blkdiscard' from other terminal

   # blkdiscard /dev/nvme0n1
   Killed
   #echo $?
   137

The bash return the status code 137 which signifies that 'blkdiscard' is killed.

My NVMe doesn't support secure erase operation so I couldn't test it. 
   # blkdiscard -s /dev/nvme0n1 
   blkdiscard: /dev/nvme0n1: BLKSECDISCARD ioctl failed: Operation not supported

Feel free to add:

Tested-by: Nilay Shroff<nilay@linux.ibm.com>

Thanks,
--Nilay
