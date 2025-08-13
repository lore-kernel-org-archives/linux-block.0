Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234D1CEAA3;
	Wed, 13 Aug 2025 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755061409; cv=none; b=CebnsCLTOHsAVNhCgBv3Vv6EvEAnXFk/UDfWKXYwlxEzEw2U+4bdxF33XL5E1gqe38ytfpd7RVJwBs1Yy6BBpbzny+ok3BTtVsa8m+ASO8FDNmGb7H3/IygACskdP6a/By3YH1H0ff7cdmE1vL0x2hXJS3e2Tu5zLOFLciRmszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755061409; c=relaxed/simple;
	bh=tGLCXaL5vF+LCtUsKT7SsgJORseZhc8FqciBJ0dqgxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwLvn9yHjQTM/kbLnnOEclNzc3CX9Wivw18R2jbj5qGP7MABsATUUHtK3KV6QyizavhVlfAiv/Sc8cWLWffVbWggnrR4F/9ExrLuqTQUd+GTh0cxeNIWosGXE3R06Oa9g17rCWYu3kaRYMk7MxwKWtvoAHni02PAntfbHDxa6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h7oPEyh5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h7oPEyh5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQNGT030080;
	Wed, 13 Aug 2025 05:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v2yJLc
	JwV0DvmeGnG0NJR2ILb4sP3qpRQ/zNjH1IqBA=; b=h7oPEyh5ibEjooU63PjEs0
	iIPDhOw+8QC9cCVNVeYsxwjXhgkiW1Og9tBO4BFGlnKQyUOxqMRV2KLhwFsU0W1t
	LVnBjRuNsINVVMv7t/+f8xcHjljzFwnzA59ZuGtbfXct9fYmLBqgI6rP7OGYk8y5
	8/M1pll+S1sOnIFPDuGZDYau3R89YBuURRpNbhR8WiGwhfSIgA744SRSw4Fa8ixQ
	LppceA+Oqrh6wcMzepQfQrD3skf0YoEi5Trjm/oJepfm5+EA1+TvlbsjImiNtKaf
	MXQIbtYUbW2hZ35GvMIRxaPfjn5r6BmZefDSEfh+JfQXxTN0nabMGwslxWRj8aqw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudams7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:03:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D53BbU004484;
	Wed, 13 Aug 2025 05:03:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudams4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:03:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D41siq025667;
	Wed, 13 Aug 2025 05:03:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmdggw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 05:03:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D53AB231457862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:03:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D76958059;
	Wed, 13 Aug 2025 05:03:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B3A58058;
	Wed, 13 Aug 2025 05:03:07 +0000 (GMT)
Received: from [9.61.63.67] (unknown [9.61.63.67])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 05:03:07 +0000 (GMT)
Message-ID: <c6881897-e824-4978-bb27-3cf0be0303eb@linux.ibm.com>
Date: Wed, 13 Aug 2025 10:33:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: restore default wbt enablement
To: Julian Sun <sunjunchao2870@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com,
        Julian Sun <sunjunchao@bytedance.com>, stable@vger.kernel.org
References: <20250812154257.57540-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250812154257.57540-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX5V2ue0HMwuR5
 PFS9jnAN56WMniPy0imsi3vgQc8fir4qojnXjOjrJef7PdutCkOGLUDtmLIGvxSJgJnmrIE2Rlh
 jdbSL4OViGr8HP+GVVne0D6Gr3rV+czKSjxTZAGsjGy50YS45nunKX9xH0Bsv2+enwWiHoPfYMs
 8AuKAaRasyaMgY/G6WYTBwnekFirnfoXsfvIdaFLz/GDc0Jd+frvJFddQWtWo2GSyiUvgDzllSz
 l3vn3q++HZ1yCewWKSFTS86Nf+OXzMHtxsF0o70I744Wrd5KA4MhYVuymUF14twiW4fUJMr6DPU
 k6DQn4RXViJ80N8SbhMbW7al/YR8JUisEyXZiMigMq/nv2XU0xP4nl3qI2F+AAeSdspo3zEQF1s
 otN2T8s8
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689c1c90 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=968KyxNXAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qyw61lXL-B-xqPK-4asA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xR-kUKshz68yBRlOtG81zVrFMIdN_khy
X-Proofpoint-ORIG-GUID: HHK6-3W_pvTH_4gJNl6C7EelEolvZwKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/12/25 9:12 PM, Julian Sun wrote:
> The commit 245618f8e45f ("block: protect wbt_lat_usec using
> q->elevator_lock") protected wbt_enable_default() with
> q->elevator_lock; however, it also placed wbt_enable_default()
> before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);, resulting
> in wbt failing to be enabled.
> 
> Moreover, the protection of wbt_enable_default() by q->elevator_lock
> was removed in commit 78c271344b6f ("block: move wbt_enable_default()
> out of queue freezing from sched ->exit()"), so we can directly fix
> this issue by placing wbt_enable_default() after
> blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.
> 
> Additionally, this issue also causes the inability to read the
> wbt_lat_usec file, and the scenario is as follows:
> 
> root@q:/sys/block/sda/queue# cat wbt_lat_usec
> cat: wbt_lat_usec: Invalid argument
> 
> root@q:/data00/sjc/linux# ls /sys/kernel/debug/block/sda/rqos
> cannot access '/sys/kernel/debug/block/sda/rqos': No such file or directory
> 
> root@q:/data00/sjc/linux# find /sys -name wbt
> /sys/kernel/debug/tracing/events/wbt
> 
> After testing with this patch, wbt can be enabled normally.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Cc: stable@vger.kernel.org
> Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
