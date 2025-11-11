Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4B2D372A;
	Tue, 11 Nov 2025 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842351; cv=none; b=f14yMPpCHT2QQvJjs8qLOhMblrtEUibpH9RJV6z6gBbc7a+z4qJWSynKJl/PyJ6oO8/KlLdDS5TrIf7lyLUPHGyRJsRKAsV9WeaX2tJ9Kxh7bmmCe6tzpL38iwhbG19Cl65A43TwVAWkPg2gj+dd5xardrGsH6VR/tze3DYIGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842351; c=relaxed/simple;
	bh=PrOvrxOMLRkz9/KqS01eoVVnlaDdIKZJknjtUl83zuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZDFccbf1S6hev1ST3aLvV2PFE2fTN1EeccvKd0FD3vvRw8i3wV+SWBApEjmO21s6oQB97PydJxY8/LCS9Reext3IJjA0I0yOhxcPQ4vMP4FngIxYlSKNDEh/Nnio0EUdyDz+Bwzg9Bhs37DLSNmnPKNEfZnxmSTdxuVIWrkEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EYoChJJa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EYoChJJa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAJpWf2025937;
	Tue, 11 Nov 2025 06:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MR57gj
	T5Jx56+fB0v+eZgrev/zXuFKNk9D2ThUk4jO0=; b=EYoChJJaofqSGlI8p4SSLK
	8pq+xebdQMco/opaYrqBjHBPgOnzSWh88zGK+UHMuy1zxB+meeWAWCLcj5DOsHyO
	O9SLQ6jVyYGu6IQ37ZCYWNmpDqpXofFBXVR/DMO22Px3tm1VkvOAOCG7lNNeYTMx
	euf4xQfLrjepEwt+XWaehPJ7nUG8PnXKpX0exOcSSO0dpp8atB0wIMrixh6L6O6u
	8f45PRhU7hOsoDYWAS2fBSkmwhXLPHJro9ifZkU4/L+Ck0NJLMAuyC4HsbXzJ1No
	ta+K1r9YZ19BMHjUeB1lEZKk1DQ1SNzRG2yUoq/8E8Fdc1naQhloH/TAIAeM7n8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk83nwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:25:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5K8GX007375;
	Tue, 11 Nov 2025 06:25:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj971e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:25:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB6PU4f12124758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:25:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC085803F;
	Tue, 11 Nov 2025 06:25:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5756D5804E;
	Tue, 11 Nov 2025 06:25:26 +0000 (GMT)
Received: from [9.109.198.139] (unknown [9.109.198.139])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 06:25:26 +0000 (GMT)
Message-ID: <b1820392-f21b-4b68-81fa-0cf123c981ba@linux.ibm.com>
Date: Tue, 11 Nov 2025 11:55:24 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: Remove queue freezing from several sysfs store
 callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
References: <20251110162418.2915157-1-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251110162418.2915157-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXzC2ap9gs9c0s
 WUV65gHeLrDIEwwPSCE2HeCsBhnSYpcRaJ8gDOiwqq4DL/5Sz/VZOaHwZz0NO8ehPkinzjqXP5R
 7hFd4zfMABcaU32wUaf/Hw3CVZHucygIpxCjqEGRPW7+BfqvCIR4lXUIc+xWc0CNJQDfMWienW/
 NRXntX3EdT7VtbwD80eCcB7XRnNf5RuwwVedqZY4AzzRS7iO2dXjvaSsobjrgPDSEbjh27VvZ4P
 CzgvTg3M8pDlikWBiHh4DDFYZjtUI2MlDXepjAJKI+7bDJBiUURBKTbg346t/V5gIuAl4FZPa5+
 ZxRV5Ub72Sg8r9BNMM58CqMWFZ9bDJ58zu37fu57JcZTrPsG0bjFXzBQATNdczVmXzjdbcjdE61
 DLl9Ul0uQ4WYDSZhFYVKRRhw5CdoaA==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6912d6db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ws-3EAvBfRN_exBOfioA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 2f8mHZXSYfwc_vyYQCVYwvYpx6aZ18n8
X-Proofpoint-GUID: 2f8mHZXSYfwc_vyYQCVYwvYpx6aZ18n8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



On 11/10/25 9:54 PM, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.
> This patch may cause a small delay in applying the new settings.
> 
> This patch affects the following sysfs attributes:
> * io_poll_delay
> * io_timeout
> * nomerges
> * read_ahead_kb
> * rq_affinity

I applied your patch on my linux tree and ran some tests. And as I earlier 
suspected, I found the following race from KCSAN:

1. Running q->io_timeout update concurrently while running I/O:

 BUG: KCSAN: data-race in blk_add_timer+0x64/0x1cc
 
 race at unknown origin, with read to 0xc000000142575fa8 of 4 bytes by task 5528 on cpu 49:
 blk_add_timer+0x64/0x1cc
 blk_mq_start_request+0xd0/0x534
 nvme_prep_rq.part.0+0x55c/0x1940 [nvme]
 nvme_queue_rqs+0x1e0/0x4c4 [nvme]
 blk_mq_dispatch_queue_requests+0x4f0/0x8c0
 blk_mq_flush_plug_list+0xb4/0x3cc
 __blk_flush_plug+0x294/0x358
 __submit_bio+0x308/0x3a4
 submit_bio_noacct_nocheck+0x5e4/0x92c
 submit_bio_noacct+0x3a4/0xec8
 submit_bio+0x70/0x2f0
 submit_bio_wait+0xc8/0x180
 __blkdev_direct_IO_simple+0x254/0x4a8
 blkdev_direct_IO+0x6d4/0x1000
 blkdev_write_iter+0x50c/0x658
 vfs_write+0x678/0x874
 sys_pwrite64+0x130/0x16c
 system_call_exception+0x1a0/0x500
 system_call_vectored_common+0x15c/0x2ec

value changed: 0x000005dc -> 0x00000bb8

Reported by Kernel Concurrency Sanitizer on:
CPU: 49 UID: 0 PID: 5528 Comm: fio Kdump: loaded Not tainted 6.18.0-rc4+ #65 VOLUNTARY 
Hardware name: IBM,9105-22A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RB1120_115) hv:phyp pSeries

2. Updating ->ra_pages while it's also being simultaneously accessed:

 BUG: KCSAN: data-race in queue_ra_show / read_ahead_kb_store
 
 write to 0xc00000000c107030 of 8 bytes by task 97376 on cpu 19:
  read_ahead_kb_store+0x84/0xcc
  dev_attr_store+0x70/0x9c
  sysfs_kf_write+0xbc/0x110
  kernfs_fop_write_iter+0x284/0x3b4
  vfs_write+0x678/0x874
  ksys_write+0xb0/0x1ac
  sys_write+0x68/0x84
  system_call_exception+0x1a0/0x500
  system_call_vectored_common+0x15c/0x2ec
 
 read to 0xc00000000c107030 of 8 bytes by task 167534 on cpu 33:
  queue_ra_show+0x70/0xd4
  queue_attr_show+0x90/0x170
  sysfs_kf_seq_show+0x144/0x28c
  kernfs_seq_show+0xbc/0xe0
  seq_read_iter+0x384/0xb4c
  kernfs_fop_read_iter+0x308/0x418
  vfs_read+0x420/0x5ac
  ksys_read+0xb0/0x1b0
  sys_read+0x68/0x84
  system_call_exception+0x1a0/0x500
  system_call_vectored_common+0x15c/0x2ec
 
 value changed: 0x0000000000000004 -> 0x0000000000000010
 
 Reported by Kernel Concurrency Sanitizer on:
 CPU: 33 UID: 0 PID: 167534 Comm: cat Kdump: loaded Not tainted 6.18.0-rc4+ #65 VOLUNTARY 
 Hardware name: IBM,9105-22A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RB1120_115) hv:phyp pSeries


So from the above trace it seems obvious that we need to mark both
writers and readers to avoid potential race.

Thanks,
--Nilay

