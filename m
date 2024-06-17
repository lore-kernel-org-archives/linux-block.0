Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D13FE4A;
	Mon, 17 Jun 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615467; cv=none; b=dP5wytbVztvPji2284l3aAasTXXounZ4NH95MekbbS8rI8kHJlEa8sM0HOZjTqYFpXlJS9esC9G6l/hPpQEHquPP++lbh5Y9+GnME3aQWhwqqr7274qQpaGEqICoumTEA2SCTzngfuqcvtZeyRRP3XnIMidpGBB/NlzCtPLayiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615467; c=relaxed/simple;
	bh=0vAa6PKyw6NOERQlOIJcTuSJpk9vJSNt+toYxjrtXYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdcEL/IhlT5egKPUXAnSrylAdmkRfXWzi7FN9gXniARqIKJO7+hb+aUp6vlmYNseO5j0wjRmmYjQHlRWwsYXqz4UcvWl7jjbWA4utMLMC8Xwd8Q8+4O+jtkjBWuOEifp+2ELd9mG22voXlajTxQoGBbpDggnJE9vkb1LgpEG2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hOmw52cY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hOmw52cY"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H8LwXE022485;
	Mon, 17 Jun 2024 09:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=N
	2Mw6uQnbAvcilPkScR95H4zvLvgapP78kdoxjkL5Uo=; b=hOmw52cYetjjZEq8I
	PAI2uKeCZ+vp3BFEvkUWSodcw3wLVLRJTdo4IPz91wMZjvfqJyY3q2/bJZA//wDI
	LS4xG5ywj4m9wCkaCoT8xpY6BkkQTKZbuvTcYxKPSNb1T0ZuPMa/yWleVAOCjcZY
	PycFJ9Qc/sxL+sCpbEf3c1goH3bsupOq3eiM0KrUHo2ElhtaGBsgD6tQH5OgY43n
	R6I6UjOEfxB77Ncx7BzuuKESFYH1Fbpio/5esLYVMci8SSFkIvsM5VuFxoFVc1Hx
	H80yw9FRTWWFZK2Pet1xhRAXq3hCF7pMtPD1AiWqDhXQOVvNK8kSzjMvbW3L+0CG
	rZyiQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytgbngd14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:10:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45H7u2S6011027;
	Mon, 17 Jun 2024 09:10:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsmrck3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:10:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45H9ApgY27460192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 09:10:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 816A85805B;
	Mon, 17 Jun 2024 09:10:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829E558058;
	Mon, 17 Jun 2024 09:10:47 +0000 (GMT)
Received: from [9.43.13.239] (unknown [9.43.13.239])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 09:10:47 +0000 (GMT)
Message-ID: <1ce94229-631d-420a-976e-6259b136a92e@linux.ibm.com>
Date: Mon, 17 Jun 2024 14:40:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel OOPS while creating a NVMe Namespace
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sachinp@linux.vnet.com,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        shinichiro.kawasaki@wdc.com
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
 <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
 <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>
 <ZmdVIfnqtweVt9ZN@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZmdVIfnqtweVt9ZN@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5L14OMVf1nwDViWXPy-Ha5421Dp2uIcq
X-Proofpoint-GUID: 5L14OMVf1nwDViWXPy-Ha5421Dp2uIcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_07,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170068



On 6/11/24 01:03, Keith Busch wrote:
> On Mon, Jun 10, 2024 at 10:17:42PM +0300, Sagi Grimberg wrote:
>> On 10/06/2024 22:15, Keith Busch wrote:
>>> On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
>>>>
>>>> On 10/06/2024 21:53, Keith Busch wrote:
>>>>> On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
>>>>>> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
>>>>> My mistake. The namespace remove list appears to be getting corrupted
>>>>> because I'm using the wrong APIs to replace a "list_move_tail". This is
>>>>> fixing the issue on my end:
>>>>>
>>>>> ---
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index 7c9f91314d366..c667290de5133 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>>>>    	mutex_lock(&ctrl->namespaces_lock);
>>>>>    	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>>>>> -		if (ns->head->ns_id > nsid)
>>>>> -			list_splice_init_rcu(&ns->list, &rm_list,
>>>>> -					     synchronize_rcu);
>>>>> +		if (ns->head->ns_id > nsid) {
>>>>> +			list_del_rcu(&ns->list);
>>>>> +			list_add_tail_rcu(&ns->list, &rm_list);
>>>>> +		}
>>>>>    	}
>>>>>    	mutex_unlock(&ctrl->namespaces_lock);
>>>>>    	synchronize_srcu(&ctrl->srcu);
>>>>> --
>>>> Can we add a reproducer for this in blktests? I'm assuming that we can
>>>> easily trigger this
>>>> with adding/removing nvmet namespaces?
>>> I'm testing this with Namespace Manamgent commands, which nvmet doesn't
>>> support. You can recreate the issue by detaching the last namespace.
>>>
>>
>> I think the same will happen in a test that creates two namespaces and then
>> echo 0 > ns/enable.
> 
> Looks like nvme/016 tess this. It's reporting as "passed" on my end, but
> I don't think it's actually testing the driver as intended. Still
> messing with it.
> 
I believe nvme/016 creates and deletes the namespace however there's no backstore 
associated with the loop device and hence nvme/016 is unable to recreate this issue.

To recreate this issue, we need to associate a backstore (either a block-dev or 
a regular-file) to the loop device and then use it for creating and then deleting 
the namespace.

I wrote a blktest for this specific regression and I could able to trigger this crash. 
I would submit this blktest in a separate email. 

Thanks,
--Nilay


