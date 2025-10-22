Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0752ECE96
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120132; cv=none; b=ZVgpH92b1gzrHbDQHv1oAeElmYR2dtI7j5Ewyb/u0nYmNTFzTxOEY3ilbreYMZFuMqGnqWUFaCtYpP/oOw76KfBBPERakuStMoZ8Fm8TrVDk4SkhsTTaLer0VK333HYxvItHQiyQYH+Y19RiqAmuBbC4COb5sZl5nKlx2Oj5dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120132; c=relaxed/simple;
	bh=RSN3cKeL/wrLTfUe/iXDZXDZWNlHU8sIpfbOMxyuaEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhwUlipnMUOR5hwAtkwZuih1asPlAMHnsYuKdBJID9KL6hqI6iTLX3K0DueRdDPDl168T6e0QYapLAF3ecrlfNcBKc5WdX8P9PxD14yfR7XvP1I2AEkImPOSIf89GzFDfW4YtQ5kV29tDIxeLibhFXMP2kklClFzZTkHKO+w9KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a933Yhqn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a933Yhqn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3nqtx027557
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 08:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PrWXaHujYM83EP0v/kYGdvqS+OMzRONuhcXEsIZpib8=; b=a933Yhqncla2BaC7
	L9lRvvEr6BQynRuJh5NPCYWspxlHRnkPfv53Zp+fyH7Uk+RmYn7Zanrkftl7tfSr
	s39XL88omoVCmp0u9RqvUtg2Ki2O/AljEUN9lclP2n6uSvC5FDfZ/7fyGv10ohy4
	zalcxXIhxDPIUxg/DsbriYDyBWbU2JMae+d8p3tkVTDQXy1AZisu0HvLAdBEt5rF
	LwvKoa+8q1SMqGRot58so87dH7d+QCDBjh9ywt4+bdBg+b1+0NMfpwchkij8xZwm
	oXvjuCaW2adBDl18ch6g4F/nZFrMc+3sX9cW5JsfFQyA1NMX1jAdqYfP0opOw0+s
	uDJCHw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j3sgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 08:02:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909e6471a9so46963255ad.0
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 01:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120128; x=1761724928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrWXaHujYM83EP0v/kYGdvqS+OMzRONuhcXEsIZpib8=;
        b=gIBV6B3mq3EPpLRRJHU91ws5aq6v6JIXIkssZwqoHd4afjN5OsQvDSie/Y1LFHuITa
         rja0p0wv/JVueEnNLgTtlhjTh/gzqyXwvDYmQfGLeNgwPS6TQQZmpir2WrmiE3bq2hdf
         /nci2jyvRvZj3GRH/FRmjnNStVMPrVceXDjdjBOfD2iwlyeLX5bZHIEBnw32jBltD+I0
         9oNfuTPVER8pJseO8OTNEI6Kp2ay/p2hx7iFYvXMfAVrMjlSHXgIeZ9pXTOIunHjh1j2
         mbsxhkJ4iEbRY6Bixlk9pK4dJ0ef48mxSQkfd9OLixF3K4IeKZlN5jqxvfufKeA68qEI
         fQPA==
X-Forwarded-Encrypted: i=1; AJvYcCWEy5gcDp5PeELp2mZiVL+kJJrId4UmzLnES5O8w9hMI3UX7E7WETbZEJZ9w7M0NACF+Nt5zeJ5tWOxmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RsSfsMe6GwK9acIM/hgnoMdEnUZUQmVQoQtisG4IE1/5nrjj
	Jf6DqtlOQJbowQ0ps1M2dn1pI0NQYBTMARMj1vLdX5b5u2/PMNtvk47WNzL1N2iZ2A7+Ai5r+rg
	Ivrp3qmfVAHWBLinU0ochvyl5RXu7z9dBwH9k/cyyVckWHp6R+QcVbcn0Oi1CjhzvoQ==
X-Gm-Gg: ASbGncuURuo7+fBK4dDC0zw5osJ2DKFmGRS+4s0YAdfGN3vXrLD9SErwaYATQoyV9sv
	fzb5Ya5fn4esPX4+B12CH7YEUuaqrQdHzdFYu/Gjmb8d9hQXIq5QLhClyp/PsHfZqmRSHCCOhRy
	3UUznCVu3NVbIaFE/j0pIXr556XrrM18OOSDFAMxc2G67faNzmJMgLvLWTK4z1lkw6FolQ0so3s
	LumeRfGdUwHyghhubPPbE0BKrciDvSOmE3VKlNLYSzVIBVQMvoxvCYnB6whr5nESQDPMaHM+NDK
	I07bEqhagFWqlr1Omj5kGh0/PVc0r//wRCFvQxO+Fio79y2GISy/E4sLHUgPb26aKpoR5/UTM4m
	O+3DLX+zzwS7ZxGuiIJP9BVbWma7QZxso/b7g2yRaMk6wsPnUWA==
X-Received: by 2002:a17:902:e5cf:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-290cb6619aemr257341465ad.52.1761120127712;
        Wed, 22 Oct 2025 01:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcRm1cmQAZ79KpbmBiXAz/1hTG8MAAUjPR7k1568+fHx4n3Z3tvlMw2nwNPvdqpf8/BIpXNw==
X-Received: by 2002:a17:902:e5cf:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-290cb6619aemr257341145ad.52.1761120127228;
        Wed, 22 Oct 2025 01:02:07 -0700 (PDT)
Received: from [10.53.169.133] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm131876805ad.18.2025.10.22.01.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:02:06 -0700 (PDT)
Message-ID: <f7401703-e912-4d61-b206-f9f1de930092@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:02:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavan.kondeti@oss.qualcomm.com
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
 <20251022014453-mutt-send-email-mst@kernel.org>
 <20251022030050-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
In-Reply-To: <20251022030050-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX14xcFXukRPgR
 zmX/fyEqZaZ1itazGOrYyUuvTFM0GAwP6Y5jNLcY1x5DvhZepB30P1CKdwE/jpYQ8nHfjnwsCi6
 MBLv8POR43rEKnw8rYsOoRB/oMrAKGC9FpOld+4hmY/15EctMEiV7UpwCTdtrvh90sjnnQ/iNdu
 CT64VCiYI4gETL8g1L9nuMTq7qL7Z/INHBq72xaExHuO2nOnTh2uQwkywyA56dMscDdizw796CB
 jztHH8E73rxG3wvnc7RMxMlYkSl9gL6HzpbJsRdUYUrFvwISXV2ftAzrnq7xARWCShfnfdjAIcK
 OMJrnZVpIiGw87Mn+NSMuhKGoj09/l15c4Hv6a8sBjuqSiKDVAatIxxq6/9C3Ul2dsvtJ4dvvU1
 ju40bHVSQI5Udv8VIlSybSvOv8NptQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f88f81 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EF7p3n4rWrlDlfIrDsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: RTkprRY_aofVrc_3a5JR-w-DdysAxycz
X-Proofpoint-ORIG-GUID: RTkprRY_aofVrc_3a5JR-w-DdysAxycz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018



On 10/22/2025 3:01 PM, Michael S. Tsirkin wrote:
> On Wed, Oct 22, 2025 at 01:45:38AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
>>> On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
>>>>> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
>>>>> is allocated, later freeze/remove may attempt to free vqs again.
>>>>> Set vblk->vqs to NULL after freeing to avoid double free.
>>>>>
>>>>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>>>>> ---
>>>>> The patch fixes a double free issue that occurs in virtio_blk during
>>>>> freeze/resume.
>>>>> The issue is caused by:
>>>>> 1. During the first freeze, vblk->vqs is freed but pointer is not set to
>>>>>    NULL.
>>>>> 2. Virtio block device fails before vblk->vqs is allocated during resume.
>>>>> 3. During the next freeze, vblk->vqs gets freed again, causing the
>>>>>    double free crash.
>>>>
>>>> this part I don't get. if restore fails, how can freeze be called
>>>> again?
>>>
>>> For example, could it be triggered by the user?
>>>
>>> Thanks
>>
>> I don't know - were you able to trigger it? how?
> 
> Sorry I mean the submitter of course.
> 

Let me add more details:
Autosleep is enabled in this case. When the system wakes up from
suspend, it will call virtio_device_restore. The failure happens in the
virtio_device_restore function before vblk->vqs has been allocated. The
system still gets woken up after the failure happens. Since autosleep is
enabled and there is no wakelock being held, the system will try to
suspend again. Then virtio_device_freeze will be called and causes the
issue.

>>
>>>>
>>>>> ---
>>>>>  drivers/block/virtio_blk.c | 13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>> index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
>>>>> --- a/drivers/block/virtio_blk.c
>>>>> +++ b/drivers/block/virtio_blk.c
>>>>> @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
>>>>>  out:
>>>>>       kfree(vqs);
>>>>>       kfree(vqs_info);
>>>>> -     if (err)
>>>>> +     if (err) {
>>>>>               kfree(vblk->vqs);
>>>>> +             /*
>>>>> +              * Set to NULL to prevent freeing vqs again during freezing.
>>>>> +              */
>>>>> +             vblk->vqs = NULL;
>>>>> +     }
>>>>>       return err;
>>>>>  }
>>>>>
>>>>
>>>>> @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>>>>>
>>>>>       vdev->config->del_vqs(vdev);
>>>>>       kfree(vblk->vqs);
>>>>> +     /*
>>>>> +      * Set to NULL to prevent freeing vqs again after a failed vqs
>>>>> +      * allocation during resume. Note that kfree() already handles NULL
>>>>> +      * pointers safely.
>>>>> +      */
>>>>> +     vblk->vqs = NULL;
>>>>>
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> ---
>>>>> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
>>>>> change-id: 20250926-virtio_double_free-7ab880d82a17
>>>>>
>>>>> Best regards,
>>>>> --
>>>>> Cong Zhang <cong.zhang@oss.qualcomm.com>
>>>>
> 

