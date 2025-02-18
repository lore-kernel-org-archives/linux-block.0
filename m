Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41522CBD0
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880585; cv=none; b=NnTwKEVXTP9qmJmp7bO0soqaN9OCA8KGk95w3XuIYqhJGYTOQ01CkpyWQX3ufwHEIiTiy2+QOPP/0BUNHTEKgXU7EHmFNkvf5stEEF6Sn1fPkY+X/Ut3DSZwV3xe1hYPAeBaIZKWOEE5c3edPWHp6bUilpvdC6JJspASeQWZYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880585; c=relaxed/simple;
	bh=yrHPieseNfPXyFBsx6AMeFknJkRYzo9H0tXTnQzp8As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l80stAi3aVByMJuR68Thl2vM4kG4O7iaXLHU5e89ebnY7r19YF+a6sjY3S3FHXQ3KOQiBXNF6XQSvstr6VS3x+sFYfuckBT9651KM2rYAUkD0m+oxbB1suNfsKH5pYPzCtkWjv3XFHZRC0ywlbBFZFzGu08gWrU4H7cZdmnITfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nAvgd1pZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nAvgd1pZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IB9XaA020445;
	Tue, 18 Feb 2025 12:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xuZ6ZR
	/AwhFvWAKUK5PZyU+KpdICzGezAjF/f7ksHDQ=; b=nAvgd1pZO0gaWEWeT6Thbw
	yGXztdekeqLTDQITARQ1lc1MwluVmZpEa3qJOLaHX8phvcJ36sWEYjPgu6OwHrg7
	y/KP0fDEyWFz6lKQRkAdaokrt4PQi60udGeNisvcxwPiFHz5JtbncOkg2kr/K3Sm
	gdHdy3wKqths6xNgh84/WS1VoRMfzAyFje1hPxVwfywPTuSqOZd7NnkSkvC3NQyS
	IkYP20zlqV9JMdqWRMCyGLj5YYmmsjzpBGVZPKP773KQDAeTwzZlPwU1SLoePv1w
	GGvzSeWDy5m9yAUnmR/7echXCqsM8N1wfKAH0AbR/gsv85IyX9G0qLzr67/OwAnQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vg99tm7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 12:09:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I9jqNp001599;
	Tue, 18 Feb 2025 12:09:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myu40p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 12:09:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IC9XZb23528066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 12:09:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9D0458063;
	Tue, 18 Feb 2025 12:09:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E21C5804B;
	Tue, 18 Feb 2025 12:09:31 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 12:09:31 +0000 (GMT)
Message-ID: <3fb31ab8-65c6-4c0e-a68a-76d5f0f04cc4@linux.ibm.com>
Date: Tue, 18 Feb 2025 17:39:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/6] block: fix lock order and remove redundant locking
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218092100.GB13262@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250218092100.GB13262@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Us3XxLBWwkEwrey9J4Wk7ZzlHIpYtNKG
X-Proofpoint-ORIG-GUID: Us3XxLBWwkEwrey9J4Wk7ZzlHIpYtNKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180093



On 2/18/25 2:51 PM, Christoph Hellwig wrote:
> The mix of blk-sysfs and block in the subject lines is a bit odd.
> Maybe just use the block prefix everywhere?
> 
Okay I will update subject line of each patch to have "block" prefix everywhere.
 
> Also q->sysfs_lock is almost unused now and we should probably look
> into killing it entirely.
> 
Yes that's the eventual goal and I'd work towards it.

> blk_mq_hw_sysfs_show takes it around the ->show methods which
> looks pretty useless.  The debugfs code takes it for a few undocumented
> things, which are worth digging into and if needed split into a separate
> lock.
> 
> The concurrent ranges code takes it - I think that is because it does
> register a complex sysfs hierarchy from something that could race with
> add_disk / del_gendisk.  Damien, can you help with your thoughts?
> (sd.c also has a comment reference it and the removed sysfs_dir_lock
> which needs fixing anyway).
> 
> blk_register_queue still takes it around a pretty random range of code
> including nesting with other locks.  I can't see what it protects
> against, but it could use a careful look.
> 
> blk_unregister_queue takes it just to clear QUEUE_FLAG_REGISTERED,
> which by definition can't really protect against anything.
Yes and also as clearing QUEUE_FLAG_REGISTERED uses atomic bitops,
we don't need to acquire q->sysfs_lock here.
> 
> Also the sysfs_lock in the elevator_queue should probably go away or
> be replaced with the new elevator_lock for the non-show/store path
> for the same reasons as outlined in this series.
yes agreed.

Once this patch series is approved, I'd work further to eliminate the
remaining use of q->sysfs_lock in block layer. At some places we may
be able to just straight away remove it and other places we may replace
it with appropriate lock.

Thanks,
--Nilay
