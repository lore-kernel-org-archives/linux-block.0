Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708F2F7CF3
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762547; cv=none; b=J71IerEkDEdh7maRqR7YBCGmtFqz4NGgLovPMI02DKVMbhpcXdBH1bxHz+hF7zPkzLIOT0PZRBux8/fyjS0aOVgUxXEU/k7P28cmYCra8rDQXRB8492lL8uf9mAN9BdDBwkoP+lecMkUt9wIuAWsYzZj1SIRo8K0tvRUieiKQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762547; c=relaxed/simple;
	bh=HnM+CeS02DDPFncPgbgZ2fRJ2Yu1HNQQwj7chvKk1ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg13tUPnhKQBqp/5PhBs/2nabsne+88m9sCdRneDowz+nlRZ0gEX9K80Pwk4s4HF0Hl4Y+A1N0cMU70E3/zEUdKnvySURI3RKeiJiUoPRJxvUcKC/cn/lopY8P3vlxRYGj28RZpWvOfea7yT8XnqLNP20nc8gdeWrTtWycpUmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m3Fthz+4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m3Fthz+4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HD7aqH014315;
	Thu, 17 Jul 2025 14:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S/HpYY
	KMaWXRT1ss2z5UWKVb51kVIaGv3kIDZC785FI=; b=m3Fthz+4w7NJspymN0HeRA
	kRdGb2XzZVwsrkpr3fqy69VHaNrm17CHfZXmZq/0WsCHDEnG1KgB+EkS+V9ZcDH8
	nxtx95IQGedxTQ7NarZAUKNWGS322h1Wi/5yJu+ASmua/iYpwfmCq2rfn6IRq3s+
	44wvC+Q+Z0qqdg25DasbuQeFqSFa+pITt/a6hHKPKuuz3nqr5/qGFnu4Ep6rS5j8
	NQ9QkeAkLE12LvOZlRmVCFixE2zQQgE1LsKWIEyrIsj/DcyJ9MqmmJqFa6LAb6nE
	KiSyagI9u1Rf9zf359gPDfv0SaVYoqN6LxyP03xqbw/wc1gsNR/RkFZUhS2N5bGg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dbkqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:28:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HE72TH021914;
	Thu, 17 Jul 2025 14:28:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3c9rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:28:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HEShQ18258148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:28:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B2A258055;
	Thu, 17 Jul 2025 14:28:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ACBE58043;
	Thu, 17 Jul 2025 14:28:41 +0000 (GMT)
Received: from [9.79.196.226] (unknown [9.79.196.226])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 14:28:41 +0000 (GMT)
Message-ID: <94ca52fd-2c16-4e3a-b0ad-8ced1c4526a9@linux.ibm.com>
Date: Thu, 17 Jul 2025 19:58:40 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
 <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora>
 <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
 <aHg9oRFYjSsNvY0_@fedora>
 <d55c37f0-d21c-48e8-9856-1e3d08d6cde4@linux.ibm.com>
 <CAHj4cs-hrakSa7ht_yD-CKMX5CVEs=etZWyi75Jvzj75DCxnZQ@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs-hrakSa7ht_yD-CKMX5CVEs=etZWyi75Jvzj75DCxnZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RSR96gcmVwe_XjTh0nZRWXcc4u--y-rX
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=6879089f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=lRhqbHx4yJLUIVgMKPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RSR96gcmVwe_XjTh0nZRWXcc4u--y-rX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNiBTYWx0ZWRfX/5L1q3BALyf0 zd6+88JrSLH/QfqZG9ASP7fOLET3ESRDIyv8fcrOjpQMJYElcltdB7cFEp8W8lAyf7Wz4987wf8 tmcFu1eWw0rWiXFVUmMG7YzdPSDs+0VLTt8ntkKueT9LBDoum1fuQU814q1RffmBLME75fd03Iw
 KxXRIBr3GqUPhZTVYM8MDIGVz1ux7nCuWMPwI5awZi/Bykdh0TJ2eI2+Zeyb225FKvxg/VCdYoG tmpMP3eKo51LKamRqY6AHl4/DL96xRSuo+j7zjU4JfAOuh/GcjLFM8B/wR6L7qcIY/jldz13Rm8 s9WyXXIG6Mt9tADNdYIn+vFFmnZhvIh3s5WGuYfykxhCUlJLGnxYC+sEFLYXzpjDN1FN6d7UqFj
 012qMgabt0F93qkyTJAC1tAsnOzDKv4hInhncraHBg6cqvRR9Kpjqb8pWTYaxHRjSamC2zIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=880 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170126



On 7/17/25 7:55 PM, Yi Zhang wrote:
> 
> Hi Nilay
> 
> How about update the patch with the below trace which doesn't have nbd info:
> 
> unreferenced object 0xffff8881b82f7400 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f6000 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f5800 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
> 
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
Sure, I will send another patch with the updated 
commit message.

Thanks,
--Nilay

