Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6B276043
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398804; cv=none; b=jlT+axfQJXYytcH2sa/lLTofpghcoaHb9XCjj9lERdq/fZQvVxrR5tg15zgCyNx6hROfpCsYHEN8sxBMry1sHXOLCuWikkx3P3LA5aDHccncpP/NP4Sv2d06NYOwvRTx4W1r+sbdrtKxB+C6pBQOrJYuSDnv4SmV1xKkRyY6Fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398804; c=relaxed/simple;
	bh=fiT2DocTHnNSdX8vxgqEZV5cESARWW3kOuxKKOLAfEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tn44k9PEM8Le1HVAPWvS41y4X79Mx1LhVX6UB0P/Ts3yuDpG1EDb08L9vflcn0+Cjf8r+8GZc91L9tOsNYUUSpmfQQtKWkcgzqlYl8unx6vEgsuCDCMOEZ8OURKjz6/yla9dHBqra8u6h2chDXmXyZkALQ6uxFZzzjWYdgtM4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ryK4x2rS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ryK4x2rS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIIRjc005172;
	Fri, 11 Apr 2025 19:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dG1iSO
	KcRSVRfr9K9SGhnrmkOzBXXyxjl7/EaXXh5ls=; b=ryK4x2rSoQ9qlKuTI1tbG5
	ZDpz+WxFP89D66iAFXMdtTcsF17Xm4anq4GYEDCE6RdYa61QPf7rXCuQHG8iTi+7
	nDPjoazYyXf/x7hEH/9t7YfOPjC+YHiHN4JCBKKGErF7jHMHnJ43x6GsDopH3d4L
	CaDD0dltojyhC5fV2cF7V1MokbZPfjrqKEvJfkn0SaZOVSnAD84tnDVk7HhHn82r
	nMz/Tzu+IUreOocYwJRbTvaN2vDSH8iw7IyCEEnhvpaNHwxXnhqM/RS16hVFGjmY
	4UAHRYiu+stEgx3bhSCEuchnJgCF7RcErbAS4j2b9/6e7uKvAgeHVJ1FLks3l+jw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufacabr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 19:13:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHHEKU024605;
	Fri, 11 Apr 2025 19:13:14 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutvpv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 19:13:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BJDE3930671560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 19:13:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A90C58052;
	Fri, 11 Apr 2025 19:13:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53EFA58056;
	Fri, 11 Apr 2025 19:13:12 +0000 (GMT)
Received: from [9.171.63.249] (unknown [9.171.63.249])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 19:13:12 +0000 (GMT)
Message-ID: <3c4350f4-4ab3-493f-b948-22f093e97d16@linux.ibm.com>
Date: Sat, 12 Apr 2025 00:43:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: prevent elevator switch during updating
 nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-5-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250410133029.2487054-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mdAQq3KT7YsAn_bNAZ2rzn9oW8yJT4xy
X-Proofpoint-ORIG-GUID: mdAQq3KT7YsAn_bNAZ2rzn9oW8yJT4xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=907
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110122



On 4/10/25 7:00 PM, Ming Lei wrote:
> @@ -5081,7 +5087,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  {
>  	mutex_lock(&set->tag_list_lock);
> +	/*
> +	 * Mark us in updating nr_hw_queues for preventing switching
> +	 * elevator
> +	 *
> +	 * Elevator switch code can _not_ acquire ->tag_list_lock
> +	 */
> +	set->flags |= BLK_MQ_F_UPDATE_HW_QUEUES;
> +	synchronize_srcu(&set->update_nr_hwq_srcu);
> +
>  	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
> +
> +	set->flags &= BLK_MQ_F_UPDATE_HW_QUEUES;

I think here we want to clear BLK_MQ_F_UPDATE_HW_QUEUES, so we need to
have set->flags updated as below:

set->flags &= ~BLK_MQ_F_UPDATE_HW_QUEUES;

Thanks,
--Nilay


