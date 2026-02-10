Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE898332917
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711097; cv=none; b=Bhx29+CzYkXxDeDHokPKeqzIXiBkD5K/gk8A9p6F0Ig7urriTWscTIfWb+9u64vhYiiW/nvINGXriaQUlXumgjaZSgJx7caHZ20As8/WtYWsqJ6S2NISWEJVXsmnfde6McYp1BHrPCI8qz8OEknpEYdSI5c8N9Zlo3IbdcSZs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711097; c=relaxed/simple;
	bh=Zoxy70mffMFVYrK1VgkmHaWhIqgSqzfo75aVny9HJds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLzh2kELX/8sZP0zTUjaCbmAlvK+j6WAXwOaXx65h9+r7IwCKH6KmL8BKCvyWQ6ELMcspU4oCtSAc/sG3Hy+HMWTN7yFuLagrFOsiulZauaGudc/dBVYqqW8ZtmeSZ7xNLW0zqLlFkfXgWlcxW1PEKEFmoBExu4aKzVf9ztqUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V5eQnPx5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V5eQnPx5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619FmaAC328612;
	Tue, 10 Feb 2026 08:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yacUS/
	5xn+i90L0A/5qoKjfR29+LuPyeO9WE9hzFMkU=; b=V5eQnPx5KHdevGsjQRzfgA
	6ctJ0DjHFjeWatIVZd0sNmA+NSam7A/wvZLenYylDJbAJnsq65C0dc3R0rPO562t
	IUs5jP8+LLQQe7yF6jXsga/RqXWwnuqhH9J5cybCDwKWLSZpl376u4BYergfkaH3
	iUqylLsrf8ezTSu/klEZeviykt92ATR0NkLkltmyjD4vMmqPmmAcVfufwbgnZZj+
	Gen//NLVFka8WTgqj+V6DTugwDD8hoR3mLndBcsqPNqRlyy04gNkrPYUS65Cup9M
	fr1qXmFa9ohttlBjFvN4uLPAGQIp+szSuFiBLCvVElqr/epyrVH+A7E4H1SdECxA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696us7f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:11:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A44FuT008400;
	Tue, 10 Feb 2026 08:11:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y8jch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:11:02 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61A8B1xj27067108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 08:11:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 641E458045;
	Tue, 10 Feb 2026 08:11:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90DD58050;
	Tue, 10 Feb 2026 08:10:56 +0000 (GMT)
Received: from [9.109.198.160] (unknown [9.109.198.160])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 08:10:56 +0000 (GMT)
Message-ID: <ac55db2a-ab90-460d-9efa-e13c5a3f498d@linux.ibm.com>
Date: Tue, 10 Feb 2026 13:40:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, sagi@grimberg.me,
        sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, tj@kernel.org, ming.lei@redhat.com,
        neal@gompa.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com> <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aYn-xwFHCpd7sITJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA2NCBTYWx0ZWRfX3oGi64WxoWN/
 GBeaVWITmRzlY94+3+Mjrz5uMdVtO3PI/urzjfFFcclJigRcI1Vwjsh8VCHcaO+5v8Ns6UVnBQf
 3m/iwm+LQ4Acb4l5RqpybHloQiOvW+al3Um1BHg6maUFfB3N5aTiK7V6b98KittQsAdBccQ82yx
 UD0euZe/6G+eFR4R4uILXRmEGVktqYlAsiGePEQAtop6AAyWVITc0v13+tPlT3VZ/YpoEvMzoqH
 w3DqLyVTMuLMsOmZVvVGS/j52BHMoo03uqNi0gu0f3qtb9YLRbqoNwgECsmZJisJQat0pPn62o1
 zgyn1jtY0/X3VKfxJ7Rgkh2E1RGZkzIdC4XrftUUAJQuvTgzGwknbVllzOteJtGEtBU9dQ9wirZ
 AXdYwTRN1qWqUiXlgQZosHjXnTgVJPWniFfdBiutTOLt058RP4EbVYKIYY/NHe960KwZC4Yrwfv
 3Hj5mU7B6KhgIr83vVQ==
X-Proofpoint-ORIG-GUID: AreZ9eDAwMrjE8TxGo49dw8sijoQhvpH
X-Proofpoint-GUID: AreZ9eDAwMrjE8TxGo49dw8sijoQhvpH
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698ae817 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=tJLSzyRPAAAA:8
 a=TfStTScm9TuUUgMehrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100064



On 2/9/26 9:05 PM, Keith Busch wrote:
> On Mon, Feb 09, 2026 at 03:58:32PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 09, 2026 at 04:29:52PM +0800, Yu Kuai wrote:
>>> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
>>> When the queue is already frozen before this call (from nvme_start_freeze
>>> in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
>>> only decrements it to 1, leaving the queue still frozen when
>>> debugfs_create_files() is called.
>>>
>>> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
>>> debugfs_create_files() and risks deadlock.
>>>
>>> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
>>> so the queue is unfrozen before the call, allowing the internal
>>> freeze/unfreeze to work correctly.
>>>
>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>> ---
>>>  drivers/nvme/host/apple.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>> index 15b3d07f8ccd..1835753ad91a 100644
>>> --- a/drivers/nvme/host/apple.c
>>> +++ b/drivers/nvme/host/apple.c
>>> @@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
>>>  
>>>  	nvme_unquiesce_io_queues(&anv->ctrl);
>>>  	nvme_wait_freeze(&anv->ctrl);
>>> -	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>>>  	nvme_unfreeze(&anv->ctrl);
>>> +	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>>
>> Looks good on it's own, but it would also good to align the
>> apple driver with the PCI one here more.
> 
> I'm pretty sure this series would deadlock nvme-pci, as that driver
> still leaves the queue frozen when calling blk_mq_update_nr_hw_queues.
> 
> We've left it frozen on purpose, though. The idea was to prevent new IO
> from entering a hw context that's no longer backed by a hardware
> resourse. Unfreezing prior opens that window up again. Maybe it's not a
> big deal; I don't often encounter scenarios where the queue count
> changes after a reset.

If an I/O were to slip through during the brief window between unfreeze
and the subsequent freeze inside blk_mq_update_nr_hw_queues(), wouldn’t
it still fail because the NVMe queues have already been suspended earlier
in the reset path? My understanding is that when the controller reset
reduces the number of online NVMe queues, the queues that are no longer
backed by hardware remain in the suspended state. As a result, any I/O
that reaches them before nr_hw_queues is updated should be rejected in
nvme_queue_rq(). And if that’s the case, then allowing a small unfreeze
window before updating the nr_hw_queue count shouldn’t result in a deadlock.
What do you think?

Thanks,
--Nilay

