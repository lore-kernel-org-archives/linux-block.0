Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52221D3F0
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571908; cv=none; b=Noek5PEyhZXW97g+BHAKAwvEZYBpWoxlIklD5u2rYAlpHROMn7l6+fKqnt6TSPbHPnXIAyiZ1b6aMWnHuJvaLx0c3Q3Lr+zEjtLFcbubH3GedV1ST6XBo0dYYrT1bAz69a3XRwmo1p7yAjThB3ADOIGSuEnOcRoQoEJEiNplPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571908; c=relaxed/simple;
	bh=p7CMoy7OEB4dxEDj9TO/ZVrYMpcucS1h1hFhC7LHDbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3dbMeWgl4jNI03jOkQJmj8U9RQ/+dJyDUXfxfFnqYtJIMpgLg/LHXTVRhFjMIOm3Qguo1ZPKCGO0okkVxhiJ9IQ2Bz3RJ32MLC7rg8U3so81iJXa6KjxAKjYXTgQLxPdrEqy6WlelpImFpoiHUrnKtHYxCrPNmmI5fQEvCEm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TnjmR/Gy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TnjmR/Gy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q5OFWs021004;
	Wed, 26 Feb 2025 12:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O69VlN
	bQ40MUTWAf3y9sDRPizoYbEwZvzD1Hy/zzbTY=; b=TnjmR/GyuM892GGTq6zggD
	+U/1Xbn6leBSL3n9KOoRTRDsELoMAA7FY4IsOpHxfdBMZCl0DSBjirARmR451JnN
	VSyyWogs1hOnlhVoqfJSAel5+hUUjy9XfvXGrT7opfIWzyqgcHYEsbelHg/oePXD
	wd+J5+LtLHHwi6Zdft7ammZAMV93WHHPhs9ZBofz1b76Lr4Gc6VpekJc3htuGTPl
	roUhi/3U/lTKIkgiTeyUdf+ZYCqdbFw3JcRU0BV3W6nfIaXs+T3cqzwJNjjM8/cB
	0pMoUyijj15FPUYxFAVCKxGW0tUoo6Bysb2ekGsSZJ3OjGbVjWxpRQdrht5aVQ3g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451vs81ph4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:11:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAAxOa027327;
	Wed, 26 Feb 2025 12:11:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum2237c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:11:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCBYTr56820152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:11:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6242C58053;
	Wed, 26 Feb 2025 12:11:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD4A258059;
	Wed, 26 Feb 2025 12:11:31 +0000 (GMT)
Received: from [9.61.110.139] (unknown [9.61.110.139])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:11:31 +0000 (GMT)
Message-ID: <241ef4d9-3f73-4312-aef8-06b528b00001@linux.ibm.com>
Date: Wed, 26 Feb 2025 17:41:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 6/7] block: protect wbt_lat_usec using q->elevator_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20250225133110.1441035-1-nilay@linux.ibm.com>
 <20250225133110.1441035-7-nilay@linux.ibm.com> <20250225151300.GB6455@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250225151300.GB6455@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ul_WahXQEL9PcynU6xD7zsZ4h74pvK8A
X-Proofpoint-GUID: ul_WahXQEL9PcynU6xD7zsZ4h74pvK8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=763 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260096



On 2/25/25 8:43 PM, Christoph Hellwig wrote:
> On Tue, Feb 25, 2025 at 07:00:41PM +0530, Nilay Shroff wrote:
>> The wbt latency and state could be updated while initializing the
>> elevator or exiting the elevator. It could be also updates while
>> configuring IO latency QoS parameters using cgroup. The elevator
>> code path is now protected with q->elevator_lock. So we should
>> protect the access to sysfs attribute wbt_lat_usec using q->elevator
>> _lock instead of q->sysfs_lock. White we're at it, also protect
>> ioc_qos_write(), which configures wbt parameters via cgroup, using
>> q->elevator_lock.
> 
> Please expand the comment near the elevator_lock field to mention
> that it protects wbt_lat_usec.
> 
Ok, will be addressed in the next patchset.

Thanks,
--Nilay
