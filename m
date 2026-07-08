Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C42690EC;
	Wed,  8 Jul 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532971; cv=none; b=Kt0JthQXlJPS1BzdfzbSd+Oz+084ZfURK1u0pihsxJ+h+ICuiqO9wDPEWKRDY0X+M0X+1Pl6Gj5OjIriDcd8J7VDTxErEmQwMcPIYlyijdsuwjjVreTvG83bbb6vGN86eQj1mXnQDEUPr/M/VqMrsX4mYOS/sp6iq+GpEEJaMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532971; c=relaxed/simple;
	bh=Zuvj1CTUcEnkcdBdYYZXQjrOJN3GJVif/dVD6hF7VjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2VjmOcE4f901Z0umbU/pnuIqLHJ3jqFkXB1rk+fIgTtbPERnP3tzaPeTOqVkla/XYPrJi6JuiJVgPp+DOEny87ejLwINZs9mPyE9B64x64X2WH3vCG8F3iTZafAxvObTnkPyEvnoklJ4Uf5CyIJ9mVuSopD8yNHl9fYFLBRUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZjXaFZa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZjXaFZa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668GIpP73823048;
	Wed, 8 Jul 2026 17:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xMwbts
	BleuxzTEtV67zIxMy9B//pZUcUb+saWLBQQFc=; b=gZjXaFZaabJH2+IaopxgZu
	zzLxJSpY9FzOuXp5xD4+CjH8TLz4ntoBmB28k7xfrws+5TjQ0gbx9wz3lb/Jbm8O
	u4vG3cjjCQhee4401zOpSm2117DHUYytAfOJKdXfTZFwZFj8gul491IJuYKl9gpn
	iUS43fXQ0lv1GqLSJYVkNE00ibW/7sI6sXk8JGv/NwORNddtnuqC5zJN3JWlpzgi
	BrP9LZd8atS03T75/at5DDyhYntonSYRA0D/5yHzxX4Ddt3yCQAO8XqWYPPD4V/K
	VKbncp3kNqzUFCeCHJHw1FOUdHl1m+Z/cgGcv2eJOFN0rvomM8Oc3Mw1JgJau5JQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3wrxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 17:49:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668HYcl4018856;
	Wed, 8 Jul 2026 17:49:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hh3ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 17:49:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Hn88C18678344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 17:49:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA765805D;
	Wed,  8 Jul 2026 17:49:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE12558053;
	Wed,  8 Jul 2026 17:49:02 +0000 (GMT)
Received: from [9.43.121.235] (unknown [9.43.121.235])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 17:49:02 +0000 (GMT)
Message-ID: <eef66514-5f53-420c-9b42-5af9c261852c@linux.ibm.com>
Date: Wed, 8 Jul 2026 23:19:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/6] null_blk: mark racy configfs attribute accesses
 with READ_ONCE/WRITE_ONCE
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
 <20260708073917.2172392-7-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260708073917.2172392-7-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4e8d96 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=dK4PIHj8gR4ZtUvXNd0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3NCBTYWx0ZWRfX4UXuSYxOCwbD
 iL6StaDPzXxHL/8FyGJ6VHCLBRauWpU6CxyJrUbnMWIhR01/Lxv39EsCsmwV4Y9qH0o15Gyn+51
 gyZpjSpVwcqjq0S7oUKG9LxRx4nPyqo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3NCBTYWx0ZWRfXzOawZxBRTt2L
 YsMOgqCjf59k3AQqtaAHx8gjnmdbIubxFE+tG4vGDuG6T0qGoHjcb3SbvuiaV/LBbmY9P7UcQSM
 X+x0z6HnfDYrzRKnEmcLg9s3k9l5wtdrJEfGV/DROI8b+6UQWK64HkL9oP0vWGaYNN7VXZ7gSMP
 w/5ddfGDlH8aNuf/yTZ+ikkZ0SCG0Stqg1DmyyO0l1WNw477RIbfiybhDzXo3a+SX3xyhgiuxhQ
 GMROOx+Ru0xr49YowLocw+TxCEn1dtkMecTa61hToaV1eBDWdfs2GE/HGt3SHyUwmk924VH2TU7
 9ytn3C4mahYbxVahTUViLxCndxZLsk06/ouCcDG6sYLEz8s7jWCJ6M8A6GxA8g60Ha9e1R9+YJf
 1pv24aOv7jCRJgPZvJe11sr1fGyHsa1twqGimylXcZf6YSvm5uVw3JPADIlQYD7txxN6H3IoPz6
 EAkxkMogLOqGnvg+Wcg==
X-Proofpoint-ORIG-GUID: IiGPVPHIBVQOIY1x411ORtzCCOXn_zzB
X-Proofpoint-GUID: IiGPVPHIBVQOIY1x411ORtzCCOXn_zzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080174

On 7/8/26 1:09 PM, Zizhi Wo wrote:
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 9e0002e4aeec..fd3c993a67b2 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -346,7 +346,7 @@ static ssize_t								\
>   nullb_device_##NAME##_show(struct config_item *item, char *page)	\
>   {									\
>   	return nullb_device_##TYPE##_attr_show(				\
> -				to_nullb_device(item)->NAME, page);	\
> +			READ_ONCE(to_nullb_device(item)->NAME), page);	\
>   }									\
>   static ssize_t								\
>   nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
> @@ -366,7 +366,7 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
>   	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
>   		ret = -EBUSY;						\
>   	if (!ret)							\
> -		dev->NAME = new_value;					\
> +		WRITE_ONCE(dev->NAME, new_value);			\
>   	mutex_unlock(&lock);						\
>   	if (ret < 0)							\
>   		return ret;						\

So in this series I see that all attribute _store() methods are now protected
by the file-scoped mutex, which wasn't the case before. If this is intentional,
have you considered protecting _show() with the same mutex as well? If yes, then
that would avoid the lockless read/write races without requiring the additional
READ_ONCE()/WRITE_ONCE() annotations throughout the code.

Since these configfs attribute accesses are not on the I/O hot path, taking the
mutex in _show() also seems acceptable from a performance perspective. Earlier
in the previous series, I suggested using READ_ONCE/WRITE_ONCE because only
_store() methods using apply_fn attributes were using the lock but that's
not the case now.

Thanks,
--Nilay
