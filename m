Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7883093A0
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082434; cv=none; b=O72pmMww6HH5LIGSGZDIIN4zol/UXTouduo3YaBH6oGPwa1gPfy6hskUnsifz46ipusecdgJ91CExPXc0kfhwpo5SMIztEhXXll/DIRwf7b4OiBF0zgHxQyIKJBaBdlNr+TXAIIDZvBbr3l0WH5F1pHtl/umdttPau84776FACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082434; c=relaxed/simple;
	bh=+wM8UkP9gT/Rn9LR8zC/UtvkP1JOoYQVFjLNXiMR/b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DH5xhp3LwF74DUcmzlKH5AjhJFzXx4GDVqekk+mklHhiq6h68mnk7n6XUkF6r66BmCni9ouHDeJDwZGYuZVHi3htZZ9T40DsEBUHBfooltELTDc0IybKuVAupcsk0u3zBt9J4W6Y5WLWYn9jDoEEPdCfe2zPiw6uweI0YixGZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVZX2G2g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVZX2G2g"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIGFd7F012679;
	Thu, 18 Dec 2025 18:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dleZfb
	nCSNcdbQ0HOyw8M99QTcAccZVPfuPyAnkPc3o=; b=GVZX2G2gluvBt2x8qSVLA8
	wFp21sgZRJq3HATz0/UzG/yEcTaeQ7cQSWKjzq0rMwi/RPwb1Zq118+v3CGIX9jM
	S5qFTBtsukVFM2+wJI84ZOKVOAe2ermmlPEmRMVuP/oltArnvBw9iSRdNRksiYFY
	ZRK5ZPYbdFoqUi3/nEz+CNCog/MLL1N+hzy0jjlfxb1vJAYZ4QIEKlcCiXXpQCnU
	KhcIeTXmoNl63r7P/6HgYlTluWa+F2+eMWh0st4Gx72EDeQuXMAhDP42lP653PuQ
	EAGd52NGVVfqOMg2ILX7AUcD7+GEKPvL1H0S6HqUjXoDdpff9yawv+U+/jjx/rYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8vaq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 18:26:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIGsMrS026753;
	Thu, 18 Dec 2025 18:26:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfst6ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 18:26:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIIQtSu55050714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 18:26:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DABB65804B;
	Thu, 18 Dec 2025 18:26:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A12858059;
	Thu, 18 Dec 2025 18:26:53 +0000 (GMT)
Received: from [9.111.59.116] (unknown [9.111.59.116])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 18:26:52 +0000 (GMT)
Message-ID: <33f9030a-5c84-4e91-8c2e-247e0d691be9@linux.ibm.com>
Date: Thu, 18 Dec 2025 23:56:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] blk-mq-debugfs: warn about possible deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-7-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251214101409.1723751-7-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX5vJpbbsTtNku
 CtT4tV94IqaAEr6EQ6APt/5LUJW+P7vQ7u2/3U4whGCkrHpJfJeVtvROZxdvkFolX5Vi2G6LP8o
 qRBMpak2nYks3dnCGV/fAUHc7unMi/ipFQ4AEynA43kERfL92T3Vn6MgrD519T7L2EoVw5bDsRu
 bw8RKv+Pn2If+kI7tNH0ngcKf1+f797++Rwef0k7msgXFeQbw2EjqlD1AJ8w3ILe6OZorVIBFOX
 srx2c4OrNwhselaEEEviJJAe57viog5sc20Zf8Yb1uWvlWOsj3NUksJCr/fxRI7VEGh3I0DTSF1
 dl42L6/r++gMX5nO67blAXExSdhsuKMQ2W0GZuEmKUrzuknjPhBCXGZI5NZDIPz7sMUhsL2lXu0
 cZhia2QF2er0e1cwMsoo2u0O2afYXg==
X-Proofpoint-GUID: ONoEmDmYpO_hAq1cuIdsGh8iOy1--0Sp
X-Proofpoint-ORIG-GUID: ONoEmDmYpO_hAq1cuIdsGh8iOy1--0Sp
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69444771 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hW4mWN5mCCKzNfNKQ1kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018



On 12/14/25 3:44 PM, Yu Kuai wrote:
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 99466595c0a4..d54f8c29d2f4 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -610,9 +610,22 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>  	{},
>  };
>  
> -static void debugfs_create_files(struct dentry *parent, void *data,
> +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> +				 void *data,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
> +	/*
> +	 * Creating new debugfs entries with queue freezed has the risk of
> +	 * deadlock.
> +	 */
> +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> +	/*
> +	 * debugfs_mutex should not be nested under other locks that can be
> +	 * grabbed while queue is frozen.
> +	 */
> +	lockdep_assert_not_held(&q->elevator_lock);
> +	lockdep_assert_not_held(&q->rq_qos_mutex);
> +

Shouldn't we also ensure that ->debugfs_mutex is already held by the caller while
the above function is invoked? That said, I also found that we need to fix the
locking order in rq_qos_del() which is invoked just before cleaning up debugfs
entries. 

Thanks,
--Nilay
