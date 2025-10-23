Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3B1DF252
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199062; cv=none; b=W7GQJOuCmc4hdujuCi9blDteXjq+6LNmuHDDAMpI6qi2oS39oU2PI6rglmirdbKjqZlpWx2oUQey02GM0uBXXl4+PaJqdSnXJ6Bzdlid4MNeq/5B8nb2RLRIxaG6I6WqSZ7COX6Fq9XZYG4OESNfVsaKEZ1JKL5L8pxnYbfysLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199062; c=relaxed/simple;
	bh=YG0lX2u/Blm0csIiDFgSi3IKvKforpaYdjRSwshP+2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljfUAMUIUxdJF6+kkfcBYgf15A7M1MYPWDh+0x2lndMLfSGphKL8thaFdLwpY8yzf3cRxGKkUiLXmxX9G7MeD9cE1ASiYECIXsxgtDL7yYA5qKxx/eBUL71RRGqhMDis3qIQTh3zsLhJ/LoNG8ZdjIYf6WqawQ7ggjIkO5CuPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phEEsGh+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phEEsGh+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ML8dUL001343;
	Thu, 23 Oct 2025 05:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Z1eb8
	pUv3TROO/PL62HS4dwx16H6VYQvUV+yTdS1R0=; b=phEEsGh+JHBKSIb7cfxekY
	rTrNQtEYboIh/J7vJ8aXqieNic9trV2mqZCG2A6r7trfuBMtt1vQhBorw49slDZA
	/GzBBWaedUMl3z2ucy9N/MeCgUDjax5WUft2TGgtuD14N7d2PvfeDE6ZsWPRhjMd
	P1YlJB2bf5s+wQueoa8PapCW9PJkugRROpS53Q/1Yv1HrCMW9t7KDvY4ZcObrCak
	wQY7jvQZCRfqCv3FeNUOqTlKQeciLMKVPGngqU8nje9XII5s1W08dDpFYz0l/OcS
	Rlg0DE6HmArJzPUOQDPKiQV5qNrQ9j+S5z9MgY8CZ4hjdfHQwTTekScRisgmGmoQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hq1hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 05:57:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N2v18j011030;
	Thu, 23 Oct 2025 05:57:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1bx44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 05:57:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59N5vUC327919070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 05:57:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A7355805A;
	Thu, 23 Oct 2025 05:57:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A0DE58051;
	Thu, 23 Oct 2025 05:57:27 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 05:57:27 +0000 (GMT)
Message-ID: <59cf7e0f-1069-4766-9234-cc91985470e4@linux.ibm.com>
Date: Thu, 23 Oct 2025 11:27:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: introduce alloc_sched_data and free_sched_data
 elevator methods
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
        axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
        gjoyce@ibm.com
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-3-nilay@linux.ibm.com> <aPhgAMxgG2q0DKcv@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aPhgAMxgG2q0DKcv@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxY+QAWa57CjA
 ueRsAYMLPvlfkbYIMDe4aeJ5lOo0+qQaRl3A7FGgw7GkbwB6LcLxbqaEo4Kuc2I9ZUBf5eY93kh
 WL3sr2s8Wbm45WsX2NRaU8FSG4wghFQz8Pwbcc0XWiN0gGi+N3tHBF/acLMBQ9awQNQec9qiBzE
 43HZAi+ZzwDYQzDfyQwjaz/moD9QmRyqey6XoGIm6yXPpeN5L8uqqhbW2+7CySVPIn7ba7ICRzT
 CUSLFTAP+/Ai+lXkhT8BwkD4bhE4pwDbbZ0/SLXAAg9d2jQyV5VN0bF+N98yqIaoatbBdL1e560
 A0Pn0MI7/ZYg6QU70W0EGbQui8EK2N2Zez0Dmikx4M7ha72iFiR2GyXOpOrld6XbqxNE6D+LSqy
 TPRbIs1dpZkzsqJdg1I8eMbvpJ2r+w==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f9c3cb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wrP9mkhF7TO3L0ZhHXgA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Jqd7VfFvPQsqK6DHTlbNjU6PbgWj_C9Q
X-Proofpoint-ORIG-GUID: Jqd7VfFvPQsqK6DHTlbNjU6PbgWj_C9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/22/25 10:09 AM, Ming Lei wrote:
> On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
>> The recent lockdep splat [1] highlights a potential deadlock risk
>> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
>> mutex. The trace shows that the issue occurs when the Kyber scheduler
>> allocates dynamic memory for its elevator data during initialization.
>>
>> To address this, introduce two new elevator operation callbacks:
>> ->alloc_sched_data and ->free_sched_data.
> 
> This way looks good.
> 
>>
>> When an elevator implements these methods, they are invoked during
>> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
>> This allows safe allocation and deallocation of per-elevator data
> 
> This per-elevator data should be very similar with `struct elevator_tags`
> from block layer viewpoint: both have same lifetime, and follow same
> allocation constraint(per-cpu lock).
> 
> Can we abstract elevator data structure to cover both? Then I guess the
> code should be more readable & maintainable, what do you think of this way?
> 
> One easiest way could be to add 'void *data' into `struct elevator_tags`,
> just the naming of `elevator_tags` is not generic enough, but might not
> a big deal.
> 
Hmm, good point! I'd rather suggest if we could instead rename 
struct elevator_tags to struct elevator_resources and then
add void *data field to it. Something like this:

struct elevator_tags {
	unsigned int nr_hw_queues;
	unsigned int nr_requests;
	struct blk_mq_tags *tags[];
        void *data;
};

What do you think?

Thanks,
--Nilay

