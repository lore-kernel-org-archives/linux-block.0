Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED2408626;
	Fri, 10 Jul 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687206; cv=none; b=nCZGpARQDGIISGhn51mybA3ud7ZorKbWY0uv9dpTOqcdcYf76G7Ml2Oyw/AUEwdBEywI0InaCspauRlOWAdHqJWr2tOp3OBJFLVWFTUpydqXT8FN3Q8msmg/0NR0Pfs0mLKKaHxX/YGEXr1B8RaOnk/1rIXBrttSRjYOSgO+Xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687206; c=relaxed/simple;
	bh=SLFcAhnev4AVMbiKWn/++hXTkVcjeRvtpOWwFblmcKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kygcvklStk2DzZ87xvpLeiJUEKPuOYAj1eEwIqdlrq/soEpbOUDomCHa088TJwwRg8JEvD6yf6UHS3nNDgNa5OK9d3UhnjBA6M5qdbg8aZqCE/NIPV4Hrxp2jHYi1Pm2gWXeJeIxIC0RtG+t1lTW4pMM21w/vXfRwSaNJwJjeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+eBzvZ2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+eBzvZ2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmnUI649025;
	Fri, 10 Jul 2026 12:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B2pVj2
	kn5YNPDk7XnMCnAaRbWFfGnF3OFEygZCO0pl4=; b=J+eBzvZ2x+i7+3VYmpH90C
	0H5PPBsAS8Z96zAbv7ehFdIO4coYQFoGT66A826hRQ0jMl1sFxn8fFxJZIxHrbIE
	r+G5ypt8mIWpAuXZiVNx0tt5lAAD/kB06kAVAJxkADTpffdoYdx5bs9efgcvvpqX
	Nd8AlJk/5POKfpdNbO40nCiNl0uAPfrc1rfhe9kKrdqSeLlXcRjPP+2a3j+QKZg5
	8a5xlu8LPIuEQLIBLUS/pb0MM7sfkDlr/LFN13ivkMEtsb2J+tQIIMUqIO9TJz1p
	xmwbF0ld6xSsZX69uDcjilIUAi2WnSKwOHAbNhldUc42DjpBLlNqG68ypyeUIgqw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw56rba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:34:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACYfWb005027;
	Fri, 10 Jul 2026 12:34:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqj6s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:34:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACYftp31326786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:34:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72AB358053;
	Fri, 10 Jul 2026 12:34:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAE225805F;
	Fri, 10 Jul 2026 12:34:36 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:34:36 +0000 (GMT)
Message-ID: <4dbcbb4a-852e-4ae8-b909-79d1aeeb0799@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:04:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 7/9] null_blk: reject per-device queue resize for
 shared tag set
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-8-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-8-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cv1sPlf_dx4OwZ_IwUejaX250yjgm49D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX1BALiIg9iUGM
 kQstTbJ0pgQf/oc0oWM/fyondJ117GcSZ/htYvhpPa1QjmMO1S6zwoKr/cqZJ4AprNoJ/SPcI+6
 5Kb8LpY5p1XlKEeMr7hK3rgdbRFsAMB081lRay2AwFT5Vbpk8nrixdvcP6NOxVKFQWZ4LtlufU1
 tv+wj2ascNjHPU34rmAaYaq4WaTNFP+xcx1HmNnjBZjjPKuJYrBmvrph/genRxmoYf6VlPNU/X/
 obYo00tCTM0FRMBa6Wt6OpgtFG7h1TVFo7YClGsfO8tnYnK74XGoyNkhfps6hW8fhlxsb3jZzyk
 Ar18eYb9zSC2OAPNmkti02cShRAqrz7Y8tQgwL17yPWOPXC/4Dy5q5G8NKKI03uuF6VwqAjTt+l
 XFnyQhKCX+n5YP+Nj+p/rWxOHFCORKJEd2/aFhg0iuWEzGyeJanDOr2IPbb2shVHR38LNQn16iu
 ioD4w+KM0i2xHs4xaJg==
X-Proofpoint-ORIG-GUID: Cv1sPlf_dx4OwZ_IwUejaX250yjgm49D
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a50e6e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=Q6vLttZ8AnW_mQyOECkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX7CP4UHXzqSUu
 kZX3TATe27yMCiU3uanXx7sdoNqtJPEI9kHT2Ci0owqrQy3W8ZJgdtSzYHA85rYWfGbYhhHxEAs
 SzIgTRw9x2virTHmWXs61FcCCgFSEoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> When shared_tags is enabled, null_setup_tagset() makes the device use the
> global tag_set, whose driver_data stays NULL. null_map_queues() therefore
> falls back to the module-wide g_submit_queues/g_poll_queues instead of any
> per-device value.
> 
> Resizing submit_queues or poll_queues via configfs on such a device calls
> blk_mq_update_nr_hw_queues() on the shared set, shrinking
> set->nr_hw_queues.  __blk_mq_realloc_hw_ctxs() only grows the
> q->queue_hw_ctx[] allocation, so on shrink it merely exits and NULLs the
> now-excess hctx slots. null_map_queues(), however, keeps mapping CPUs with
> the unchanged g_submit_queues/g_poll_queues, so mq_map[] ends up pointing
> at those NULLed hctx slots. blk_mq_map_swqueue() then dereferences the NULL
> hctx (hctx->cpumask), crashing the kernel:
> 
> [  460.218374] KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
> [  460.219003] CPU: 24 UID: 0 PID: 1492 Comm: sh Not tainted 7.2.0-rc2+ #67 PREEMPT(full)
> [  460.219792] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
> [  460.220452] RIP: 0010:blk_mq_map_swqueue+0x4db/0x1430
> ......
> [  460.228977] Call Trace:
> [  460.229175]  <TASK>
> [  460.229354]  blk_mq_update_nr_hw_queues+0xd49/0x11c0
> [  460.229779]  ? __pfx_blk_mq_update_nr_hw_queues+0x10/0x10
> [  460.230200]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
> [  460.230694]  nullb_device_submit_queues_store+0xd9/0x170 [null_blk]
> [  460.231190]  ? __pfx_nullb_device_submit_queues_store+0x10/0x10 [null_blk]
> [  460.231776]  ? configfs_write_iter+0x35c/0x4e0
> [  460.232122]  configfs_write_iter+0x286/0x4e0
> [  460.232460]  vfs_write+0x52d/0xd00
> [  460.232779]  ? __x64_sys_openat+0x108/0x1d0
> [  460.233106]  ? __pfx_vfs_write+0x10/0x10
> [  460.233413]  ? fdget_pos+0x1cf/0x4c0
> [  460.233745]  ? fput_close+0x133/0x190
> [  460.234038]  ? __pfx_expand_files+0x10/0x10
> [  460.234368]  ksys_write+0xfc/0x1d0
> 
> Reproducer:
> modprobe null_blk shared_tags=1 submit_queues=64 poll_queues=1
> mkdir /sys/kernel/config/nullb/dev
> echo 1 > /sys/kernel/config/nullb/dev/power
> echo 1 > /sys/kernel/config/nullb/dev/submit_queues
> 
> A per-device resize of a shared tag set is meaningless anyway, so reject it
> with -EINVAL in nullb_update_nr_hw_queues() when the device is bound to the
> global tag_set.
> 
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   drivers/block/null_blk/main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 6d30591abb28..340ecc0a331e 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -380,10 +380,19 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>   	int ret, nr_hw_queues;
>   
>   	if (!dev->nullb)
>   		return 0;
>   
> +	/*
> +	 * A shared tag_set is mapped via the module-wide queue counts, so a
> +	 * per-device resize is meaningless. On shrink it would also leave
> +	 * mq_map[] pointing at NULLed hctx slots, causing a NULL deref in
> +	 * blk_mq_map_swqueue(). Reject it.
> +	 */
> +	if (dev->nullb->tag_set == &tag_set)
> +		return -EINVAL;
> +

Wouldn't it be simpler to check dev->shared_tags here instead? Since the restriction
is specifically for devices configured with shared tags, that seems a bit easier to
reason about than checking whether dev->nullb->tag_set points to the global tag_set.
Something like this:

if (dev->shared_tags)
         return -EINVAL;
Thanks,
--Nilay


