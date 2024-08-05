Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B3481B9
	for <linux-block@vger.kernel.org>; Mon,  5 Aug 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879387; cv=none; b=pv9jQ7lv3glcH/3D2apmPDmVlYqW4tlbmd7LLEXZNNULKMlG4fGQDDm6xUYWESNoK/7FWS3TuADADKHw3GluEFvI6KNxNxfaUM9gUUvxNJXRIbi++Np20SxksjkcRDSux3CwbwSHc+CGwRFGt2QNbCz2n4FujEAEB5jvXLG+80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879387; c=relaxed/simple;
	bh=77AdRPMU+oKFMlvwaz8hzpAdhgq8mphjRvypHmaTRhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F+eEtv2thra52juzo1JC/j1sh9TJurZVJD0oSfZKW+KgOh764kbHl6rxsWE1NiVtuYX6agEKU25aphzb8AwZkM2dMrXHKB1vXAuX2jbSmOsLoJ34PMflAxMD4/tSnyiguUtBkzWUvQTeUIYMMB256rGudnX+Tk09sqGA0MTOfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NdPYh7Vt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NdPYh7Vt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BAGnb028213;
	Mon, 5 Aug 2024 17:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PCF+n9CasqFxMvBXm+VRjE5ivbhyQ96EE79UgBv3Res=; b=NdPYh7VtQ++iSC2r
	et6ZBbJWMgfjcsH3aUSuZmbu3uZcRTEgP5S/wmLsMGWFhxeIWyqYy61BI62eb2pW
	SuqQIom3AVWwGrPwV5X/1PDZUjJuSqwNhtxmG0rnbpE44c9bolz7msafc6ioCi4/
	8pJIS060s5eF+WFv5xS6N7v7ErFfr+Wuqd5siqYLe46Iz4IEP/486x87q5vWylMY
	JkLPdcV9gBEkm05opehuSsA7RfYWAdQ5mWxWYs79VDCy6Pw+iP1Tv5SE7fYgRGUG
	tpZC1Ac3B0kUL5YtBK+cqN7W9DRc0E5hxe4HCeTA9YqtCp65//Wjug/ubdALJnJa
	8acSOg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sdae4pna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 17:36:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475HaAp9014012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 17:36:10 GMT
Received: from [10.216.59.226] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 10:36:03 -0700
Message-ID: <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
Date: Mon, 5 Aug 2024 23:05:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Qais Yousef <qyousef@layalina.io>,
        Christian Loehle <christian.loehle@arm.com>
CC: <axboe@kernel.dk>, <mingo@kernel.org>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <linux-block@vger.kernel.org>, <sudeep.holla@arm.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, <kailash@google.com>,
        <tkjos@google.com>, <dhavale@google.com>, <bvanassche@google.com>,
        <quic_nitirawa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_narepall@quicinc.com>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
From: MANISH PANDEY <quic_mapa@quicinc.com>
In-Reply-To: <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b8iNTFrtaFvNnHg3iljQDmlpFS7sJiLb
X-Proofpoint-GUID: b8iNTFrtaFvNnHg3iljQDmlpFS7sJiLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_06,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050127



On 8/5/2024 10:47 PM, Bart Van Assche wrote:
> On 8/4/24 7:07 PM, Qais Yousef wrote:
>> irqbalancers usually move the interrupts, and I'm not sure we can
>> make an assumption about the reason an interrupt is triggering on
>> different capacity CPU.
> User space software can't modify the affinity of managed interrupts.
>  From include/linux/irq.h:
> 
>   * IRQD_AFFINITY_MANAGED - Affinity is auto-managed by the kernel
> 
> That flag is tested by the procfs code that implements the smp_affinity
> procfs attribute:
> 
> static ssize_t write_irq_affinity(int type, struct file *file,
>          const char __user *buffer, size_t count, loff_t *pos)
> {
>      [ ... ]
>      if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
>          return -EIO;
>      [ ... ]
> }
> 
> I'm not sure whether or not the interrupts on Manish test setup are
> managed. Manish, can you please provide the output of the following
> commands?
> 
> adb shell 'grep -i ufshcd /proc/interrupts'
> adb shell 'grep -i ufshcd /proc/interrupts | while read a b; do ls -ld 
> /proc/irq/${a%:}/smp_affinity; done'
> adb shell 'grep -i ufshcd /proc/interrupts | while read a b; do grep -aH 
> . /proc/irq/${a%:}/smp_affinity; done'
> 
In our SoC's we manage Power and Perf balancing by dynamically changing 
the IRQs based on the load. Say if we have more load, we assign UFS IRQs 
on Large cluster CPUs and if we have less load, we affine the IRQs on 
Small cluster CPUs.

Also for some SoC's since IRQs are mainly delivered to Small cluster 
CPUs by default, so we manage to complete the request via using 
QUEUE_FLAG_SAME_FORCE.

This issue is more affecting UFS MCQ devices, which usages ESI/MSI IRQs 
and have distributed ESI IRQs for CQs.
Mostly we use Large cluster CPUs for binding IRQ and CQ and hence 
completing more completions on Large cluster which won't be from same 
capacity CPU as request may be from S/M clusters.

> Thanks,
> 
> Bart.
