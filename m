Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B9469D
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072903; cv=none; b=pTmPY9kddtrDlxSDc3z18gZsM7XvnSKJ0v2lfF8HDyvDnLS99oaJl5f9dDWuXed2m+dqHlmtGfLOfON1dWpjGXGRn2VG93kbeSc4z7YC1hx+T/lD5ZdFo6qwSO5XXMhEckMQcJ59KgfYpO/zS6+6el9KllNbQnco6rN8nSq9kPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072903; c=relaxed/simple;
	bh=9duWBaLAJ5M2Tg3b3TPDA/RjPBqZGihiL2U7t55x8C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k8ZETxc7MYR1mRY0g2bXd1i3DVoPIzIy1zMGXy59CNOeAU0tgbPjur7BoAl86/b1eyx9tGNndDb/DDGcDgJlSMzNWY4kIVBekV+zmLesQQWe3zgRQHXxf7/mFKb+LNYUyxSHSisXULmZQUrj2XAlXqazARHOgq+UIcJNXAEcBOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTg8lV7r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTg8lV7r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTF6XIU024041;
	Tue, 30 Dec 2025 05:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Gg9zU
	b/knP6EPxsoL3tMJcCFcqOob/8WKiucS1DGD0=; b=sTg8lV7rvFfTu6ZqhrJ4E6
	ls3qvEgtKSMl5ojbqD/xXD36b81Ne4ly20EI+poUcFrtQqenrcStr1/zmMCSLyPg
	uoypPAtwEyXMOrBBOJlAjcHx5YD8kH/9NoMdoO074MXrewht4lCKSnWyj3E1aAGW
	6UD2tL3V1hGwYM6zhOtODYt9WcTdWzQRgRQt9tmMilUHi43DxiUPp4FGr7ZcBvgo
	GMfFmXfhBT4rvD2gRjyBTdpnFXSdDLtQSadQWxzN1TLE41Kd154JOfaL614Znrfc
	eFX7htocnQ3ACwKHT/ypGE9o3Lu1bD77Hzgt/TKHDLUni8MF7/p33LFddtvZGJag
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vf15uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:34:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU39kWG008053;
	Tue, 30 Dec 2025 05:34:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bav0jrbn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:34:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BU5YmGS64946630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:34:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 437765803F;
	Tue, 30 Dec 2025 05:34:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C174758054;
	Tue, 30 Dec 2025 05:34:45 +0000 (GMT)
Received: from [9.111.47.194] (unknown [9.111.47.194])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 05:34:45 +0000 (GMT)
Message-ID: <b963f2ad-b73e-4370-8867-f28332fa22ea@linux.ibm.com>
Date: Tue, 30 Dec 2025 11:04:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/13] blk-wbt: fix possible deadlock to nest
 pcpu_alloc_mutex under q_usage_counter
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251225103248.1303397-1-yukuai@fnnas.com>
 <20251225103248.1303397-3-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251225103248.1303397-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a9k9NESF c=1 sm=1 tr=0 ts=69536479 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=NL1F5aIbUArUtQSLZB8A:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: vdpB5Egq-lYfe6l_bqE0TVTuzM4HD0rF
X-Proofpoint-ORIG-GUID: vdpB5Egq-lYfe6l_bqE0TVTuzM4HD0rF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA0NiBTYWx0ZWRfXzfjCDL8eBini
 1WXfh9+cVf4+dkKllMNrpe6+gFMKYOLvtKdrTfV8hHR9z9DuoPehr/NxgGFsp+T8V3mSJbkGL0W
 jaOiXSOhs1fXLMpMNHgB7LtXf8khiaKTy4Nf3kjY1lDmpxv39d1Dcp5OgvRf2Cqculytrynjux0
 73Uuo8WQjmaPKV3A/nOH0qHcp6rgsUUMy+o3hOGhW5bJWFGBQta7/F7sZD7571hg8M+cCbVy0Ma
 sO9s+DsRTaBgCaL7uMrYNOdL6+vh1siqdJ/4zbOS3RSDP/uu53cis0mIm2YPAwYOLqzHhfvgqFq
 r9b4dF2Tl4G0MixhXlvt5BTC+qvgsKcXEPNaKejPVoyEBYD2FVO9H+kRY/BZ4ln6Ug/rgr+lEQH
 b1wWjxZExAzjppM/cr9zmFrUXmK73HH5vhYT2mDmFk3sznIOc1/lB6mvGWNveKNkat4wPXsb1Ok
 Q0fx+U+GtVtpBM98iyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300046



On 12/25/25 4:02 PM, Yu Kuai wrote:
> If wbt is disabled by default and user configures wbt by sysfs, queue
> will be frozen first and then pcpu_alloc_mutex will be held in
> blk_stat_alloc_callback().
> 
> Fix this problem by allocating memory first before queue frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
