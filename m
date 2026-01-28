Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0275156236
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769580512; cv=none; b=DcBBs3WIctSd5AtOlz2eX9br7K6ws2lcvmu4RZqj2FzrvB+c6Wlhr72aEmdH6BvqAh8vSzNl98WU03fmZAnTNGgYCCB+k5ana0wZNMmePC62Rt40fVjiwytR2SBzPyQHqRkIe8B2iEEke4YRGHX4tflSVsxNxS/VKfS0wV8arUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769580512; c=relaxed/simple;
	bh=Tvtjma8yHYxT7hevJIZoKqVozmWu7Oxt+LywaVZeXys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRYvYoatWnbROCE2W0SbgsDm35sjgem/IGR8HbX0iQqU/GflPXLAgFnnFkbCVrgLsnJa/LGN7p21M02sCre1P69L+E2Ejee7Z9eDyYxjHOqcw4NzggHfYA5vmvHFyMljPWxljRjK0+IEMdY8s4VBGEsBLb2PSiPIgKO/PksNRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NYFk6/H7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NYFk6/H7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60RIBE0o007148;
	Wed, 28 Jan 2026 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wkoM9QgZ1YTgAjTN7zWEpaspS7u5/Q
	oK+VSk9hQ8ilE=; b=NYFk6/H7AUiZfZutNWIUfjZHR6zZBpf+R/0eEkRVs5gRaM
	QEOIFMnalxazABCTL1bgzOZexVmod39zLTR9xNixFwZyMBopk8wIiHAAjAlD0kvZ
	qMEnut52w+aaC2LzJ5A4mTwWf1sJTmR9p0+qfm0jW3nft07AsZkL//gVtmx1hRgo
	o9ukJWCqa4kjYnAu/TgBnhf/IzMQe7nR8U7x/Uhr6mX/EkQCAc2W+m2qazooIzOl
	UrTO+Neu4aDZK7cYZQLd89JBsj5TQBnCzeZbx0qa5QKjb6BDpAUTp4qbsNHO5+9z
	HayyaMTLDymHHRtRjMaF8EF4Vp5OlQ+jodzm6yCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrthj9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 06:08:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60S63g3D027656;
	Wed, 28 Jan 2026 06:08:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrthj9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 06:08:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60S2ZVdr023624;
	Wed, 28 Jan 2026 06:08:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjv11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 06:08:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60S68MVf56033762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 06:08:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C561620043;
	Wed, 28 Jan 2026 06:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEEC120040;
	Wed, 28 Jan 2026 06:08:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Jan 2026 06:08:21 +0000 (GMT)
Date: Wed, 28 Jan 2026 11:38:19 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
Message-ID: <aXmn07uJ9qxe4qJt@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251221132402.27293-1-vitalifster@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221132402.27293-1-vitalifster@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v2hUHrqSRzzxycWwIH2oCaQ2tvy7finp
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6979a7db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=TkuBN2Fti-PRllfk:21 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=3Mt9XtWo_b8JSGLEDj0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: jmNoTbNoTrvxUjQGk0qTB3R4NWeEqHO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NCBTYWx0ZWRfX8vM4Ye7MRchu
 /HWDw03opb+7Ke+41Gjti5bBREzZIbGgHuxZGqpy9XoiIiWQa/qg7ZmFt8qP4ka8lNG3UXxsK6Q
 dJ39vyguzhbySrEfR5JktB5A+Xobx7uERZ//CTNWHtfw13JtqTDbBKzDsnkaJxF7QNQjV5yAoxR
 d80I7nGsBFb9zEmAmjB6N8t0J94BpIhy6++UoE0g7n4ewBIGvfWHbPKg9SRGMLpALKcOPtcIYDH
 Z5VOY9ppWlEbHkbhPbUFRtt22YBn+yi+O187rx5oZWAPCIXXTcRZBUiHIxC+K2CE+QsCDy0ddza
 ggCYVbyK4XfGtThSILg4uxoz4IsoYQLMIatXnMwAkvPGnQrkp4ZsIEgHI0bf32Sxtjzn+pc/Gq4
 jAgxjd0qaHeVkiTeNqVsaXgmxjwd2W8CeRWQuEcjyk/YiYaUpo0Hk5khbPtkoqNFEx+BusEipQz
 JVOU0F/cLCoSwWB4Enw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280044

On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> It contradicts NVMe specification where alignment is only required when atomic
> write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes
> 
> Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>

Hi Vitaliy,

There's some context to how this feature is designed as such. One of the
reasons to have powers of 2 is to abstract out device (SCSI, NVME) level
spec details from the higher level implementation of atomic writes. My
memory on what the specs say is a bit fuzzy but iirc SCSI defines an
optional alignment for WRITE_ATOMIC command wheras NVMe can have a
boundary which shall not be crossed. 

Which means, for a user to perform atomic writes, the physical blocks
allocated by the filesystem would need to adhere to these limitations,
which would need knowledge, at the FS level, of what the underlying device
is and what its limitations are. We wanted to avoid exposing these
details to the FS. The power of 2 length and alignment becomes a good
middle ground where if the FS can ensure that the allocated blocks
follow these limits, then it would satisfy both SCSI and NVMe, without
having to worry about the individual spec's details.

It also helps that power of 2 simplifies the calculations at a lot of
places and the first users of the feature ie DBs are okay with this
limitation.

Yes it might be a bit restrictive and we might have use cases in the
future that need non power-of-2, but just removing it from the
generic helpers, like you did, is not the right way. It will be a more
involved change that might need modifications throughout the stack.

Regards,
ojaswin

> ---
>  fs/read_write.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 833bae068770..5467d710108d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  
>  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
>  {
> -	size_t len = iov_iter_count(iter);
> -
>  	if (!iter_is_ubuf(iter))
>  		return -EINVAL;
>  
> -	if (!is_power_of_2(len))
> -		return -EINVAL;
> -
> -	if (!IS_ALIGNED(iocb->ki_pos, len))
> -		return -EINVAL;
> -
>  	if (!(iocb->ki_flags & IOCB_DIRECT))
>  		return -EOPNOTSUPP;
>  
> -- 
> 2.51.0
> 
