Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190126;
	b=Yus/kkI7M5mZn4LU5qwDul66HM9AKHPP4PXHw0HTfni54O7BB0s4Z/o965L/kmhJfNo1
	 KBSwbD9C4m1+zLOT68fCa9gr8xuMDJtaM+9G+p6xizv6PT6HsEV2o+47kD2dwk4XN0JDG
	 /d0uoHJmv3EMjKBuO6egzuqRn8qVhNNcOgT6XQYKFiS2CRz37AkETBlpfRqz8RAIJa7NX
	 1ubh46XCRFZ0mZnHkzgVnR7KD31LmOZz6oMn/FitgTF8Xj9h2BiCCG3o7lftCqcxJggxl
	 LvFDivbatNdDUg1eMFDnNs4spAauStd3KIv8OVX5GuCImA5tBrWEPT4y81r7w/X+uBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BDw9vuLhsoJjw9OjJjb0Sp8UoJEuw4L8WFj5zk6BSWY=;
	b=NJVp8PId/rHiaeE9yjG7QNrcDivJib5BUNFfMIPyOuqfdXiL4I3YUr5wRAZ5zIEkm2kx
	 Hpo5rGYaX3IHYO63U7lj/2rGJWwMeL8ns6bw+YWue9YLD1z5TXVSS7TtCQ4RQm0sa2LDu
	 jVzl4DFDHCoKG/BFPnbGc/9t9xat1cBeuKRXEI7wxFIPHH4A/pL8sK1tEmDigCQBNLJ8s
	 oZe0bP4+4ivEmFcvrdV7pqhFkPHqeJwJzHG18vwJzva8qZMY2fDrdqRf0YsWlGUoaAcwk
	 HjrMMvi6KkmNtAmPpegtGsIHrAcXW0E4O8jEfqyzYU/HOPE/j4uLwvX8RR2kGA9VGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XuDVl3A9;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9E606A31A;
	Wed, 28 Oct 2026 12:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XuDVl3A9
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBi6871133902;
	Wed, 28 Oct 2026 12:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BDw9vu
	LhsoJjw9OjJjb0Sp8UoJEuw4L8WFj5zk6BSWY=; b=XuDVl3A9YCkRRz23GIsZhC
	Nf6kMB0XiW+zAKKDXYwqy7FylwEIMUUYNsBeKJf65rTOgScJf/M3ofKeRdtqAGPl
	oxO+axuWZShR5s2uAoIcapa52awlPmWk2yyOoxvE8q7buRMVxfZe25D7jdT8D4JI
	1hBzSLtEa6HI1q1OFVcVra9JcpsvowB8OFj2qPnJNfjFh3udImXrA9LGIIO/Ujvh
	WwkPSrcQ4JLZ08TGftJZ9q+qMUqkmRJuLZQAuAn0bpBFDjAa8JITNCz8vkMbN8Zu
	apfFS9b+nbPYHHagLm+I0eb5Jji4Es5Fk9wY8ATy0iHP8u6+uwu1k5cXvaJE9Dww
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd74kst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:21:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBo2Vs1501992;
	Wed, 28 Oct 2026 12:21:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7w435-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 12:21:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SCKhk88454850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 12:20:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D4058055;
	Wed, 28 Oct 2026 12:21:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6BF958043;
	Wed, 28 Oct 2026 12:21:28 +0000 (GMT)
Received: from [9.61.174.203] (unknown [9.61.174.203])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 12:21:28 +0000 (GMT)
Message-ID: <7f697f9d-6e8c-4544-bca7-137d3f3d2dbf@linux.ibm.com>
Date: Wed, 28 Oct 2026 17:51:26 +0530
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
Subject: Re: [PATCH] block: only serialize elevator switches of the same queue
To: Laveesh Bansal <laveeshb@laveeshbansal.com>, Jens Axboe <axboe@kernel.dk>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Yu Kuai <yukuai@fygo.io>, Reindl Harald <h.reindl@thelounge.net>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261023201704.20577-1-laveeshb@laveeshbansal.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261023201704.20577-1-laveeshb@laveeshbansal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae1e8cd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=MshuAW7lajBaXJloSoQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX4l6D5QaWGz2h
 CnjRROkMNiJQ7Ya6YqT3NsCx3Mw/c0NENxyDEOr6r6zQJ7GTFb1/BvQBOtEWMOjT3gwDF7FJvEI
 gSJfxS4mr/ExWAFy6Nr3c4ORSZWVYZBgSPrjRog7H5oMPMw/eLVvZiRDKpi63psB2/233tm/exO
 YXNo2fXufOH61BmkSFUeYDxJgT3VUURltO3Onnoj3NnjI5JVZZgOGA/uzWgSEAE9LWSqCn2fBEi
 dLIZhaXEpTZ3zW4OgqnoGoOvpr23jUzAY1IbAqwDyKbB280Q0nQVkCKFXLY5IKypIpEINxaA/RJ
 J5YBCtkCgIC+kPghX4/2vIh6hc0+FZIgPjZ68pCd0dHg3hjNgr1DyS34D5lS3jjALtuwCciAk5e
 4d1MWpKr+RIItzomiX87LyTWLwo445uZbKPw7SVZjcFzu2vm8QjyTaPKvg5horhQojGOY8LlGnu
 7GTrTM0dFwJNNnQ8ruA==
X-Proofpoint-GUID: lDua0ER_ApJ6W_nPF_XmqZ5Y3kGicyRX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0OCBTYWx0ZWRfX/KzQg3wTep+S
 VzTYtuisttxR4OUBt/ozQwq8NZzRusu60xvo68B2C7xsJTHBQ3AegygCZpPn5q9jCemL1sk+CJo
 a+hLJFCbYR8j3Ou4Mv77UhDFhiIeC4Q=
X-Proofpoint-ORIG-GUID: 5qpIMuLbKQsIv_1NAsBCfYlxbgwQ_5h9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280048

On 10/24/26 1:47 AM, Laveesh Bansal wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 196bccf27f58..655c18237967 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -473,6 +473,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>   	refcount_set(&q->refs, 1);
>   	mutex_init(&q->debugfs_mutex);
>   	mutex_init(&q->elevator_lock);
> +	mutex_init(&q->elevator_store_lock);
>   	mutex_init(&q->sysfs_lock);
>   	mutex_init(&q->limits_lock);
>   	mutex_init(&q->rq_qos_mutex);
> diff --git a/block/elevator.c b/block/elevator.c
> index 2161b6eea680..0a8fcb4bad06 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -812,16 +812,16 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>   	 * reference during concurrent disk deletion:
>   	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>   	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
> -	 *
> -	 * Use the writer lock instead of the reader lock of update_nr_hwq_lock
> -	 * to serialize the two-stage elevator switch steps in
> -	 * elevator_change(): the core switch step under the elevator lock and
> -	 * the elevator_change_done() step outside the elevator lock.
>   	 */
> -	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
> +	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
>   		ret = -EBUSY;
>   		goto out;
>   	}
> +
> +	/* The reader lock is shared: serialize both stages of a switch here. */
> +	ret = mutex_lock_killable(&q->elevator_store_lock);

We generally try to avoid introducing new locks unless absolutely necessary.
Adding another lock to the generic block layer also introduces maintenance
overhead. In fact, we have been trying to eliminate some existing locks in
the block layer by restructuring the code where possible.

That said, I understand the issue you're trying to address. Instead of
introducing a new lock, I'd suggest using QUEUE_FLAG_NO_ELV_SWITCH in the
sysfs store path. The store path could atomically test and set this flag.
If the flag is already set, it means either another concurrent store
operation is in progress or the disk is being torn down. In either case,
the store operation can return -EBUSY. Based on this approach, I'd suggest
the following change:

diff --git a/block/elevator.c b/block/elevator.c
index 2161b6eea680..e59381922679 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -812,25 +812,24 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
  	 * reference during concurrent disk deletion:
  	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
  	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
-	 *
-	 * Use the writer lock instead of the reader lock of update_nr_hwq_lock
-	 * to serialize the two-stage elevator switch steps in
-	 * elevator_change(): the core switch step under the elevator lock and
-	 * the elevator_change_done() step outside the elevator lock.
  	 */
-	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
+	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
  		ret = -EBUSY;
  		goto out;
  	}
-	if (!blk_queue_no_elv_switch(q)) {
-		ret = elevator_change(q, &ctx);
-		if (!ret)
-			ret = count;
-	} else {
-		ret = -ENOENT;
+
+	if (test_and_set_bit(QUEUE_FLAG_NO_ELV_SWITCH, &q->queue_flags)) {
+		ret = -EBUSY;
+		goto out_unlock;
  	}
-	up_write(&set->update_nr_hwq_lock);

+	ret = elevator_change(q, &ctx);
+	if (!ret)
+		ret = count;
+
+	clear_bit(QUEUE_FLAG_NO_ELV_SWITCH, &q->queue_flags);
+out_unlock:
+	up_read(&set->update_nr_hwq_lock);
  out:
  	if (ctx.type)
  		elevator_put(ctx.type);

Please note that I have only compile tested the above code. You may test it,
and update if this works for your case.

Thanks,
--Nilay
