Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66775288C0E;
	Wed, 15 Jul 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124914; cv=none; b=fUZVMJDUEcBSzFBL6RtF2Ymyqq4MdGq1FNyYgXfv7cjjevf7sb3cWEzXjpwqmRuacVVNOi4wAYYc1FGLiT6QxP8c6aSyEM461Twhcxyfq4MBIi8xrqYAjXQK6wQhIDtKsKaK+Ibff4EPhpsExlxlu/aAFb5R8nN3X3dxzWLlaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124914; c=relaxed/simple;
	bh=oHF+Ocw6ePvop6wEmHBOqulV73OkPHCSlvUZhrw49wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndBb4Dpkf9/qeCp51I6xrzE8eD7QSBmSIhthr1tzPj4VopYSVNp49rD0N4V5r+83eqvVcagk5nuMsOB9UNYKbpJQxmAsd3TgZF57g4VBOeQa5YyZgTQmMSijIPvOgxqDO09PaQzAk7QeFjeEkirP8AWXfka1ptog2d2VaprM1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHia8JID; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHia8JID"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FEBvkX321826;
	Wed, 15 Jul 2026 14:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EZP95B
	fV7MZgnBgl0QPWmLJ33IJNw+k2Na8voXVuKsk=; b=HHia8JIDe/Ev6qO8XvqP6y
	Skl8ZjSU2y2hSPgbrOrICHXIYQpDs6d7pH3xXiQEMa7UpTupa7eJabP9a4fpFiAl
	SkFpxiVDEc/S+LqG2opBwjcPVStIAfjV/nuceU9YlTaEsk7SxnBJ6KChdCe8x/Xy
	AchvNbeAPIGMY4AN1voOL8n067w+MoVluPy6dTbgLaWoBNfQ2f57FGsYbYXarHfK
	dQHEse9d0fdqJVGU3pfUP6qpw7XJJC2/YNWwr0OlWdVsb4rqPlL0NiorLI4fYuxq
	ax6/6Mukn84+QvxbPk0TZcqh7VbrtXwD4BCrK/xvqZDbCzdIwRG66HKwTOgUF8JQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2abbvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 14:14:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FE6vPH012432;
	Wed, 15 Jul 2026 14:14:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw8h4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 14:14:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FEEhe222479520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 14:14:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A406F5805C;
	Wed, 15 Jul 2026 14:14:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E990658051;
	Wed, 15 Jul 2026 14:14:38 +0000 (GMT)
Received: from [9.43.121.189] (unknown [9.43.121.189])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 14:14:38 +0000 (GMT)
Message-ID: <2f61dfa0-ca63-4d81-a702-7fdd4a2e0f4e@linux.ibm.com>
Date: Wed, 15 Jul 2026 19:44:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 5/9] null_blk: free zones array on device power-off
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-6-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260714041805.1088702-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfX+P/SW/A4EeKw
 GoDpDDjBGKvs8lxKa0fscWN77FJTGhEUX5tlUQ6/HkmM/gIA/rvvxKucLjO8fNO2G07RprWqpQ0
 kOqJS6kiFNCrMe5fYm1pmvEI7k1CNVk=
X-Proofpoint-GUID: xEIc1n7Yp_rkRTjW4zYz0Jc8hEQyWF4N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE0MSBTYWx0ZWRfXwy49c3aBcsUW
 /sExozYQuHIknkkKhWXdNuglrnNDixXQsPgSIQnbGufpSgZyhwRaV///4Unv9P1qdvnLzt5WMZ0
 NOvdcWT158112xJPsDg7PYAQVvCCFL1XT5vodHUbj8+vjNGSyiHKFM7AJMorBsXE7jvs9xYyl1R
 HciUHLGjtEIhF53EVlPjafTd47o6hmSONNsi5vLV05QOBH27PJ4ZdqAlIATX0HcRF65oZtS7K6/
 Aeu09tEOmx0NCBQRK5lBdPw4vDuiDPRAFSK6tK/uT7Dw6NWObrXD0LeYrmyTsJAApAe8jWRYrOl
 n1MSgLerFeUtQGRI8V6+CzOcABvE9htL+klWUwmhlSKVki+ILw5loSZJaQXcKu4gzZSFUqIOVkP
 +oz0+EoNv+Cz44XSLQN4YOBo5SwzIdKP6Fec0n2TxTIuG2jIXhAxVLHallq/qX6MKI+dY6lfDSG
 6VNtJPWwtRg2qBtuX1w==
X-Proofpoint-ORIG-GUID: xEIc1n7Yp_rkRTjW4zYz0Jc8hEQyWF4N
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a5795d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=ODOmb87mxIfaMOJMrkgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150141

On 7/14/26 9:48 AM, Zizhi Wo wrote:
> null_init_zoned_dev() allocates dev->zones when a zoned device is powered
> on, but null_del_dev() never frees it on power-off; dev->zones is only
> freed later in null_free_dev(), when the configfs directory is removed. If
> the device is powered off and then on again, null_init_zoned_dev()
> allocates a new array and overwrites the dev->zones pointer, leaking the
> previous allocation each power cycle.
> 
> Free dev->zones in null_del_dev() via null_free_zoned_dev() to solve it.
> And calling null_free_zoned_dev() in null_free_dev() is no longer necessary
> because every caller already invokes null_del_dev() first: via
> nullb_group_drop_item() before nullb_device_release(), in the
> null_add_dev() error path of null_create_dev(), and in null_destroy_dev().
> Remove the redundant call.
> 
> And take &lock around zone_cond_store() in the two store wrappers to
> serialize dev->zones check-and-deref against its alloc/free, which already
> run under &lock. The reason there was no problem before is that only
> nullb_device_release() or null_exit() frees the dev->zones, which
> guarantees that subsequent users won't access the configfs interface.
> 
> Fixes: ca4b2a011948 ("null_blk: add zone support")
> Assisted-by: Claude-Code:GLM-5.2
> Signed-off-by: Zizhi Wo<wozizhi@huawei.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
