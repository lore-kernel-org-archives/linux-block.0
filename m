Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B4219A72;
	Wed,  2 Jul 2025 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437370; cv=none; b=OlXlsDbmaU5mIdKh/fdZja6Mi7JcVxnTzs8qfQVJLQZOqQWxeaksmXPzSqBfyRImeiX1qbHTb3r/uPoI03zTNb0MBNv7vXEkZS8ZuP5+EjWCdKfD6ZwrirKfSu8SOtOGHoKFpwJL6i+lUAJRlpjSFnjVdX6yhIbwpxPEe/yclUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437370; c=relaxed/simple;
	bh=2udpDP6aJq7yw4yrO5mcybhjlkPzUQ90UwKUqm9EFK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ue4ZusNORQFXGoSU8YLndnjTkfDlIXDGmnhjGUAA2vIUJODHBSzA8OYgU1DU5gExx5wejvB4K8pyGC9Z26QUTnZ1ngnVNqsZfUi/qQjr+37l4ckgHTBXMdOpmT8V23K8/C4kKQtStQlzcrBy+ITaT4dNyT2eBANz8hgzbvlsLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aZ6PFaim; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aZ6PFaim"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5622b0mE011357;
	Wed, 2 Jul 2025 06:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OtIkKF
	5ibBxODszHLe1JM79ZjIjDUmvycEYPuH+g/Yk=; b=aZ6PFaim3JyAFxC6TijGX4
	jcPiRPoYU29zHgEckyu5D/B3UjMecoAqrg++9kJeHnWtxZ+nAtuctAAbeGlGyXGE
	39QGD8RoiVBUsjYCgxYIvUHMY6I4uhCPgcRHVVqWz3OdnVwuUxk6oUrmmlAOsKCp
	zIthzOZa/Wc7vMBxaCS/xMCEtSoekToapto3JFOwGasnQJXP1sBHXDqrLZ+8rjl6
	qQFTtCQel15tSicVv/eRnvzWXG/nmsVlTcW0f3fVYZ6ZGwICwmDBWIT2lb8s82H3
	wxEyVFLT2aOaSdqNJ6P5xj4FGuuMZihb8uRxjY0095J4X89jFuOC4X+Vtc921+qA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrkqnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 06:22:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56229FnA006904;
	Wed, 2 Jul 2025 06:22:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxme135-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 06:22:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5626MEld16122418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 06:22:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53B8758045;
	Wed,  2 Jul 2025 06:22:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E475F5805F;
	Wed,  2 Jul 2025 06:22:09 +0000 (GMT)
Received: from [9.109.198.197] (unknown [9.109.198.197])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 06:22:09 +0000 (GMT)
Message-ID: <7b09167f-bf8d-4d94-9317-3cfbb4f83cd8@linux.ibm.com>
Date: Wed, 2 Jul 2025 11:52:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org, hare@suse.de,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
 <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
 <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
 <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
 <aGSaVhiH2DeTvtdr@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aGSaVhiH2DeTvtdr@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6864d018 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=PL8FM_zyLEa3LRvGiX0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 25iKB3x1FaUALPZA2WTuXGyERogZkYcq
X-Proofpoint-ORIG-GUID: 25iKB3x1FaUALPZA2WTuXGyERogZkYcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA0OCBTYWx0ZWRfX50OdNXDO+dAq CZ2jrsSDupmt0aF42DN2Mk8JtfgAuACe6/6v5SVJAoSVy2ytkz3HlDFkzZ0P6pkOupjFTzpTmyq ve/T0RCB4AU9mf//7X9Zb1VxCBMbYmgxRvyvwiYgk2gWnx0O8V7UzAs4j5cNgc5rhUEYE86W0aH
 Ux8BblrleShXmz6XuN3CZ94kYCywE3hnfxof4li5cnOb6HiEuMtsl9e1CmXqG8ZnKZ5YNIH3zhV 0xGKD8hv1GxmNAFRWaGzJCG+xHJgeCENneEtG2Y3Z7kl81jWcPN/qi9Njs4vc+47SDfkOUms/Z7 C0A622TMdk99o6yAw+zbSV6CHRt2WsbPMDKt4weqJWW/VhAu+5AqbFEJaNEWnqIT0kVSWPKNZfL
 gjWHaQRQilyCKe06ILizjco+EwKf2F3ynUV8m1SrMC1JNeEoN5CpUY91FKZY9idARaINqg/Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020048



On 7/2/25 8:02 AM, Ming Lei wrote:
> On Wed, Jul 02, 2025 at 09:12:09AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/07/01 21:28, Nilay Shroff 写道:
>>>
>>>
>>> On 6/28/25 6:18 AM, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/06/27 19:04, Ming Lei 写道:
>>>>> I guess the patch in the following link may be simper, both two take
>>>>> similar approach:
>>>>>
>>>>> https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/
>>>>
>>>> I this the above approach has concurrent problems if nbd_start_device
>>>> concurrent with nbd_start_device:
>>>>
>>>> t1:
>>>> nbd_start_device
>>>> lock
>>>> num_connections = 1
>>>> unlock
>>>>      t2:
>>>>      nbd_add_socket
>>>>      lock
>>>>      config->num_connections++
>>>>      unlock
>>>>          t3:
>>>>          nbd_start_device
>>>>          lock
>>>>          num_connections = 2
>>>>          unlock
>>>>          blk_mq_update_nr_hw_queues
>>>>
>>>> blk_mq_update_nr_hw_queues
>>>> //nr_hw_queues updated to 1 before failure
>>>> return -EINVAL
>>>>
>>>
>>> In the above case, yes I see that t1 would return -EINVAL (as
>>> config->num_connections doesn't match with num_connections)
>>> but then t3 would succeed to update nr_hw_queue (as both
>>> config->num_connections and num_connections set to 2 this
>>> time). Isn't it? If yes, then the above patch (from Ming)
>>> seems good.
>>
>> Emm, I'm confused, If you agree with the concurrent process, then
>> t3 update nr_hw_queues to 2 first and return sucess, later t1 update
>> nr_hw_queues back to 1 and return failure.
> 
> It should be easy to avoid failure by simple retrying.
> 
Yeah I think retry should be a safe bet here. 

On another note, synchronizing nbd_start_device and nbd_add_socket
using nbd->task_setup looks more complex and rather we may use 
nbd->pid to synchronize both. We need to move setting of nbd->pid
before we invoke blk_mq_update_nr_hw_queues in nbd_start_device.
Then in nbd_add_socket we can evaluate nbd->pid and if it's 
non-NULL then we could assume that either nr_hw_queues update is in 
progress or device has been setup and so return -EBUSY. I think
anyways updating number of connections once device is configured
would not be possible, so once nbd_start_device is initiated, we
shall prevent user adding more connections. If we follow this
approach then IMO we don't need to add retry discussed above.

Thanks,
--Nilay
