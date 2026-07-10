Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8983B14D0;
	Fri, 10 Jul 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687049; cv=none; b=VLjEsQP/G88Z4d/Lkx4Iindv92Hzaz+82HEZAAD4jbMYKgbuTNZ1cqIPwA6bMsXaGYCd+UqH22Fpj8INCvXTVW/qGi0FT7cuO0GuEIdzlmPeiC8rOIAtTb3MHbO4CZCSXyoRmACUkWFvgXppcZDwWOPOp4P3eJPmgxRDNCT2yLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687049; c=relaxed/simple;
	bh=tc3cJHjvWMfnIxKeFSgPriccd32KzBaRy641OaE6+yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8FBM5y0EMN/IOgBjtImGmK88B+75PL6RDbkIJ7qUzk3sg94L8hX4Sdy97pgHOqiFKswwX6oPLG4WDBvUw6C6SOKkuVvzeSdR8z9YWU8FYyYuKftQxpyf9MJnjMjrDU4qUpHEVrYtCeAAWcjoeCp5AHqyuSPXisUJOwpMpSQsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rJJoyyJs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rJJoyyJs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAnCnB248315;
	Fri, 10 Jul 2026 12:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ofrqDa
	Fk5lbvmoaF5VmhxzfsgF+izi4zjTQiRxSxgfc=; b=rJJoyyJs7jGOI5ywcQDZHR
	baXQjr7NOFR8by+zSagpJHDcQMKX/4Vz+2LQgq3mQ5gU3R6JuSa0fl9iUI1WXTHD
	A4ZEVN2Mpi5zWyKeUBaFBnbvGwx5M2QQM1mx/0qVqeH93/NhS8dXZakPosaLBfcC
	BK9omnnDcY3tOndOQnJ4Wda3rE07HtJDw21GFOA6oTpKCTxsfRGsVXI06emIXuYU
	8sozfhcPa5LezlKxnMFj5YEQXpyxx8pH4Qoe476nTDk8J4u3nPGOIrKeeYQyrCNY
	+f7NtQkgr8uLsPxnxQyiVDIc8ol/qVcmDrEegO/yOQUD152F17ibYONIsQjvywIA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke6x51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:37:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACYfMM009299;
	Fri, 10 Jul 2026 12:37:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkj0r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:37:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACb8LY54854126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:37:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1347A5805D;
	Fri, 10 Jul 2026 12:37:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5868458043;
	Fri, 10 Jul 2026 12:37:03 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:37:02 +0000 (GMT)
Message-ID: <b839e6f7-cd47-4403-946d-b964ac25fb2f@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:07:01 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/9] null_blk: free global tag_set on init error path
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-5-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-5-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50e775 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ibIutRk6EwtKxA6za_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX4BtKsnisFbjh
 aGCV0DkUtQfr7imuTLwBk3otFj4heLFhSNO1dj1lDQYexRaL7kxb5gKv5oBhX3vzzZvv2DqduIE
 0vMEjKy/syZQqw28Yx7TcnXZQbZrmVpLCkx2qhxMilOhfwq7Jz6VrQWa81NXsRcUdyvu9ONNnd9
 s05bXlLA+k/ByA/9pISDQRTNR5OUjpFb1xjvy2yn1SRwzjr0KYfrPzLwGN7580jLuRoYND+a4or
 YX67fiG83t7shg1Y38f26OUDg2qQ3ZUz4NMIgyU18XrZZQqPjKerRsLBreBELm3BJtv8B8MXajM
 isnJj6eJfDFv7hG9J/Cr4+uNNpC8HbGW8+9JL6WDBdG3IheOa4DHe3tkFX4wcl4ygiILd/IwtV1
 mfecsn5p07mPjwa0Z1KsYz2gFXv3eIDeWqCHKHci2A+gSunmheZC/J9Et/gXJDY7mvV0iqXfGZK
 5d5nZXKoKsx0nt384Dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfXwQh4x1xVtgk8
 QDBiMDKjdPSt67hhbVztAJNZoplK0PjfMRgbhkuXYWacYMEvQTxTZ9mG9lvPfsQxSrG3Rz120mX
 cD2Dd8unbjRE7Pss6WFozyCCLA/94aA=
X-Proofpoint-GUID: 3MdgLOu73xwLKuKpBp4zXsvGPamr6-qr
X-Proofpoint-ORIG-GUID: 3MdgLOu73xwLKuKpBp4zXsvGPamr6-qr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> If shared_tags is enabled, null_setup_tagset() allocates the global tag_set
> via null_init_global_tag_set(). If device creation later fails, err_dev
> destroys the default devices and calls unregister_blkdev(), but never frees
> the global tag_set. Since module init failed, null_exit() is never invoked,
> so the global tag_set's tags and maps are permanently leaked.
> 
> Free the global tag_set in err_dev, matching null_exit() which does
> if (tag_set.ops) blk_mq_free_tag_set(&tag_set).

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
