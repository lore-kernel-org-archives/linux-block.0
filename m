Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943940927B;
	Fri, 10 Jul 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686694; cv=none; b=IK7Ld0vkjdVuYNYb/b3uiAVJk2GmLb3ZtdK9Kg+XLHEFWCftreaxgGp0zN7YyRamD6HDoIQvrsBfHsgBTSo3XYNJMEEDCdW62zz5KZyEV1FsKTsDG7auBy39jGViRwo04KREPiZqE+25LyOnkSJ/k6OWrzh2M32emUo0dGu/Lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686694; c=relaxed/simple;
	bh=5kN9DIw/z2O+djO1lndJGFpaZTjsb9jPqCPsBSm4RyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATJEQ8r985bNs5lHcjmJ10vf+Piq2dR9fi3cWxPFdU9p/PgNW2ZUSdh7syJm/1m6+V+06eNVmigY9NPQ96wyyEQRknYCFSy9WA4jM0yajVJfJqJgF0Bufn+vaxPJQbHT30836lRopxS59HhepJ8n7T95dLcW9nW70RcJDsUIs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nk/Iol2K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nk/Iol2K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAnMrV4168888;
	Fri, 10 Jul 2026 12:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DmhWSK
	i2F3cs5/LpJd194Ci0DiKkqYF4BOyrOoxGims=; b=nk/Iol2KJXD1gYrcC6OA4V
	K9jV8Z9veOxyMb9vZKjhTkrS/NA78RhA3JGph4Ys37Iriz6v+lskNdFttZootuUj
	1ixEIUCBOJwC8CdJkdRzmtVQu5SVyrd6HduH2J4Zz4rpIKG7bq8Aedku9jxOwWJu
	Z+qO5JEz6paYT8BLZ8nqGo0AQEhwoMxdAdFA31F7CC+nwKYXTmnaZYBzdGgGBQlZ
	+hS7XfsF5syQvS1s5OH0OOq0Q01pjD5A0UyJ+NPlR1Bi80FKd/64ZyHM3qV6rZtJ
	EyAdFv/JDkgTiq6HOzHwlEPTajuPnxVbBctEkb9feG4abxWmvUGyPsbeP8lsFmdw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt6udx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:31:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACJeQP032028;
	Fri, 10 Jul 2026 12:31:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hsv89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:31:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACV2CQ9896484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:31:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63DA15805D;
	Fri, 10 Jul 2026 12:31:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C604258059;
	Fri, 10 Jul 2026 12:30:57 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:30:57 +0000 (GMT)
Message-ID: <46c33982-0f5a-4acf-8695-858fdb4bf75b@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:00:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 8/9] null_blk: serialize configfs attribute stores with
 device setup
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-9-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-9-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VheuGFtxeu9tLvhnBQ-ruLyq6VJUd4CY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX1ch+iBm45zVF
 3l9UR6XtUqG0hXUajqxcRsBLkgGyNRHjMSw+SejjwMziGnX8EswuwdQm7Rf3yNy6gUg3qpWrpwy
 yHMOcaAyNPUjJE6Urh44g6eLZ8pN8T4=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a50e608 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=y51Q5GejMjsIS-RTXT4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VheuGFtxeu9tLvhnBQ-ruLyq6VJUd4CY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfXz9+oh9i8Tx+V
 qQjFBgt93fwiE00y7O2v1PGSjokaPAaT2tjZUlolDDmbp2DaFWkuIiBiRNcEmOKwMdlaqo5jwZ7
 TlWFweTYLgK03tso+ex/QRRJ1K1/pGjomDlF88cCCF+nep5jIyVdmkcQBpx9AFMZOP3yZjuszUM
 cHEI8AkGJ0HCB4v9DWqdn9Xfib/3hl7M0rN1oKDw9iOgcr77Ii03DoaWeCLUiumceUrc+nXcEhD
 K++5cFWPfECBT2IBn8/6YGVhQQRkjbw5+XnjuoIVQR8EEfN9W8bQZJgmHEr7Ew6gBcAMwrrCN+q
 rtAzL1Ymzd8pOZI3BchVpnBvY15bEmhog55s9FhPMKBMfpK7KqS1VYoeYldt6AKK4j9cpSFV/1p
 /NrrOSSpaMbkbz6XQbPdcUB0EgvrdjJnTkFMGFVZd1mdyFcoFIbHkrlahep0sldSLY/sLhOHbtn
 3TUbH9vnLucaZB/GlbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> The NULLB_DEVICE_ATTR _store takes no lock: apply_fn attributes
> (submit_queues, poll_queues) get dev->NAME written again after apply_fn
> returns, outside its lock; APPLY=NULL attributes are entirely lockless.
> configfs only serializes stores per-open-file, so concurrent stores on
> separate fds race.
> 
> For apply_fn attributes, once one store's apply_fn has reconfigured the
> hardware, a second (losing) store can still overwrite dev->NAME
> afterwards. This leaves dev->submit_queues out of sync with the live
> queue count, which is later caught by the WARN_ON_ONCE() in
> null_map_queues().
> 
> For !apply_fn attributes, power_store()'s null_add_dev() validates and
> builds the device under "lock" but only sets CONFIGURED afterwards. A store
> slipping in during this window can change a field mid-setup -- for example,
> zone_nr_conv can be pushed above nr_zones after it has already been
> clamped, leading to an out-of-bounds dev->zones[] access.
> 
> Take "lock" in the macro around the apply_fn call, the CONFIGURED test and
> the field write, and move it out of nullb_apply_submit_queues()/
> nullb_apply_poll_queues() so both paths are covered once. This serializes
> stores with power_store's setup and with each other.
> 
> Also reset ret to 0 after the input parsing so that within the locked
> section ret is purely a status code, rather than carrying the byte count
> returned by nullb_device_##TYPE##_attr_store(). The field is then written
> only on success via if (!ret), giving a single consistent rule for both the
> apply_fn and the APPLY=NULL paths.
> 
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
