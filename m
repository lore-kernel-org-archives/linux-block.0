Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A150276;
	Tue, 24 Sep 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165748; cv=none; b=fxx/OOiATxnbp0LT0x7PylAcTUYveKotf3C9sLqQbM24Vc3LaWBCZAt7kPFvAaHkBhmbYx7rfPxRIQdyFMtZqJsCFh62CjbAx4jtlBpC6608a8ufpO5zyVjgyMhR+lOGxc3c5SRq4FFd/NREzfgUd4u0e015N++lOMDK+gIlQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165748; c=relaxed/simple;
	bh=vSGXyxX6oOxCSJBz4sD8kNpYaTs7kKqybk7DzfvvCt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GAGuuh1aMEGaxEwiy8zZJjIJteq8hCm7kNOaY81vjMSkzxwimBHdFf1/NzCLeX2c5rKO/vI+tbpJVK5Lw2qay81FFLKRDdylAWiJECLt2j4nskuQcUg8X5g5RUKkBMpNWZkfJiIjW3MBiLgsFe8wK5jbMXr4RjJJZWyAHesdo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FukPoBfK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FukPoBfK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O2RpDt023576;
	Tue, 24 Sep 2024 08:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	en0OrIo1jP7PuqBMsu1Ct7FHd5WhkM4OW0+JX6esDAU=; b=FukPoBfKG2i48q1X
	1wDfbMjHbEBozSGIzYDCdNmtv4riZyyEV+sV5Uvql7nBNejj9rPhi824MZ+qVoS4
	4u6dcFIreFDSMOol1h8PkBoN8jeEATkXinaw7+u3ETkkZ9GaPcA8SCGPvl+Gb7aB
	0m293IQslKDWGbO5EfX8dCWb/6sLXcLgQcj9ZYyHaZCyaldp6l+dJbrd4LcFGyYT
	e9/1Y2cxgvWxw/R8ut56wn2wKdec50qkoTQ7sZ8I4aizsxqy2nB/NlYpojQkFsOc
	Bf9h350K9ECqorkVPhLjK5Za7YwTClxQ6k+IEcyoa0K855NdE0IAI1eNRgchHUqV
	RrromQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrgp6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:15:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48O8Fdeb006749;
	Tue, 24 Sep 2024 08:15:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrgp6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:15:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48O7o9dZ013933;
	Tue, 24 Sep 2024 08:15:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9ymtq3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 08:15:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48O8FcVT27198042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:15:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE7A5805D;
	Tue, 24 Sep 2024 08:15:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA6ED58059;
	Tue, 24 Sep 2024 08:15:35 +0000 (GMT)
Received: from [9.204.204.92] (unknown [9.204.204.92])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Sep 2024 08:15:35 +0000 (GMT)
Message-ID: <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
Date: Tue, 24 Sep 2024 13:45:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zram: don't free statically defined names
Content-Language: en-GB
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com>
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <20240924014241.GH38742@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LILgiBblAokMJKO6uowWvrf4iMi37SFI
X-Proofpoint-ORIG-GUID: bC6rzon100RjJ8KmFnzah6Sezjtt_6rD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=701 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240053

Please add below tages to the patch.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

Refer: 
https://lore.kernel.org/lkml/57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com/

Regards,

Venkat.

On 24/09/24 7:12 am, Sergey Senozhatsky wrote:
> On (24/09/23 19:48), Andrey Skvortsov wrote:
>> When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
>> default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
>> so we need to make sure that we don't attempt to kfree() the
>> statically defined compressor name.
>>
>> This is detected by KASAN.
>>
>> ==================================================================
>>    Call trace:
>>     kfree+0x60/0x3a0
>>     zram_destroy_comps+0x98/0x198 [zram]
>>     zram_reset_device+0x22c/0x4a8 [zram]
>>     reset_store+0x1bc/0x2d8 [zram]
>>     dev_attr_store+0x44/0x80
>>     sysfs_kf_write+0xfc/0x188
>>     kernfs_fop_write_iter+0x28c/0x428
>>     vfs_write+0x4dc/0x9b8
>>     ksys_write+0x100/0x1f8
>>     __arm64_sys_write+0x74/0xb8
>>     invoke_syscall+0xd8/0x260
>>     el0_svc_common.constprop.0+0xb4/0x240
>>     do_el0_svc+0x48/0x68
>>     el0_svc+0x40/0xc8
>>     el0t_64_sync_handler+0x120/0x130
>>     el0t_64_sync+0x190/0x198
>> ==================================================================
>>
>> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>> Fixes: 684826f8271a ("zram: free secondary algorithms names")
>> Cc: <stable@vger.kernel.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
