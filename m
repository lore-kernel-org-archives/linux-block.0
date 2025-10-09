Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455AA1EB36;
	Thu,  9 Oct 2025 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008870; cv=none; b=G0uRiHYvBUVpJsKLp69W/82z8hDikr85WxXQUzYkzFfNbZmMaMxqAQd4JbiEmWOQ7X/FJd5YlCe8TwviYe3V/ftVAn9dnx3KjYrwY6nmsIHOu+dBaStdsVl2jk7H8KwHe6wnnQS1viBDQf7ZNtcnrypuYyge91eA9qkdc9cvkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008870; c=relaxed/simple;
	bh=c/zZCh1ZrrUgA6YNnpCoW96vHVTKqaxNwVKLlVtYs+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnFJ7wV+HyrQjiuMRvyzSeGUyYGK2s8+y4IYaO101gjzDCdmroX4QP7OjIi9r761cY0FRuhs8G6O9/bASf3iYw3ekmTiSHBSpEwhUYvmW2xEpB381///T8pxFfr++n3RSFgJAV3dsoSFGrALbX32/WzLDFWTf8Qes2yHbC541J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBHue2t+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBHue2t+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995l2GS014583;
	Thu, 9 Oct 2025 11:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+GCq95
	xtI4i6VDT4PE67sq6JMSZ79H5/1C6ySZ6WjY4=; b=BBHue2t+V0g5v4SSQLW8cG
	b0wUPdEzJ3gAk6xYkqpXgd60NnilcP9vRL+SiIXX8FL89gYskPuUDgiAu86vO7pl
	xPoS2GkqDuB0vhn7JivwJUz4gH5UUZ7cceYEc8RzN2LFO4e44s70EM2hG2bPeyLE
	Hr1k8DfVnFmnyMWwBsWV7ZeL564MytArxfCJdtnr93joRlb4rQckhoebPCvecRsy
	gqpJkI9kSptvG7B97zudbtRXgby+4YaMkPanzdRFwyrr1hoeOa43EPklI/ViCbcq
	5yfCiDZREBqEabNo4AIR6i1PeXz6oGJCKON98hvIPH1GRgcGtcXBQn39fybBgE3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84mbh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:20:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998ONRo021026;
	Thu, 9 Oct 2025 11:20:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8sm7f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:20:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599BKWbY3998422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 11:20:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39ED58050;
	Thu,  9 Oct 2025 11:20:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9DE058045;
	Thu,  9 Oct 2025 11:20:39 +0000 (GMT)
Received: from [9.109.198.200] (unknown [9.109.198.200])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 11:20:39 +0000 (GMT)
Message-ID: <9427431d-513a-4dda-9f88-8b7b2d0cbd35@linux.ibm.com>
Date: Thu, 9 Oct 2025 16:50:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 4/7] kyber: covert to use request_queue->async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251009074634.527661-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e79a8d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=uRv04f0bpIKDJRt5AmAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 51SqFHk-prMhqlW77MRncPqdEwG576wM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX20vzR5a4HRV7
 IrqS0Gldbj+mFe1PmyvMgcOjHAMm2k+/+i/cWvD7k83YQA4NBtBuVZir89+X7sxglJKyLKcNc1U
 WUAdl58Evx+yuw8YZyQk5iowqA2DW4tl4m0QSUCcQ7x2NEsvHVL4nPLiLl6hRPqlFvnA8+ykRU6
 bx0T3lbrlaotdXYfOAmg66ngYzPydjldQYO2CBLFHkb2fyBdwxX7oXofqVQ7bRcZzgpKXwV9wYU
 V2hz1mOGdt//UKz1NxFaG2QLm28hjZpxyI+t6dpDaCJXSFNNQDbumiDmJEFBLlcCC9E+hA6ZBaj
 jpNdBxnQVXfDqehSjwzrId5DYzw3SsRNts/8KCqLdi1zSBlw1S71KIuort/Yh/ZJv2L4XLVlUaP
 /YyKXJm2HPjwvj5pjGr+YbByBptHeA==
X-Proofpoint-ORIG-GUID: 51SqFHk-prMhqlW77MRncPqdEwG576wM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/9/25 1:16 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Instead of the internal async_depth, remove kqd->async_depth and related
> helpers.
> 
> Noted elevator attribute async_depth is now removed, queue attribute
> with the same name is used instead.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

