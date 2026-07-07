Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BA3B42D4;
	Tue,  7 Jul 2026 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409656; cv=none; b=JmKAXOvRl40VZqFkZ+bQLE7IiA70zDsX92uE7FL2LcXAPI62t7oFPmEoURD5Xxjljsqxnzg3/Ru13jpqLdjhimAGQDWU4THxSYJt1mF6PT3aVUTzLjS5NffsFu/s9VI0FQOJlBjoXETt/WllNrKQspOhz0Ltfj95ZMTxEG0ZzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409656; c=relaxed/simple;
	bh=6ee5LUui9i7BvvMR8fXTyq7t5MVXGJSUxT3iOICyCnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6DqtUgYoBNbTIHC+Rl9Ne4reQ+S6IfKoOGD6y+mNk7ncg99kl35WHLAnN7j0+esLRXV9LOdM/4odyaN/QbGFK914GQ9mtcHSO/g3r8nMbxZbtAX6omJSblX6gm5+lb13IDn9ey+FOdS9yKi/mBDKi3oXsOHpRMJmRt7NjwtKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nabajz5Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nabajz5Z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674INT42519198;
	Tue, 7 Jul 2026 07:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5wrmxk
	Sm7FyP5LPEQkAPbg8YixAhjxAn+XQwOQyuXcw=; b=nabajz5Z7l9OIT9hjKqO8N
	LnKmWW5OYAsQ+0PirHZ4rCamTw1dVkX7sP5xCJ+oOgjgmNjJUrfL+Nu5j5dWUHq9
	SI0IHHzjtN5fxxk0f3Rh5f5BiZZeUg6XXpFZ/QE8VE+4nBI9pB/dtaTGKs3QBIBv
	3UFoUFdTCODG2iwwMwmFKYZMPkiCn3kMYm5VhHITq+HYADU4jkSt/vVB3JEjQhPH
	cRyNKymKxRRqRA88PpTXCTYpb3Mo1QU0H/bN5wvA5CmA6iKA3OcvWUCyFYXf/JOe
	ZU7K07SCTe94pcTm3sn99sUHYP7DR5t2JOS8dg4vagnVPVexVRP9QLPKemp/3Stw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkndp8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:33:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6677Jb4E031582;
	Tue, 7 Jul 2026 07:33:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y1803-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:33:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677Xsue41288182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:33:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B7F958063;
	Tue,  7 Jul 2026 07:33:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3723258065;
	Tue,  7 Jul 2026 07:33:50 +0000 (GMT)
Received: from [9.43.121.235] (unknown [9.43.121.235])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 07:33:49 +0000 (GMT)
Message-ID: <94fcb5aa-0b1a-4d32-bc07-fd939367c6ee@linux.ibm.com>
Date: Tue, 7 Jul 2026 13:03:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] null_blk: don't locklessly overwrite dev state
 after apply_fn
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        linux-block@vger.kernel.org, kch@nvidia.com,
        johannes.thumshirn@wdc.com, kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-6-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260707025542.1299859-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4cabe3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i0EeH86SAAAA:8
 a=b-9-wLa2cmdvAF9gubMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e6BAsgB4i6vmu_-UbAZou2pfxBJl9IxT
X-Proofpoint-ORIG-GUID: e6BAsgB4i6vmu_-UbAZou2pfxBJl9IxT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX4XiuLRtn7ZoI
 yQakPkNwZujRxqYKCOS6MuuTsQcc+4blEgd/l/RKgO9VHrrHfTq0TWhqDp0fhw2+ZuxqHv1luXF
 WgCdMcnNlEsdWuNpwxeqKJoHo8M/1Y0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX0BKd3U7nh22l
 WZ0Va5L0XpPcibtsm4RUtK1RXgq7fAIby6N0f7093Zyu5Ipvmfzt1qp/FChkVcG1qtEBGlojOFv
 Co+pTLwpjVYwH4zx7VvDbwhU9bLJz3+Lfo/njwLNRA54w69IuqOy/6qjuMVIhh6AlRBcq7hk+P8
 GSw5omu0yH+JQbzSj4Y5UWgajUY/O0AG2GsbvRgA0sGdAt/0ono0ceIt3DHGvd1N7R/pJJzcDAH
 E+VIg2DdeOozNdA5U3FjE5NCciS+3jNSvKqgiOPsWwFANAX00QVe65RJR6wGy03M14NLxv4ODll
 atajJN3m4wbrYbj0/qcqnQEBdi73/9eiGIC9GDxRCbA3/oe8mxtRExcHKLGM3fs80pFLgvkbarg
 jsdrTfM6FcRnWP+k9HZEWDyimEopGVgDnuBHT6pQqb2tEDYp+d+ch9txSHPDkSaEqZ+Tx6NDmjA
 OISgMUpDqlQmyp1s2fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070069

On 7/7/26 8:25 AM, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> The NULLB_DEVICE_ATTR macro unconditionally writes dev->NAME = new_value
> after apply_fn() returns. For attributes with an apply_fn (submit_queues,
> poll_queues), apply_fn already sets dev->NAME under &nullb_list_lock.
> 
> configfs serializes writes via a per-open-file mutex (buffer->mutex), so
> two threads writing to the same attribute through separate open file
> descriptions run the store callback concurrently. The macro's write is
> redundant and lockless, so a concurrent store's losing thread can overwrite
> the winner's value after apply_fn set it, making dev->submit_queues
> mismatch the hardware state. null_map_queues() then hits a WARN_ON_ONCE and
> falls back to a single queue.
> 
> Restructure the macro so that apply_fn attributes return directly after
> apply_fn, and only non-apply_fn attributes write dev->NAME -- those are
> only changeable while not CONFIGURED and have no live hardware state to
> mismatch.
> 
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   drivers/block/null_blk/main.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index cab51301560e..e7555c47b671 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -360,13 +360,15 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
>   	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>   	if (ret < 0)							\
>   		return ret;						\
> -	if (apply_fn)							\
> +	if (apply_fn) {							\
>   		ret = apply_fn(dev, new_value);				\
> -	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
> -		ret = -EBUSY;						\
> -	if (ret < 0)							\
> -		return ret;						\
> -	dev->NAME = new_value;						\
> +		if (ret < 0)						\
> +			return ret;					\
> +	} else {							\
> +		if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))	\
> +			return -EBUSY;					\
> +		dev->NAME = new_value;					\
> +	}								\
>   	return count;							\
>   }									\
>   CONFIGFS_ATTR(nullb_device_, NAME);

Your patch correctly addresses the synchronization issue regarding the
apply_fn attributes under the nullb_list_lock. However, even with this
restructuring, the 'else' block remains vulnerable to concurrent
unmarked accesses to dev->NAME.

It seems when the device is not powered on, multiple threads can still
concurrently call the _show and _store callbacks on the same attribute
across separate open configfs file descriptions.

While this may be considered a benign data race, it can trigger KCSAN
splats and may allow the compiler to perform potentially unsafe optimization
heuristics (such as load/store tearing or merging). So I think we should
at-least mark those accesses using WRITE_ONCE() and READ_ONCE(). This also
help silence the KCSAN splat if it's configured.

Thanks,
--Nilay

