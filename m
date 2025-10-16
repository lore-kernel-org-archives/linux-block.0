Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28AF3314D5
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611436; cv=none; b=tbG1twSEIodoxNdoepXGAKIBu9r0PyOAB8o6Q7xBZJmtn5YR7wT4e2tQ096Dj5w4Ro2nUhboKR2domZhS27C8g4Ac15wQutbBCARf17o8/2FERsmeCZUeVU6ntV5fW7Hx3k1ypUdvbJl7a30g42qplZkORlLSYbWBbb69QWTicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611436; c=relaxed/simple;
	bh=VWLEG9IZXo4c8E27XasFM385i7XxlR/EYb4wks1MHjs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ot+hWkW9EXt2mKHAMbPFsLI1a70vr98EljJwIO/7ha1YgQ2oMLxxBMzb29/p8ioNLQ1fXRkFs5fSetcLKE6jB8uMCkDAWXrJHc0npgXhgYaBmR2BHuMQlYZRzEaiMgfTQSpH+ZeiTqMoGvNv1hyqs7OCzsDPCQTU3zaRPB2CGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wx9iFIJr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wx9iFIJr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G15Nxw021718;
	Thu, 16 Oct 2025 10:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hvx28a
	GWz4TqMzy8zyRLDRxJmFzT9SHDZqhmTboqtoM=; b=Wx9iFIJrUbjC7MecWwJz21
	xOHn9hKmzfuZ7Cf4ua+gTbDJFssumgYu8FGfyN5dY14BM27Ife83CjFcvEKoVf/7
	X/rXXhEBln38YGXXHqWXZ+p28H3W4K5SEtS7B5glYuO5ZCc1R7zzp2BTH18tkEEI
	M2cpjl671K7gttq0o84VO1e+KuEFySHFvrCUTk2curZlbmiZeO6jFVqBCxSJSadn
	YIoPycYFTQ409iucNfVkoeSBnxi96KjM9Qs9TTdXozsti1FW58MVTQDRcl1ARaxF
	jm6YmyIS8ss1RkXVxJLsJwwP9Je82rH3xxnMTfd4jzoC0BqVld4KhNOKcnRpNU/w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew08wfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:43:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G9PFxT015207;
	Thu, 16 Oct 2025 10:43:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsdfre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:43:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GAhbDv16057074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 10:43:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585BD5805D;
	Thu, 16 Oct 2025 10:43:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A68758059;
	Thu, 16 Oct 2025 10:43:34 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 10:43:33 +0000 (GMT)
Message-ID: <bfc714df-5425-48a6-963f-86d250eeb4b4@linux.ibm.com>
Date: Thu, 16 Oct 2025 16:13:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/2] fix sbitmap initialization and null_blk shared
 tagset behavior
From: Nilay Shroff <nilay@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com, hare@suse.de,
        ming.lei@redhat.com, johannes.thumshirn@wdc.com, gjoyce@ibm.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250723134442.1283664-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0dhGdqGwqEwmENfHUj89IW5dR6I_PPfP
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f0cc5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xM27ssRcYHfMtaMJAbgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXwOJm9iWEqBN7
 nXomeGa8aPc7oUcG6swMBeVoyzbWRURnkoxubi80Rzr1SO8bnDZvKoMhdZvWW1YyWxf0hyThvNw
 P15BhoY2934Ul1ExEQho1TTZ2J1BspRTDeJqbvEZiXzFBfOfoH7xAHRFNghdPJoJq0jT1lHGkpv
 GSkgPpNG07fVsh+6RL7OSD3674LPGOKF+gtsmjAgswqxD/7iRQwhNLEM+A0+8xblbyiKBBKPd/p
 CyzVMp1t760NAuJiowrQPDVi9BQ3JhoeJHyJ5s22uApjYYn6iKmxlrHAw4F7gty4xQN2PMk0uMA
 hnzr2d1fV0vv/szbW3n/b3XeNo+i+eu90vHfLOAoeLQyKbFqTQuA9IZ/3UMQ+XwcAUN6rlNVVo5
 3yy4Xtz6BANtIwhfxXRzousJF02Wvw==
X-Proofpoint-GUID: 0dhGdqGwqEwmENfHUj89IW5dR6I_PPfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Hi Jens,

It seems this patchset may have fallen through the cracks. 
It still applies cleanly on the latest mainline code. Could
you please consider pulling it for the 6.18 cycle?

Thanks,
--Nilay

On 7/23/25 7:13 PM, Nilay Shroff wrote:
> Hi,
> 
> This patchset fixes two subtle issues discovered while unit testing
> nr_hw_queue update code using null_blk driver.
> 
> The first patch in the series, fixes an issue in the sbitmap initialization
> code, where sb->alloc_hint is not explicitly set to NULL when the sbitmap
> depth is zero. This can lead to a kernel crash in sbitmap_free(), which
> unconditionally calls free_percpu() on sb->alloc_hint — even if it was
> never allocated. The crash is caused by dereferencing an invalid pointer
> or stale garbage value.
> 
> The second patch in the series, prevents runtime updates to submit_queues
> or poll_queues when using a shared tagset. Currently, such updates lead 
> to the allocation of new hardware queues (hctx) that are never mapped to
> any software queues (ctx), rendering them unusable for I/O. This patch
> rejects these changes and ensures more consistent behavior. Interestingly,
> this unnecessary queue update path helped uncover the issue fixed in first
> patch.
> 
> As usual, review and feedback are most welcome!
> 
> Changes from v2:
>     - Updated the second patch to prevent the user from modifying submit
>       or poll queues when tagset is shared (Damien Le Moal, Yu Kuai)
> Changes from v1:
>     - The set->driver_data field should be initialized separately for the
>       shared tagset to ensure it is correctly set for both shared and
>       non-shared tagset cases. (Damien Le Moal)
> 
> Nilay Shroff (2):
>   lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
>   null_blk: prevent submit and poll queues update for shared tagset
> 
>  drivers/block/null_blk/main.c | 32 ++++++++++++++++++++++----------
>  lib/sbitmap.c                 |  1 +
>  2 files changed, 23 insertions(+), 10 deletions(-)
> 

