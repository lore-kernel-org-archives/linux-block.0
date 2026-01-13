Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74A26A0A7
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282074; cv=none; b=rDtLCAQwKb7igki8XVOWXsscvVgJy8c4CxbfZnLa25RTQGVrJTt2mElHI0BuGG0Zb0MfTqrX85eNJn4amrHP+w5koLzi8Sri89ZXfkXsrSk13CaTPQQP/NT/eDbr+KMQvd7UBHejGis6YX1n1N0/vvDIhJ0EqqHigY2f0hrzhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282074; c=relaxed/simple;
	bh=2qAxwhrppVrOj8g7sJXJ9v7a9gGDPfMJeyVarSXAyt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+vIJaRv/EL9dSgQpUouQ4+/zaUcEjGu5V/7jz/UQZrdcBEb9zv3nZsPdOEw9x8ZjOVN7gTt4497E1fzJjUJxhpfKESeuBI3kaXkJkeq+3JqqSvrMLBBqQNnjQt9Ebb9j3QCMp6sdc1TjOM9POTc4345obJZ8p2KonmFjZsQU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZI0sISLn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZI0sISLn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CM21vI004230;
	Tue, 13 Jan 2026 05:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r0Eo5p
	G/bSXdFrHmAA7TroR04e0m/duMa/n7fHJc77w=; b=ZI0sISLncGewgzlfg7CA4d
	JYpWWD/ygOytUx4S2VVXJBZFZWN+ouE5ynPyXcmFfwfY/CgwlnoLuFqwfzLC+nAz
	QW6qRYdc1M3gBMMF7cSybqnCU9XCb5UQ/X0O073Q/mfNQoIDJd+Oe3eFtblvCsm4
	Od9kpsgz/pvjOu823bV7tNqwKnAmKGGRyXrD/fjHusr9rT6PH7SMSGJtew70q9n0
	7+i3iEmF5qd2fC6IjXDL+dT2egTjaPPwM+C8NY/LbBbiKcwYlZttxdEIjTDvRApo
	5f6DjzQ+PD20eK33oVtCl7rbB7A/SrWrEymESYBiX4xkMdQ1NeyWwKeHeEIeBKPA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bke92tuje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 05:27:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60D2YR3V025546;
	Tue, 13 Jan 2026 05:27:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23n2ags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 05:27:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60D5RUka29295260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 05:27:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23B558059;
	Tue, 13 Jan 2026 05:27:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC6D858057;
	Tue, 13 Jan 2026 05:27:46 +0000 (GMT)
Received: from [9.109.198.193] (unknown [9.109.198.193])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 05:27:46 +0000 (GMT)
Message-ID: <b0577774-4ca4-462e-98e6-5e2540f5c428@linux.ibm.com>
Date: Tue, 13 Jan 2026 10:57:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix kmemleak by releasing references to fault
 configfs items
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: gjoyce@ibm.com
References: <20260112174003.1724320-1-nilay@linux.ibm.com>
 <b8a5b940-3be3-4f4d-bf3d-36fdf6896e5a@kernel.dk>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b8a5b940-3be3-4f4d-bf3d-36fdf6896e5a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vKBL-mD2TaDOrgah6EEb-KHxhi3zfp_J
X-Authority-Analysis: v=2.4 cv=dYyNHHXe c=1 sm=1 tr=0 ts=6965d7d7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4z9ZDRyrDThlQRHdhsMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0MSBTYWx0ZWRfXzLwD/i3pZeYC
 NK0goMj/DOLnfk8rdBtNJ3SbXYzXt56/baj59LBp3BVn8rkrYKUAU8Uv7jJqJuaGdhwrZHiSp5o
 70zt1oZnrZnbfclc8c+dwHrFhYjk6poLSvKGIbTGRbvkMWQS5QAvMYuzWWzG+vCSv++mWxPKUk1
 vv2QOHHutXjw8ueZWwIKV/jpac+7c5iDFhgQB9Wvq/y3Hr5WSRm3LR8aGUl2yWjHbMmonBvbS8G
 ii3T+u59Map0xZMSweCuf4qDqXKOWkRWJWPdAhgZ4IQDm62OKxjP5Z0J/g/E7mvmUzEfouzdkly
 Mcu17VGXxOJOd0D/BmOh0zI8fEQxvtQfpppWflPE5XVXjSN+CPG8GILYe3Q1QooqtIIqwCvCx90
 1JlspjyjuyOy5a/fqg37Kd5QFfU55/jnv07Nwv0CZ9l3yOFG4hcpvkTA4c5F57OruBSH8EPjXp+
 G5aDrWcE1Eza36ExMpA==
X-Proofpoint-GUID: vKBL-mD2TaDOrgah6EEb-KHxhi3zfp_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601130041



On 1/13/26 1:51 AM, Jens Axboe wrote:
> On 1/12/26 10:39 AM, Nilay Shroff wrote:
>> When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
>> driver sets up fault injection support by creating the timeout_inject,
>> requeue_inject, and init_hctx_fault_inject configfs items as children
>> of the top-level nullb configfs group.
>>
>> However, when the nullb device is removed, the references taken to
>> these fault-config configfs items are not released. As a result,
>> kmemleak reports a memory leak, for example:
>>
>> unreferenced object 0xc00000021ff25c40 (size 32):
>>   comm "mkdir", pid 10665, jiffies 4322121578
>>   hex dump (first 32 bytes):
>>     69 6e 69 74 5f 68 63 74 78 5f 66 61 75 6c 74 5f  init_hctx_fault_
>>     69 6e 6a 65 63 74 00 88 00 00 00 00 00 00 00 00  inject..........
>>   backtrace (crc 1a018c86):
>>     __kmalloc_node_track_caller_noprof+0x494/0xbd8
>>     kvasprintf+0x74/0xf4
>>     config_item_set_name+0xf0/0x104
>>     config_group_init_type_name+0x48/0xfc
>>     fault_config_init+0x48/0xf0
>>     0xc0080000180559e4
>>     configfs_mkdir+0x304/0x814
>>     vfs_mkdir+0x49c/0x604
>>     do_mkdirat+0x314/0x3d0
>>     sys_mkdir+0xa0/0xd8
>>     system_call_exception+0x1b0/0x4f0
>>     system_call_vectored_common+0x15c/0x2ec
>>
>> Fix this by explicitly releasing the references to the fault-config
>> configfs items when dropping the reference to the top-level nullb
>> configfs group.
> 
> Seems like this should have a fixes and stable tag, too?
> 
Yeah, I will send out v2 with these changes.

Thanks,
--Nilay
