Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FD21E098;
	Sun, 15 Feb 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771162611; cv=none; b=EdJM3g45eAIRG1z9vjfpVbJGf93M0Rx7dHLt8ix/THtODttg5JAo8qNYLqU3ufyC63ZNopRXJRWwij5yH5lMPoYD1ITdOVh2v/mom7fAovDl+5VmPEBCs6g+R2SVktqUFp2Qiqlc9uXAIBCKHeeMnVaHoqqMahQMRFW2ZTr+FUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771162611; c=relaxed/simple;
	bh=tv696dnWNUfGESUXUqgcJCr5JOIOnS/430nP6KkHIII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrdv2jnE2q534RSdC68xLJ4dRuUXhpXDfdt3Eq/UDBLiNvod7xbJ39vfHtm1QubHt9fmBOGgoEUMsEOYzR2uHX2LiKEDW3Y59Vuu+K4rTjHZBW/SxZxElAE1YMUE1vjerV9obkXexAsGxHuxndJLQVJGKhTmUlDtWX2/26hfwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RvG36rvs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RvG36rvs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FCEvgm2467508;
	Sun, 15 Feb 2026 13:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wv0twF
	G2AbTUbcmqc9QmUNDyOQT9K8V9I+NilC4yf1w=; b=RvG36rvsIKNaDAabmEyD29
	BiKRerYsqOgAkzeBD51ElLsNecIsoeOf/dgiqpcQqYEJpc6QXg8bGdntY/SF9hGw
	xCrw9GzYHIETLvToE+oi5SvbY8VX7HYuDct6PS5ob67JYOHM//4PiO9FFWQcO8ko
	vPORDlc7kJgaRdwfx7BAi6dwfSkncJhHrvnCDo06Hv+SWFw4bq6/3ED5QIxLK00P
	wyViDEZQjiCNcm7nRsI9Vh2AUxTsKhtboEkxkeY0CxOgc4BWqFBX+3ONAx0egyu5
	9NBl9dbVeHidTeBPxQANE7QPh7CiKt0ypzeLWkonM6LgWFSiSEC1Eswo9zVUeaSQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4k3tq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 13:36:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61FDIobQ032483;
	Sun, 15 Feb 2026 13:36:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4vjss6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 13:36:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61FDaS9J590520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Feb 2026 13:36:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF3658059;
	Sun, 15 Feb 2026 13:36:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D511858058;
	Sun, 15 Feb 2026 13:36:23 +0000 (GMT)
Received: from [9.111.50.199] (unknown [9.111.50.199])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Feb 2026 13:36:23 +0000 (GMT)
Message-ID: <defde5ab-eb0b-4f1d-b930-91732367a311@linux.ibm.com>
Date: Sun, 15 Feb 2026 19:06:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq-debugfs: Fix warning about possible deadlock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai@fnnas.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260213224504.3990506-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260213224504.3990506-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDEwOCBTYWx0ZWRfX317GoWlVQ6JG
 M5X0OeyJM88Cbw0jutbBu+OcOxdlBcFTLqAUBt5BfZd3UPAZQ7rq4j5XfrHh4arQaiX0RQuJrLr
 JIPagdXtWhq0jjK9Hcz7dyLontOd1wUQ+1y9izUorVqmkFJW3UcjmdnCYUmSvZYRRgrAOhdMAOm
 uTfInsf8mE3ebtpSgvhHFEGRxWy19AoINu27/U+OjP/9zUiH2J5o69Mo2g6ryShFggiyT0mkAF8
 dSJ3cfzGB2ajcsWGcW5CTc47cRMUHL0PQ1zCGiDDXLE9GUs47+3W5CxqHmK0gAgFvnzX4VrSs7G
 FnNX5Gs9DXkJ6cqaO3NI6hmGEHbB+EDBAdj6eepL3f3ZPS802Gi5uTa93bIVMaufkuWiW37dOw7
 LIyu0aFjOVhMf18clAS6NWRngMaxHZ1H3pvvdrckMPZM+s22D0v1qQktnm49WFZpp4Vl+ZbWEqH
 VTaha4FpIwrR8KXaXqg==
X-Proofpoint-ORIG-GUID: tWl3MxVNjerv5k9vDHJ5tirmNOqSctBT
X-Proofpoint-GUID: tWl3MxVNjerv5k9vDHJ5tirmNOqSctBT
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6991cbdd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=tJLSzyRPAAAA:8 a=WTJdmG3rAAAA:8 a=tIEEJtxj3QNLvETeUEAA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602150108



On 2/14/26 4:15 AM, Mohamed Khalfella wrote:
> Commit 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")
> added WARN_ONCE_ON() to debugfs_create_files() to prevent potential
> deadlock if the queue is frozen. We hit this warning with the stacktrace
> below
> 
> WARNING: block/blk-mq-debugfs.c:620 at debugfs_create_files+0x9c/0x1d0
> Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
> RIP: 0010:debugfs_create_files+0x9c/0x1d0
> Call Trace:
>  <TASK>
>  blk_mq_debugfs_register_hctx+0x186/0x320
>  blk_mq_debugfs_register_hctxs+0x80/0xa0
>  blk_mq_update_nr_hw_queues+0xc8f/0xd50
>  nvme_tcp_setup_ctrl+0xcfa/0xda0 [nvme_tcp]
>  nvme_tcp_reconnect_ctrl_work+0x51/0x180 [nvme_tcp]
>  process_scheduled_works+0x840/0xd80
>  worker_thread+0x36d/0x4a0
>  kthread+0x366/0x380
>  ret_from_fork+0x7b/0x670
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Here __blk_mq_update_nr_hw_queues() did set PF_MEMALLOC_NOIO flag before
> calling blk_mq_debugfs_register_hctxs() and this should guarantee the
> described deadlock will not happen. Warn only if the queue is frozen and
> NOIO flag is not set.
> 
> Fixes: 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index faeaa1fc86a7..ec6670dc0a3d 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -612,12 +612,14 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
>  				 void *data,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
> +	unsigned int pflags = READ_ONCE(current->flags);
> +
>  	lockdep_assert_held(&q->debugfs_mutex);
>  	/*
>  	 * Creating new debugfs entries with queue freezed has the risk of
>  	 * deadlock.
>  	 */
> -	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> +	WARN_ON_ONCE((q->mq_freeze_depth != 0) && !(pflags & PF_MEMALLOC_NOIO));
>  	/*
>  	 * debugfs_mutex should not be nested under other locks that can be
>  	 * grabbed while queue is frozen.
> 
> base-commit: cd7a5651db263b5384aef1950898e5e889425134

This issue is already being addressed here:
https://lore.kernel.org/all/20260214054350.2322436-1-yukuai@fnnas.com/

Thanks,
--Nilay


