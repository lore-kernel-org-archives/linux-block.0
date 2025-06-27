Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE14A33;
	Fri, 27 Jun 2025 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004996; cv=none; b=UaLOsWhaijZThUgRYaGmmiDdK653B41wCnKtpZqOrrZj2sgAYGwKDhMagfksrbtLxDR1bQHqoqdYoyrwlTeIFGLmlrVK8HB6qIe/Qpy6aHEUhnzRgTofb6a/qpdc3zlehay5g02telgqQ3451GqQM1GlNFxpQFOQi9b9Pb8264E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004996; c=relaxed/simple;
	bh=w/bRJLkxZk/hnquSI5ldj7BRGD76ZgiRsGrgnyxYdyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJyw+PUbaXu2S5AKl19aBznsq5ntKNAhSytbOomzS6GnmhG1ITZBpDQaSy00924ZgOO42QRnKJUm0V/z9MyBRJKyOED6CL3u1PGv8SM4fYXoUpBHbTBcYdylIZte98zAk+WSH6cv0Dz3rrpHJoG9JuQvHI3xgBBbarThc5lAs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QRj6JEWS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QRj6JEWS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QM23P1030930;
	Fri, 27 Jun 2025 06:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vnDQJb
	6jUvGWw98aX2kHVBFDk2NJ3Wp9kdiq69Qou2k=; b=QRj6JEWSeZnCMPt2UJelr9
	8CPQkJ7rrsCg4VxZe4e9wSmJiZLHvZxjxjeWtQ++5nXs/s7uAGDi5Zf1O5qkwpSj
	HJDFRlndqkIZUGBF2SV1nodiuzsXHSayn83P7NrywXTpQyPOO93UhuAGoyhftnnM
	YXlyJXp4NZZxy3BJYjOcMBbOOMy3/kbV9MZqe1HHZt3mLVOza+xx+6PvPZJtmsQB
	1IneZDtJm1aihSf5nFZntjelK0DB2WiYA1HuwJ2LyRlwc1FbJIJs9U7eJWF2W0Ar
	aU/BYevXAvt15IaSGSquNYggD/FCkor6zoSOk69UaEIXPfPwxeM8KEcSPRF0GGBg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk64b2r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 06:16:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R5FMoL002918;
	Fri, 27 Jun 2025 06:16:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmjmk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 06:16:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55R6GFGI28377724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 06:16:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728FB5805A;
	Fri, 27 Jun 2025 06:16:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926E158060;
	Fri, 27 Jun 2025 06:16:13 +0000 (GMT)
Received: from [9.61.89.181] (unknown [9.61.89.181])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 06:16:13 +0000 (GMT)
Message-ID: <7e4ff7e0-b2e0-4e2d-92a4-65b3d695c5e1@linux.ibm.com>
Date: Fri, 27 Jun 2025 11:46:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
 <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA0NCBTYWx0ZWRfX2rtiVOlTF/Lk GQRAZqwD1x+pfweEgqvnPN/8degIfMv0TbLLFZo3EYe6Cx47fbZui2dQexLsDopGMBEJ94NJJGt vv2whKEVE8i88Fky1jpcRSeQlaAPtTVz+DyjNriAuaApOCuaBIP51ytcZWQfStiBG4rQE8BBXoz
 itNmJIbjiHntZGc/BB0Ps3qWVG5m5tqwvRuFKjf5A5ttoiDzW7rDRpP3J8mI2M5A/RdskcGNfnx l5d3SUyYScAuY6fbWyZB6CENVjTGuxaKxCrihqSlidGzOVsLUSpK8E2rFah27FtDTW2ztMXytom iRvtBaDWWyfMh/W4yYgJAKbvIp+Su4TKnWWaI8m7oBtBWcozKmZeVyJv1jhDORngyT+FAuj4qLY
 345Ob76GN+HiOoWPqb0+uCDxjWwe56bTQ2jK6oaxp83LuTs6PZRt+F8Ceh+DNX7KE0i2yLE2
X-Proofpoint-ORIG-GUID: ETLt9ZL7hFhri4vy_klAbFAagaAhd49g
X-Proofpoint-GUID: ETLt9ZL7hFhri4vy_klAbFAagaAhd49g
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685e3731 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=lNxP-K4Lu0nT8guvpfkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270044



On 6/26/25 9:32 PM, Bart Van Assche wrote:
> On 6/25/25 10:31 PM, Nilay Shroff wrote:
>> It seems that some other thread on your system acquired
>> ->freeze_lock and never released it and that prevents
>> the udev-worker thread to forward progress.
> 
> That's wrong. blk_mq_freeze_queue_wait() is waiting for q_usage_counter
> to drop to zero as the below output shows:
> 
> (gdb) list *(blk_mq_freeze_queue_wait+0xf2)
> 0xffffffff823ab0b2 is in blk_mq_freeze_queue_wait (block/blk-mq.c:190).
> 185     }
> 186     EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
> 187
> 188     void blk_mq_freeze_queue_wait(struct request_queue *q)
> 189     {
> 190             wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
> 191     }
> 192     EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
> 193
> 194     int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
> 
>> If you haven't enabled lockdep on your system then can you
>> please configure lockdep and rerun the srp/002 test?
> 
> Lockdep was enabled during the test and didn't complain.
> 
> This is my analysis of the deadlock:
> 
> * Multiple requests are pending:
> # (cd /sys/kernel/debug/block && grep -aH . */*/*/*list) | head
> dm-2/hctx0/cpu0/default_rq_list:0000000035c26c20 {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=137, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:000000005060461e {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=136, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:000000007cd295ec {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=135, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:00000000a4a8006b {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=134, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:000000001f93036f {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=140, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:00000000333baffb {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=173, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:000000002c050850 {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=141, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:000000000668dd8b {.op=WRITE, .cmd_flags=SYNC|META|PRIO, .rq_flags=IO_STAT, .state=idle, .tag=133, .internal_tag=-1}
> dm-2/hctx0/cpu0/default_rq_list:0000000079b67c9f {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=207, .internal_tag=-1}
> dm-2/hctx0/cpu107/default_rq_list:0000000036254afb {.op=READ, .cmd_flags=SYNC|IDLE, .rq_flags=IO_STAT, .state=idle, .tag=1384, .internal_tag=-1}
> 
> * queue_if_no_path is enabled for the multipath device dm-2:
> # ls -l /dev/mapper/mpatha
> lrwxrwxrwx 1 root root 7 Jun 26 08:50 /dev/mapper/mpatha -> ../dm-2
> # dmsetup table mpatha
> 0 65536 multipath 1 queue_if_no_path 1 alua 1 1 service-time 0 1 2 8:32 1 1
> 
> * The block device 8:32 is being deleted:
> # grep '^8:32$' /sys/class/block/*/dev | wc -l
> 0
> 
> * blk_mq_freeze_queue_nomemsave() waits for the pending requests to
>   finish. Because the only path in the multipath is being deleted
>   and because queue_if_no_path is enabled,
>   blk_mq_freeze_queue_nomemsave() hangs.
> 
Thanks! this makes sense now. But then we do have few other limits 
(e.g. iostats_passthrough, iostats, write_cache etc.) which are accessed
during IO hotpath. So if we were to update those limits then we acquire
->limits_lock and also freezes the queue. So I wonder how could those be
addressed? 

Thanks,
--Nilay


