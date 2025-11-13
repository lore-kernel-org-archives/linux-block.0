Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F6352936;
	Thu, 13 Nov 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040337; cv=none; b=WEPy6ca9dmKpjKkHtE8my/gpTzNJRUY/vaRjSLuTR2NrgRmCTVxenaHebHsRdBKSNfODWQGHy4B7/yGSo0J6vWSCVluTvU9oe+HbkOyevesr/PoEu+vQkIn/0Z5I7w1JvT0bapv4DZYuFu819CZQv5K8WcXtZMEgiQlsyTGvf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040337; c=relaxed/simple;
	bh=390nwoh9XrOw7TM0x0Uag8CCh+ivjx5Sdd+gp1n26Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDc6ukUrh3ElayYUIZLSo8Z3gSO5Ixv31cNU36bwvN+7uwHnH7BRtZPtQ7XLtSVcmCmx/gD2Eb5LAf2/BTnJMbBS94haJ6L7QlgPuxn+3qmtR54iJEf3iw4dDGJlGtz234y+49b+AtmQPbz1FGJxJVJn1rFE56SGfSAl9cWTzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qBoOj0yj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qBoOj0yj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD6ASEq005450;
	Thu, 13 Nov 2025 13:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R2KDPT
	6y+CJ/XZssKHOI1vWKMsK2Lk3tzV1b3k4Nlyk=; b=qBoOj0yjVpQWGtQScmKfuU
	zvIoYeclfAFht4Mf6ZLNMutZXgqwqIooI2wtUPG2m/+v+c2gB/j8YvSNME+cvl6R
	s7d4+PmNg4pCQrQicYWRrolRiHVBiI2X3FPdzB+5tjk72skYbjtQxDMEbau5dSsX
	0Fm4tVgPWglfZyAsNL1hqK+ykq5be6lS7ABvY3lfXdu/XvNZC8ftIaylpaGGT9Qi
	NJiPb2lAuyr7U9jOZM0gd44eFlo528ob8alo/Z9q9cIO9CZnbN6G8fzyVi50o87b
	KRvMolAqgYig8drwqK2GAm6JujQhppmDPVhLzrzsmrkjzpyRtTvdQqkYK2QIE1Yg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7g8du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 13:25:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCfIlQ028867;
	Thu, 13 Nov 2025 13:25:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6sp46y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 13:25:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADDPGcO47186316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:25:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831A758059;
	Thu, 13 Nov 2025 13:25:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1CEA5804B;
	Thu, 13 Nov 2025 13:25:12 +0000 (GMT)
Received: from [9.109.198.209] (unknown [9.109.198.209])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 13:25:12 +0000 (GMT)
Message-ID: <c527dae6-266c-44fe-9f79-130accc761a2@linux.ibm.com>
Date: Thu, 13 Nov 2025 18:55:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: Remove queue freezing from several sysfs store
 callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
References: <20251110162418.2915157-1-bvanassche@acm.org>
 <b1820392-f21b-4b68-81fa-0cf123c981ba@linux.ibm.com>
 <0b146bb8-3f7f-4d78-842f-a08b43e5f4b5@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0b146bb8-3f7f-4d78-842f-a08b43e5f4b5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX/aAoXxaLlbTD
 VlwF+QugYXf/i9Jr6TwFToH7SsCCFT5f1XdEEJyejk9M0L2Myop5PIKy/K5gjnX7E4cAh1WB2Hi
 2btiTlMxGcl5oukxQoFbZa+WXUaR5H0Y/V4JD6+j5f0AGFTxK9qDSG3YVPukykkun92YDXWk5Pt
 P5vMfDU5xT4pnTsJHCKwF6fJEV472HkZ0AiustF/X7bdHjBbzBW64bCBa2qyAptFvOXEIuzpUO5
 fKItMH54DwxD9wmgQPaOhoxgypbMGnwE6KbgpaCTjoSolljjU2qkzTyfeH844BgKDT5Ym2oWDcb
 4enDCIIbO3B16iLkbWUkM0sW+RMg9hhjT7U4FNyuQQMh2OaJZ4YYNCaj7T/ueve/GQAjfwyvVGq
 ZQtbSGi1ph6raVO0kxGfI245GB2mMA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6915dc3e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=b0YqxUdnJKorBibaU0cA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: IQz2SHg9gewtqs21_sF6plO6Ci3ohuxv
X-Proofpoint-ORIG-GUID: IQz2SHg9gewtqs21_sF6plO6Ci3ohuxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018



On 11/12/25 1:22 AM, Bart Van Assche wrote:
> On 11/10/25 10:25 PM, Nilay Shroff wrote:
>> I applied your patch on my linux tree and ran some tests. And as I earlier
>> suspected, I found the following race from KCSAN:
>>
>> [ ... ] 
> 
> Thank you for having run these tests. It's unfortunate that I couldn't
> trigger these KCSAN complaints in my tests with KCSAN enabled in the
> kernel configuration.
>> So from the above trace it seems obvious that we need to mark both
>> writers and readers to avoid potential race.
> 
> That would be an intrusive change. I don't think that the kernel
> maintainers would agree with marking all rq_timeout and all ra_pages
> reads with READ_ONCE(). I propose to annotate both the rq_timeout and
> ra_pages data members with __data_racy to suppress these KCSAN reports.
> 
Yes, that should also work. I validated the use of __data_racy on my test kernel.

However, while compiling the kernel with __data_racy applied to q->rq_timeout,
I encountered a build failure. After some investigation, I found that the issue
occurred because my kernel configuration had CONFIG_DEBUG_INFO_BTF enabled. 
During the build, when the compiler attempted to generate BTF types from the
vmlinux.unstripped binary, it failed. 

Mu guess is that some compilation units have KCSAN disabled, in which case
the pre-processor expands __data_racy to nothing. In other units where KCSAN
is enabled, __data_racy expands to the volatile qualifier. As a result, BTF
resolver encountered two versions of struct request_queue: one where q->rq_timeout
was declared with the volatile keyword and another where it was declared without it.
This type mismatch caused resolver to fail during the BTF extraction phase.

Yes this is something not related to block layer and has to fixed by 
KCSAN/eBPF developers.

Thanks,
--Nilay
