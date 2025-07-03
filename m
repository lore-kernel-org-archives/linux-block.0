Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18372EF67F
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554480; cv=none; b=bZDxyKkEP5uCslgyS1b5x1g7m+c1jC8QyD7OPNmczhUz9UKhOYvH6MfTjKuQaK8lTB8bB8wOaKhRvMPxVwTrR82DN0SxKZ0ppX6HZdYq7ixOL/kC4Cf1Q0Hiy66KsBjala7BbDCOVh5uLTWSiyKg2E5xIPWfXW8O4ywmgFe9A68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554480; c=relaxed/simple;
	bh=RoH5FPBfNY5kOVrjdtcmJjb/6bRPe9fE/HoaKAzaHa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwcFdWPKjUJGlmP3t7A92sG28oOVoD2fucc6bJysBWORkbSADidGHRKKwQW9pEJ/qoO1XDrxsu1kmXzRhR84EFgXF/XPCcP+XrK7cCnQES7qXl7f0zl9pRXrNmipA+0Mk4Z87LyulOc9Xno4c3sNoacmv9pwG+DjfMw3/3c3oEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=re4xtsTg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="re4xtsTg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5636oLOc006903;
	Thu, 3 Jul 2025 14:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RoH5FP
	BfNY5kOVrjdtcmJjb/6bRPe9fE/HoaKAzaHa4=; b=re4xtsTgf2k+2jUWDo7YV0
	rmyKjjL8mGGNkHYCzJf1w3W8ZstRtMvQBjDgKZVK6oBU08Q729UEzAVgjCeMB/dW
	pvkif0GhVr1qUDeB6nm3SqxotRx9d3tn97HhqTYliihHZcKIzcRx98zQtvXqMI13
	9egLI73xRqpN1Yc8Axa9TzWNcw44j0IjkggRpKE2mLG/21RoCZwa93XoUyU47sSB
	HL2TaOgrvK8OtfTsJNqaA0ZK3dSuUX0ne2/DsGKTx0ChPVyqByQrndtouTgKQBF5
	7a7k6hFVaMjS+oTiTUsuu+dA1nH36EhpVdnHZ5eqVayt+lFK8xb3PevrQwGSk2hw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u246x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:54:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563EXgiO006841;
	Thu, 3 Jul 2025 14:54:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmn8g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:54:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563EsQSk25690824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 14:54:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28CCE5805B;
	Thu,  3 Jul 2025 14:54:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89CCB5804B;
	Thu,  3 Jul 2025 14:54:24 +0000 (GMT)
Received: from [9.61.113.48] (unknown [9.61.113.48])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 14:54:24 +0000 (GMT)
Message-ID: <7ab65e37-c226-4db5-8138-1db1f0c1c861@linux.ibm.com>
Date: Thu, 3 Jul 2025 20:24:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: Restrict the duration of sysfs attribute
 changes
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250702182430.3764163-3-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250702182430.3764163-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uCTSakXmrr5D5iDCnFJTQtfw3yaSgeny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEyNSBTYWx0ZWRfX0wPTbRivyWHj hZSP3bvlMvgh2Nkpa3cOqP6Ba6TfwsbVxy46bWmlFZt64NftNGB2QO97NFe1+Lq4DNOs2xJ2HVX 25DE4EYtsJJOpI4eJvn9C1AS9aCD4lBJyJ3mOLSokOH7/4k1wlTJ5eufcoZC1sXfUJmcLpyRWvn
 pHerWUBUZopovJlMdNYVJY0NDcHJzPumTPxMEINQ70f7F57Ff5YD1CghC5AlDQ2YuDaLqq2CVUh H6p2WFrrxe4+qOHXbqtgOkhl5MeTcWq6cz25KuXlSzxpEidhl+Bldy9r4tR5H5LGgg82ZSSzp2M eoDUvIj2lQjr5ioHE73Y+lyeWi0hn4lbNFyTalsGUZSNNqscpW0Fr7ZnLsAMF+iYnJ50XukiHyj
 lJXnNUCtqICZRF6rv1/u5pxvHEBuYUT03BW6nSAMYPO4vMFQTCdVgtESxJKz8tE69KKUcuW3
X-Proofpoint-GUID: uCTSakXmrr5D5iDCnFJTQtfw3yaSgeny
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=686699a3 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=MTV04HYMyJ8qHcmmLUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030125



On 7/2/25 11:54 PM, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Fix this by restricting how long to wait until
> the queue is frozen inside the remaining sysfs callback methods that
> freeze the request queue.

I think we should explicitly list the attribute names that are affected by
this change. Also, it would help clarify which sysfs store callbacks are
impacted.

Thanks,
--Nilay

