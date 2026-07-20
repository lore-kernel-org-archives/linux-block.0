Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE03BFE23
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559895; cv=none; b=WcFnkL4tck4rrl+Nf6tBAAnsIBESMDiSSzCxXwV+ipqy+25c8/0rBqn+665/imYc/wabqMD679V+Q63vor46H2ZoKnROfTYYQVem2a80MmjjtijtmuWN8P9ostwuptmYx/++7dbHxPMeIFcKKX1+4QSrOdm5fblJCjpapuJaTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559895; c=relaxed/simple;
	bh=qbI6Wkkhc7DoWKC0I6Hkl26Eb2hzs6aSw7pfRb0R9Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBSMecWUUi+xfBBmB9OMZB073WkwbUishUH5nSsFi3dzOh/+rZizMGd9EY4RrJ8ytWTbrDUgxxHAFLQ/J0sK8R/skBr6Jt4SiNSi6ouqsuifBq3IP66K+LZ34d6V/deXzSk20Z4+DRQy1A11jK8ggjAm2zZDYIzJ2gbgmSImlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m0qJfquF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m0qJfquF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KEC8n22324866;
	Mon, 20 Jul 2026 15:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MIJv9D
	3kJz2lRSJtM7QnxKWo9crxnllNeOjg2QVLC7g=; b=m0qJfquFur8VlTqG/iwCUM
	tKWtss9IbgFQs0EgU5UH6DKz5IOd7SOy9I4Gnsf49wP3fNMhdmHFhYbigaRj1BAc
	WvQyJxanl8zqK03E54yD17tn+uFiVayzPMsnPG7L7FrB7i5qPSv3EgOseRw5cYSM
	JTipX3CXMTcGgoolyll8qwoSUg4aqzL0YrMZ77OKOa0JkAEZhEM0DALLcj8sQd8N
	FVfju8YNFJ52THR5h1hK71BjkWoc3wEkHajP3JNMetzZkVuFMnjFjGtvjvcGmQiE
	PqjpMMOZaAycSTwe4wS4SuqzrrIdlDUZ3ZFBXodLq4fi4alDameKwD9Ap6TKjZUw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fyta3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 15:04:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KF4abg019019;
	Mon, 20 Jul 2026 15:04:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagx2cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 15:04:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KF4cGP27460242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 15:04:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5FEE5805D;
	Mon, 20 Jul 2026 15:04:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EF2058054;
	Mon, 20 Jul 2026 15:04:36 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 15:04:36 +0000 (GMT)
Message-ID: <77f53c55-c0ad-4588-9455-0b07d9cf0367@linux.ibm.com>
Date: Mon, 20 Jul 2026 20:34:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme/069: add a test for multipath cdev lifetime
To: John Garry <john.g.garry@oracle.com>, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
        John Garry <john.garry@linux.dev>
References: <20260720150217.1355223-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260720150217.1355223-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MyBTYWx0ZWRfX98qg9tU6qvIQ
 MG8DtcOQXDrvn394W3EtQVh8Oe7OE4CmHb0f30MDJNIDAx5vKtZ75fND9Vmms/zOyMRr3C4fWrt
 aYxLaBtUui9sDgQEiw0S19bHsdtIh6VIMsHHALnbnHGuWuR3H23c542eI8i9Z2S1zr0/oQBbwyi
 aO+x1lw80Ov8zcwMg9YjzXBsi40idk+rTvPRcIVtMI3o3PB2n06xIsae7A4Dpk4lUx2KhBH3JTZ
 iZHGG7nWcha4JF8+Ew+F4CzjnwXn9XsdMWH3d6nh420aSsV/616DuEH9B6XNk/WBqgVqruS8ErE
 srkgs+i61dgx60QuOl0Uwne9DDEPTVOCPWy98fiReqTuDnzcegvRU+FxZ+qG7re7B9JgCxR1mCz
 rZDGjIkzHKgKXRB34vyDQLZ71kjDXeKrt3FBDO98Dc7WCttgc4csYLsxHjtrVh2nUbdUXUdzkXa
 kwrM9hAD2ZfXx+yjHlA==
X-Proofpoint-GUID: hFXis39SbKthvWzizO-na0kNM7b9nHR8
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e3907 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=xmNKHcU9ebH4ajXmbt0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MyBTYWx0ZWRfX5PcswvqTO6MV
 Rp8FpJPeSdRn16YU5gd3oaK8poccENCxqyZDOyap+wcQSj99Bpxjl1QshNeJxYaVYN40ISMBsL+
 Y0qRhlJzBZpJSmwAwqrBP5/q1FJyLwQ=
X-Proofpoint-ORIG-GUID: hFXis39SbKthvWzizO-na0kNM7b9nHR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200163

On 7/20/26 8:32 PM, John Garry wrote:
> In [0], a fix was proposed for the NS and NS head (multipath) cdev
> lifetime.
> 
> The issue was that fds for the nvme-generic cdev may exist after we tear
> down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
> use-after-free.
> 
> This test recreates the method described in [0] to expose this issue
> for NS head cdev.
> 
> First a fd is created by opening the nvme-generic cdev. Next we tear down
> the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
> the kernel fix in [0], this should trigger a KASAN warn.
> 
> [0]https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613
> 
> Reviewed-by: Daniel Wagner<dwagner@suse.de>
> Signed-off-by: John Garry<john.g.garry@oracle.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

