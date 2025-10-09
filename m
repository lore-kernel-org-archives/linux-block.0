Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EB2C21F1;
	Thu,  9 Oct 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008828; cv=none; b=eUlMN1bh0BUwzQ9JL5o3YNrTyb64xK+BdvCJO4d6Dusa2dTzPenQohvIIpG4xnwudJVsdSlQC1dt0VClKc7xvKpFp5mije58Nv9UwRcNnmmeSOroK8d2EK2VjuQsBvRoL1x4KsCA5xqfrlteNuvPyBvluey5h01EJuZ1HoZlXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008828; c=relaxed/simple;
	bh=QjcEKf99YwFjnzXuDCEeH98lWD1QPHRc5zZlVu3YH34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgNcjiLOp9fRe18q6V6F5gt4P5ReGlRejQpASyMkQfIdYaW53Mde7aXRVW3bbjkwMIno8OEyr3ufGWb4UbVdS4qIhTcCzMQnOYc/6iBEsscn/2AwtjwAPCpj7XeL033lfg6/2lxoNEsQHSoC1ZidfSbJFRehwZF5rBLP7vV71qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LzBCUEyg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LzBCUEyg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5993GvX1002693;
	Thu, 9 Oct 2025 11:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oSyewR
	1O86+iaGQRpRAhZnh2rN7TGtmaoIS6vlfie/8=; b=LzBCUEygy0jERqJm6s5HZB
	5GaaPnjnepPcT6J6Nih7su9AnJd9BoyeEB/xOjRV3yDyYZDHEuXbBDNI1pm7WIVy
	RZ/63cLpQRqsm0k/e0khIixj/z9TM1oTUYeeJIeULsXzEGr32vOJcjzwfkfaZsKY
	6Uwc7Soekl3VIJaNm/dbeT3hbHbunVI2YuvD2q4TNAj5iG8RdvUCwNQjADu8L/1l
	kixdPuSOtjxOtb/saXuIX0Ex9Yc+hIjArm0wsypC9XfnWP/FAxrwoPFY4bosHUkf
	0hKcE64h0IPFFtRixIgMRf9u2UhAhkRHGzRvwhj5xzVGywAZGeX1naXDEnZfGpsg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv86vawq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:20:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998LJm3020997;
	Thu, 9 Oct 2025 11:20:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9mv7dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:20:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599BK96D22217458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 11:20:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 199A158055;
	Thu,  9 Oct 2025 11:20:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F22E658043;
	Thu,  9 Oct 2025 11:20:05 +0000 (GMT)
Received: from [9.109.198.200] (unknown [9.109.198.200])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 11:20:05 +0000 (GMT)
Message-ID: <a79cb3bf-d9e4-4c29-85f8-e7bfc504b190@linux.ibm.com>
Date: Thu, 9 Oct 2025 16:50:04 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 3/7] blk-mq: add a new queue sysfs attribute
 async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251009074634.527661-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3tSKUwcYMoDv2i0tC-7RPFnCX42ydJgl
X-Proofpoint-ORIG-GUID: 3tSKUwcYMoDv2i0tC-7RPFnCX42ydJgl
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=68e79a6a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=DGc0GZ7HoTz3mdxrIMAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwNyuhdlbddr8
 /FG8OzwqNwedSBHu4YbDjLN1vzxIIZ/BOwm2OfenPOaAsPLjYbov7RkWv9q2z7bjQb1FVKNpY0q
 OAynECB4KjVWjrgWmpu4tSrBWIoSPBLCxgAL4SLgqu5PjE8Mv4SMJSDTBOgPyNlVAoc8m8/JeRB
 Lbz5v2NHcuHLcqcdd3fN8PMiFYOiwN2gJ08vKdb39m/xW3xM84gOYSA6eFv2/0soUScivDdtLmv
 ZyQtCdatFQwdicsUuoszJCiWDo2TdfXUjnlFELu3eybOV7PA662tL41a5OKfN/hoZ7CGS2oj+rU
 tustneQ0Utvg+5T+Lmrm3yDMPlTgwzOmG1PPmo3lIsdULN3fWyPBIQ6Pb5hCDr78a3aKnJchWiX
 T52gJpKnqLo/fY35s0no8GPL5/nTsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121



On 10/9/25 1:16 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Add a new field async_depth to request_queue and related APIs, this is
> currently not used, following patches will convert elevators to use
> this instead of internal async_depth.
> 
> Also factor out a helper blk_mq_limit_depth() to make code cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
