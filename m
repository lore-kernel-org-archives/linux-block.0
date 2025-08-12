Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C22D0298
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007391; cv=none; b=vEg+kNvnDe7O18Z/37KqRio8woyv7nmuKVGoyODGVcT+c+wZUpvBp5Xl2FFCkJybPBo/vuXeftRX8o67X3wBhh4LjP6dLryAHodrKDr2TMA1o866jZLAe5lywAzHvRqLFlbL9Udol7/crW+jDB37AaEn67efQmyFJO1mtZQr7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007391; c=relaxed/simple;
	bh=okMYGIyk1uy3eY+X3GHUmlzCNz4jAtP/x8RrEzKldpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhVDmpYGISpt5X46odt5q253ROYlYSpW9kzIFrZeIS7V0cGAf/+VeHeLuzCEf/5gA/GiHoEBStC3Oh8rd3zopc7kc0yE16inFYX+qvuJzRUSGc0AlcPORxwynZVxczIwfnZ5ra4mt+yQZ+xKat9iGuHpirKymFgv7Uj+y8Qi44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9ubBJTb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9ubBJTb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C8ZB2H025025;
	Tue, 12 Aug 2025 14:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f9ZTxx
	o8r/9khmrNuycenVCvO/+7oHR8/ToiDM6gNPM=; b=K9ubBJTbEc8cw5Z0WZz2bO
	+e0DARuJQJz5ehTmO+1pBNdDCpNNZ0FfGu5ofWV2HzxUu6F71r0khlOG3Cmowciv
	KEUDp59l8EdOsyi8yUEgbKy4yTwnWsqb27Mboo+Ahz4BavhaPB8K6EZFvJmNduEt
	M+drKEpgfK3xBe8aeG5MNvEO5nnEYtNbQIG4w9PF0+K1/nUVSNSG6k59RM81qLmb
	uOZ0w7yq/zorGbHcxwGdn79W+xcdV/vOTpNBelfMsdn0TRI11qx5Mwy4glQ3QfR4
	QXCZQT+txrLb1QYCjAhCjCmaufn61HI9hsqwGulfb3IXbUhCJRvDrdmjVMXC+X7A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14er90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:02:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57CDo3QD011903;
	Tue, 12 Aug 2025 14:02:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14er8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:02:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDU8Sd026275;
	Tue, 12 Aug 2025 14:02:44 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh212svn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:02:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CE2hpQ20120094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 14:02:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1BCD58056;
	Tue, 12 Aug 2025 14:02:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A71C5803F;
	Tue, 12 Aug 2025 14:02:41 +0000 (GMT)
Received: from [9.61.161.148] (unknown [9.61.161.148])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 14:02:41 +0000 (GMT)
Message-ID: <dc5051ad-bf11-4975-a9e5-295cb4a1f627@linux.ibm.com>
Date: Tue, 12 Aug 2025 19:32:39 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix wbt can not be enabled.
To: Julian Sun <sunjunchao2870@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com,
        Julian Sun <sunjunchao@bytedance.com>
References: <20250812114333.1252987-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250812114333.1252987-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E_rv6Dnzty3LyYJQfWEPfJBiXHPWf9Q4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzMyBTYWx0ZWRfXxq6iW2IcWCdC
 OENPJt2yJrJXPl83f2DTWA7Z72HOxSi9UcwXSVDYfDSgW6J5FmxyENBtHbGdMn6Isj8HYZV4Ln8
 w2oqyKyYAmx99YH1h+e5URq335FC6yW03CLKi8vyepkAv94YTaPW8+GenVoKD/ffRuyJdAIwAMK
 0rJhPwTBJ+vlbqFtWm0aYH1l0lxWW8x+g6MzEsQ4nBTUqZfLmKFX7GGDCeZL3dt9NsOTjjNK8ni
 rekldeH+dWFijX09eA4mSbfHsEabZ19tw+zB6Aqdu0uzfrGNZ5tW43kDKOmZIhcs1V6Bu6yCE5F
 iPWsg+i1c6b+EFaV8JmyZvvi874GCIOo96duCCRcaUTbX8PPamEfE4OpTA+fK4bE68Fw0DL0tV/
 tol/ExBodTQBqpe0mFN2/8VMTy/DpgD0s00WKACBcah0F4zZd7HcDRdXjTbBFCQ9au4NlRB8
X-Proofpoint-GUID: aPhRBmR-2YwKBQY6IOAcCBnjLyNX_6zy
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689b4986 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=968KyxNXAAAA:8 a=8oJvsXycyqwgdLAS3wgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120133



On 8/12/25 5:13 PM, Julian Sun wrote:
> The commit 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
> protected wbt_enable_default() with q->elevator_lock; however, it
> also placed wbt_enable_default() before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);,
> resulting in wbt failing to be enabled.
> 
> Moreover, the protection of wbt_enable_default() by q->elevator_lock was
> removed in commit 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()"),
> so we can directly fix this issue by placing wbt_enable_default()
> after blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.
> 
> Additionally, this issue also causes the inability to read the
> wbt_lat_usec file, and the scenario is as follows:
> 
> root@q:/sys/block/sda/queue# cat wbt_lat_usec
> cat: wbt_lat_usec: Invalid argument
> 
> root@q:/data00/sjc/linux# ls /sys/kernel/debug/block/sda/rqos
> ls: cannot access '/sys/kernel/debug/block/sda/rqos': No such file or directory
> 
> root@q:/data00/sjc/linux# find /sys -name wbt
> /sys/kernel/debug/tracing/events/wbt
> 
> After testing with this patch, wbt can be enabled normally.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

I think you need to wrap the commit description so that it doesn't
cross over 72 lines. I see there are few overly long lines in the 
commit. Also you should consider adding fixes tag in the commit 
so that it could be backported to stable kernels. 

I'd also suggest to update the commit header as follows:
block: restore default wbt enablement

Otherwise changes look good to me.

Thanks,
--Nilay
