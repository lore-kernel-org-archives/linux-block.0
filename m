Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E8246BA8;
	Thu,  9 Oct 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008560; cv=none; b=Y0lKMxHN1PMKJVMigwxGugPVOBSsvsyq9FfP/QJfXOrXadhVhT+PLYo6gi+jbMvO5xYFINs+owhr4f5sUyQZ9AqVo7nFPuskre5ve+H4gM0M30b9yZUOJPL99eSw7n+UgLfWNTyAeNiFi/kWBJZzGRcHjJNdZNWnG+ZXzmbyNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008560; c=relaxed/simple;
	bh=EaSP5cyQU5Nw272fpeLlRinjkfJFMIhw/De4BzVEd+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh8ZkMxnx8yGFKj1DDsU+ghpmzzKE5v5wr1CvJXcVLh1I2ujnO8Zwjn0F2Lph2M8sNnzfpWdBjNe6V7lMlKbPQTYemXYwjc3a1nHBj0RQKzWIpxu5Lfk97J966APE3jSxaRznGfMjjE4ZSpn42Ql4a9bnJZZ7jCtcAPqZfxEvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tA1nTgLz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tA1nTgLz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59967V3U031169;
	Thu, 9 Oct 2025 11:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i0KHr1
	+GEOVjdxB2Kd33v2fDOjQZq3mH1GQT4rtvhgs=; b=tA1nTgLzWD2UaKrUI8do1f
	JXcYhi65vbV+QxC3VZCFzXBIceGgI1r6vstYT1Ed26WSbMQ+sfaJiNaTMWiB+HtI
	19Z/autIROk/1vhbfOn/Yvef1rEcp9JZWNRQksKlfI/qAl+Tk5vB9CFxYGZP7ThS
	g78lyAnO2r5J96C2Sx33BRkEXYkxvlXaezBUSemdQa9wHzCX9DE6dQ/xDFVqEcwk
	NLQKI/JAE2pmVEXpp71Ec9kFgZcRDMl+LmN6ekx9SW0gW3/XmJnFq2sazTQpfW4O
	VKllKAD1IqAXmOZJ8iXi8es4UnanrktbUm7BTTo2iOFylsYVkqyyI9Vz5aUleYhw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81m9g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:15:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998KI3e022773;
	Thu, 9 Oct 2025 11:15:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vc6km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:15:26 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599BFPM520447756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 11:15:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3026E5805F;
	Thu,  9 Oct 2025 11:15:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C20058059;
	Thu,  9 Oct 2025 11:15:21 +0000 (GMT)
Received: from [9.109.198.200] (unknown [9.109.198.200])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 11:15:21 +0000 (GMT)
Message-ID: <c8a08b5d-a221-4696-8bff-4fa80340a575@linux.ibm.com>
Date: Thu, 9 Oct 2025 16:45:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 2/7] blk-mq-sched: unify elevators checking for async
 requests
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251009074634.527661-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TYg84TneXMJdH4uTVDTvY6q1MsHUjDVe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzg5KbgVmLQkS
 eq+a6ssalK/zPGT/VM09qGBArW7Ev1klN1/6lh8ODsqWgNNWFNKEqfewj/vXu3E6cXZklspueio
 duScgkxozdwJhSILj6hhnQ3XAb2VjyI/m16xzK0DR6yafhxcqM8xIbeXITOeQ6vPpsjqXcAmWLK
 wBYtIMUkVttlOMmeR9Z00+czHpTq67KP1KsZWkIibmXpvycayNbHH8satiC78ClQ51YJBWIr8jr
 5rO6zkjvuMR+jp1SoVh6COCpPCodtmS+9bMEVQvIG/IoWbw5yUnDSxdfbpK/zaUdCwuSXFFGE+H
 QE6YR0VT/nZFcIMdZefIJsCuVEHw5m5TMTBC+bub37+DNKnYuDv0rss/JmxYsgbrxGRmLpYbtQh
 sbTeu5SvXKevZ+ofb14+LPJztYlaDw==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e7994e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=wiJGR1NNRVUR7wOXJQEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: TYg84TneXMJdH4uTVDTvY6q1MsHUjDVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/9/25 1:16 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> bfq and mq-deadline consider sync writes as async requests and only
> resver tags for sync reads by async_depth, however, kyber doesn't
> consider sync writes as async requests for now.
> 
> Consider the case there are lots of dirty pages, and user use fsync to
> flush dirty pages. In this case sched_tags can be exhausted by sync writes
> and sync reads can stuck waiting for tag. Hence let kyber follow what
> mq-deadline and bfq did, and unify async requests checking for all
> elevators.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
