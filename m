Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2B4C7531
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642834; cv=none; b=tO/jTblE3XyC9vHC8gjX4aWQmUttrIHO55z5L8Ws7BE+T/Cg8zJrloWs5dMM9pLU9ihXCAsVAxvY90weMvMEJvk2Now1zwLpB+i0AfpA7tAi4aCKRCJgQGRWQWxTi26Ys+MFqr4Q4LN9A4XxiSeU8uVvmVw2jmIZbFrOTGjchas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642834; c=relaxed/simple;
	bh=IHjKB4L5nRV2UKl/PMgUcbJsiI5fL3VekqREU8PfNK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz0Ye6XT7tddPQb2RPwepOZlSOhjfcMwLpvBAagn5q5DO5jzsJa28BcLjyHvWlcPBbo0ahJ0fvN6E1wco53JnN/H+JU3Wal3dGB0dU+PP64y9dem/ufNzGku+kyCpvEqMkKnJXuQF5bx/HNrAKfluNgMXbWkv2Zcu9uBDcI5/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3r3Fe5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GYxac+Rr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3r3Fe5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GYxac+Rr"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9ZjPb1520197
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 11:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+jTM8LwMfdXriiY2J868Sv0nXBm4Jhe5/I4UKZcO15Q=; b=M3r3Fe5Yp5jZwPeP
	6U1a3JjNypIugGMJkitHM/ngIuXONUYfoxQmf1OOtvXXtV9pNgrtuKf6S9+1d0iJ
	4lvxFRHh+fRe7rWMd+ddKdiPs6U+bULLVs1vBFyoH5I4Q9XWDfeJ/6FwkyYO0Cmp
	an/Bsv0eb1P7eoFsE4d9ulQP+BLvjOmyOd4EtyQZa0vYg3YR7UMCrELsxsQAP1+t
	QMQP+Wc4TC44UhbhWCLWqf/j5rffOI9FzyhT+SO9chgi2MM8ufRVV4/XQ3j9yRas
	3ROpVu6TmvnQLjmbWToT7IlKqq+tsbMjnVYNNYi02H31alHdNKQOBIUiaahznN3p
	uHqgnQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hbvnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 11:00:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39512608fb1so1552829a91.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789642810; x=1790247610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jTM8LwMfdXriiY2J868Sv0nXBm4Jhe5/I4UKZcO15Q=;
        b=GYxac+RrGYUm/8ShIrpO9SO6RxcdF2QEC8WZIFduo44gaNbe0B7qZMbqaviYsp33qm
         shNWViJUd7HZs39dejH7PIcs6A0wKO5gLw68VMj6eMR318qnbJD+hDuOJq/DIfzL3CRu
         gUmRUtMSfruy3zcmbAt6uMx0xvBJh/hD8yuH7Gw87wSLf4jcpHC87P27QSFLmA1DAWRv
         wvEpRoxCIWwawsYxBhIGKTsYMeYNdQARU+h0jzucqM0R/6mp1LF3WfqUHcIgBlZCSIUZ
         Zl4YgTOzxasunthLggPO5AXDpVXKV3rYgJIGly0L3z7GFZmmG/OLXYDCIDCPCO8TEFbl
         TofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642810; x=1790247610;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jTM8LwMfdXriiY2J868Sv0nXBm4Jhe5/I4UKZcO15Q=;
        b=SmKCmqxIHuGjMKI7i/cFe9CWwzVNSjKMM8Wuos6Pb4tT4S6JXdtXsCayaffJCBpuUH
         UIA8U3Td2lpoRbCtP89le2shuhAoJmuUiELupvGmT78YqKOMP7WaOQok2TonxcYg4K2+
         vO9cwBbzMzCsYphd/mfgSI3JZzkIGv2ZqMtsufPDoslk5pIaKbfnfrWppaIrbofuPmZ/
         uZUnw/JU3cQbibjcWvTsnSf+rK87yLiE6/zU/+/JJnDfZSEdHwYOIOrnksQ4ZZRufFMR
         Ptiv3nnfAXSJOmc08YpLjYwQetXGFhflXrlb5Ogg4pGJit7lI9cLYJenOIZDpnyfVe6C
         dxoA==
X-Forwarded-Encrypted: i=1; AKwUvBzoXWW1XwtIIKspwnM0mHjaAWd/nVLrGVqsrYUnAz98hUBPhVioylHQnPPVecywLSlOAYMFlKnDkKNMNg==@vger.kernel.org
X-Gm-Message-State: AFuF++kJU4YVjGAzgL6YRVS97wylKhJrAVPPcZQs+iGUNHKd7HoNHOIe
	55HsE3W2uHDXa4xRmqt4TTRwzK/qaKkCeKSOyYefhnHCUbTvRBvpacpl+anEGaJeVRpfFpn0Xj8
	iS+71Zqb/uSmh/gC6p8ARj3Tbc1pdTM8wsiD7h4me70DyT510ZFf+wSDixKzb4fXfSg==
X-Gm-Gg: AYBFou0c4ZbIGSV78W4Yqb616MvO61qjBOB3l9wfcaLsW1c3xhRPAT2Znby8i9ILog1
	hxYjlvy5iGrsjmNLOiL5AB3qb5pYCFst6AQOB+6KAlNKtUsaDd0465VgjETupc+fkKBWHfPdV2R
	80DJeXisYqH6p7HyfaIRk484mC1SIvHyOZj4AaaaRGzLyBryzSilgZxESYwl9Y7ucF2fqA3WmcY
	0YezPeXlkIM2k/hzA1lDp3KlFDDGT5Eig2STXcFXiwyRzMzJf+J7CBSO1Fu6UUubR4OoawQ1Skd
	HzCuXaoeQ2VShJPczwwPE2IEoEgy/nY2Pk1BpLx17n0nzcvTQkP3Y82LzHVxUh7ViJEzoStO1Ny
	WvO8hBDWYhYkQZtu9wj3BFrRXNPw=
X-Received: by 2002:a17:90a:6c96:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-39e21a7824emr9355197a91.11.1789642809576;
        Thu, 17 Sep 2026 04:00:09 -0700 (PDT)
X-Received: by 2002:a17:90a:6c96:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-39e21a7824emr9355108a91.11.1789642808808;
        Thu, 17 Sep 2026 04:00:08 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e732d6sm4715358a91.11.2026.09.17.04.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:00:08 -0700 (PDT)
Message-ID: <ab07749b-2aef-485c-b54c-becd26e5dfae@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 19:00:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-arm-msm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
 <20260912050459-mutt-send-email-mst@kernel.org>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260912050459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE1MiBTYWx0ZWRfX6abH4hPDKx7Y
 NQGH7jnYX5s2zx69ItCCJg31bxyqBzRTx6RI2CRd3CLyabbx6GGLv3XokaOn4ozv3ITlN0MhVCQ
 RRLYkkK8Ig29iYgdxYrCTGj+qDHXHBv3e8qta17tLth6L/VRgNHSBs0+Ateqx+dEoyV0vQ+89NF
 z3s8LeXPjTKY/geKr9COPkpH3S+WRVfSILVCqr1WTacnqS4b1eLA+CAk8nTxKYjiQzwL0GB/Lxl
 OoRGEWLBnO+D3iDKfLofsWsXoG9v9dCScJIYg5JBYO8b5pDUVCasWibPjJhhwAhC9OFakHp0y4r
 OnY8AFUE2pdbMLcv9HlO3GNkxlwDTs3Pu7dCQjNsScB7pc9VUie+7KWcyQlqpnSRH6tjgtz+Nwa
 T4cN5v/9WCd/b1zBXjka2DYXvJefEcuV7k3ZpkZhEVY1WnE5D70epV/zHzWIHGFEXHpYLFD07nq
 ZCiL1Bxu2gxOUry8HSw==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aabc83d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iuKekLPq-CDQsUwbdJkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: nEULpS04L7E68h8xjaqJQnr5ny-UJY9U
X-Proofpoint-ORIG-GUID: nEULpS04L7E68h8xjaqJQnr5ny-UJY9U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE1MiBTYWx0ZWRfX6fSpZ9b6q9jr
 HAgn9HbkhqbWnp1OZsQQaAnvbPsIlDPeJY/j5tENI/YcgI/eDvB+fIKtcU7BlKuHJjZBQhZCVtW
 Bn8Rkb3ETyzQIoDVhK/2NddkI7sMyQM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170152



On 9/12/2026 5:09 PM, Michael S. Tsirkin wrote:
> On Sat, Sep 12, 2026 at 04:52:44PM +0800, Cong Zhang wrote:
>> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
>> virtblk_freeze_priv().
>>
>> Keep the existing freeze and unfreeze order. The synchronous call waits
>> for dispatch code that was already running. The queue remains quiesced
>> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
> 
> 
> 
> This repeatition of the code in english is not what we need
> in the commit log.
> 
> Suggested format:
> 
> The following issue was observed by ...: currently .... because ... this is a
> problem because ... and we can not ... because ... to fix ... so that
> ... tested by ...: before ... after ...
> 
Got it. I will merge the detailed description of the issue into the
commit message.
> 
> 
> 
>> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
>>
>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> 
> no empty lines between tags please
>
Sure. Will remove this in the new patch.
> 
>> ---
>> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
>> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
>> while the flag is clear. It can then be preempted before it gets a
>> request. At that time, it has no queue usage reference, so
>> blk_mq_freeze_queue() does not wait for it.
>>
>> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
>> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
>> dispatcher can run again, use its old flag check, get the new request,
>> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
>> reset the device, delete the virtqueues, and free vblk->vqs. The old
>> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
>> kernel can crash.
> 
> 
> 
> this kind of thing belongs in the commit log.
> 
>> ---
>> Changes in v2:
>> - Cc stable@vger.kernel.org.
> 
> 
> which is no longer there?
>
I only CC in the mail, but not in the commit message, will add this in
the new patch.
> 
>> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
>> ---
>>  drivers/block/virtio_blk.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 32bf3ba07a9d..7a570591e040 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>>  
>>  	/* Ensure no requests in virtqueues before deleting vqs. */
>>  	memflags = blk_mq_freeze_queue(q);
>> -	blk_mq_quiesce_queue_nowait(q);
>> +	blk_mq_quiesce_queue(q);
>>  	blk_mq_unfreeze_queue(q, memflags);
>>  
>>  	/* Ensure we don't receive any more interrupts */
>>
>> ---
>> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
>> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
>>
>> Best regards,
>> --  
>> Cong Zhang <cong.zhang@oss.qualcomm.com>
> 

