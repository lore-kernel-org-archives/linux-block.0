Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD941FC8
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103349; cv=none; b=tTj9UmWRAkTveDJItUK02HRlmyFoXteunpLTFegu30iCFp62RuBqtzBR7MaklqjZFi2aVl3oP+Umb/vgKRTy5LDY516uSKkuQBZEHlJabthT5iNw6A+b5ZfE0VEIc5UP4zMpBFNvCSlJYQ55f4sLdK846UlFg27vNE9Hs/Xujuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103349; c=relaxed/simple;
	bh=GeQKfQZVyQPIOPYfGfAJScT4kqDBjZBS9GTs2RXHmAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+0hCOXLPNfm174x2zQ9Ypfpf+/HCV015X0NlRuCgPqsDVUNxjaQToKEoSJaxEAqhcHLhrSt+YYyj7jF1RL37Rnqx04L82LJC2wLEuZoaQTZEfHnq+BJazi5+hT3IVaz4ugSSnRSgRYzqL0flq2Nfx/fMjhyYe7isPK2+Y5im+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k3Zf7wcR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3Zf7wcR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554LJwTb027915;
	Thu, 5 Jun 2025 06:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0lVG56
	rLv9YGbmbGTggV+VnJFp/V43uWfBI9y/eAhqM=; b=k3Zf7wcRMiNcrr/Rn9Dgu4
	OZg9D1Za9zcMFfxN57CHn3+ZZ82jk56KNchGin/3GBRH1XphYIeY/EvHi9V8fU3f
	OWem+rJbSS9fzFnx6fz9qyGQo7olwZKaTSiw3KNchOxbtZQ7q4s0WcHGe1iuMUo4
	ssndJsZCn5DY9Buwsm1qdsCrCYQHRLA8/pM+oxcAbJL8YHE9FqHdq8Bve8996StZ
	Cwu2jx2nDTfnPMhijInw1diSIs1715e2jSizBtlr/9jj74CYLFhnJ2LE/1ec+hWr
	6ZA0+F4s+YM01ZScENR3zARDD3GH5itVec/hcQx8v7Rw0aMZ0FwHfR6bknfwdnKg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyexnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 06:02:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5554cfJi024899;
	Thu, 5 Jun 2025 06:02:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmk9ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 06:02:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55562CBa31982130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Jun 2025 06:02:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 618E458059;
	Thu,  5 Jun 2025 06:02:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3FFB5804B;
	Thu,  5 Jun 2025 06:02:09 +0000 (GMT)
Received: from [9.109.198.212] (unknown [9.109.198.212])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Jun 2025 06:02:09 +0000 (GMT)
Message-ID: <38ef98c2-0803-4f1b-af62-55d91bd54b38@linux.ibm.com>
Date: Thu, 5 Jun 2025 11:32:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: fix lock dependency between percpu alloc lock
 and elevator lock
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250528123638.1029700-1-nilay@linux.ibm.com>
 <aD60SF6QGMSPykq-@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aD60SF6QGMSPykq-@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=684132e6 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=anRjEHdlgnGowwTb73EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4MAznGqqVPjyihL0RgpsXNg4dJXzN2Vk
X-Proofpoint-ORIG-GUID: 4MAznGqqVPjyihL0RgpsXNg4dJXzN2Vk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA1MiBTYWx0ZWRfXyJcUm965tCJq D69IVwVYFsEupfkWo74qywizMjhGVmWv1lGJOG5jewMAzTb98H70IzpQt1d4O4Kd9QIoEmtgaq3 BDNeREFMX1IfuVvimtXOdM3tVh+vVH6+aRZwOWBkDBZSE1wCB0k7FJJgvoi+3t5zFF1OO0COm1k
 Txmbbd81JFpjdTzDENQpIGOsYDY/NSFsXVgdq4uhj1KH9ymXxUXN4jjXK6+yEaF1QbCeNykNqm6 yApQ0mfGpufHbEayX7QkQIJpIcJwT9e4x0+GpFlWW+6+B/EjyeCNAT+iPYuAz3TEN5MckQykx18 72DQdC5/QvArc7YckdhfntLg6h07g3d48d+76lsNLcb84jSIz5ZwXqTMczylGCsoO7Ug8JFBpM0
 yQfioqRV2FnAiIVLyKVl9Hl/C4SQ31qVmgoo7EZeweuqQgvvA1tpk/JeKvtT2DC9b5MQLt9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=893 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050052


Missed to respond to one of your comments in my previous response.

On 6/3/25 2:07 PM, Ming Lei wrote:
  
>> -static struct elevator_type *elevator_find_get(const char *name)
>> +struct elevator_type *elevator_find_get(const char *name)
>>  {
>>  	struct elevator_type *e;
>>  
>> @@ -128,6 +117,7 @@ static struct elevator_type *elevator_find_get(const char *name)
>>  	spin_unlock(&elv_list_lock);
>>  	return e;
>>  }
>> +EXPORT_SYMBOL(elevator_find_get);
> 
> `elevator_find_get()` is block core internal helper, why do you export it?
> 
Yes we don't need to. My bad, we just need to make it non static so
that it could be invoked from other file. I will fix this in next patch.

Thanks,
--Nilay
