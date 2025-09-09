Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9F285C9F;
	Tue,  9 Sep 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421330; cv=none; b=CE+EDTJEV+3KiWoRWOdmTcpF0ncmlTDyJEeUUgz348qOW7H/jb6vQNLMcoUasYUl9x6lmZJ8tQJM92nnwXz1WeKZiqssNnrhiIxO+453IzleFENaz+nvxkBIkkDlL3twPA8HnKMbFo95lKED2l4svK92xiUYd8AUZBrypIap218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421330; c=relaxed/simple;
	bh=HMOJgDmzbklbWB34lpWhrZmvzVhTyGV59YpwlqeGk9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILeKahqKha2ejCskE1n6+ptx8N/ohrBe/9vkUZkytFDl31nEZyH0yd5qrneD+mw05SAxl3WwbLEYbanbzY3pEqFl0TQ7ybzTJZtI0qXgJCegIWNQvIjmx7tepstufSeRCq2abEAtB0l/Byh7Bw9yqwDydgyGj9rDG6D5u/4Nb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PfYYnW8l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PfYYnW8l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897q4Kk004056;
	Tue, 9 Sep 2025 12:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eJjoaU
	Wz6/8jNYwUyJDPayIHu7u/nwMi7eI79sZP+9U=; b=PfYYnW8l4Rra4CTH1Ahp98
	VpNeUQZLPrWioYLY+qxdGbeUf99dRV2xgb/xPl5ChDrEGA2eScOkqaNMXwKDcR+y
	ZPjwp9tQ/vKCGgcQLxuCAsCcVJC4kIVpFcW6u32PPKQ25W4b6NizoyO7V4DK2dra
	IpkgHMw5evr9VM7pT57uae0EsGyEHyfmvn1INtw8uht/meyaeC1seztBsYfwnXMn
	+I5HYUR/GmjisxZ8Ms6aKZH5huZ9lqgxqZBNhmlp+3pcEFvQ4QR4zxm0BRvBZPfm
	vbPx8ZMwgSdq9BmRcQoxnVaKUivzr2tJlO1HDHJMGQhNvbHrrwtu/VwS4E4DeFjw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff7s1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:35:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899AV2x020499;
	Tue, 9 Sep 2025 12:35:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0u7xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:35:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589CZHnn31392348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 12:35:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FDDB58059;
	Tue,  9 Sep 2025 12:35:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88DFF58057;
	Tue,  9 Sep 2025 12:35:13 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 12:35:13 +0000 (GMT)
Message-ID: <b516e882-d427-4acb-b6a8-b3f011eef311@linux.ibm.com>
Date: Tue, 9 Sep 2025 18:05:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 10/10] blk-mq: fix stale nr_requests
 documentation
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-11-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-11-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QrpXw5FqOeCpI7ODN7Gzkj10RgZqnlUU
X-Proofpoint-GUID: QrpXw5FqOeCpI7ODN7Gzkj10RgZqnlUU
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c01f07 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=tYaLi_SPQAiz_1EOLDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX4Fw3GitvJxkP
 /+KoF+9VXnKkjvvqM09Zch8La4MPAcTjIhcplZscSpd26rcfMKUXVwMmcZP45Pctr9S15U/nPH+
 xedS+NaCPT7AKk5VLsmH9vojyBzKyx3H4Tt2IypINXkEO07vawIP8a1UnVOjyip34z9G8IqMPa9
 mDmqgKGW+s2/85fV1TeM3fEenGg0Fnq6VpAWtEjpRodimOD2raZM3h/7U8JuDRwZkzoHqAMrwDA
 Y0apZIXUJ+qniG21bYuciNpKzqpb7CwgOODu+Eer8aTpRZD6JPl2mww4GsjeBIghxkSuwm3boe9
 zH0BVgQ0dveoNqmz2zJQhPoNTOY5uqtWUZc1QzizT4qAev7zZE4IKmoVe1xo48XLaKv74gEiaLY
 JLHH1yqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The nr_requests documentation is still the removed single queue, remove
> it and update to current blk-mq.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
