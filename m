Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CC285C84;
	Mon, 17 Nov 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378009; cv=none; b=N0ttf6rNR01qJVI9Tc21nQwTi9NC/DmQWHlqDnvOYp8qcOkY78PZCV/L2IVRA1LuoYZNaVAmVcWUvUM8vjPSaWeZqEo0WjkCA/FD/Yjx75o39gKzd4s+/Gl+6E2KaBDRapiKFaCGM97zR6oScvvsIbjiWGispki2FRz53TEKtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378009; c=relaxed/simple;
	bh=WYcTXJ++ONRGoK/2zUKEvfNq3KVTyAfnfCaXqGe8Am8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6sgskZaJg5w0RAVl8sjhur2UiklZpf4oLUIf6COyYuzp8NUKfe7PxfIOUwdK74R2Y6J/Gg8qP5zdj4Mw6wGNThzYtid6jTh7fz/v2JADPpIOhMKjsaEyc4/ps9LwltVNsMHUSCcaF68UNqA6gK9s4YR6PmmHNSuDWs6O8edTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aGnDJ/yd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aGnDJ/yd"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGKEC5c020334;
	Mon, 17 Nov 2025 11:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VpI9et
	WYxReP8LSRSlps206NVtUElfU6x4jbplUdgZQ=; b=aGnDJ/yd3afDIhkh2pPriM
	l4ScU2zgDYb/DjvmFaT5eSMm3a5VuAfpxQrKTUZCsWqJUxPiU5MhBW8wBiiadlOn
	X3mT9cEn8KPYa7x2feS35KMW5/OS+Nr8pcRZJPakK+JT0AodAkXobUz2tuv/G2Z7
	HSkLrC1a10ka9nR489ST36pqatPlb692rqS09Xz5ZwTcEghzof3SZo0qgtCXTfxs
	w1ZK/P1Sb2yl6wEgAHnCHL/9+IzWWGtxFltV073ms4IgZrJ9/h1CJXqXTWOTENnY
	qpbpfD3bwdT8ZLAWNa/umtexrJMe7PG8NMtbTNwp338V6IRAw0HpwJRVqyEClPSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjvwskh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 11:13:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH8vk8T017318;
	Mon, 17 Nov 2025 11:13:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1d4h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 11:13:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHBDF5Z16188062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:13:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F20058052;
	Mon, 17 Nov 2025 11:13:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 950715805A;
	Mon, 17 Nov 2025 11:13:13 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 11:13:13 +0000 (GMT)
Message-ID: <1bd4a77f-399f-4dbe-a6b6-79b07f5e2759@linux.ibm.com>
Date: Mon, 17 Nov 2025 16:43:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper
 rq_qos_add_freezed()
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-2-yukuai@fnnas.com> <aRsAdF3GxNJ3Q1Qv@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aRsAdF3GxNJ3Q1Qv@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691b034c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=msZIkkZUJXvqM21ySCoA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXxVsqVQY3fwnp
 L/ddHSXuwebdUBBaPnANP7kAl0NDZMRHPJsyTphZN9CdcCqufHC9Q/2xMTbeAiCkTQx+2oQrgB/
 EWJjL8JQ5BRH+8CRJyTAV7X5jK0dbn4pDa6c5txvpSvM4n4oOdXe6nSA2aHgams6W1iCmskGa5z
 TqHAE148yqnvtQ68EONglm7nrptQQxORYjhWvmeRTdM5lrU/GbMZeIjz6v6ZHnz4xnVAeND4JH7
 O8j+wXQUKHc2XdMrcKcRc0BZKxCOutqLiBylmJvbMTml6WA3Fgpt3XNg9ZhMZOcCWft1vuSAgPI
 y/dsnvAJvDB3JzgKADq+ar+5kobnLptU7ENDiG1V0I3a6j9X8pzWcYRLWmTvctZK93Qp1nC9VAa
 /6fDPjKK2zFM4xpQGph+6xmCB3jb0Q==
X-Proofpoint-GUID: P8xELGG2g3yOani_Cylg3lh7-TzqAE2R
X-Proofpoint-ORIG-GUID: P8xELGG2g3yOani_Cylg3lh7-TzqAE2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



On 11/17/25 4:31 PM, Ming Lei wrote:
> On Sun, Nov 16, 2025 at 12:10:20PM +0800, Yu Kuai wrote:
>> queue should not be freezed under rq_qos_mutex, see example index
>> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
>> parameters"), which means current implementation of rq_qos_add() is
>> problematic. Add a new helper and prepare to fix this problem in
>> following patches.
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> ---
>>  block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
>>  block/blk-rq-qos.h |  2 ++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index 654478dfbc20..353397d7e126 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
>>  	mutex_unlock(&q->rq_qos_mutex);
>>  }
>>  
>> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
>> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
>> +{
>> +	struct request_queue *q = disk->queue;
>> +
>> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>> +	lockdep_assert_held(&q->rq_qos_mutex);
>> +
>> +	if (rq_qos_id(q, id))
>> +		return -EBUSY;
>> +
>> +	rqos->disk = disk;
>> +	rqos->id = id;
>> +	rqos->ops = ops;
>> +	rqos->next = q->rq_qos;
>> +	q->rq_qos = rqos;
>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>> +
>> +	if (rqos->ops->debugfs_attrs) {
>> +		mutex_lock(&q->debugfs_mutex);
>> +		blk_mq_debugfs_register_rqos(rqos);
>> +		mutex_unlock(&q->debugfs_mutex);
>> +	}
> 
> It will cause more lockdep splat to let q->debugfs_mutex depend on queue freeze,
> 
I think we already have that ->debugfs_mutex dependency on ->freeze_lock. 
for instance, 
  ioc_qos_write  => freeze-queue
   blk_iocost_init
     rq_qos_add 

and also, 
  queue_wb_lat_store  => freeze-queue
    wbt_init
      rq_qos_add

> Also blk_mq_debugfs_register_rqos() does _not_ require queue to be frozen,
> and it should be fine to move blk_mq_debugfs_register_rqos() out of queue
> freeze.
> 
Yes correct, but I thought this pacthset is meant only to address incorrect 
locking order between ->rq_qos_mutex and ->freeze_lock. So do you suggest
also refactoring code to avoid ->debugfs_mutex dependency on ->freeze_lock?
If yes then shouldn't that be handled in a separate patchset?

Thanks,
--Nilay
