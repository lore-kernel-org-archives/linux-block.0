Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D222E2DCB
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524779; cv=none; b=edO9J3KyFmL8hyRCc1VJ3ueoRB5Fj5wHmF9x1u9T8mbU1jTGtLukD/I0x3DmhEzKA+ba2HOAq4rFnrIX+8A5y4xv3VMHXqgzI5ndr+/JW2jGNFAyDfoEjTknbK/SEvpeG6uzZ/qo+8IoVdB0z0eB5MJXUfQWlOMPACypctRMunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524779; c=relaxed/simple;
	bh=D9uuygrbDHcEaiPIjm29w9chvF3KlF89V8704UmAQp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTGBWoCbSWOpYvU8ZpmS8+5ipT9mDRY85AxwNZOPsQM2S7ZONOJTuGqXrHWX2/UcFratKuAIp/UENlal7+CGmlG7hSqHMCqGBzPHQQFfFE1GIctPMIfZzQHW7HvHYeQx2jBYxzxUHWZ6ZWmQbNFCrrKUsXSeW2Mick2see6vwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YI7VbTzL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YI7VbTzL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F5USrm004307;
	Wed, 15 Oct 2025 10:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tPNw+y
	KOW+dClUmIxqAYoLaVwb/cCk1mWyqwKU5IRMY=; b=YI7VbTzL33DcdLECvNUQRX
	BRX58YMSSTW/j7NHJFcbeF6Pt4zrwbFkEk3BJxul0Et/FoBYVsym/Yyeja4n+SbE
	E1z9/XQRhOCtKRP/jHe5e+O0igxbj+tW5zMaVT62cKXfgVYl2zj37B+oLL9+91Ok
	Dou0+Z5odpL3lm1dauUdCjFvhAQR+jsGDn5DQYNE993xF1Eijw7w52OxjHhkhf3g
	P69UJ20gW+3pNyUrsELTnkmDZafwgp6ZNF9LVIyoFER7dfaTRxdTKC15Fj8WGZd6
	ewd90XvBqsUM4srwb1CvDDCueB8Ct1EDfkiB2qkBWt9/ozqKFjEUvOwyIOmoohcQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7xs3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 10:39:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F75anN016742;
	Wed, 15 Oct 2025 10:39:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jypxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 10:39:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FAdUZn21234364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 10:39:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43B8A58073;
	Wed, 15 Oct 2025 10:39:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48E2E5806D;
	Wed, 15 Oct 2025 10:39:28 +0000 (GMT)
Received: from [9.61.83.49] (unknown [9.61.83.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 10:39:27 +0000 (GMT)
Message-ID: <0fafe3f8-5aa3-4146-b823-e80585ac507c@linux.ibm.com>
Date: Wed, 15 Oct 2025 16:09:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove elevator_lock usage from blkg_conf frozen
 operations
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>
References: <20251015103055.1357105-1-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251015103055.1357105-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gWkaeovtFPOEixnmJreocPURLeeti7iY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX57yVR/UVQE/C
 D5v/MYNxzoOvQOBitC8UI5K3udZRMUHLNZYjtt6UYLcE3i7M9dXuvvuNKV2ScJ4RcRM8iMvawmZ
 G+drJENFnWC7HWoM4vG8bJrk9ts9QSMdW2ptL5YJx8S9A2spMrpuiVv9myDqxKPhMGG2kOLV3Dr
 cNLm/mdTyoydZsW7TKUcpfc8OlHElgRbUf7PWNYRQI+29ZyZllqiyzRynd4hxfMv+/9Y5QHyI8q
 +SZbOBnz056FPbGDIhNapvnvC5nTFqGKJtKW6T7PsfW0TagBDh20i67mFuIUFaBaD3TkElAEZFv
 sEchW87HeTa/lTxNbQVrF9NIqVKzKHTF7dpAlaLjGSYih2UIChBP7mGFgQXKOUhSYbkLt/4e6q0
 GYEF0N75CesB0rPsogkifF/oyY21Zw==
X-Proofpoint-GUID: gWkaeovtFPOEixnmJreocPURLeeti7iY
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ef79e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=6vJ5I3pwAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=jAktq3dgcQUfkETu_6YA:9 a=QEXdDO2ut3YA:10 a=UhDSD9IQSXy9UYYdGJCK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084



On 10/15/25 4:00 PM, Ming Lei wrote:
> Remove the acquisition and release of q->elevator_lock in the
> blkg_conf_open_bdev_frozen() and blkg_conf_exit_frozen() functions. The
> elevator lock is no longer needed in these code paths since commit
> 78c271344b6f ("block: move wbt_enable_default() out of queue freezing
> from sched ->exit()") which introduces `disk->rqos_state_mutex` for
> protecting wbt state change, and not necessary to abuse elevator_lock
> for this purpose.
> 
> This change helps to solve the lockdep warning reported from Yu Kuai[1].
> 
> Pass blktests/throtl with lockdep enabled.
> 
> Links: https://lore.kernel.org/linux-block/e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn/ [1]
> Fixes: commit 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
