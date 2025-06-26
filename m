Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635264C83;
	Thu, 26 Jun 2025 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915903; cv=none; b=DJgTqnTxzCcpam3X/58K0jIHCO9jHTmx7lNmyElfBT7KRckVT1AW52Xctqb3kw0+gsrFxF/HzRq0sv3YwD/T7DyvemlnD56dbalYYfN1PRGQA+HEMRDNUwIElXl4p7yexaZeuAcoMT8J3eTXshDm5EBF9Z8W1wKaAQY1FsiN6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915903; c=relaxed/simple;
	bh=qWBf9bYZau35U4VEUb3AywJF4qMV9c74VzBOnBg13fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fX6JNkEyU1xuz+aDB6+A5cX5ZpGzFAdGGbGg503OtMe/kKTCPgXgstBBzFmtkSB+GHmWh2Nky+6BdQCDEU9qv6509rPT5IHWQs4AZE/dpbYb52720vOq5gNZ7E2pUVzfADsCemDCpfDap+DNCIxfVFb5n7WF5g67LmZefvriljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zj6g/O/W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zj6g/O/W"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4Ao3j032470;
	Thu, 26 Jun 2025 05:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AXwSZ/
	zoFeba5RSC5tnwiz8ZLTt2rZVbUAdgZvUgTyg=; b=Zj6g/O/W+jyTrKN3E1CIK+
	juwIpz6EzU+6Jw9iKBzSfNZjNuXjiKLT4hMkv22yrzaIMVOcDfNvY9n1pDXYi8g5
	XtLNA5lzRRVsYwnE4qzMDwn+LwWcAslm99rMsrvvS+hXQoR7i+L3lHYDlhjpTOrO
	oHEtI4yWyCW3UKVaXlmRoWWioQ6npr0dIrU+KYC5XKVpnl1rSlv/yhj2W9tURW1i
	ndt+1yOInUVzzQ/rkHhenyzA3l6aBNhFyKHNXvlsnqaSIk0SCVrGud9sUWzSrzfF
	5yFTaFuJajJ0wROww0NUgGgCBoD4nGDC9FlVB6eEegXMY2GyEujO1kkqn8KhpMCA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u481n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:31:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4XPHl006329;
	Thu, 26 Jun 2025 05:31:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pdbqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:31:25 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q5VPuY28639780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 05:31:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FFA158056;
	Thu, 26 Jun 2025 05:31:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F32B58061;
	Thu, 26 Jun 2025 05:31:23 +0000 (GMT)
Received: from [9.109.198.209] (unknown [9.109.198.209])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 05:31:22 +0000 (GMT)
Message-ID: <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
Date: Thu, 26 Jun 2025 11:01:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250625195450.1172740-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vjp1lTMLuhbR8PGcWqNzWjbrDr-UHh8u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0MCBTYWx0ZWRfX5iJfb1o90Rs1 pjIcgRECdwd7gr2NzGvUKgDebpUR0XL8GHoAeDDe6aocDWfMt+dZaLWu74Qw99cDsjsd+U6Txoa hzmumNbEaz2u3q7ic3RPizyQ75MQqY61+4Du3nVkkvh6GLpblylHhAYNN55XNB9YKeCUqpBOBvC
 D6LJL2DMo1T87zBh12mpiquKNpM3FaFF0oFXyMcFy4pxh2HKMN5wqOZiXHqUcP1zsYQAJoNiq/W NdecC6DcMlvtZWGPGWa4cVw6Fc8dLBexhJ5b74iDcAwdN9tU4YgsDVyRfzBngpkwqeCFlcWhdMN dntdsqSbzgnM/TJ/QEw6TPGa815UuYvmE7AekjmnJn8QUcAstaQBdKGI08t02lzSbjBMVSHA3v7
 LPa5/u2WvPJDMmP/q8cb+RAM6VdL1UtDTnNolBXgKmlS2W1jyacPCsSRac7pw4l6pYHhFFW9
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685cdb2e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=n9A0ujWuVjVftbXWBU0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vjp1lTMLuhbR8PGcWqNzWjbrDr-UHh8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260040



On 6/26/25 1:24 AM, Bart Van Assche wrote:
> Every time I run test srp/002 the following deadlock is triggered:
> 
> task:multipathd
> Call Trace:
>  <TASK>
>  __schedule+0x8c1/0x1bf0
>  schedule+0xdd/0x270
>  schedule_preempt_disabled+0x1c/0x30
>  __mutex_lock+0xb89/0x1650
>  mutex_lock_nested+0x1f/0x30
>  dm_table_set_restrictions+0x823/0xdf0
>  __bind+0x166/0x590
>  dm_swap_table+0x2a7/0x490
>  do_resume+0x1b1/0x610
>  dev_suspend+0x55/0x1a0
>  ctl_ioctl+0x3a5/0x7e0
>  dm_ctl_ioctl+0x12/0x20
>  __x64_sys_ioctl+0x127/0x1a0
>  x64_sys_call+0xe2b/0x17d0
>  do_syscall_64+0x96/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  </TASK>
> task:(udev-worker)
> Call Trace:
>  <TASK>
>  __schedule+0x8c1/0x1bf0
>  schedule+0xdd/0x270
>  blk_mq_freeze_queue_wait+0xf2/0x140
>  blk_mq_freeze_queue_nomemsave+0x23/0x30
>  queue_ra_store+0x14e/0x290
>  queue_attr_store+0x23e/0x2c0
>  sysfs_kf_write+0xde/0x140
>  kernfs_fop_write_iter+0x3b2/0x630
>  vfs_write+0x4fd/0x1390
>  ksys_write+0xfd/0x230
>  __x64_sys_write+0x76/0xc0
>  x64_sys_call+0x276/0x17d0
>  do_syscall_64+0x96/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  </TASK>

It seems that some other thread on your system acquired 
->freeze_lock and never released it and that prevents 
the udev-worker thread to forward progress. As udev-worker
couldn't forward progress, it also now prevents the 
multipathd to make progress (as multipathd is pending
on ->limits_lock which has been acquired by udev-worker).

If you haven't enabled lockdep on your system then can you 
please configure lockdep and rerun the srp/002 test?
I think, you shall encounter a lockdep splat and that
shall help further investigate the deadlock. 

Thanks,
--Nilay


