Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AB12FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544771; cv=none; b=V2A+NiKzsBHZzOUI4piwk3aRvmxUV1y0wlfSZsqvJ5OsV9wyjb/URX7ggCYkU+sZBYl5elz8ZBrXSh8KzL2Hnuf8qcwwvrxFDAdyRKM2fUsbzISJ7ZULvGHqhvrE+K840PYR5hY9LPDoUxjyadEE6ooUprao5haBTJ/GmAspjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544771; c=relaxed/simple;
	bh=EYwiwJFpL8FOeKXALGjilZqBcVHRWpQKc47b5AbIyzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B487gr5BiqkX90o9IgtV1w0I/VjG/LZmSuA42d1pXFQx0mILOdYmaGfXaKMvKMZfuoA9Z46xB6D63q9Cfn+xSM1fIcDYdJvChksIzuOTiDw6ZOAeaX/fAe7TEC4q2kLbx543nHJRUqVJRcTuW8d9UUYlOpcWYzsYoMydiZHzBUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iz3Q4eVY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iz3Q4eVY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 603NTfHp002328;
	Sun, 4 Jan 2026 16:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kLrcGn
	SLP58OQOeDmLvU+XgqzlTAVIQtB+cFdzo/MO8=; b=Iz3Q4eVYbeRm7L8m6bntwA
	c3rMFXuPBFrqqbClQ9Epq2cIJf62+JK50kQKstX0NR54sEbGlzmk+VIkLt3UiD7J
	zMGERw8IyX3Ry623KxLYLdrqM/NQAwl4OAs1+/UqwwdODGBO5jt3ji5PZnaKs+uU
	15vHDTEoYJcTbdxZ+J1gS4Q7GVzXZfihAuPLuRmAlW8eDpOw9gu39Kj7bU7ZZ+91
	PzZAXc3QhgwpujYLlN/HA2Mdvcem6S2SYqPRf6NEqUOV1zs2YuEeWU4LttbDROMy
	nz0dx1x33WfaQY/KNiVoIl4QdyC2MYqwOPBvk38+05xigEJuVuolHjizig6KAXrw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshektdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:39:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604DjcJk029699;
	Sun, 4 Jan 2026 16:39:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfdtxj65x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:39:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GdEZZ32244444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:39:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D14558053;
	Sun,  4 Jan 2026 16:39:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E675758059;
	Sun,  4 Jan 2026 16:39:11 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:39:11 +0000 (GMT)
Message-ID: <edd8ed81-ff0d-45af-834b-681c12ec76a9@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:09:09 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/16] block/blk-rq-qos: add a new helper
 rq_qos_add_frozen()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-11-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-11-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfXwUPOkOBu6tmt
 qn6B9XZhEvdzijymt2XhhVL57lJn3bc3ViwJAHEgZih8PICZ6NLEPjY2xo7dcR6tF45tMiOp0iw
 fUd92r80dwa59/zjdYWEXF4AEJf92MNJxLyfgBbebU/FIpEE79O4ldncBWwtlngYefd2vJ4Wusg
 0UEYraDqjj/OTobLOtrpPV87Orn782SUy9x4utXy67sii8F2skj4l69hxDlkin9sj9fMKr0xpV4
 c+4hMfh+4SCUpnTOMFc698DbV3zm+QUSaQQdHNPfZ2zYTKGMvLqEFoFb1jcDAXA9qAWP6TSMtPf
 Hws7PGXKkI7yqyW0zpUlq5gw/qiQgMmHUMhaHfhb8oJ6kQReF9m891yTZiHPLxSZz3I+1/vm+xF
 iW3IKt0xXqaXVuZmUiBCs9kyitWKzq6qUsmGsPndHtilP+X9Q033bETjtnrqlUWCYtFMi3HOsQL
 HysQCHG6BF8znJRqkRg==
X-Proofpoint-GUID: HsAcpspVS5jSDwW_v6c5LR8PgfnECv_2
X-Proofpoint-ORIG-GUID: HsAcpspVS5jSDwW_v6c5LR8PgfnECv_2
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695a97b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=agwegPMbBInk--NRaOkA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> queue should not be frozen under rq_qos_mutex, see example from
> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
> parameters"), which means current implementation of rq_qos_add() is
> problematic. Add a new helper and prepare to fix this problem in
> following patches.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
