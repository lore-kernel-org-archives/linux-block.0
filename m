Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BB2797A9
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709966; cv=none; b=aQ2lRR87CbHAWbeibw1FdXw/Wpm49AmGY3DPKOkwKBingA6TIg7lVWDKJxYldewLbCug/6dcLI/WhOsk5SY/sSsgDhXdZDX8Ph6vuqFMpiaBkymmo0ZCYtnLrO4xmDf7mNNHft2vcZKGP0Q8yF/SYIyPun1zORF5nIsqD8PF5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709966; c=relaxed/simple;
	bh=ZY2iDMnW2erpAl68OAOHP6zmu7FUOZQCZttBttxaH7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5yMSS7+NkAKDZiYG9cb0F2ki0kSnyMtEk0XPlGuXz1bz8OIZ+ocJTTfeoc/eCyUa4YtkwGGqOB242v68JByPh4Is4SrhoYjkKfMoUXU7eJt0+NfpMu2z1SDStXQjVr3nY+Gn/9YMPfG6+XZnN2YPBVtaoY4jqYlUkOQ16SQt28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QPaSzAhs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QPaSzAhs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8x6PD010420;
	Tue, 15 Apr 2025 09:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kFwCSs
	0a1MfwisTuUu3Hg2G36wrwZjA8JpmzyqE1v6o=; b=QPaSzAhsm14Seh5y0CayoX
	dXttz7iI8gf6FaDcMUlVJJWKmzzJceiM+5NP9yc47P1Nlolq09zgwGt4/khBmqR7
	5xp2KSn6E3X/O8kkCLx5gHQJ1oYjM+3WaUzXc8bWzJvq43fvNGMHDwRLyKGW5jvP
	ZLn+lK63ywoZPtdOmfZEWOFP+ptoMp6HPfXP7HrIxbq+e1jvF2mjuBybnUiNfcYI
	7kQDX6+yyHVncjaQ40HZgFCHV559zXJhffO7NQoqo9tMx5hwTiGLxPK2La/Tgw/4
	Ch8PVc6JMdfekYPqGqv7i56PUVmBlwyk692qR9UtFUitnS5ovsZRJpN08b6zUdRw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tpdfxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:39:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F7Xprf016703;
	Tue, 15 Apr 2025 09:39:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46057225db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:39:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53F9dG2Z30016024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 09:39:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06C1058061;
	Tue, 15 Apr 2025 09:39:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A6058059;
	Tue, 15 Apr 2025 09:39:13 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 09:39:13 +0000 (GMT)
Message-ID: <c54867c4-d2df-4fc9-adce-348918b58349@linux.ibm.com>
Date: Tue, 15 Apr 2025 15:09:12 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] block: move elv_register[unregister]_queue out of
 elevator_lock
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-12-ming.lei@redhat.com>
 <43e99891-94f2-4b31-a073-f7e717afbdd7@linux.ibm.com>
 <Z_xj6OAZ9o142Dvl@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_xj6OAZ9o142Dvl@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hPFfwOk92OUMBXiVOSUCcCYIpv0E6nzU
X-Proofpoint-ORIG-GUID: hPFfwOk92OUMBXiVOSUCcCYIpv0E6nzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=697 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150066



On 4/14/25 6:54 AM, Ming Lei wrote:
> On Sat, Apr 12, 2025 at 12:50:10AM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/10/25 7:00 PM, Ming Lei wrote:
>>> +int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (ctx->old) {
>>> +		elv_unregister_queue(q, ctx->old);
>>> +		kobject_put(&ctx->old->kobj);
>>> +	}
>>> +	if (ctx->new) {
>>> +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
>>> +		if (ret) {
>>> +			unsigned memflags = blk_mq_freeze_queue(q);
>>> +
>>> +			mutex_lock(&q->elevator_lock);
>>> +			elevator_exit(q);
>>> +			mutex_unlock(&q->elevator_lock);
>>> +			blk_mq_unfreeze_queue(q, memflags);
>>> +		}
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>> We could have sysf elevator attributes simultaneously accessed while this function 
>> adds/removes sysfs elevator attributes without any protection. In fact, the show/store
>> methods of elevator attributes runs with e->sysfs_lock held. So it seems moving 
>> the above function out of lock protection might cause crash or other side effects?
> 
> sysfs/kobject provides such protection, and kobject_del() will drain any
> in-flight attribute access.
> 
Okay, so in that case do we now really need e->sysfs_lock protection while accessing 
elevator attributes? 

Thanks,
--Nilay
