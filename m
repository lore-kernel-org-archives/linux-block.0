Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76334215A
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058977; cv=none; b=HZr96LZKoofNMD4kVl4JQjSk1qzQiMFRkiC/2FnXhufd2STzIXwloTsjFRAlt9IG7U43T7syVzDGDx+MCtYEk6UetEqOuPW8+RL4YZlvQzWNMB4yJAfSuNCQQGIH173IBZ1ZdZon5X10u4PoItxuxeL0PpN8VLoMVlar1wUpdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058977; c=relaxed/simple;
	bh=4vc3eUVdl8D00p4m5GILHMDRoWYrQ7sf5PNenE9uo64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0OlJxVJL71egNUl5klSS18qlPlcBar/pbiJlwXSerACSAJKLLh+6fOoBRikRe64FvAuXjzwpDi0odNuLZ6C4MHst5o1ejzHdGnz3+woMLns9vN7peiNVIgmP1EA+6SNJmNJCOvk+C+Q0X6t+YC7PrFjPDHeBjcNQm4teV7UAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bCF/0Wa/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bCF/0Wa/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBv7nT006824;
	Tue, 21 Oct 2025 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1b69gD
	T8LvJVtiHS4ua5Tn6SRWH4Fsf1vL9xpsxKQeE=; b=bCF/0Wa/KvKu6mQrXbsl9S
	IuI12RC4yilHAEQ8igAzzYa+6hR1osQ2yr76PsAHX3P22upm6LdX5AEibz+EsAc4
	lPjhFxAyp/n9PTO0X/8dAUWgOiq0uZm2AY6NL/nYzbyBBZdVrfnPhH6JOuaihVTM
	8YP4AWqBlnw3KWNb2wK1CASSxYokK8XFnkIejP3AjVt/itLGoqpCAqdAPiUas1Im
	xKuDNZZRybiL9zQ3MA9chXEP6DaTzSPO4jgBUpSJ53HQihGVkVuKg/5xMVRtgC03
	YIJszN5E+NsH2pBXcy0wKoFkKtRMRcX9nAn8MzPqsr8rQUohKLwQuegkzH/y8tvQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326qp30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 15:02:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCAD24032099;
	Tue, 21 Oct 2025 15:02:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mua18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 15:02:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LF2SMN28705344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:02:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0DBA58060;
	Tue, 21 Oct 2025 15:02:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5CB58066;
	Tue, 21 Oct 2025 15:02:25 +0000 (GMT)
Received: from [9.61.103.108] (unknown [9.61.103.108])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 15:02:25 +0000 (GMT)
Message-ID: <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
Date: Tue, 21 Oct 2025 20:32:24 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f7a086 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=TakWwMvn3hYBPWLwZwUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9kyN3yeIF1VP
 lFJJrlwUuBVhHNK3FogKnywjZqb3LY/SqgUeMZY0/GgT5hsULn2RVI8gcCUOSvEG3xhWKbRoh3B
 K8U1Yt/qSuiZhj8rOEJTnZMJfb5qZhzg/V/1nu9BRf/XsZhoXuiTTKmK9+UL/j82Y5AfwiDLmGV
 NXEKCcPmzxoY3H5ug/5yj8vlV+//ihBAt/9xxdHBNxCpPREdZA60JkhlkL57cRFLNkhNi6yVgaN
 1oRYgcIUdNf7YoZx1xFSVjdLQwodkslZAq7NkoIF3ytW8NN7IzPGwMS8X8gRQzeMLAG5hpJOBLN
 hlQSH0v1Qy7CCriubiqEqzFFJq6NIHZOEvyU9zkgA2IHg+Lx1IHHp4hTS3E5Vi36W/v1YGaSOT6
 iXAW1S5uqKurxre3Pgrcawa2ZK+J5g==
X-Proofpoint-GUID: xIWKchR_gvnhykSQPwUL9AvJTejebeoA
X-Proofpoint-ORIG-GUID: xIWKchR_gvnhykSQPwUL9AvJTejebeoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/20/25 7:12 PM, John Garry wrote:
> On 10/07/2025 06:07, Nilay Shroff wrote:
>>> Considering multi-controller subsystems, some controllers might have
>>> namespaces with only 512b formats attached, and other controllers might
>>> have some 4k mixed in, so then they can't all consistently report the
>>> desired AWUPF value. They'd have to just scale AWUPF based on the
>>> largest sector size supported. Which I guess is what the current wording
>>> is guiding toward, but that just suggests host drivers disregard the
>>> value and use NAWUPF instead. So still option III.
>> Yes, I agree — option III seems to be the best possible way forward.
>> However, does this mean we would disregard atomic write support for any
>> multi-controller NVMe vendor that consistently reports a valid AWUPF value
>> across all controllers and namespace formats, but sets NAWUPF to zero?
> 
> Hi Nilay,
> 
> Does the drive which you are using report NAWUPF as zero (as hinted)?
> 
> If so, have you tried the following https://lore.kernel.org/linux-nvme/20250820150220.1923826-1-john.g.garry@oracle.com/
> 
> We were considering changing the NVMe driver to not use AWUPF at all...

Yes, I just tested your patch with the latest upstream kernel on my drive, 
which reports a non-zero AWUPF but a zero NAWUPF.

And your opt-in change works well on my disk. So we may consider 
merging this change if everyone agrees.

Thanks,
--Nilay



 
