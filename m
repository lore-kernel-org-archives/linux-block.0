Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89319B5B1;
	Thu,  2 Oct 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418375; cv=none; b=E0IulTeDyP4bKUzMqB2QoN0YsBaVxTavn3YBatxuepv79kD5D9CzEUqbAfwbbyV6c0ACgpcgI9nrBf4GTYkPDv3sLt64j7UsjXxl5aajxbbcCiXw693viExA38DVQ/dnG6+pIGr0NN9u1Ju2KCljx/rEZjA+pX/nJyYfik5Sc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418375; c=relaxed/simple;
	bh=86+d7oYVxiPsIbwcUXFZlId1FsXspGbKwpLlmHcsIpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlfnIWpWZz0rEx4qOyfU08KUym9oHaO+uWnBXFdi+0yA99sc2OXyPH7MSqs1xSjS2FVWf2yWS2EWd1t9nnQPEDY7dHXs81xwSDVjoFqNkXRT+NI7WwWwCfwu+f0YbiV4XSIccSX0J4nIkX0hnf8lSamdf1GKgqy1Ji79Dgf+s6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQDOk+69; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQDOk+69"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5925Ks2p010350;
	Thu, 2 Oct 2025 15:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NFblGk
	WMOBOr1bkSJnmF9Js+Y9j/s50bmu5NM2ZqmaY=; b=UQDOk+69XPhmcXkLOIlnz0
	VPKIWlz46FxXgkTqIuQakhI/rXTInv57Ofq7aWJJgjfYITw/X4AVjAnZXNnpxJ4i
	1aarg8Qra23AAolIqIk8H/+kYdrQfgb2WMH9TH11MFEEF8vdDvuhmwPYzrAvLqdS
	x6vrhKQAJsNEq/DbjM4fdWCsy3FncY/eKjJ+FCgtoMbTG2VbsyvaJQDPpXj7qa3T
	3eLCyroomg71DU0sO3NLtzgyrIJ2D8Wrc+i97hXfw8C8jdt0lWht2uYhR9WvJ7Ir
	QEFtyC+0FpRPIDoimYwhxx8QLs+1e06+WLv8nRGj/i1n90Rtz5ne3Qn1/6OCqhSg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhw83a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:13:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592EPoXn001585;
	Thu, 2 Oct 2025 15:13:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfje831-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:13:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592FDn0W24314414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 15:13:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B432258063;
	Thu,  2 Oct 2025 15:13:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7751B58043;
	Thu,  2 Oct 2025 15:13:45 +0000 (GMT)
Received: from [9.43.27.61] (unknown [9.43.27.61])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Oct 2025 15:13:45 +0000 (GMT)
Message-ID: <ff7287cd-7818-4601-a799-f3782a8b5f28@linux.ibm.com>
Date: Thu, 2 Oct 2025 20:43:43 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] block: convert nr_requests to unsigned int
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250930071111.1218494-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68de96af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=boErDzzRFBrX35Pm4HcA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX4C+mOmVChIFM
 gBcMlfoM3lrtHbjTCODlbgt3Z1qoryQe83pRAYNFjbCC5xW51mdficM+GNJw6sKQR9eWP5kJYrV
 cOhKiOX0lCIWYKJCbj9N+Gn5o72n8Xw1LGj6DI6DRPO97c/XL2U88exCNyatQen1zwm6vxCCJnt
 asFfWJMgY2+aeM3kxeVT9Zr3qYCtrzy1/+i71ubu4dFjc3EGUy73nZuC0lp+oP6lyUqHGtkEnga
 fqbvF9oUWd3SMBIZ66g85jfp/iUzYtL+h0twWsTh6p5ubHtLkz/kAZnKu3T6tbEOsctWWYbRPrS
 fj5WnszZS0/NWJVAez5E58V8q13sYs8XE+O5IeUmbFBHKR9JCky2YEmJw/stZ1/SlUXl7bT07Cu
 Gf52ZKZyA2KwTwvqnCfEKHQ0/8O6Qg==
X-Proofpoint-GUID: WXdyrJRZ37O8IHt2RZqWq337cARLrjcf
X-Proofpoint-ORIG-GUID: WXdyrJRZ37O8IHt2RZqWq337cARLrjcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010



On 9/30/25 12:41 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This value represents the number of requests for elevator tags, or drivers
> tags if elevator is none. The max value for elevator tags is 2048, and
> in drivers at most 16 bits is used for tag.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
