Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725538;
	b=hI7ym16ztayLb8RkJFa8zUvOld0vfwtbv1qXVmHhwM6F11ZxUJyAz95OByBkjgKSErcd
	 egw4Tb6y9WXUAaPJEHYP7vRlGmwiF8dmZ5xZ4QnMeK1oH4OJbb/p+JJxDzaCaSQzc1isu
	 htmApb6k1ktRwE00uqgHb31IbS7dD3Ybem2uoS2vzDnp4zhc2J4VpBIRcEYNEWRsu2WpX
	 YMVYhJFu27IJbvsEVUftEfkdDN9yO4f9BAbvXZta8iLvjz8WahWvq2Q4F3LFY2jjfcQHK
	 9Tyc5M6IuV/xBIyYMfU3Cu+VH3JbqfcbIR5F6af/gROVSb96lWDHwaogjUFw8Hk1ljA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sQ5/jk8rKWyAkNOj7nl6uop6nOfWs8xpblsULbfB1nk=;
	b=A/GGjXeWc47+bhRyiRz/Q93cgkIe/32fU+ELGDmFGJvZyKdNYdRL7tN9TZRHYPquhlLc
	 q5H3Bpw60FK4xI7Hqrp0WE5ru5dWff3SZatOMRVESw3yWpfo+nSoHydEPmX4NkX/7x1Lj
	 Zul92CHv1hMKyuE0KOFnMnj1WNAlgVxuDOK5HBMA2c6PO2HqDr9wvKn1dr6nLbbZGJ96e
	 1zDHYnwm+Do8WSjxo2xN52nVdawDGk+KvqUWJjgN0H8ol1XVKv6Lt7v+5orhbENpy522V
	 259w2HG++KwdWwSyOh05L7cSAsdG1B6jy2x3B/oy9xCjAsIImPjkLb2wEiVJQZYjbbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Es+/SAM3";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37745606A324;
	Tue,  3 Nov 2026 17:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37745606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Es+/SAM3
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEBQ21957448;
	Tue, 3 Nov 2026 17:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sQ5/jk
	8rKWyAkNOj7nl6uop6nOfWs8xpblsULbfB1nk=; b=Es+/SAM3wQW37G84liMDh5
	borI63RxXCNJtBDi3PyMLxxd6T5EwR5bp+Xe+hfkBoK0t9FuVRzKC00TT8kONM5w
	IU8MypYm3s0dO2ZjPkLehIIdTpHnlR9pwWP8yYFtKS9X80JlGHXGSrSWohmTdGyT
	iIkdz7zKgylu68o8jNmkB5LFh21brZ43tB3Rmc7k41GxvvaE+yDcAwCjxfPzG4PZ
	NCAwvq0w/Ce+81yiV+esdOdwYMRsvosg11JWT4cbwOG/7+fcmVz22E7TyFDuiPyq
	h0Yi+TmBlen37B7ZRVe1+s+vLFzeI4/lHFKHpEl95p2sUxqbuVh+3RUyNi0WB0gA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhq6un-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:04:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK44U2695648;
	Tue, 3 Nov 2026 17:04:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5guj44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:04:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3H4ogX55640372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 17:04:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6592758059;
	Tue,  3 Nov 2026 17:04:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71F7158058;
	Tue,  3 Nov 2026 17:04:46 +0000 (GMT)
Received: from [9.61.129.51] (unknown [9.61.129.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 17:04:46 +0000 (GMT)
Message-ID: <7f6e7fc6-dd40-4949-9a1b-95200c9680e6@linux.ibm.com>
Date: Tue, 3 Nov 2026 22:34:44 +0530
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
        Hannes Reinecke <hare@kernel.org>,
        Frederic Weisbecker
 <frederic@kernel.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d-Nw3Q3zP_MAaZ7sH5O-WlJu5ENMXRp0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfX5UilMRvmKMZd
 oVFVkprwMWWs6xXsiE5HNVLR6Cixz5ZoyDx5AUN3gx1p33X8kzLum/roaNDJESDUBD4IXdxdlgL
 xDyIKNz4YUkwDPdBCEHLKNttcPpTF6I=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aea1433 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Xo84benzLQ6E682cTSsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfX8fV48+h9Df/T
 dR/Uq0WBQAYrS8YxaMPDscPYGtROOj9C5Jlk+TCaCZ6A+TeOUjtGFORrPwMvzy0U+52t7U+I6Qe
 khYwhOND4JK0bja1yyKwlFdZyYRwR5NseCuRaDUR3JNmr54bmLIjbfIH6qPvfq4hZiThMCtuX8c
 oqPlKQh7YBdBN/4dM4z8jlqm4PXbnZi8hESHterSA86BXet99DCanySnItezE73V2hniSO6TjJ8
 APZKtmsU/k4KBBnEinCmYElvyKjD/jId6eCpHINOQ0p8781qgmKRx4vzDNmEPC5HhVVDrwPmFq8
 iu4faUNrkR9rFTb0zubDzZszAWhTqAKTSOPpNhksZxYc01+k06AX67qE8IZm6dQcog2xGxTLq7g
 cFn8krnF3Yhs65D1UukBqNgYDhP/ZTYWYnLaGIgiGPcYeQb6AJ6V0LgHDxw2xJxG46TxUFbMAcw
 kfBo/uE01IlJOMqHvYg==
X-Proofpoint-GUID: d-Nw3Q3zP_MAaZ7sH5O-WlJu5ENMXRp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030066

On 11/3/26 8:27 PM, Daniel Wagner wrote:
> blk_mq_alloc_request_hctx uses the first online CPU in hctx->cpumask to
> select the software context for a request.
> 
> Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), hctx->cpumask excludes isolated CPUs. If a hardware
> context is mapped only to isolated CPUs, the mask is empty and
> blk_mq_alloc_request_hctx fails with -EXDEV.
> 
> The NVMe fabrics transports use blk_mq_alloc_request_hctx to allocate
> the Connect command for each I/O queue. As a result, connecting to a
> controller can fail when using isolcpus=domain or an isolated cpuset
> partition.
> 
> Passthrough requests bypass the software queues and go directly to
> hctx->dispatch. Their software context is only used to select the
> completion CPU and as a hint when freeing the tag.
> 
> Use the software context of an online housekeeping CPU for passthrough
> requests.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Tested-by: Maurizio Lombardi<mlombard@redhat.com>
> Signed-off-by: Daniel Wagner<dwagner@suse.de>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
