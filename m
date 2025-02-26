Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48E21C18D
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571791; cv=none; b=qs+8iGkUaOSiLIvC4E5NwPRolx3XgQfeOFTNLZ7G6ii7tGjKUvL71XtP4pgulJEwT7yVtS51ONSTzmqXQRU4B0pqgp/KfQcDQgIQXTzZ/Q7CyIQNuVwXkhM6hcENzjHAEZZFK3+cDHZATBLrIrKtS3w04a/Ra/FMdMADToiSrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571791; c=relaxed/simple;
	bh=R9HEqyX0RCsmIU2LgTOWHv96v5fhHl4sAX3ktnVJMFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8jTGR3Duu4Pu+YNYaQrS5PFEqRk3QOqCAv6p8W/lrV9NOTvvQBxm3bF6U+KEn4aI0Yzff+nSL9rhw3r/RxeGkuDvdk+59nI5or3T8cCBBqFT4RAj+d6CSQSw5Rml6vN74gX9v3YESZH8oeUacLlT7Vr0Bx4z7QLil2Rs9tnDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p5VpNjE4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p5VpNjE4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7WfZ4005793;
	Wed, 26 Feb 2025 12:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L0xP/r
	ywbnty73luXJ/4iHscd/ozbd6KlPTgTFKNPrY=; b=p5VpNjE47lpsUOJovJkN1+
	Lje3BrOSIZb8I0pxkIKFo3s9K6J5c05Q2KcIONsfPjeLZM7JDxR1q3ANla9kp/2s
	f7Vm9Fp3nDE1KSanZgl0Sar/dxvn1nO4aKfOqtELaFizvJ2AFjz/IIojiTbutPsD
	84Y9Mx2oy6PXIgiX2VdH3jkrN+uwV/vzfM9BZjmERoNI8ka/wu7FQyiPvkrMY+k5
	385KGEthBye3bqiEExcTVE49cKEcSii6gOHBTXyGukOTeAoMPwDPgxWWn59O88a7
	eJGxu0CCCBlU6Bj0vU4DzgyGPsQ+eFDoIfE7rBLM0wGMVnY5YTxMf6d8mz10JJ/A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp15qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:09:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAEOcB027376;
	Wed, 26 Feb 2025 12:09:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum2231k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:09:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QC9fRY25690626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:09:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3599D58043;
	Wed, 26 Feb 2025 12:09:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F296C58059;
	Wed, 26 Feb 2025 12:09:38 +0000 (GMT)
Received: from [9.61.110.139] (unknown [9.61.110.139])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:09:38 +0000 (GMT)
Message-ID: <0d4afccf-3b62-485e-9bde-61463f6cbb95@linux.ibm.com>
Date: Wed, 26 Feb 2025 17:39:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <20250218084622.GA11405@lst.de>
 <00742db2-08b3-4582-b741-8c9197ffaced@linux.ibm.com>
 <cecc5d49-9a54-4285-a0d2-32699cb1f908@linux.ibm.com>
 <Z7nGw_PJfAld8fAz@fedora> <20250224144929.GA2205@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250224144929.GA2205@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2CFFYeu05mpLB_oyHteJhcu1rvx1xIch
X-Proofpoint-GUID: 2CFFYeu05mpLB_oyHteJhcu1rvx1xIch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=783 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260096



On 2/24/25 8:19 PM, Christoph Hellwig wrote:
> On Sat, Feb 22, 2025 at 08:44:51PM +0800, Ming Lei wrote:
>> IMO, it is fine to read it lockless without READ_ONCE/WRITE_ONCE because
>> disk->nr_zones is defined as 'unsigned int', which won't return garbage
>> value anytime.
>>
>> But I don't object if you want to change to READ_ONCE/WRITE_ONCE.
> 
> It changes every time the disk capacity changes.  And on the (uncommon)
> reformats.  So the best locking would be the same as for the disk
> capacity.
> 
So does that mean we shall use bdev->bd_size_lock or disk->open_mutex here?

Thanks,
--Nilay
