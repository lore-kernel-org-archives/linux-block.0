Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD5218ADC;
	Tue,  1 Jul 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751346803; cv=none; b=owZrOsCfdUNuNE6YEPWzAumwjfMpGyzt3uch5cyadjlN2Xuz2Zg/6cCiQpUI41i0SryCa1PUOYyLXzeOHa+Ri+VTtW6zCxWpmDgvG/rsEtXsPR57lozyeDXSrYJWBlUOaR2hjl+iRxHDOcKtWHZ8UQQ0w5KUnDe7RjOEFbdtsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751346803; c=relaxed/simple;
	bh=XV03swUuxNU+I7PC4PoXIuOb+XDnLGJjpePjbo2H7M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiFa7exHFN+vrFr8RIa+/pRXsumYdt7whPRz4Bh6dxeh5S0OrF8/D7DbYvKzP+MZ96ZseRJ8Gmf+An/lSDNxXz8F9MDh42SY25SxUws1yoJnQOg53GXQU6V2dYRFgkUF1aac5aCdiJNjQ/UGMI2f/PQcfnCRmsc8vCVGPVexFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S0YrzViy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0YrzViy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5612sdch003793;
	Tue, 1 Jul 2025 05:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VNJ6ud
	eGAYz1ol/IGC4dxgmwoyOxvNXq1BigLmffIvA=; b=S0YrzViy7C1dbRQXirhQHV
	2cZdo++VzUcrZu2JzSDKf8FHfnFBzkoVp8HWTXseSL/YHX28Kk9UURtgoC1Slg2a
	l51+xmIWEXM7/qoB8XoFYMgZB9VUj4IgZcteGBiUqmL/VZRueP4mn68CSAKpMpas
	DjUpszKHijoIkkvMhPmluT/0Yhwl7t/MX+NzAAz2N0pPefRoOhQ6WaG7NuDNKcCm
	xwDDVW0ToLTXOkbW8k9BM6Rj5/pxMwlLa+reISpnPJ4ASelqDZGLsEEUtrA+p17p
	uTYzzxQZ/UB4AaY3T9JU62FolJSvTeQAVJpUImdxYH13nYvuXO2LNHQ+lKBP+7Ow
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d5dbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:13:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5614U2lT006841;
	Tue, 1 Jul 2025 05:13:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm8y3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:13:03 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5615D3GZ17760912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 05:13:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23ADA58045;
	Tue,  1 Jul 2025 05:13:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9789658054;
	Tue,  1 Jul 2025 05:12:50 +0000 (GMT)
Received: from [9.109.198.197] (unknown [9.109.198.197])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 05:12:48 +0000 (GMT)
Message-ID: <86eee32c-f83e-4af2-849a-34beb82be5ce@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:42:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
References: <20250626203713.2258558-1-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250626203713.2258558-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sl5GLMJyhFKhFm9adhc1SMxoikWHncSj
X-Proofpoint-GUID: Sl5GLMJyhFKhFm9adhc1SMxoikWHncSj
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68636e61 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=N54-gffFAAAA:8 a=BzWE9k2HBGNmBK6PzhQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyMSBTYWx0ZWRfXz1NgCzKKRhMy eMRTrp5kJkkdmrsBJleFTrxLf2gm/+LNE1yfqcOrYo2akxkNz1Nwk63YFlsDLoMwJLF3NLg6HG7 GlSvh2sO9DOxUWXvC/s1zr2yzBSVdscS/gvsXfiSWR5P95GkHMzSvmv7x1vWvx52giK4OxlrWZk
 mIsCvT2bAr+8ARUkv/x8b4KRLGVUjkiCagn4PQHCqTIXLqG4mGLrPORjtoLfmQ+CTS7ls3yA9Qc t3LvSR1Dg05DPt5msKQv8n3xY3PP3PrBbYkK/SG9VEdepvK2vEQOyOQDAY32lZvhW7b5OGPCSFx OFNMAY4BfCVpzRIyWVI5+ypTr9FiYJNMs9xWjiBNW0Yo1aBTaqpGZ5fY02u5j64YXWFYM4WTQEK
 cOf0Vk9L28jhzalj+C3Pdv8/FG70SgcL/29Wqpk7A/hDY1lnHe5NEbnntu9NezxOGvfG6tqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010021



On 6/27/25 2:07 AM, Bart Van Assche wrote:
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
> 
> This deadlock happens because blk_mq_freeze_queue_nomemsave() waits for
> pending requests to finish. The pending requests do never complete because
> the dm-multipath queue_if_no_path option is enabled and the only path in
> the dm-multipath configuration is being removed.
> 
> Fix this deadlock by removing the queue freezing/unfreezing code from
> queue_ra_store().
> 
> Freezing the request queue from inside a block layer sysfs store callback
> function is essential when modifying parameters that affect how bios or
> requests are processed, e.g. parameters that affect bio_split_to_limit().
> Freezing the request queue when modifying parameters that do not affect bio
> nor request processing is not necessary.
> 
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: b07a889e8335 ("block: move q->sysfs_lock and queue-freeze under show/store method")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
I hope we'd address other sysfs store attributes requiring queue-freeze
in another patch. So with that,

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


