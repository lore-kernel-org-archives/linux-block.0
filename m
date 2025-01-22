Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714724A18
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567200; cv=none; b=rv9syn5eyrbuh7I/PCtAE8NdcSM6xK29+EmhAiiXdDSO4nk5zXvxmE1JXr9iwwy4SP/1QqhvzRwQd5pnnep9FiJYH0YuDKCCcSwtMTabHPy76GEQgmB8YcbDp8jKdszXQUxkzvFYS84pZMTMasB+Zp/RfpTkqmOf629MkVCEPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567200; c=relaxed/simple;
	bh=UiVTRqCEyRChLd21Po/OOGS0oVKoPAD4VAWXgxBGRCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/SamjwdZTEBYulWkhnrZ8I2yYsHSrJbafc/FrtGmCf4Kgqk+gubBqAM7FVRqNTt3NWFJWsQyYDeleWQqYehMLM30ubjkuaCy8lyTnU54VB/zrXTSxOyejEzR0w7To1lfJKtIaCXrNy/3lN1B0vTheZ3rfAGtjhb616mLIOSDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JBVNqRaw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JBVNqRaw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDmAZU013754;
	Wed, 22 Jan 2025 17:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DvL+BT
	eSKPzlmSiMZFOI7vDMdkfBDeNY9TkZBFK1P+s=; b=JBVNqRawluOJ25A/s5E0Sz
	mypSpaNNX25LGg8M+qmlNk8rAMEPhusubUjLwkqYP39rFaOLKzSUagMikzeHhdBa
	Rsz2meUHRfnx2fBIduNCfnK1nd70rrJUI0V8t9k4Xa+f29pmf9Yhclgit+AoUpT+
	WFYrjmuCkSQCGrVGw1ZmS1kTmcn2PULlZ/vZ+cE83j16VQcaJHnW7Df70vQ/3zE6
	NbscQz9Pf6hm95ZdQ72SsBrkcBxZzbATG4yVas5vL4PR4isknn5PFkP4pWJ9BK1s
	P/i/ZsqcbGO3rbVVkY34kEx7bu/JxGwV/SOtGL57NBecWE2wMKajy1UAehzKA0zQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9c7pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 17:33:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MHX94O009692;
	Wed, 22 Jan 2025 17:33:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9c7pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 17:33:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEDJa2022387;
	Wed, 22 Jan 2025 17:33:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4k9d1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 17:33:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MHX6W156885648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 17:33:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F17A2007A;
	Wed, 22 Jan 2025 17:33:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8CE20079;
	Wed, 22 Jan 2025 17:33:05 +0000 (GMT)
Received: from [9.171.41.95] (unknown [9.171.41.95])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 17:33:05 +0000 (GMT)
Message-ID: <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
Date: Wed, 22 Jan 2025 18:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
To: "Boyer, Andrew" <Andrew.Boyer@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Nelson, Shannon" <Shannon.Nelson@amd.com>,
        "Creeley, Brett" <Brett.Creeley@amd.com>,
        "Hubbe, Allen"
 <Allen.Hubbe@amd.com>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9XMjU6g2GxlcFUivRnsFvvAk3cFXg26O
X-Proofpoint-ORIG-GUID: 6L8z3k5TyX8W3L5k3nRabhFaDxhHH998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220128

Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
[...]

>>>> --- a/drivers/block/virtio_blk.c
>>>> +++ b/drivers/block/virtio_blk.c
>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>>>>  {
>>>>    struct virtio_blk *vblk = hctx->queue->queuedata;
>>>>    struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
>>>> -   bool kick;
>>>>    spin_lock_irq(&vq->lock);
>>>> -   kick = virtqueue_kick_prepare(vq->vq);
>>>> +   virtqueue_kick(vq->vq);
>>>>    spin_unlock_irq(&vq->lock);
>>>> -
>>>> -   if (kick)
>>>> -           virtqueue_notify(vq->vq);
>>>>  }
>>>
>>> I would assume this will be a performance nightmare for normal IO.
>>
> 
> Hello Michael and Christian and Jason,
> Thank you for taking a look.
> 
> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.

The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
Really, dont do it.
