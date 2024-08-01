Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56493D97F;
	Thu,  1 Aug 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504359; cv=none; b=mbUFHmPWueEn+80ZoqykXWAUdyteMAbso3UfNNawliukIivWQcz51Ykjc+pQTCIAgIdzvgUKbzZgFVQI0sNvjPbR/DWHTZ7qzQj9bKr59m1clQIO+JkAiiNMItamqkVtGhdnAGsnuXFTWg63LfCmPG7twL4q9NtWlYU9R03LJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504359; c=relaxed/simple;
	bh=P5c2DBuXZQLakzngPvXJxZTsAUm4GoxmPr4cJ5PWTMA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=sFCfyOX8mQ8lMvypVCWNsFm+hb0ZBeqnF+hpMOPsN8bxy/3qFSY3pvmaGnIlRL1SE5oO7Yehg5/3UpwhPKoDoZQ3PWT/VSFqtOdaC50UFmZEQT3OJsvmtdzpttexXmctjPNCtgV2kNJ5kdTK3E9/5q/7rXUDJ/rVpUDXGyMfwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=By6oS7pB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="By6oS7pB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47191XY9010027;
	Thu, 1 Aug 2024 09:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N0VbP550rL2fJ64uytjW+POfX0XXkOB0jyiRKZOwwKA=; b=By6oS7pB1aUCrbro
	YLTIatbkbuUXNLE7K5FpOHzWJUgW34zxVofOdZeI2V9k94f9q5AFNbslFseEI6ds
	uYvMy5fonAf6Htbt0oXTeyV90fTY9TNemp3l+5TmHwWXQfyo8hBRfSt8mT1YpM5d
	JK2Eo6ngbwxV++CSMJXlN22sQp1Mkp/JqLNIL1E939im/UatEzht6fLNahPtQJVi
	L3gOapZZOfAveduoh7/dMUVGSwU13BUmk+FkvP70j3sFItk17DBXhdpjFmy6bqf9
	phNcrOUKn9r/Ds2PThk2KABeveaTfsD4aqg8e26X/KBtvmqzoO3u4CUXa7/tMfiX
	GoCcdA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qnbabce0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:25:41 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4719Pd72028085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 09:25:40 GMT
Received: from [10.217.217.229] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 02:25:34 -0700
Message-ID: <d2009fca-57db-49e6-a874-e8291c3e27f5@quicinc.com>
Date: Thu, 1 Aug 2024 14:55:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
From: MANISH PANDEY <quic_mapa@quicinc.com>
To: <qyousef@layalina.io>
CC: <axboe@kernel.dk>, <mingo@kernel.org>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <linux-block@vger.kernel.org>, <sudeep.holla@arm.com>,
        Jaegeuk Kim
	<jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig
	<hch@infradead.org>, <kailash@google.com>,
        <tkjos@google.com>, <dhavale@google.com>, <bvanassche@google.com>,
        <quic_nitirawa@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_narepall@quicinc.com>,
        <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
Content-Language: en-US
In-Reply-To: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f9kALu7khQB3Z2Zt08f4aCJuybUt-OBN
X-Proofpoint-GUID: f9kALu7khQB3Z2Zt08f4aCJuybUt-OBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010058

++ adding linux-kernel group

On 7/31/2024 7:16 PM, MANISH PANDEY wrote:
> Hi Qais Yousef,
> Recently we observed below patch has been merged
> https://lore.kernel.org/all/20240223155749.2958009-3-qyousef@layalina.io
> 
> This patch is causing performance degradation ~20% in Random IO along 
> with significant drop in Sequential IO performance. So we would like to 
> revert this patch as it impacts MCQ UFS devices heavily. Though Non MCQ 
> devices are also getting impacted due to this.
> 
> We have several concerns with the patch
> 1. This patch takes away the luxury of affining best possible cpus from 
>    device drivers and limits driver to fall in same group of CPUs.
> 
> 2. Why can't device driver use irq affinity to use desired CPUs to 
> complete the IO request, instead of forcing it from block layer.
> 
> 3. Already CPUs are grouped based on LLC, then if a new categorization 
> is required ?
> 
>> big performance impact if the IO request
>> was done from a CPU with higher capacity but the interrupt is serviced
>> on a lower capacity CPU.
> 
> This patch doesn't considers the issue of contention in submission path 
> and completion path. Also what if we want to complete the request of 
> smaller capacity CPU to Higher capacity CPU?
> Shouldn't a device driver take care of this and allow the vendors to use 
> the best possible combination they want to use?
> Does it considers MCQ devices and different SQ<->CQ mappings?
> 
>> Without the patch I see the BLOCK softirq always running on little cores
>> (where the hardirq is serviced). With it I can see it running on all
>> cores.
> 
> why we can't use echo 2 > rq_affinity to force complete on the same
> group of CPUs from where request was initiated?
> Also why to force vendors to always use SOFTIRQ for completion?
> We should be flexible to either complete the IO request via IPI, HARDIRQ 
> or SOFTIRQ.
> 
> 
> An SoC can have different CPU configuration possible and this patch 
> forces a restriction on the completion path. This problem is more worse 
> in MCQ devices as we can have different SQ<->CQ mapping.
> 
> So we would like to revert the patch. Please let us know if any concerns?
> 
> Regards
> Manish Pandey
