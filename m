Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96725216E16
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424096; cv=none; b=k9Qmcgl3AMNAMyXS94U5lNS1OqXGeoiHqD7dAQL25Q8C8GR2fv7Eovt55usJYt/wkgUXcBnkOhVaBonBn+5Xvea11dzdHwi0CuBb+mD7ZNVEUdOU79MZ8x1ibSCO2wYx/nHhYzjnx36PkwMdNBQ1lzQM+/T8voCDMjnS4pXm9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424096; c=relaxed/simple;
	bh=XS7boO1v2F8RCk6/wCqyylpZ0JyCbbFOPzIjLQix8Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBGYKyLYMHBqbIt3k8F1sAiSdjIr6Q9VIzJz1ErVpViC80xHOJHMBQrvMlRC8Jr1+AjcmZuHiNnYZWiKLN9M8kdnf8IUNXGkgKsLy7fDNzw8TQluLaHmm66YEYKfPl65XUe9UbmiKwZKqxkasiJ13A9Yuj5O7Lz6h034ooeXM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QTJ61X5W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QTJ61X5W"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093shbV009879;
	Thu, 9 Jan 2025 12:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8Mwg2m
	rpblERBt87yu/wRBB5H/z9dusogfsCVououvo=; b=QTJ61X5WbFR55Y5fUmMnAo
	djtxIcmu6tJPQ2MfNodSqSqVgi14jpd9t2GLfEMmaKWC0BqY56gABa/ez6J1JiUt
	ZAGVHcnDcPxBsCvBPKeTfxD8GmCp55np+voxgQwvOLwGbiYceRkOuOuf3awnLFM9
	pmDLibngdJHAfWfiU77YB/Y7Bce8TPDevaBEXzHxRk4Xudc2F/lxdurzUiWAH4GX
	7hyvBvUSNMHyTNUnJVWB6TQNZQR1IQvhkMYNBdVYHx/zMaZsHgc4mAYh74ohuCUK
	JE7C8JVkhEZ1lm0WLfnXixWWj1D8Mp7tpb52e5xVrO02m8+w79mdRkB7txnXCDlA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc9xue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 12:01:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 509C1Pfw030431;
	Thu, 9 Jan 2025 12:01:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc9xua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 12:01:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50990HQp016144;
	Thu, 9 Jan 2025 12:01:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm4vmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 12:01:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509C1Ki638863236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 12:01:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C0C20043;
	Thu,  9 Jan 2025 12:01:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D63420040;
	Thu,  9 Jan 2025 12:01:20 +0000 (GMT)
Received: from [9.152.224.86] (unknown [9.152.224.86])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 12:01:20 +0000 (GMT)
Message-ID: <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
Date: Thu, 9 Jan 2025 13:01:20 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
To: Andrew Boyer <andrew.boyer@amd.com>
Cc: Viktor Prutyanov <viktor@daynix.com>,
        "Michael S . Tsirkin"
 <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org
References: <20250107182516.48723-1-andrew.boyer@amd.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20250107182516.48723-1-andrew.boyer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _9JlJEQU1zqu8A-HAit5wiwEhRcWt25X
X-Proofpoint-ORIG-GUID: X_CAXkE2C-L7zXGClDRmNCbBsEP5ZIPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090095



Am 07.01.25 um 19:25 schrieb Andrew Boyer:
> Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
> support") added notification data support to the core virtio driver
> code. When this feature is enabled, the notification includes the
> updated producer index for the queue. Thus it is now critical that
> notifications arrive in order.
> 
> The virtio_blk driver has historically not worried about notification
> ordering. Modify it so that the prepare and kick steps are both done
> under the vq lock.
> 
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature support")
> Cc: Viktor Prutyanov <viktor@daynix.com>
> Cc: virtualization@lists.linux.dev
> Cc: linux-block@vger.kernel.org
> ---
>   drivers/block/virtio_blk.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe378f1386..14d9e66bb844 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct virtio_blk *vblk = hctx->queue->queuedata;
>   	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> -	bool kick;
>   
>   	spin_lock_irq(&vq->lock);
> -	kick = virtqueue_kick_prepare(vq->vq);
> +	virtqueue_kick(vq->vq);
>   	spin_unlock_irq(&vq->lock);
> -
> -	if (kick)
> -		virtqueue_notify(vq->vq);
>   }

I would assume this will be a performance nightmare for normal IO.
