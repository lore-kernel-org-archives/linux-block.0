Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479C1607A4
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105068; cv=none; b=Diyzr9PolXT3PANppLoPGdsHvFJItctPwgOcXBCH67ukyrVhNEiCcKbsr0Mde/LwnFH3EVUAtHDfwLr79MCyjwICb6dntVaNHfCUOShu0VGJzrVzRs3Ml07m4EzxxIEeuKKIHw5DzJ5Ud7zhXA4KEE0kubYn/96nuwP1ATzjqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105068; c=relaxed/simple;
	bh=ZQPipNDdjVBAbFgfxxDJ95AbpmZYa3Qy8MSXa1QiDcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3kwPkK2+pszIkbjBsLpA8LB2Yv5fNUyLQ2JOsD+Nz9BzI0dXgjNhCQbnEmKQCz91jldQmG46kkmi5yZx+MjWuByUQD/Og4kkS6jARp2dhM2s3EO45dXCCKFD8VUK6sYeNm4MQcjWEOVKl+mJkoSgqAF81Et8jfCewBRwQzNUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLbWWHMT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLbWWHMT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LB74Uc004113;
	Mon, 21 Jul 2025 13:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uQvhZD
	BgG5GczamMR6oaGwLiWPTFPI5BzM55hDfW6IM=; b=WLbWWHMTba6NnD771A7vcA
	mjbVIfLa+HfV2/0tnnb/oFohEXjUmQn5xcfZEDU8DNqQpmLz4QqOz6S/csaQIh1W
	JSupj8p98FX4E345+xNbnFaSywcG0T5fF5KKfBNY5FNqfSGbyM3d+4nYhKpWcBaP
	RmPUeByP2FFhWB9TW4RO/e/kQ7iIrjDqKPwlC4cTOxeI6eZjMljB1jq5o6YYvuV2
	UNyMbymK9pYiPa6Gk2i5TYyLrlhRUMbTzM4kmrvM6yJ8g+vbD0adpvEforzPZ31e
	a8WkPnG0pPdOy6R8faO3JjvbuN7hBS9r8Jlzh9ryrFJ16wfi5SKhBHt7fk/Kk92w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqru7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 13:37:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCIOKT005253;
	Mon, 21 Jul 2025 13:37:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fnhjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 13:37:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LDbYHH59703710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 13:37:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B510D5805E;
	Mon, 21 Jul 2025 13:37:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E62B55805C;
	Mon, 21 Jul 2025 13:37:30 +0000 (GMT)
Received: from [9.43.127.174] (unknown [9.43.127.174])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 13:37:30 +0000 (GMT)
Message-ID: <a4f4d30e-c032-46b8-bc29-2254ddcf8fea@linux.ibm.com>
Date: Mon, 21 Jul 2025 19:07:28 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250720113553.913034-1-nilay@linux.ibm.com>
 <20250720113553.913034-3-nilay@linux.ibm.com>
 <4b30df72-72e0-484e-99d5-820af02619d9@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4b30df72-72e0-484e-99d5-820af02619d9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mzAwUg7uSyTeTF6rpH5zLUKUP8YCDLvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExNyBTYWx0ZWRfX7OZPu1L+v+cj
 u/CzYtAOEU94BCjMm88ZRWZyV4EcPNXKcY4T1Rwj03gFBn35wYWFXhJOKvaHJm0VuhpCvjnKnEN
 Vf1xxe/zJ8r5TmgjY4lrzyMZSF6O5dVRxbJfLSR1jnvU31+cZw72Wb9ahVuWiEizDP+XcraOVlB
 ppDSdZ/3O0SBv3cMyz4m2D/90BKH/vLGewUVa9howmYeCS6fPJeCdtEMe+Qlpcbq7OtR7M5saLK
 mQmvhN2OisgAFOtTdyKY58pPMFdGu0Exn304JvM0r27oqA5H/51JCHmORznM5I2Qufqq+iCoQGl
 tZEB8Nc8ttzwlgyXNsgFTdxuZH2UUZW9uCw0at1QmPkHlv2JAG6dJNNfxKIAQTAH0QgXDizp22L
 O77F6ASmtXcvwMFzAUK2KBQ1mNiMwFsKB3hvl8a+J7hZkHqrQqK77TXOSd7DK00g+cYBOO+s
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687e429f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=NuxngZXgg-Y-D_1eyDsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mzAwUg7uSyTeTF6rpH5zLUKUP8YCDLvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210117



On 7/21/25 6:34 PM, Damien Le Moal wrote:
> On 2025/07/20 20:35, Nilay Shroff wrote:
>> When setting up a null block device, we initialize a tagset that
>> includes a driver_data field—typically used by block drivers to
>> store a pointer to driver-specific data. In the case of null_blk,
>> this should point to the struct nullb instance.
>>
>> However, due to recent tagset refactoring in the null_blk driver, we
>> missed initializing driver_data when creating a shared tagset. As a
>> result, software queues (ctx) fail to map correctly to new hardware
>> queues (hctx). For example, increasing the number of submit queues
>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>> remap queues. Since set->driver_data is unset, null_map_queues()
>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>> effectively making the hardware queues unusable for I/O.
>>
>> This patch fixes the issue by ensuring that set->driver_data is properly
>> initialized to point to the struct nullb during tagset setup.
>>
>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  drivers/block/null_blk/main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index aa163ae9b2aa..9e1c4ce6fc42 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1854,13 +1854,14 @@ static int null_init_global_tag_set(void)
>>  
>>  static int null_setup_tagset(struct nullb *nullb)
>>  {
>> +	nullb->tag_set->driver_data = nullb;
>> +
> 
> How can this be correct since the tag_set pointer is initialized below ?
> 
>>  	if (nullb->dev->shared_tags) {
>>  		nullb->tag_set = &tag_set;
> 
> Shouldn't you add:
> 
> 		nullb->tag_set->driver_data = nullb;
> 
> here instead ?
> 
>>  		return null_init_global_tag_set();
>>  	}

Oh yes good catch! I'll fix this in the next patchset.
My bad.. :(

Thanks,
--Nilay

