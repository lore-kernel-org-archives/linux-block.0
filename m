Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB22DA762;
	Thu,  9 Oct 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008970; cv=none; b=lBrRtprBmso/kYEpfIG4c3H2+pS+/Q/0Uzlno6oZxq8O/296p7F+0pPOqpVneAt/3xxGgeTUIZ5vnT7MUg3WmdVxWfDDPTB2fsb5qvdsUS6tgkzSWUSUFfg3BG0le/IUREK8c9BTEDEmbiDc6zz7xQsHCV8YAHXMH037fX+IqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008970; c=relaxed/simple;
	bh=zn4LqYT9GURWSLIEhN4idUv/jlT7jQyS84QdblaDewM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evHhkd39t/Lkohn+JiQ2gIMm94DgDbSf76fqVi0tsGPEupeYzlUtDA++jkoybyHDeYMdIZJu0l4D+VFjK28Ywy9aoVcz7qE4Gn2i0FTyNALl7841lWS64c/tKQfs9MVcoFjYFREluMnRQa3mk0k28jsMg5tk3vJqjQsavQg1kiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsD8iSbc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsD8iSbc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995bCI8031164;
	Thu, 9 Oct 2025 11:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6JLp8J
	qX7nMFlgLBJloJD0W0dqWyzSREKJwOYvb8CVA=; b=fsD8iSbccIfL2nZdZRmLZn
	pOnDz5LqLeb5rKexL/6roYNmYAalKZ/A8C8mCa7GKJyq5FDvmx6nFPjtVpBTAtkr
	wMtKSekHQSYw+ZrU+SEBrxeD1IXq01qS+ZCaheoB+cf+f/4kWxvWDoHIfnlG6KRn
	emLLWg/yV8sYa0uDa4KyYGXfjogr26plqYCQzuY4ZEl7jlNww1jhDwRHUP3Ypr00
	4WNAoVTDIQ3ZZVu0tcG24S4wg0x0ypj+nNK65YuXMy9XiFGQoDVd4cKjE/Jvnpm+
	8LDL9z/mrjqPnHx3xao+QVdk0zleBixrpQhzVvO704XwL1xRL1P4cmvuUazdSizw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81ma6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:22:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998LCgv022808;
	Thu, 9 Oct 2025 11:22:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vc79g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:22:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599BMZIr15270636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 11:22:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 685D458054;
	Thu,  9 Oct 2025 11:22:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCDA45803F;
	Thu,  9 Oct 2025 11:22:31 +0000 (GMT)
Received: from [9.109.198.200] (unknown [9.109.198.200])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 11:22:31 +0000 (GMT)
Message-ID: <d720e632-12dc-49dc-8eef-91b502fccfde@linux.ibm.com>
Date: Thu, 9 Oct 2025 16:52:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 7/7] blk-mq: add documentation for new queue attribute
 async_dpeth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-8-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251009074634.527661-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vjpnoiMRcuCjGqm_vL7-w26thlE_684H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0v97sm4iPhqk
 CSukMwJZqW2U9wqxxely3/zyCf8pWS43L7rkeLWkp3JEIh9FEccml3bOPmUqarpDb+lmlq2R50K
 sCPf7FYUqLX3ySNvLl5lm4Y8BWmgdwYHHInUHNxnmRCeF68G5VHbKOpwo7x2vBD6Hoq9CYcgZmo
 m5rckfbIBnQsgdPL4KQB2JUSvuocrkYgsQQ+6phEq2/7zSkghUp4+FuJA0uDqZagoa5QULf56F3
 SJ/KHcG9SS453RCjEwkAgAwIalqqwxGRcDKtmsa90iHPmR0P76/C3wQQr0oEoak0soFzpDjp24v
 ti8BanQy5F7JHp0tnPK14zLeTESaoQ4e2DbxoCIOr3QX/Xan8b7r+YYevnRJg9gLUudMLz3fg+3
 plkxNPGIRF+UkyaXX4PQ+XNCi+06hQ==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e79afd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=cVRXvqtE_swIzvAQJvsA:9 a=QEXdDO2ut3YA:10 a=Ba5x5ocL4jwA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: vjpnoiMRcuCjGqm_vL7-w26thlE_684H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/9/25 1:16 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Explain the attribute and the default value in different case.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
