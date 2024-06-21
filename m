Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533D10E3
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718933998; cv=none; b=GOBi58leID+1dFJzvjE+yH9LFcU58aGOjNeq8DYFqHCONyddmSMltJhNKGVm+T9BMGxeA26qCzkDUYzqN+fsBuSJQMRRYv9qxloa3ZmQyRuB2iDWrkRMPP/zC4HtKamgBwzhJbCG/Orbur73yYDA1MjXO4wtk7YblK2WcEGCrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718933998; c=relaxed/simple;
	bh=IOfMoJALxxIvfxYGw+lS/rbmnhQlsAcBC1Nt87FjgOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cMj5v2cIlh2Fkv9PNd6r0vob4QgdZYi8CQhmyPboaSWHYF9wbr+ufEO9L7Z+iR1kZTANcM0XCziPTBzGiTGyOR6P8mKWGxcqFGubK0+6cBoQlHrJDDUBinXPjO2TkKE6aX2R5ZPzo8848hGczvGRJUA5IjYIfZGt00ZV6Sc6/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MRtKfBC9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MRtKfBC9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHCruO009466;
	Fri, 21 Jun 2024 01:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VV7cHLl32IzayV5h0uSeZQpxWpkiWHM/wNDY1x1qvPE=; b=MRtKfBC9H6NrIDoc
	tw1MvcfsBrPOPFrRIW/3GaCI/1iua2YhYZ88SoRwGC/sIm3IMtz3SSaEa8K3jaFI
	ThJXOTSl2M48W73UtGSqJmHlJIpxxTnnVz1XQKRAWuDqrstlPMx4vWRmesu3sdIg
	pHQKeVhPcPdjm8iYCo9kIBzJHV1yJ5aQ7PmXmF8N5S/AXDPueK6SqhyLN1wjxoz4
	OYmO1UXKImj0gc6Kj7OxjyI/HWOALpEnZmk9usOcROhrCWVgBbjCjoxfN8ZDuQps
	FJ9lZvgCE/y2dueaaWjaC74DRStXvwMzb3D+HAKOsrrOFn5qvY0XX5OKquRt+ciB
	lntwyQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm2h27e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 01:39:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L1dpYe030281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 01:39:51 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 18:39:49 -0700
Message-ID: <c6fa7134-c99e-464d-9d5d-a9480aaf59fc@quicinc.com>
Date: Fri, 21 Jun 2024 09:39:47 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.6 kernel block: blk_mq_freeze_queue_wait in suspend path but
 userspace task held the queue->q_usage_counter in 'TASK_FROZEN' state
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
        <",linux-scsi"@vger.kernel.org>
References: <6fb677a4-b655-4395-9dd1-450217fec69d@quicinc.com>
 <4c98300f-bc0d-4267-acd4-6365de65713e@acm.org>
From: Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <4c98300f-bc0d-4267-acd4-6365de65713e@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xZWVlMXgv5JzcF8b78iMNievi7PTxVVS
X-Proofpoint-ORIG-GUID: xZWVlMXgv5JzcF8b78iMNievi7PTxVVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210011



On 2024/6/21 0:52, Bart Van Assche wrote:
> On 6/19/24 11:53 PM, Kassey Li wrote:
>> hello, linux block team:
> 
> Please repost this message on the linux-scsi mailing list. I think this
> is a UFSHCD driver issue rather than a block layer issue.
> 
>> userspace task A  ['TASK_FROZEN']
>>
>>      [<ffffffdc0c527f10>] __switch_to+0x1e8
>>      [<ffffffdc0c5287ec>] __schedule+0x6cc
>>      [<ffffffdc0c528c28>] schedule+0x78
>>      [<ffffffdc0c532bbc>] schedule_timeout+0x50
>>      [<ffffffdc0c529e48>] do_wait_for_common+0x10c
>>      [<ffffffdc0c529238>] wait_for_completion+0x48
>>      [<ffffffdc0b4def4c>] __flush_work+0xcc
>>      [<ffffffdc0b4dee70>] flush_work+0x14
>>      [<ffffffdc0c091aec>] ufshcd_hold+0xc0
> 
> Is ufshcd_hold() executing flush_work(&hba->clk_gating.ungate_work)?
> If so, why does the ungate work not complete?

userspace task A (pid 9453) sleep on 1919.065798809
to __flush_work, where it  will insert wq_barrier_func


	Line 4289153:      kworker/u19:2-20272 [001] ..... 1919.091512: 
workqueue_execute_start work_struct 0xffffff881cbba090 function 
0xffffffdc0c0a647c ('ufshcd_ungate_work', 0)
	Line 4289842:      kworker/u19:2-20272 [001] ..... 1919.096289: 
workqueue_execute_end work_struct 0xffffff881cbba090 function 
0xffffffdc0c0a647c ('ufshcd_ungate_work', 0)
	Line 4289843:      kworker/u19:2-20272   [001] .....  1919.096291: 
workqueue_execute_start  work_struct 0xffffffc0ceddb4f0 function 
0xffffffdc0b4e322c ('wq_barrier_func', 0)
	Line 4289844:      kworker/u19:2-20272   [001] .....  1919.096293: 
workqueue_execute_end  work_struct 0xffffffc0ceddb4f0 function 
0xffffffdc0b4e322c ('wq_barrier_func', 0)

	the ftrace log showed ufshcd_ungate_work , wq_barrier_func were all done.

	a sched_waking should happened for pid=9453 between 1919.096291 to 
1919.096293
		since 
wq_barrier_func->complete->swake_up_locked->try_to_wake_up->ttwu_state_match
	however, ttwu_state_match only wake up the task in TASK_NORMAL state.
	
here pid=9453 in TASK_FROZEN is not the case.

do you have some suggest on break this ?

	



> 
> Thanks,
> 
> Bart.
