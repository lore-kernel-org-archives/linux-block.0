Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0906274668
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047965; cv=none; b=G/+AmOblTM93HfzLVV8/2Yr17wffJyFsWWq0oU2Mhfo0Y4GotamZa8GLYD91zWR10W2X0cZiI7LXOyR9E862nCSQ5MgwMXYzXw7y/EpuLn4K1RzFt/Kdl0PGtAbSGBs6SyUv9tiSWg9tEu3P0mohQbrnEEpqs6ujxHp+cet1Itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047965; c=relaxed/simple;
	bh=t+CPgDF0g0h2/U3um6zTipZ0g8x9lC+Cp14p+9PSf8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5uWieTzV6ds8RHAZ16jmSxvw74bOUKGMlBDecpJINkpDNreoJEb+U/m3bv7eQ71hVHp3KF0AKcYZx3Zub+o+hpz1mgkA7ztuh+Z5bbS8WkqjKbKtSqFBDC85ocnheRPI3YCn2ENYr47xFp8kXdhAUfYTRnYroBsH32/m3K/1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FJCuIYea; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FJCuIYea"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694MYa0024482;
	Wed, 9 Jul 2025 07:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uj3p27
	IbfpOi4bUET5dHlqbtsW25PO5mkzWP+VCzV+M=; b=FJCuIYeak8yZF0cUPPs+fi
	lRE7PHmqZ233UR3OJe+XAzIw+nOTNQf3UOUPk2N24PYM9O3WDJEM8FHEwt25Pndo
	zVncQWy+XdeCfLqf7D3I+vm8vB6bjtyJ5bZ2P6Xnu/RAK7Eodj7hO+l5/jdRumjC
	8hhREsnV1mWhX8N5gh+b+HqmIQOSa4IhLnDHgns0S1mnWO5qYeum7WHAU/FEYiNs
	miJWn0Rti0x1gh8ZHz4lJ5vAthU+XnD7Zt+EB+fDy6kyB2ENKxF3YOxDa1eNTYn+
	/hOp5kUdAiMeRDeV/cimAkHFJebqlWAjrldg/yiLSDBJiII/Rvh3jMoZ7DRsCICw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur74vfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:59:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5697N27Q002865;
	Wed, 9 Jul 2025 07:59:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmf1cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 07:59:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5697xBB219661544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 07:59:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1294758056;
	Wed,  9 Jul 2025 07:59:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22AD45805D;
	Wed,  9 Jul 2025 07:59:09 +0000 (GMT)
Received: from [9.61.141.34] (unknown [9.61.141.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 07:59:08 +0000 (GMT)
Message-ID: <95e6bce2-19dc-4085-908e-c81fa7a1d5d3@linux.ibm.com>
Date: Wed, 9 Jul 2025 13:29:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix lockdep deadlock warning
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com,
        Yu Kuai <yukuai3@huawei.com>
References: <20250709014109.2292837-1-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250709014109.2292837-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA2OSBTYWx0ZWRfX1/tVoB7nDoBN nWE7Q0vOj1g/6tOgjhH6/teQhZet3bk+vc9aRXDd8mXZoYklCpGEByYL0F/zjR2/ciGiECjgBtz tLitGIYB6HWJVWbpsW0SFg5lRXo6VmJP8YY7kx1m4DERKN+fhJNWhoQwyucSv7joe4Nh6dTPYFo
 AtkAdHUeOi4T8yBItxFoEpvSEAbkep/Uqz27d/7Xy3cz5GQA61+lWIpkWHqXahOAazs9sg01raY vxzZwnDUete22hdHXG0yX7UYW4eLbgMRw4cOm502PMDT3DT3uqV/Tu6UetPkMCQ2ZAxln0k3e7U qR7iUSN11yOt/9qqJfJRcb587SBzTNEvm+DTR0T5pPJFHuiye3Pr7FmAY2Ioar589w5s2dpUVSJ
 WBguvznnylx3ZmlUGbWofZgX4R/WaIzOHrQlrUXzKJuIhcEfas8B2En+fLh7tlS2HoUNUGcB
X-Proofpoint-GUID: 4VNtBjF6qqTiO187HwbmzvLQV4YQ5ZBx
X-Proofpoint-ORIG-GUID: 4VNtBjF6qqTiO187HwbmzvLQV4YQ5ZBx
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686e2150 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=-tVqgtyqGLMlycA9sdMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090069



On 7/9/25 7:11 AM, Ming Lei wrote:
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7bdc7eb808ea..136640e4c866 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1473,7 +1473,15 @@ static int nbd_start_device(struct nbd_device *nbd)
>  		return -EINVAL;
>  	}
>  
> -	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
> +retry:
> +	mutex_unlock(&nbd->config_lock);
> +	blk_mq_update_nr_hw_queues(&nbd->tag_set, num_connections);
> +	mutex_lock(&nbd->config_lock);
> +
> +	/* if another code path updated nr_hw_queues, retry until succeed */
> +	if (num_connections != config->num_connections)
> +		goto retry;
> +

Don't we need to update num_connections to config->num_connections
here before we attempt retry?

Thanks,
--Nilay

