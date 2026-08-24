Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EA19D07A
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551980; cv=none; b=U6JXpCHh2QW0JDbQ27sy7bnoLgNVIgiqEhxFblg2OL4YkFpRlZvSn6Sxh/zpFKBllVOWpP9Cz3tVzVI1+U/TMRYlpbmVopR6mBXePnMfAgdzrimI+dY1817z7rE5TX6iNXlgnHAIQKj1QC96gQ3DDOHGDSo+asMf23AQTxE+oW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551980; c=relaxed/simple;
	bh=ZxDlBPowj/JnSPs/s9FamAmMjzwziRXbLE6AMyt3g9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsznFEfXUtu/dF+BnOBMX+otblL2jIQChquFNqycEQiFzUig08OyFf4IwoWbWnL4QFw6sdceVcTdXg13t4jdk6Vs9Wr4dzzZDNhhLurY5OdW5CUHIk+3vcwmA0xBekCK6NAxPSiVO0CJ8DH/14IMnMt1FPcqkwkni69ZYIfkWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mb4l6BJT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mb4l6BJT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5Vax71014028;
	Mon, 24 Aug 2026 06:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y45Yj4
	wCv/1hyRIoTb5htK/ISsoDVgidzufce/DdsZY=; b=Mb4l6BJTCwlIcR3PgBEleJ
	D+/DO1Iv4Tl6ou2kdhbvq95llpEhMWVOuTS9c+mKMZr6RdGXKhtjC1WNK+PtVycC
	utjxxjrEhBHnGmeWU8cIwgOwA7wBUI7ElPK3x0gWu69dffwYLcQTXX1+M1goHykJ
	H7xyLyZqoCviQOVRX25s8y8T+D0Nhi4kFe9d4xWw+Ed5N2Vph+xRQzzKAOw/sW2f
	dhyhpf6qNDYJtDGZJ6LerV3BCSNWGcuRP407foKP443p5VPhxK+ZKyHSpvByAVqn
	UTk8fbVgd5n0k1Soy0EK2V4clA2hZ9jBeD7uWKigb9xAXZYJoiTBPqnj5loleVlw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwyba9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 06:12:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O6BFcN026580;
	Mon, 24 Aug 2026 06:12:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag44gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 06:12:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O6Cn9O32965270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 06:12:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329E358056;
	Mon, 24 Aug 2026 06:12:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB0CD58052;
	Mon, 24 Aug 2026 06:12:47 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 06:12:47 +0000 (GMT)
Message-ID: <b7f88eff-7886-4a85-9c97-7c88ba856780@linux.ibm.com>
Date: Mon, 24 Aug 2026 11:42:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] loop: Fix race conditions in loop_validate_file()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <cover.1787255652.git.bvanassche@acm.org>
 <2b6da8a843526abf58d0d591ce487533bbce805e.1787255652.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2b6da8a843526abf58d0d591ce487533bbce805e.1787255652.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX1noYg4n1oIUi
 DNOZBImf/okV8LFasbjokAxfYsnwPKn+kSP/1JAniKsvaDCTSfpZwczezDjn/G7J6js6GtMC3ts
 4pfSriJdf4JW33a0kD/K+D/U0/eMECQ=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8be0e2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=N54-gffFAAAA:8
 a=jrC3V2uMrGWpuTbyrfsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XcNgvhXkP-JfMdYIaGCG9fhMU6DDBma2
X-Proofpoint-GUID: XcNgvhXkP-JfMdYIaGCG9fhMU6DDBma2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX4U53tEMmxKAq
 3JOMWUcN7vrOFGfn3oVHm5lZQISlyo4lOtUHnxpUVsm0/eT7NGJYf6shzD53viobF61wdJ0EPwf
 YAvl6HLRzXbjLwDGtLUOJuRjS0rlFPsZB+PCQyo4GceqskSRW+XPsuiAhbIivJIHiYGL0naOzva
 SPxhuRFVtt7i8AiuoI4yOAoahAr6kD/AT9le/g+fIQ8fTK5is7M7F2XMEk/pblbP7DZpt/nTaP0
 GaeiZemyhvRByFMZD1ghpkOAabuwevgAuGiBj0entSmP6DKjxNOWprA9MJ8+/HIlOfI3u/BkX8o
 1kl8u2eHzMQQU8bQbZD/VvmeBNnYM6kIxCYEWwqD1aAYBolgU5+i437HpLPb2ExbsDDDY6J0x1r
 K6B9hmEByOW4CbHCz3tQAA52Wktj0EgmfGWBm/dd9EW16vTKWfEHhVXo+RSEoscnrRmx4ENKw2k
 CbBqWBAFFNzWSiIw7uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240051

On 8/21/26 1:27 AM, Bart Van Assche wrote:
> Fix race conditions in loop_validate_file() by adding reference counting
> to the file chain traversal.
> 
> Ensure the file reference is kept alive during all dereferences by
> calling get_file() before the loop and deferring fput() until after we
> have locked the target device's lo_mutex and confirmed it is in the
> Lo_bound state.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/block/loop.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c5f026520836..8b633ea6e72f 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -520,7 +520,7 @@ static struct file *loop_get_backing_file(struct loop_device *lo)
>   	 * loop_configure().
>   	 */
>   	rmb();
> -	return lo->lo_backing_file;
> +	return get_file(lo->lo_backing_file);
>   }
>   
>   /* Returns 0 if and only if @file is not backed by loop device @bdev. */
> @@ -534,21 +534,27 @@ static int loop_validate_file(struct loop_device *lo, struct file *file,
>   	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
>   		return -EINVAL;
>   
> +	get_file(f);
>   	/* Avoid recursion */
>   	while (is_loop_device(f)) {
>   		struct loop_device *l;
> +		struct file *prev_f = f;
>   		struct block_device *f_bdev = loop_get_bdev(f);
>   
>   		lockdep_assert_held(&loop_validate_mutex);
> -		if (f_bdev->bd_disk == bdev->bd_disk)
> +		if (f_bdev->bd_disk == bdev->bd_disk) {
> +			fput(f);
>   			return -EBADF;
> +		}
>   
>   		l = f_bdev->bd_disk->private_data;
>   		scoped_guard(mutex, &l->lo_mutex)
>   			f = loop_get_backing_file(l);
> +		fput(prev_f);
>   		if (!f)
>   			return -EINVAL;
>   	}
> +	fput(f);
>   	return 0;
>   }
>   
I see that with the refactoring and the changes in this patch, where we now
take an explicit reference to each backing file while traversing the loop-device
chain and hold the corresponding lo_mutex while checking lo_state and acquiring
that reference, loop_validate_mutex may no longer be necessary.

In particular, loop_get_backing_file() now atomically checks that the loop device
is in Lo_bound state and takes a reference to lo_backing_file while holding
lo_mutex. Therefore, if loop_clr_fd() or loop_change_fd() concurrently replaces
or clears the backing file, the validator still holds its own reference. It also
appears that loop_change_fd() and loop_clr_fd() for the same loop device are
already serialized by lo_mutex.

So I am wondering whether loop_validate_mutex now be redundant? If so, it may
be worth consider removing it as part of this series. That would simplify the
locking and make the context annotations considerably cleaner as well.

Thanks,
--Nilay

