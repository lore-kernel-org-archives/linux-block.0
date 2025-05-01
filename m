Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AF4690
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746082089; cv=none; b=h83zpWy8f65MToKXtyEleQ8udR9GGZQ0v11SxfqwLHreG5rImQEm2PsiRBuShPDC4aTEdGTrwTY2Kj4P0lJXSc/F5YIc336HaEqQeGUGZJrJuUH/xvrnw1OBVaai8mZdKLJ1crp8xdXPKsMD7me8NMecOau3d1VVKm+likOCBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746082089; c=relaxed/simple;
	bh=l39PSZyMoAZJC2HexpJHpwE1zAC1j2TS2LSfiL8UCxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0/ZSc4BF6Re2a0pdikAA/e3+IhKKgT0376XgkUZZiuwvf8i4HJkXgY8LRWpRKt+YdM7B+rUid3/NCEL0kHN9Am6BYprwHQl01Ipig0ERl1y63IX2gM739kpjcrEjEaVZwSXMuxwn0COw3pCY7klFm7d0POXbAAxhOLJ/T19+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRl9jfyt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRl9jfyt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UL3EFu021986;
	Thu, 1 May 2025 06:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sbjvqn
	Ir3FOysy4vhDayMDUKvEHblP+JR12ylc0pQIo=; b=nRl9jfyt0JeGcU1Zr4KwEe
	S1bhwez8iKCA0LwIF0sy2Y+/xET/jS75jtzDDu5rDAgA00nqII4xa8LVMsC4okrX
	et1FnoWMtIOcAliFneVZzJY8EmAdie48DGusy32rh0KczQZuD+PFUFKV8eEkTpjq
	sEqXKSpK0gijAB75Lxt8jnMrWapT6CXMjtHf8Yjj+xMA3o1uhWKI4SopitaJDAs2
	lZHHqfocIwstYSRdWy+s5j86Z0MzP/9FdAFef6znGLrosCcO43LVW6kxsZkCQ5a1
	IBBjfTR0iK9HrJ0uM07va+gs0nfnHhN/g/ISxYdSGDZIvOCWCPGVW7TfwZcO7r5Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buekhtuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 06:48:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5416bYSY008508;
	Thu, 1 May 2025 06:47:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch3bed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 06:47:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5416lwZF9110166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 06:47:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D260C5805D;
	Thu,  1 May 2025 06:47:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39E0858052;
	Thu,  1 May 2025 06:47:56 +0000 (GMT)
Received: from [9.43.8.50] (unknown [9.43.8.50])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 06:47:55 +0000 (GMT)
Message-ID: <d70c4915-56c2-458f-b4ea-9edeb40754eb@linux.ibm.com>
Date: Thu, 1 May 2025 12:17:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/24] block: look up the elevator type in
 elevator_switch
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-10-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250430043529.1950194-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA0OCBTYWx0ZWRfX4Lv8sTGPfiJO tpRtmdzNXIapehzwImKdYwwutCTH8GQdo90AVWDOasRtxaK/tLe4RsZoVJdaC1dRf2oV+0FuOJK xtkBeoduEdWJWiHn5AxuxMtWlgxcSF6b+PC7HFj8l2qprOMbXBOCgLjJ517xetiOBaQDrKiadsO
 a1vJY2FYAsadXbQ9e0cELD4JhqHChU9sDKP+XRDntdRAKjM44nLcAjg/tSiiMT0UEI2jB5ic5mT TeUsy3sKz7rxPw1tEQqgiCSgH8OkUYCJaBi9pIF0UvxEMaOxoD0QXL57zsdLbyWx1mqOs13EMgT 7XAjVbQGiPSFF6DtwTduueu/iP2rd5kXKUfX7S3yKIJqP/Xq4TqhZgZ9Cp5rYnd5/a1lNbbZpqW
 Swy1RaZere3TIuYywBHnUukQ3/TeHzlQFukVzQCzAzKpM7rA48+XoTlnxMmCj8aTyfEfLTK8
X-Authority-Analysis: v=2.4 cv=Io0ecK/g c=1 sm=1 tr=0 ts=68131920 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=8uDfyGt4XYERhb7PZvQA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=oOt8LVSLndi7zlzjSLJE:22
X-Proofpoint-ORIG-GUID: _E6L8RD_oCVdS6Kr84ZDaoOiLyUHI39S
X-Proofpoint-GUID: _E6L8RD_oCVdS6Kr84ZDaoOiLyUHI39S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=0 mlxlogscore=607
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505010048



On 4/30/25 10:05 AM, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> That makes the function nicely self-contained and can be used
> to avoid code duplication.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
