Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2408AD51
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555059; cv=none; b=q541JslsxWEXDza+wA0MPQXyfyt9ComsrZxNhb+mkBddToGlFSfrvuufKmyh/MASxhHq6zT2kzdQVuM9KkjM1vBQkju/H5XkLRtjhW/cvhFZuG8J4kabL50PiF4itmXeSJfY+gT01mZi2jlVIdIqiyPKWheGlBUqMsjUJhRQijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555059; c=relaxed/simple;
	bh=fJ5bSR/gka3dluPpsV2ajv378LBjS3GtrdAMbJdDWr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NW1JuxmSzNiMoG2XiUKDdnPvKC2mYX3WWg8TWgZjL0pQZ5KZeZ5/yR3iV+dRkEk0JmC1KyXJRfvUFTu6ryFxnKaqs0VlsujElrlpkgilu0dhAMSNfU998+FGmUCCvNoasys7oPswtN+VWDhVdlKFlX1MvCIAsR+Aj6up1jbAXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LwRoj850; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LwRoj850"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCFlY1k016479;
	Fri, 12 Dec 2025 15:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fJ5bSR
	/gka3dluPpsV2ajv378LBjS3GtrdAMbJdDWr4=; b=LwRoj850UEsnnZqCzq6L6X
	6Gw7hGxh6B6kLpBDgwikSqmrLRIqSdDAoFbsY3FU8BeTniKWMfVw/3iH9YNMI0Mt
	nPuLRUZqjLL1nLip5bTSFWqI3MMfBYQtSFK4SP3kHxsdzzQIMo/s9cMf07M8Vtn2
	nzOpsbQGXBauDJfXqS+m2isrq+vgpxcn6Njh69JlVE+ZR+572GhCOt6UBlCQrqMz
	B5JFqVhKrK1b8BZgaNI+ovqhes+174mDXsOtS7k1XyRJ740G+MN7EvIfZm7bxKTF
	uRlcretOz/ZSxF5duNYDNzhsiCBtV9gM6eEBn9mjOccNUCywTQ5j1g6HMtRa5KBg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53wab9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 15:57:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCE96sC028102;
	Fri, 12 Dec 2025 15:57:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6ycu6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 15:57:24 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCFvOT98848084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 15:57:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E84F45805A;
	Fri, 12 Dec 2025 15:57:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CC458051;
	Fri, 12 Dec 2025 15:57:21 +0000 (GMT)
Received: from [9.111.55.66] (unknown [9.111.55.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 15:57:21 +0000 (GMT)
Message-ID: <2bb0437e-7610-4da9-86a0-a95e425bb79e@linux.ibm.com>
Date: Fri, 12 Dec 2025 21:27:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: fix race between wbt_enable_default and IO
 submission
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai@fnnas.com>, Guangwu Zhang <guazhang@redhat.com>
References: <20251212143500.485521-1-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251212143500.485521-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX1IKX9axjjT1w
 3dSs1cqMFKPBqAXmZTpimJ/vR3MPseDxHDhU+XkHDhtQzEiRq8jftoCzJVUIOBA+Shn3XafBgwB
 9oaQPsHSu+JqFEJzYDu620mZPE2NklK/0eCeeB2mtezorYFL0rXeOg3RqN4tNUlHboi7GWtwdxC
 daN5Xt8M9/+hvIuonW3FQ7qmRr2UDNAba0++VTtGItpq2ydWbrUxiAZIR2zgJOWC2nIOzwr/edg
 f2zF1AZqlQ4OsJRTezZHZIr28JfSnmlXpoZWi4DiY8oC2E3gLjgQv2+XKPxJfBisohJU/rpVI2S
 sIslQGglWwLBnig0vapIadmQ2JPt88MH/3X6eH3/oT9VKc+njeczlTR7Xhpb+nU/JYQ/OZvNemQ
 R/2BMS3550iZT/6aKqIgHv96ec9tCA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693c3b65 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jZooFtwnRqYpt7X2nncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I1xnuS6oi-Y0tu4aLyoBgZ1O_XzRMWeU
X-Proofpoint-GUID: I1xnuS6oi-Y0tu4aLyoBgZ1O_XzRMWeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020



On 12/12/25 8:05 PM, Ming Lei wrote:
> When wbt_enable_default() is moved out of queue freezing in elevator_change(),
> it can cause the wbt inflight counter to become negative (-1), leading to hung
> tasks in the writeback path. Tasks get stuck in wbt_wait() because the counter
> is in an inconsistent state.

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
