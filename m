Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC8202C2B
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621597; cv=none; b=dZgpXpejYIRCnj0zGtM8gd3m0x1dRKIPWAkRAzvGhdIUf06ET72xHKKH95G6DlpY6761As4jr5EnirpbfmS4ViMkGDcb91oElcynwpBRKUQ+iNHlRaT96ErJbmJvpxce5ETVT3B8UwKcN0kWfq6riF2ngRWHooQhoXgbuNz3eQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621597; c=relaxed/simple;
	bh=Aony/Oeam1G2/BBL6Kq9qxlUgm00m0WU7B92qhK4Yck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmWiaB+2ihLrFfziZNECOMcbjXhhCfViuZMAM7eQFeH0Qxmgi2SuT8SP4Scn3NDnSViPTFTtQ+95E5tN0Z4N2X5ljNHbJFpqtBe4KoWGCHcRtlSTyVK0kKTW/Nup8eq0MmUHU4inx4PgVCsb2JjLJTm9TnMzkBLhBxvtNx2qf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PwmhzWKI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PwmhzWKI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N184Qc022435;
	Thu, 23 Jan 2025 08:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8DMelf
	tgrXdy5p6kvxO526wh8fZmlaEWMftASjFtW2k=; b=PwmhzWKIl7z3+tisnWXc7X
	M+Wgeqh27iOyb0ypR1nFw6l+dCa1vITh9v1dtdoAP8fGpOd3N54zTHlnc4L7YqNn
	cl0xbYjWyM0FqDE5xOQPCM1AZlmuClv7P7hbCmrmfetTdSrpiAYXgNNmlnb7frMx
	NZL8w1wVB3a0V3OAsaaEKg3f7jXZzgqYp/c9Ugf3T1TkwGC0PbPO7SxHXnga2nT9
	+S7FgutM+XDOGECLfP3gM9IL0dBNR6rZ0W2ew/Mlb0eGwfy/JzGMXTt3i2HF7Xjj
	KnQpg09+egzQDD6TnIUy4s6q3morodj8xXVNaHsB7h51PgeYDsJEZz2TQfnDFLBA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu99qrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:39:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50N8dlSp027264;
	Thu, 23 Jan 2025 08:39:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu99qrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:39:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N69hvp019330;
	Thu, 23 Jan 2025 08:39:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsmu0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:39:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50N8djBU47055314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:39:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 472572004B;
	Thu, 23 Jan 2025 08:39:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E76020043;
	Thu, 23 Jan 2025 08:39:44 +0000 (GMT)
Received: from [9.171.69.212] (unknown [9.171.69.212])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 08:39:44 +0000 (GMT)
Message-ID: <5952f58f-9b80-4706-adb4-555f1489f2cf@linux.ibm.com>
Date: Thu, 23 Jan 2025 09:39:44 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Boyer, Andrew" <Andrew.Boyer@amd.com>, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20250122165854-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 99q-JurwCCVj1phEQxOQ_aSTdCD6JRwo
X-Proofpoint-ORIG-GUID: SK5nwaTbJF5laEMlqWLAQFQfLM4Cfo7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230064


Am 22.01.25 um 23:07 schrieb Michael S. Tsirkin:
> On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
>> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
>> [...]
>>
>>>>>> --- a/drivers/block/virtio_blk.c
>>>>>> +++ b/drivers/block/virtio_blk.c
>>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>>>>>>   {
>>>>>>     struct virtio_blk *vblk = hctx->queue->queuedata;
>>>>>>     struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
>>>>>> -   bool kick;
>>>>>>     spin_lock_irq(&vq->lock);
>>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
>>>>>> +   virtqueue_kick(vq->vq);
>>>>>>     spin_unlock_irq(&vq->lock);
>>>>>> -
>>>>>> -   if (kick)
>>>>>> -           virtqueue_notify(vq->vq);
>>>>>>   }
>>>>>
>>>>> I would assume this will be a performance nightmare for normal IO.
>>>>
>>>
>>> Hello Michael and Christian and Jason,
>>> Thank you for taking a look.
>>>
>>> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
>>
>> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
>> Really, dont do it.
> 
> 
> The issue is with hardware that wants a copy of an index sent to
> it in a notification. Now, you have a race:
> 
> 
> thread 1:
> 
> 	index = 1
> 		-> 			-> send 1 to hardware
>             
> 
> thread 2:
> 
> 	index = 2
> 		-> send 2 to hardware
> 
> 
> 
> 
> the spec unfortunately does not say whether that is legal.
> 
> As far as I could tell, the device can easily use the
> wrap counter inside the notification to detect this
> and simply discard the "1" notification.
> 
> 
> If not, I'd like to understand why.

Yes I agree with you here.
I just want to emphasize that holding a lock during notify is not a workable solution.
