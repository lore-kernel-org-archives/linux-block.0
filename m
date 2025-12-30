Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2F24169D
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072860; cv=none; b=C3pjEKyRdDHrKkUttH0dbwpdYin82jN86uDqOy5dKCji61q3lgTEbZYl/cjHQQ4vLnRmspcTN5sYzDSW7o3oCTKiaBk3NtM+QnvrKarh5nB8+4Vp68zyTWnnXlg69ozcPzl99+AjyWaLqyItlpwPFXPIlT1P9HyM4mrmCrp9rCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072860; c=relaxed/simple;
	bh=S0EPWCGeympU3kVk/+wtDHbxqMhJWeohJSe9CkjzEzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TD81UAda0qwaEgsmpdILG0d9vXUv/7eHXSAkUPK0ZRb+tkp66OY5WroyysfgBekLOYCRxnvqQpyHbzxB1+CnKY5WRBdHVmMZtauZegetc+8Kwow+C+2rN9L/BARvExigWpVJDpqN3ht426B5uTzErV75fS19vZkwdOt8FYuzKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUTYnYgQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUTYnYgQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTFwCAF018036;
	Tue, 30 Dec 2025 05:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=69lAZQ
	EeWFf/LvFu2Amia/IFNoNb91CuwJ3WCVDY2Q0=; b=RUTYnYgQP6R26pRefiIWxo
	TNvwSLV20+X7vrTY3AKlaU78B0SgsdWAJdB8Po0KP3CMY9S4erJiTijNlWEKLK2k
	u4OvNMrzbz1/2maux59p5H6dQTJDZiI7RWv52vBOXWZO8hEHWAVdPo/evzyvzvrl
	fihSimJ8UnlqVUTFage1TyQ55XBPEjyjwyhMEBfwrUckzJ03CuH0NDMb2OpGBSFX
	FmC5s0hxIvD41teonf3Ze5PANdR4y2sOFtJyFts9KPjDO3l5KuscbA0sMWS0vypD
	Wm20tpoZ248HK1X/3mN3EwehnAbudTG+T7BWwaZ6Mi8WhZgx0ErAP4j7xB2BRN4w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba73vs1py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:33:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU0ZMj5012916;
	Tue, 30 Dec 2025 05:33:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4basssrpu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 05:33:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BU5XuJB36569840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:33:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D66D58054;
	Tue, 30 Dec 2025 05:33:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3FCF5804E;
	Tue, 30 Dec 2025 05:33:53 +0000 (GMT)
Received: from [9.111.47.194] (unknown [9.111.47.194])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 05:33:53 +0000 (GMT)
Message-ID: <5ca7b3a4-e849-4e59-a56c-7e095b0c93b9@linux.ibm.com>
Date: Tue, 30 Dec 2025 11:03:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] blk-mq-debugfs: remove
 blk_mq_debugfs_unregister_rqos()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251225103248.1303397-1-yukuai@fnnas.com>
 <20251225103248.1303397-7-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251225103248.1303397-7-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kzIW9ukpdeP-FBSF6zno6lRgLwo4jLZb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA0NiBTYWx0ZWRfX1wLFUzfQ+emQ
 kQgLtoyMC0G7ieHo+aaqtIcsFWMHmMaRsKPhxB6RQRj2HNUll1doedh0ODBBEdAl/IKNZldpZS+
 QH7vm54207uDkl2gBPnZxW/z0Lylumg1ghohUx3FkZoEq2YjltrUqtLd3RLMB1RoDxWd6tsVvM0
 OHukuMKvCylstvpzqQ8wlo4dGMzDxvKwe2DQgQWKKBwfYNV8aEzaW/a/nGNlmjtYusufR7qg4vX
 dEh5XiTM4vWHkUIiK52RWBzKLJrbP5JoMMFHcRnTEZN9COCe/v9jBU1Fa4KC5QbfEOPFa71WMzP
 ZvTcq1pJcJ1iJmsCACaH9go25K0wpuLc5W+V57rUTnRPRPRZVO4yIuKhsgocprG3lD2uAQ5A/Tl
 pFXC2As5yE1BcGJ5LLBenqDht7bqtW1LrLvsKpBY67D0VszZcLlZUXcgY+cQXUPGuPS/zzxMBP2
 msqFJfARS+hB4qKuHKQ==
X-Authority-Analysis: v=2.4 cv=fobRpV4f c=1 sm=1 tr=0 ts=69536446 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=J_wXmi_fcelS5s1Xn4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kzIW9ukpdeP-FBSF6zno6lRgLwo4jLZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300046



On 12/25/25 4:02 PM, Yu Kuai wrote:
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index d7ce99ce2e80..85cf74402a09 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -371,8 +371,4 @@ void rq_qos_del(struct rq_qos *rqos)
>  	if (!q->rq_qos)
>  		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>  	blk_mq_unfreeze_queue(q, memflags);
> -
> -	mutex_lock(&q->debugfs_mutex);
> -	blk_mq_debugfs_unregister_rqos(rqos);
> -	mutex_unlock(&q->debugfs_mutex);
>  }

This change looks good overall, but I have one comment:

Do we really need to freeze the queue in rq_qos_del() here? Currently,
rq_qos_del() is only called from blk_iocost_init() and blk_iolatency_init(),
both of which run while holding ->freeze_lock. Given this, it seems
unnecessary for rq_qos_del() to freeze and unfreeze the queue again.
Instead, we could remove the freeze/unfreeze logic from rq_qos_del() and
add a WARN_ON() or assertion to ensure that the caller has already frozen
the queue before invoking it.
Moreover, with the current logic, rq_qos_del() may reverse the locking
order between ->rq_qos_mutex and ->freeze_lock if the caller has not
already acquired ->freeze_lock, which could lead to potential lock
ordering issues.

Thanks,
--Nilay
