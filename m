Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD327E05A
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068427; cv=none; b=AhY1ih1nHM5V48s389jaknQxbLsFsoHA0DH3TPG59zS/sFdeTlSNDNivBv3FY6PlLYK7CifH3QX3AQ3KKISQFigBH0SuzdiwO/8Uw10kjCd4hwOFal0skkJkuSHh9AwUKYnrt1gDZHSwAk8oG42frZ6PYcRrlWp9xONMXl955WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068427; c=relaxed/simple;
	bh=HH34eaWUr4zzJ1h6b+n9mtTTIkZXOoTQPrOmQlKSIpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JGkCZxswYGotfpX5rrJW4H77URbrK+c+2VW8eyd3UPN+3Po4Vbel6xMe3ckM7WOZyw9mTWBiXLfdJiJpcj5+B8wX6IZnm3YJEPxLC5wIkD54FWYYUesjjty1ORpvZ0PAghkUXVu8dSv0CK9BPOE/9ComAFgEiqCQ7tfxRvE1y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TwMDPS8R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TwMDPS8R"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI50hcx012679;
	Thu, 18 Dec 2025 14:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w/ymKB
	GkzlGHiF80IBkRMQZtraZIxUfesa466tA73Aw=; b=TwMDPS8RU/qNVeUJ6k2g45
	LTEWfCT2r04jiuhn2KwSbrkXt8nOsphY++0NYztjSWKB8/feTzMZFQjNCooMJKw3
	8YN2aYeBzshELf12FDfuMINPpNl9RAbeIxPGTFestTAd7XbK7tL5nOUcKhzE511V
	FVw8Ix17UkB2JRd1sbEjCtRltsqMdPLzsQOiEhXxmrPonWJaAt7voXYuoTM9AJRx
	lbCa5dKu/O4tOMVVKOpiPA8R36UfJmiyKwL4TBPY0iys93C/sn5eyBj60g5n6NUL
	OtqUwY5Vh5PsbpGuaUdGmi4+GfiLNvul7jayGiQC7IHX4XWeW0GuynFUghbhoLow
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8u6n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:33:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIDfTc2026753;
	Thu, 18 Dec 2025 14:33:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfss3wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:33:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIEXUfJ29557446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 14:33:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2CDA5805D;
	Thu, 18 Dec 2025 14:33:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 823E258052;
	Thu, 18 Dec 2025 14:33:27 +0000 (GMT)
Received: from [9.111.59.18] (unknown [9.111.59.18])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 14:33:27 +0000 (GMT)
Message-ID: <6a72b97f-aa13-4a6e-b165-57faa56597fa@linux.ibm.com>
Date: Thu, 18 Dec 2025 20:03:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] blk-rq-qos: fix possible debugfs_mutex deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-5-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251214101409.1723751-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX16YAIuFqb+Er
 VhnORrENPD7FQESqmUtk8GpA3kAZgwD5vSZf8V9oAv0e6MfrlsL58a6LCcuKVY0zkWxon3arkwR
 HCHCEDVcMC2LRG3Uo+wc5KEipkYBsUgKjTeXJKa+7m1erOxmsSej3Jzo1BKb/gaTEYE8egdXqYD
 kITVAPY8V2C1mrlWoqd47Rbp7Df9l4pLBh9xsOjuHz2VGIEVjtqyBI0sWk0kpdBKu8kpB/HhVbs
 DOl6wvNlfVEIQuYou5sp3OltRSFeeTInRbHUeeVRgGCiWeIvr4f8iJDu96nu06ITO/A0x4jZm/m
 Ssqs2nKbMSYX9pcbvJ6M9vhN5/FqDRuD4ffBaCfDd/dCOjzCzB5p7LxoEL/zIPdlQs4UH4mrDw/
 yBUktGP7Dm9qowcDGirOQL4Rwiawnw==
X-Proofpoint-GUID: NUyVjyM5LdI_TN3m5n6QN-LQfhih1ZNj
X-Proofpoint-ORIG-GUID: NUyVjyM5LdI_TN3m5n6QN-LQfhih1ZNj
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=694410bc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=rTDWk-x5bkgnBn-qG3IA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018



On 12/14/25 3:43 PM, Yu Kuai wrote:
> Currently rq-qos debugfs entries are created from rq_qos_add(), while
> rq_qos_add() can be called while queue is still frozen. This can
> deadlock because creating new entries can trigger fs reclaim.
> 
> Fix this problem by delaying creating rq-qos debugfs entries after queue
> is unfrozen.
> 
> - For wbt, 1) it can be initialized by default, fix it by calling new
>   helper after wbt_init() from wbt_enable_default; 2) it can be
>   initialized by sysfs, fix it by calling new helper after queue is
>   unfrozen from queue_wb_lat_store().
> - For iocost and iolatency, they can only be initialized by blkcg
>   configuration, however, they don't have debugfs entries for now, hence
>   they are not handled yet.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
