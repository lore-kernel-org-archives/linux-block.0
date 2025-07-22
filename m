Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2C2E03E8
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179589; cv=none; b=fvzv1t5RwN/0+R41H9Hut5CmOCKhTWcmAO2QpIctyF6INek5WtxSbydayPWbmt3lxyDFW6bxlq7nIFY9aIbo7VepBoA4w1CyEp7nx92EeLUHZEwHtAQsUPEt3SWG7C2S/DLU3nN8flTNgI9I38UQXSsNO1WJOKEiC7W3sO89hvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179589; c=relaxed/simple;
	bh=/slbNGuXvbtOv03HK5fWMzTUtohwVUmVGHh4XuHpW+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OByGXPcnsyj1jalo152XgBKTR05irHJGbI8N0/V7IPfeuGdO3zbvXOyAtdH1lJcB4V5uCvPIyAJNRCGM//akWVZas2qT4P848GBvc2AZoEaNq5rLRBsdgi+P61yisjL4t9dIpQ0/t4zRkZn4Pjs2yul3XQzC/pXLoAuqqXyPZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7WE/Oy5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7WE/Oy5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LMVZMZ024131;
	Tue, 22 Jul 2025 10:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0c803Y
	42fThzePbTn2ibPusjju7GeGKMVG5ZsNhVarI=; b=T7WE/Oy5ZPswrBwIFWKu/c
	OeKFT8iRyJHnhH84iffp1sMFC1H9dJK7mZINfXetuZuPVjDpv9oKNucdLw9kWO4f
	KkSrIK+3OnIwm/Qf+g1Mg8BKT4fZVkXBDQNJk2mZYVD72G2TCf87dt+8uTGfLVo/
	krRahdjp5Q+e7ZYpBbDSH6K1wakB1oEkvWL+r4ZHtvBhZGoUaH4FldEsoSRvhzg4
	+u0OD/dNGYUkm/RvqJWLW+E4LCRJNYEFI7zukoMPc8mZav8a4yTxJX+UG7+pklxZ
	Dzk3KrmYx5PrXpI7w6AxknqIvWOB8oWmfsOzJ046ijUkFGhWTJ1TCxW1XBQBCnJA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfwpjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 10:19:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M67B4n005457;
	Tue, 22 Jul 2025 10:19:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqsj5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 10:19:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56MAJJgb29295300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:19:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D646C58056;
	Tue, 22 Jul 2025 10:19:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6791658052;
	Tue, 22 Jul 2025 10:19:22 +0000 (GMT)
Received: from [9.109.203.242] (unknown [9.109.203.242])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Jul 2025 10:19:22 +0000 (GMT)
Message-ID: <3d591f18-b914-4df6-a46c-2644b6a2ce36@linux.ibm.com>
Date: Tue, 22 Jul 2025 15:49:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Yu Kuai <yukuai1@huaweicloud.com>, Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
        johannes.thumshirn@wdc.com, gjoyce@ibm.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
 <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
 <ffa76a0b-3067-129c-ead4-f1e5f0a65357@huaweicloud.com>
 <0687504a-ea0e-497c-b36e-a942520f7177@kernel.org>
 <8bb4fb9e-e79b-cc92-264f-ae2914093a64@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8bb4fb9e-e79b-cc92-264f-ae2914093a64@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4NCBTYWx0ZWRfXwwtVKXBgFuzM
 q0uiQymRk1EsvLniy8h9KKgDwa0szEWEESTDekngL5DCFlcCBOg47ZtYZTF2ibg+NLNYOdjZfcC
 gtzbPDiH8vsmL0B+X9X/5FlcjP/UrOyu7RhLa1qNyWQyvh9snfMS+/SQdX5ABvHGu2LdRATYat2
 uGfTqq3VtYh87jBsr89Sx/+gjZbJDjlaWNXft7ALl8zAqdH9+zkADTXisbiRPJxx82tgFThvtc0
 KibZxiPXgK9//lDMXf6MXC3OW6hn5A+LomUFEnRUwjMysEYkMa1N6027ZqswCSCcvWL5RsF2/4/
 U7NaVjmvNXpn9hTAopu70wfbyAVKCFmEZOQsBgHmU1BkQ42qvaZK8h42eLYYzAaCykLF7kx1eJq
 /0LrhADu0rMlvYhvzUzy+1fzASdz8NCjLgaVvy0p7C+lrc/ET4GUi4Ofcd5isO4sg7OQP5rQ
X-Proofpoint-GUID: q6arR-VOfpjhVQnd-3K620wWe4aT22Ke
X-Proofpoint-ORIG-GUID: q6arR-VOfpjhVQnd-3K620wWe4aT22Ke
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687f65af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=kbDOTc1PTC6AC5nVFtAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220084



On 7/22/25 2:54 PM, Yu Kuai wrote:
>>>>> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
>>>>>
>>>> I think you were right — the first patch alone is sufficient to prevent the
>>>> crash.
>>>> Initially, I thought the second patch might also be necessary, especially for
>>>> the
>>>> scenario where the user increases the number of submit_queues for a null_blk
>>>> device.
>>>> While the block layer does create a new hardware queue (hctx) in response to
>>>> such
>>>> an update, null_blk (null_map_queues()) does not map any software queue (ctx)
>>>> to it.
>>>> As a result, the newly added hctx remains unused for I/O.
>>>>
>>>> Given this behavior, I believe we should not allow users to update submit_queues
>>>> on a null_blk device if it is using a shared tagset. Currently, the code allows
>>>> this update, but it’s misleading since the change has no actual effect.
>>>>
>>>> Would it make sense to explicitly prevent updating submit_queues in this case?
>>>> That would align the interface with the actual behavior and avoid potential
>>>> confusion and also saves us allocating memory for hctx which remains unused.
>>>> Maybe we should have this check, in nullb_update_nr_hw_queues():
>>>>
>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>>> index fbae0427263d..aed2a6904db1 100644
>>>> --- a/drivers/block/null_blk/main.c
>>>> +++ b/drivers/block/null_blk/main.c
>>>> @@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device
>>>> *dev,
>>>>           if (!submit_queues)
>>>>                   return -EINVAL;
>>>>    +       /*
>>>> +        * Cannot update queues with shared tagset.
>>>> +        */
>>>> +       if (dev->shared_tags)
>>>> +               return -EINVAL;
>>>> +
>>>>           /*
>>>>            * Make sure that null_init_hctx() does not access nullb->queues[] past
>>>>            * the end of that array.
>>>>
>>>> If the above change looks good, maybe I can update second patch with
>>>> the above change.
>>>
>>> I'm good with this change, howerver, with a quick look it seems lots of
>>> configfs api are broken for shared_tags. For example:
>>>
>>> If we switch shared_tags from 0 to 1, and then read submit_queues,
>>> looks like it's the old dev->submit_queues instead of g_submit_queues;
>>
>> g_submit_queues is used as the initial value for dev->submit_queues. See
>> nullb_alloc_dev(). So if we prevent changing dev->submit_queues with configfs,
>> we'll get whatever g_submit_queues was set on modprobe for the shared tagset.
> 
> I know that, I mean in the case shared_tags is 0 and set submit_queues
> different from g_submit_queues, and then *switch shared_tags from 0 to
> 1*, user will read wrong submit_queues :)
> 
I think I got what you were referring here. So in addition to the above change
we also need to validate the nullb config before we power on nullb device. And
we can add that in null_validate_conf():

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index aa163ae9b2aa..1762dc541a17 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1893,6 +1893,10 @@ static int null_validate_conf(struct nullb_device *dev)
                dev->submit_queues = 1;
        dev->prev_submit_queues = dev->submit_queues;
 
+       if (dev->shared_tags)
+               if (dev->submit_queues > g_submit_queues)
+                       dev->submit_queues = g_submit_queues;
+
        if (dev->poll_queues > g_poll_queues)
                dev->poll_queues = g_poll_queues;
        dev->prev_poll_queues = dev->poll_queues;

If this looks good then I could also add the above change in this 
patchset.

Thanks,
--Nilay
