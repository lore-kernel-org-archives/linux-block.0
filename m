Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668C12FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544855; cv=none; b=iQyqP2KO7o9zfRVqIco3Hfuu99bpMT/7Z0KSI4iC013UJ3E+xWitSefURkk4+ljI/qdO9f9Iqq61ewfw4qxKvJO1WCVBUBdQOoS0MiCeEWVz0fHji3yTBGy4YEf9FMQH97IFcILqekX3cfW/eVb1eXJNsrF5QAqYfn5Ym8BIlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544855; c=relaxed/simple;
	bh=kE7IjIPZ52lF+SraPfpn/zq7dhl1Ce1L3WFfmJWpbaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HmKgfEmUZ8waAe+ZaAV2oEI9se8Px2TLLbY7pioY6KuqHPSWYFTXCuSExeBfjCG0m78jvoEGaDmN4LzVSNHLC85Tfo4a/cz/JEj8OIrSbMGpz9oH5FnOiNZB/tICNk9GjxLaJNwetm61X8fkXuHPP4THOEs9dcvVkgeFfcioQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ic7WxTHY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ic7WxTHY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604CQ68B028393;
	Sun, 4 Jan 2026 16:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ynoEBP
	GAepulRTUGciZNApallB0jwl7a+bnsoWQBwRM=; b=Ic7WxTHYVCl6fGUNc8529O
	l2vS7d477UGbwcsyYR/q/ManfSnZ4r4L1sb1v0FiSCVUpqZdozquXhuWePWNQbnV
	YRdnKs1kuaHEVL0YFNUhVOwOFn1Ul1S+SnCGdG9m/6r3x8fPEn3TJTvI4gNcFm2H
	qnOahW4ht/YI4AptYwz+m+5jxjLZGFwO8waYq/JzXqSmOJPeMDYnKrjwas1F/KJE
	lJEl69ajhKOTR4dE4S8WAi1UqJC3YWMYeAgtyPxe+CUauG0EdHL/XlQr8hcdEQYV
	BNXcIqqjxT5hR0oxhRj7Hf/KfuHXPT3KOvKT4bwvjsBHmOIg17p/bSrQYAIVojyw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtbppn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:40:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604GL5K0019166;
	Sun, 4 Jan 2026 16:40:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg50st08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:40:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GedIR35914244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:40:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 199675805F;
	Sun,  4 Jan 2026 16:40:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9295458043;
	Sun,  4 Jan 2026 16:40:36 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:40:36 +0000 (GMT)
Message-ID: <273b6df9-e8e5-463a-a201-d43ace448404@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:10:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/16] block/blk-rq-qos: cleanup rq_qos_add()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-15-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-15-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695a9808 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=umBIMjYr1lxjD7hLcVMA:9 a=QEXdDO2ut3YA:10
 a=A3mqa8q7df4A:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: 6UEnP8ghH2UwklIAmxTQnd9aWMWEHhC9
X-Proofpoint-ORIG-GUID: 6UEnP8ghH2UwklIAmxTQnd9aWMWEHhC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX72n/wD1SAE+i
 915e0/OgUJdUAce+0DVYwesqO02r8Ys2zGBsRFvMXFVAmEzg917rrylE/6a/Sws8f1rBUNLBez+
 g61FpbfFS1yL8KF/KXQ4QLatMmo4HGdbNzsMymzVhEQv1VsFbpQl9bejUlkWdxzOJKKYlxT7fY8
 soXVmln8OWDhrW/U+M70K+qd6wXJEbx+Uz5bSgJAsbW3XziIVDHpggvgEbWTBC9Z46FSg9moal5
 AguXlLV74cJXA9A7eAK/FSTSFe4CDcYPPFZAR3eIgEdHr9MNns6SsPe88T8HhnUxVDrwAjzolUv
 UDywLIbFP6ZeRk5BcC83mCYkyxw50DTMyNlO7Zm7UHT/xssYkMFRO7eMqyOW6sQeSfcKA5hHxwX
 9xTuW5ZlMvm5XzU/wMjBcJlrpq3u+ziG2FD8y1ZUFtIYzB0YHXDzYsezAKJxYOAGo9JsI6X7vk6
 0AwSAw9x5f1UF++BGPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> Now that there is no caller of rq_qos_add(), remove it, and also rename
> rq_qos_add_frozen() back to rq_qos_add().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
