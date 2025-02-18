Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCB23C8AF
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878089; cv=none; b=L9fzwBmn6Kx8r52t2+fcrUhmKLME/UCtPDsWANYnSexA6oQtok+ikkXb05ySeWxG/ZGWvv82WbzTfznw52dbeYTP4QPLJ5mgTX6pgl41mo3rJebXisOeCz6Le0FJLF5uF5Km8rGuqIjvlTo6g+XVs8XQpF0XGAnac0FIG431Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878089; c=relaxed/simple;
	bh=+x7uNtkstkcObGADBSPN9LdT8/QHSE53w3KwIx2O0yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzFG8i+DxnVGzGObnFxfcUlfFGePMi8BEv1uRcrZV6UdCZ7btu5/a5Vn+1zfPo5c9Y75zrm18vOBeeoNqhby3PKsxFbAKfUrN7tduEMmemBvAGihQtn4Wb4xPR5V3yqfAOZKva6ERZ3v2A8xbKJCDBApNvhBUNcZ75KBEig9geA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RbXyMpyr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RbXyMpyr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5OAbT009959;
	Tue, 18 Feb 2025 11:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X2sG1z
	rN3K7srnzCOdPYKt/H1nGxiJ09eW5suqAouH8=; b=RbXyMpyr5udpLPe1mGogrO
	xFepQAXPzuQXjJPIFyhzJ7CvZSQTagnWMV4TuSm95yBEF1AC3s2z9acwdnTnRFSZ
	U6Lcv+OvrwHsYlPXlt0xc/Eg7uSvNjBrAMpsPnCUs1q6rfzAI1IxbgJ/py11pz0t
	OZcoaa9puerCP6XlbC3d1IbfL+60dPCuzQiclFh6bv2UZKVoqFhXvXawRNuA+uH1
	TeBkVGdQy1MmfdRkmNcmC1gXhonYs24efnR6MAuiuzkNW4uF4C2xnkj0Oa2fLAQe
	1gfBBb+J3Poz5X6qBLz5wXi3fedSQzOuqBYCE9/uxsCDYSKQ2UHXwQjsJccNCLYQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vm18sjr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:28:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I9vmSK001623;
	Tue, 18 Feb 2025 11:27:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5mytww3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:27:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IBRw8Y31523448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 11:27:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C9E58055;
	Tue, 18 Feb 2025 11:27:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8944E58063;
	Tue, 18 Feb 2025 11:27:56 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 11:27:56 +0000 (GMT)
Message-ID: <a3673878-9f74-40b8-b0ef-136905c93c4e@linux.ibm.com>
Date: Tue, 18 Feb 2025 16:57:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 6/6] blk-sysfs: protect read_ahead_kb using
 q->limits_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-7-nilay@linux.ibm.com> <20250218091209.GA13262@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250218091209.GA13262@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -QCdk3fJNwrd9ISB6W-Zz9sEiiRIPiQc
X-Proofpoint-ORIG-GUID: -QCdk3fJNwrd9ISB6W-Zz9sEiiRIPiQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=826 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180086



On 2/18/25 2:42 PM, Christoph Hellwig wrote:
>> +	/*
>> +	 * We don't use atomic update helper queue_limits_start_update() and
>> +	 * queue_limits_commit_update() here for updaing ra_pages bacause
>> +	 * blk_apply_bdi_limits() which is invoked from  queue_limits_commit_
>> +	 * update() can overwrite the ra_pages value which user actaully wants
>> +	 * to store here. The blk_apply_bdi_limits() sets value of ra_pages
>> +	 * based on the optimal I/O size(io_opt).
>> +	 */
> 
> Maybe replace this with:
> 
> 	/*
> 	 * ra_pages is protected by limit_lock because it is usually
> 	 * calculated from the queue limits by queue_limits_commit_update.
> 	 */
> 
Yeah will update comment.

Thanks,
--Nilay
