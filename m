Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D44334C0A
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068103; cv=none; b=YVw0NsW6TGiQdWbUEHSJ6D8wwo20SPG7JnaN/i7b/gXULQb30armawXDHRjGy9w+1Bs5yA3nn/eTNz8nLs73SgI8WIuBHANiUQq+tQbmRbcVMDCQYnvRM39KYD17GSNLXwlRlalxjLVbU2NOC8s40WgV1OJpVyT8bYrEAJN//Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068103; c=relaxed/simple;
	bh=okCKJH6FTI7y1iwSprDxaVelU1RYUbX1YQD4PZ2wdBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zbr0IWZD+uK+g42iFMciufD49PqJas/HsNkVQ/6oyoPHBJbzmCRKFl5gnXqzMAt/dRnuz2j7YJDq/pd2S6Vr52zO90EEnO8RNCUWlbmjgSiHVHHzCPTRqoXqkfWs1JimkidFsqRV1YugsM7hNK409Y0N8YjjpvQqkfJCbh2IO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HblaoGC5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HblaoGC5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BID1bdn011526;
	Thu, 18 Dec 2025 14:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MPfRKH
	OzILJ/T8Jd2M2ydF3HphNJwvFLkmZzxcbLKN4=; b=HblaoGC52QRqBc80hLI4PZ
	gvgvGq3ZzQOmQ5FvzMTowh/byxlkCu5JHHAehr4K0Vm07EEtqNYClPAh7l782SVn
	GXX8fhnFcJaKj8Gf8jzGRxhJnavYhyGt30K7+/oOLqwKpUn1vbxHEhodiQrw9lCE
	lxJZGsvH5iAc6dw/8/eHcVVn+xOKZJZtEE3i0aISIsyHwMInK3vyqeCE2x5PIaN5
	1lsarROXO9ytd4vc3/xeNguf+ul3tT82JJXT9xMxZzoWX5NHVbgeiar8A9syrNSj
	5DC3lGWa8CC/IFvNovqMG1g5tW/Q3JR/fAjWTgWpll+5+MEmIyOPZZs0/0//YEGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8u5r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:28:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIBAuOO002863;
	Thu, 18 Dec 2025 14:28:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfngs4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:28:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIES8X258720578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 14:28:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7A258052;
	Thu, 18 Dec 2025 14:28:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99F4C58056;
	Thu, 18 Dec 2025 14:28:05 +0000 (GMT)
Received: from [9.111.59.18] (unknown [9.111.59.18])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 14:28:05 +0000 (GMT)
Message-ID: <6cbfa0b0-e556-44a6-b18a-619fa0cfaeb8@linux.ibm.com>
Date: Thu, 18 Dec 2025 19:58:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/13] blk-mq-debugfs: factor out a helper to register
 debugfs for all rq_qos
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-4-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251214101409.1723751-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX7p6UydAPkCg+
 iN2JpaFI2cLBjfAkmdnip2KZhN3FdDYyolEci2qUJhhSTqnY691kQcGEFFycyJc0Wj49DBv/yLg
 JgPuQrl0DgyxkF7OPSdsC72eRGSgP3Wht4V555HQ+IpV2aeHt8LTlkDV1kKsZUnqZgfyczH4bbb
 kKSp8Kmj/Ry/TDJQiMzltN/j4uP+s2p91BbeNJqf65KNBFZDaNHot0YRIPKpd2mN7ShQMYdMqCR
 qHBGWA6Py/O0/ZHFcaSOOrHrg66bH7kRLHpjiiIQX2b4cWQI9m2RP6TXRfB5IBzTL8AdihHOutb
 GsSbXzMN6de0bt9lrAprN/HgLcWvXizOtbAa+oRtUTpB/Xg68AEaJOQksMkKVE5OVgUBJ9kMD/J
 xll+T+MZPFI6TZN/hId0GeXnhINw3A==
X-Proofpoint-GUID: uD5z3pNYJOtRrAsd69fFZQ2n26Y0BIFr
X-Proofpoint-ORIG-GUID: uD5z3pNYJOtRrAsd69fFZQ2n26Y0BIFr
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69440f7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=AJc7nIEB-FM70Pyo:21 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8
 a=wyYLQWUfLxWmFtnzBUgA:9 a=QEXdDO2ut3YA:10 a=H0xsmVfZzgdqH4_HIfU3:22
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
> There is already a helper blk_mq_debugfs_register_rqos() to register
> one rqos, however this helper is called synchronously when the rqos is
> created with queue frozen.
> 
> Prepare to fix possible deadlock to create blk-mq debugfs entries while
> queue is still frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
