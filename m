Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B24677B;
	Fri, 10 Jul 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693530; cv=none; b=gCR7IhRQUP070znlbMtFlPLkUyKYtO98gkxMsd7gcsuAh3jWWstdgXgbAEm5U7TxJoBTGTRHPcynB2XrUnM+BDP5PvwXVtYGatqqVV/fHkcS/fN7Wn9oq3cKMeVe59h5/AHyFweLM9LojrT/e2J7H3KusBqZVsdZFUmm/5Lpkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693530; c=relaxed/simple;
	bh=eVdhXE6q1Q6/+YIOcApKtx0V9wXwy3IuudG/MmqSx2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkOfE2mu60ojqXTJGDLyma3JeV49frMXTaiPhax0AJ0SeXodsVbcqGscqD36nT3XxFDinqDMUb5+ZXgMNsZyNaWatPPvc/4PTExSBx67eOg4Qrxl4Vr8iyEfr+UUL8aEfdXJ+myVCv7jbhKjikupgW8Wg885qGpCvbkioBfZG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FI0Yleyy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FI0Yleyy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ADIUfw1351849;
	Fri, 10 Jul 2026 14:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HiSQ3F
	ag9awBhlT8h5qq630QKV1cvvjdGhDyjaf5ZMc=; b=FI0YleyyOEAbNQwuo/q3Qh
	OKs347SIt4+Lir3pWAB+/RM9xtRigAggfXBh/0vFzbq0Pu6OAb5QBW5LuFi4Fqag
	ouoNsY8ZLAmoNS0zpAodCoUvR4ZNzBUEltAaFwMeEFxLuqosJO81JhwlV85+WqFu
	gNewEbMd+BoBhQgsB/9V2WAdLBChL7PdKGV6BLbYJBSgmQy8K3eBNoIxneSXJRkT
	/RjElhVufCfGu0Fs4vsZafp9PXZ2qmoL1pFA51X5JZYPdvmK2Aj5OAOSZqV3EAuS
	lQMRqkRFTm4VlIFdaqmpClfqGBjWP6/OtznlgDFVr3Fv6Y16Av8sgT/Y83e7w3ig
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknxfsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 14:25:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AEJln4014408;
	Fri, 10 Jul 2026 14:25:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgj664-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 14:25:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AEP14w9241268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 14:25:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B1035805D;
	Fri, 10 Jul 2026 14:25:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE46B58043;
	Fri, 10 Jul 2026 14:24:55 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 14:24:55 +0000 (GMT)
Message-ID: <c110c8bf-52eb-4f01-b01d-b042178a6002@linux.ibm.com>
Date: Fri, 10 Jul 2026 19:54:53 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/9] null_blk: free zones array on device power-off
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-6-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-6-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a5100be cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=uWrvuyrVUc6Y2h0ZqlEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K4wH_1QOKl_93amwq4u01294mXpRAi4Z
X-Proofpoint-ORIG-GUID: K4wH_1QOKl_93amwq4u01294mXpRAi4Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX7pmA3o2d8K0A
 npUz2c+49e8wDzVgq0ioDNcSN9iKL8TkN2QXZLpsW+k6YghaGOgDtfrAzn0mVcK4PLcSqPF7qU0
 EkjRBEqLyv7ZTGJmqKFgjY8nzEDGGHM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX9Pp8JcDhEqFP
 NsAPUM1//XnrComFLGnsHeT6xwKk6UbHCPr+FJqGgDrfYrz/UE+QbMqzAn4RHBOUBrgUzuqDUqG
 i3F19SWRW0sChfE9K6TddjI9I5Au6dfxCVxJC/nfRkG5nI1cG8/fy+0q2wCFU884kPrfFzUEG58
 Zz6Zfm8Z5KhsxmB1DqOzfO5z+zIKgpboKE0Q6hsbk/Oc7IVPRPH0vjP0Q5bwe8I/BlJ0XnCtpBN
 Y9AuRyoYU4uT3lL4NQ4T86hGG0iOqMqm+ml6og/bulUJ+H0JSJeZnngJiZZPO6MIzYeemXvDDSQ
 aT0BGxS5khEgDtrSL8SbmOCM5bZTIJqAkYNwPkduDJssSeIPSmHWuDuJB8Wa/DxXSa31etbqeag
 rS70mxLJxxzAcwphXp76agc22pvcn6lHXI1GM48o7689hSY5aW3o0fvouPBlGAyCNKIyNEQobBx
 vPccSUGasSmGB4VrJDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100142

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> null_init_zoned_dev() allocates dev->zones when a zoned device is powered
> on, but null_del_dev() never frees it on power-off; dev->zones is only
> freed later in null_free_dev(), when the configfs directory is removed. If
> the device is powered off and then on again, null_init_zoned_dev()
> allocates a new array and overwrites the dev->zones pointer, leaking the
> previous allocation each power cycle.
> 
> Free dev->zones in null_del_dev() via null_free_zoned_dev() to solve it.
> And calling null_del_dev() in null_free_dev() is no longer necessary
> because every caller already invokes null_del_dev() first: via
> nullb_group_drop_item() before nullb_device_release(), in the
> null_add_dev() error path of null_create_dev(), and in null_destroy_dev().
> Remove the redundant call.

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
