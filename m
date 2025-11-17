Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DF275B16;
	Mon, 17 Nov 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374404; cv=none; b=HM8dWq57x2LxNnSdBkDSdd0ZRcEfoRPY2QhXOJNLtOLCqt5oYJ+9Pb43IxvAJzjyDyEaiXarp2xgMN85Y7urwpLbZJVet2boh4gbKS4MIEselstpYxfRgXzGG4UMqgEl/8+TtY8tcolwrXN2uSfu3fCxSKymffsk9jZsuzZKWus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374404; c=relaxed/simple;
	bh=blGyRsiXrcT6z50cH2lIn9B0Y111xZhkGXf7XnsLB1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LYDjKFmZS1etg8Gf7BugYZ2xR6C2A0XFj1RVv6TJRZvmQ0+SX/8ens03Vmeap2+YLa+kUMuO+E2cGbDQOKtVanFRwH5rTB6+j+9pXMT+TcIIIuLB/ZlOm/6v0GUhXegECOT6sIngH/5M6QAEXJuDrUXm3f65dYRq/QlIo/TFLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/jBD4YR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/jBD4YR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGKEC12020334;
	Mon, 17 Nov 2025 10:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n6kj//
	FP2oQNqcbF7MnJREoh0n2JGnPKWVBAChLv9j4=; b=F/jBD4YRyf/wdIsWnbbvOY
	PNYPmzVsojTPLRKrmdzd4ci/75mro6P0UuaqI3ks/I9/uGLkw61egNSsKvOjpHHl
	RA+UMTWVPg54ijAlbnKxfjnPpJATcJCnhYHWMvGpqPL0pJPY0KwnJxcd76GF4a90
	F9NEwxMT/TV0kxDSsaZeuJIpw+kXZNx7xnuUjotrnahYkAHg+CKkNQqUVVP6tqAN
	a5gGfw+iBF5y9+9lSOTr0JSn7TVr+8GJy7GF2fciQgmMFPb+z2T5I+CvYPZWzEkQ
	YvWMMDal6Z0I7pa1fhdFwLNRuL7PyqPWnYWnosj7+g0Vot+75tjTJ8RPz8r2OohQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjvwjy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:13:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH81hWt005133;
	Mon, 17 Nov 2025 10:13:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bjw4x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:13:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHAD7XK25231990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:13:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F18BF58052;
	Mon, 17 Nov 2025 10:13:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4040C58056;
	Mon, 17 Nov 2025 10:13:05 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 10:13:04 +0000 (GMT)
Message-ID: <12d7e23f-8773-4dcc-8fc9-0155abc5957a@linux.ibm.com>
Date: Mon, 17 Nov 2025 15:43:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5/5] block/blk-rq-qos: cleanup rq_qos_add()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, ming.lei@redhat.com
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-6-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251116041024.120500-6-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691af534 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=kPapzPGjlWR10QuwJpUA:9 a=QEXdDO2ut3YA:10
 a=A3mqa8q7df4A:10 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzpKVjnMKYhWm
 Ac71APl9WuG51M1rJmhbs5K87JOXzzquKpokpKrYSdwPpOplmQ1Zm32Bynv/KEK4v8VAm6KRHo7
 7o8wqftqXR/shx5HOUV8jYUSKFton85+0vD8v8EuAbKPdrkge549SBaWAmWxGo76NKPESDsIlCU
 wcCeSV1DbS8hQMx+BPkxsXethcjY0lv3j98jNTLDu0d+rHVAtfjuBiwNkdQbBv3U9156e0BHgDq
 UY2P7GKCpXI58F59hNzYw9B6ulkwQ35B1a7Jv5+SHPo2gskyLnu0cleNl4OqBXdCQQMP2yld7Es
 rjssXEE1j9Fo/k06pSMM2LAkbesu/vjKP4UjE1in3GfdAl6+Ky0BLLtQZL/lJGISPP72NCh+kaU
 kCyGGaK9TuE5ZAlVJefPrAaDA8LWUw==
X-Proofpoint-GUID: QhYnsx8765lUOjbb7cROYQnrXkeV0Yal
X-Proofpoint-ORIG-GUID: QhYnsx8765lUOjbb7cROYQnrXkeV0Yal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



On 11/16/25 9:40 AM, Yu Kuai wrote:
> Now that there is no caller of rq_qos_add(), remove it, and also rename
> rq_qos_add_freezed() back to rq_qos_add().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
