Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136A32BF4C;
	Tue,  9 Sep 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420534; cv=none; b=WTOD0T2dSYg7lyjUPvkcabvm7Y8XhmyMsGltR61W+OPbJ0t3FFWluwg76FNigRaeuk1KpTSal973XFKHw2fsTu1JU7lPuOk0rw/5TmJKYs/Yb8tMN/5LBsl5DNgzoKXnUY1IDBs1huYbB/qtpSEidsYZrT+nZRhWtyR35v1AVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420534; c=relaxed/simple;
	bh=37P3XprDm+59gcb6XjJxMhBzm481r3NPs3Vo9qlxQbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAjLANDDYJk/GLKKZ0BXqjNtN6CAWZEphuA6Yk7NrO+W4YO8n5u3fcR8pPRFcR4Z2wpn5923uRh7GDC/m+qzpXo2ca7kvFAy78ke/DFdOqDjZhnr3JNqioWWT5c6BAw4R44R5c+LGSqxJOjzrwpxdLbZFTguK343IYa7gZw206g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k+btDa2s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k+btDa2s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896qZ6F022621;
	Tue, 9 Sep 2025 12:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HgXHuv
	DQWM+e6g8HNFRsUTtYri2UfP2/XrW1ol1u7GE=; b=k+btDa2sq7CBHU/zbN/lFH
	ghWfPvHjObHTjdwM0MbcrLvY9fXysRq63ShPfGzZUmg5uPj1TmS4uJjx77Y1Aicr
	azRWjJMg3W9mv4Rc4oPZg3L7at/N9NCiVH7nWxiIRrEVYdeH2JiknmZWCS/h2RY5
	jmgdMAa/9KYp+VTQfYE4GKLgLVCjLpsag2Ci8t2npNNcDlvAwN6V4Dx3Jd6cpQCk
	icJ8pLnTkFLF8+DfyrZ5yO8TF8dM+PT5uB5bjp6+NliPvShzCOMKbhwbqDpHlFHm
	hwOefHywbfBS8ou5242Yt348ozhsx0CjMHxUjXlwewjmmENhzBIKNQWxD67xIAbw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwqmvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:21:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589BRPBR001198;
	Tue, 9 Sep 2025 12:21:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203arp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:21:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589CLvTv3146310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 12:21:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 659C358059;
	Tue,  9 Sep 2025 12:21:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A88958058;
	Tue,  9 Sep 2025 12:21:53 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 12:21:53 +0000 (GMT)
Message-ID: <a7c4342c-c72e-43ad-961f-1d4f5a57b408@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:51:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 08/10] blk-mq: fix potential deadlock while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-9-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sLLKeMBLjgSL_T0Rfdt3xaNP907hJex5
X-Proofpoint-ORIG-GUID: sLLKeMBLjgSL_T0Rfdt3xaNP907hJex5
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c01be6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=5m0jnhctum0_gvrSJaQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX/swE9qgZ1A1u
 a/5X7jLp40465RnH3HV2yXx7ajiCRFN8MIjIClXY1XOjacW08Tvl9Kva6t+jB2SpO2e9XaXSYB0
 UNZr8mTN6otBWsp15dCbzkAPX0NAc28WVB97bm2KGjXCE4mCaR8K5V1csHmC1BovAQZbbtn0Qwo
 vM6wm2M039RKJ0XJ/svXD04CDyma4t6Tsx4/w64pUlScmSqHtClo+Yd50ZhP22llxUkUh7lVxxV
 9uSkVx72h6wQE+MzzMI+UajDrfA7ns1xwnjpS2iyEcSTeudVSxcSMQLhOHZ7LrCnrbgvNYxxblP
 R7tv3BqPZIqGAbN6oUTr0sBWGkkURU4Tn5pVnqCFSis3j8w4ccrMSQ+Fz0P1e/FwL+0lFvJvwHT
 OzWu3KdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Allocate and free sched_tags while queue is freezed can deadlock[1],
> this is a long term problem, hence allocate memory before freezing
> queue and free memory after queue is unfreezed.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
