Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8617A2EA
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338341; cv=none; b=ZHOvxUJS9JhylJpizi8onNI1jvDDm9ccJqxTpQe8lVY5wfuvTAX3PTQ9zEmn+OcYgyUUweTkbn3W0bG5ldunrKGt/vSZGgF/nXx+xW7gmCq/YiyycH41BjAZzkDkWfREAWUflWHTI49wAd7w3SZ55hDZJ48l89eRnu+qs/6Gz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338341; c=relaxed/simple;
	bh=lxAlBsE6BkTj7EBUhtabxyuglpWdKka00iVXwo9wjoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVv96iHzd5QG4/hREOyRvl1IqowBBq0k13lo88WYt3dndH6r3ypNjQ5LP+Wd508I54C1/hhxR/rir4FmEnOcccsOpVKgvhfXxAERB8+2RK2T5MZYyvqPcJN+77Lqxsg4+YVx4tFynWTVgzp21Kf1cNTVIJ28hzHPvdOaJ1/g7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gpZ079w+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpZ079w+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G2FBjP2130947;
	Thu, 16 Apr 2026 11:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nzjNxB
	jB818Z9QavfFiRVUN3lyVCXAzPo83A3NBLejE=; b=gpZ079w+A11qrF/lYURZlF
	oxRxUxSaU6WeVNAgfm0HlDWX8Ue54u7tINH3NcfQIqmOTdeU1DBZGLIM2yQ91t6Z
	nT5j6qyQymtI+u5unDQSpNiLJYDodgc+1HpP6uH2VyIOy5EfTMsoZV7gkVf8ek/8
	9liJ+rPnptjh14vS8OYjAJ1R5Epkp2UtBFjjHjvGjcFWFNAidozZBqRE2b8azIzo
	U6kfwPz1C7zn4ZtMe/Pd0WPKSYoX4FzRxXTMfYEwilgZEGWXh3AoAsSYb4GwNjVL
	eUpc/n1EW5/YfVe4mdSALgSfvxAmyjmh1WpT93hbWPaYbtnRZsUYO+lcBqbQAF3Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nn3s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 11:18:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G7aGpg003581;
	Thu, 16 Apr 2026 11:18:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnjkar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 11:18:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GBIttm1835910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 11:18:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E8E58059;
	Thu, 16 Apr 2026 11:18:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1558F5804B;
	Thu, 16 Apr 2026 11:18:54 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 11:18:53 +0000 (GMT)
Message-ID: <c1e9d3b5-c236-4e5c-8cf2-90df5e32005b@linux.ibm.com>
Date: Thu, 16 Apr 2026 16:48:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
To: John Garry <john.g.garry@oracle.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260415104111.1439459-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AaOw05Dd72kb-l0wraPCpUcfO6dCRgQR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEwNyBTYWx0ZWRfX5DOaNUdR3zkD
 TiOHt7fgGRHyFZ0WRQsZdUfCXz57R3MJSWeMx/Ffkfbw+b0PRSMZ4VYGU/Pcw4fRVMBedBCe+Wz
 R4ah8lxVOqTvCPELEdaVZU0lwUEeYdf3aPvsbNnP7LLRkcajUbiIXt7N+MR9cxWLGMru4eJDaMc
 +HA+k/BPgjBjQkR1LGqtii3oYJC428w8PK6STdLR8/l817GLf5CtX2ConFD8ihCCQiL8wwvWaA7
 9MpXKuffd78hEnHuf3r7OTlbxxJtvbmJ9R2g1cVnRLxvMVMJl+EnsjKKsLPCcf64Eb8vegLCTUG
 9hdLU2auW16SP7RAQIRDUTlwWsGCJ21h8d6I+eMrD7NujxEXQl9vWrhImDMjjsODoGIxDr5zzrN
 9RVHVaEWKdUpDR9K4n1ZsO2MchmflfemCdUVnuvWVtM0f9JygL5pEEBNr5AFPhiYTx4vHRiZ/Gj
 CzuT4BlNMi8kUmrg8YA==
X-Proofpoint-ORIG-GUID: AaOw05Dd72kb-l0wraPCpUcfO6dCRgQR
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e0c5a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=nsBul3eVbvCJHK_4BqQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160107


> diff --git a/tests/nvme/068 b/tests/nvme/068
> new file mode 100644
> index 0000000..e06fd6b
> --- /dev/null
> +++ b/tests/nvme/068
> @@ -0,0 +1,118 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 John Garry
> +#
> +# Test NVMe multipath delayed removal works as expected
> +
Should we also reference the commit 62188639ec16 ("nvme-multipath:
introduce delayed removal of the multipath head node") which introduced
this feature in the kernel?

> +. tests/nvme/rc
> +. common/xfs
> +
> +DESCRIPTION="NVMe multipath delayed removal test"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_module_param_value nvme_core multipath Y
> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +_delayed_nvme_reconnect_ctrl() {
> +	sleep 5
> +	_nvme_connect_subsys
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local nvmedev
> +	local ns
> +	local bytes_written
> +	local refcnt_orig
> +	local refcnt
> +	_nvmet_target_setup
> +
> +	_nvme_connect_subsys
> +
> +	# Part a: Prove that writes fail when no path returns. Any reads or
> +	#	  writes are queued during the delayed removal period. If no
> +	#	  paths return before the timer expires, then those IOs should
> +	#	  fail.
> +	#	  During the delayed removal period, ensure that the module
> +	#	  refcnt is incremented, to prove that we cannot remove the
> +	#	  driver during this period.
> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +	refcnt=$(_module_use_count nvme_core)

Should the refcount be stored in $refcnt_orig instead of $refcnt?

> +	echo 10 > "/sys/block/"$ns"/delayed_removal_secs"
> +	refcnt_orig=$(_module_use_count nvme_core)

We may not need to again store refcnt here if we store it
before enabling delayed_removal_sec above.

Other than above trivial comments, this looks good to me.

Thanks,
--Nilay

