Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254A16F282
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571995; cv=none; b=cjnShRVRsck9nF1d/ErD6sj6a7yt6x7/0SQz0e6N+Umg/SBFhnh6uTClCx8zUsJlEjRYL4rcq92dXKoqFd7gDdnV2MyMKKGDZiTTmJCZI4pnaXxlxGsnHTpvzjfa358NuvKurmgaSHNfaS0XwWCSQzfsU2N5yTEYFYvV21pERPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571995; c=relaxed/simple;
	bh=3wWP0qSrpV/zVdSsZxpyoHImrAx0HB8IsjAz7ljNFm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enEIcdvpcOeNzPOrBFK2SQdnNFmJK0fGaT2QACw+H8e/jUT1E0Ri7CI/prJjtI9Mwe8BZ2pHnKQBQ4svj/RgX8MK8Ga9oenJKOFe3DPuw+vrc5om0qw/sKoIjbcBhO5cxvDU0Sru2ksNh+5KON9Y72xtCykiiaeSllOP1qa/6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d5cactbz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d5cactbz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1ks5Q027809;
	Wed, 26 Feb 2025 12:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4VWikd
	e6/6o4HBdhF2ZNdU6OvfiKxHYQVzYkWyzFntM=; b=d5cactbzng1yWzQbvJNf7O
	MBPiIim0rouvrsO5z+77uPuxVRm0CqFiLe8BnoCENN0tFtCrqORYbJhayizV68ad
	4Pay5oYvNY812n/f15y9heJ/GFvS/J19HOIB+UqHeasM5b0ce0u0S3rVF4QXVGZO
	rRez0SCLKPkT+U39jLg7di8b3jsdQ4S6UdxdWbSliJNQLHCYs94wvRRUQaufzvPN
	5son9wqoga82oQoBawJ8lytCcwEFEcW7zRNozJg1/3qoRW96D20s6lcyVU7p/hLn
	/Dwkj52qCkBW9K6mtTpubpN7kueZrzje1ZPftzm1iTTUK9gjJ8TNKoLHgwAycxUg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5jb0fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:13:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QBafaU026285;
	Wed, 26 Feb 2025 12:13:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnjgj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:13:00 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCCxCG32768708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:12:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6043458043;
	Wed, 26 Feb 2025 12:12:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E38E158053;
	Wed, 26 Feb 2025 12:12:56 +0000 (GMT)
Received: from [9.61.110.139] (unknown [9.61.110.139])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:12:56 +0000 (GMT)
Message-ID: <a993f5e7-37ff-45bb-ad90-3dd33058d4b8@linux.ibm.com>
Date: Wed, 26 Feb 2025 17:42:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 4/7] block: Introduce a dedicated lock for protecting
 queue elevator updates
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20250225133110.1441035-1-nilay@linux.ibm.com>
 <20250225133110.1441035-5-nilay@linux.ibm.com> <20250225151208.GA6455@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250225151208.GA6455@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dy1jiX7PFlzDFwzU7SGU-1EijoLjZoMS
X-Proofpoint-ORIG-GUID: dy1jiX7PFlzDFwzU7SGU-1EijoLjZoMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=484 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260096



On 2/25/25 8:42 PM, Christoph Hellwig wrote:
> This still has the capitalization of the first letter after the block:
> prefix in the subject line.
> 
Fixing this in next patchset.

>> +	 * Attributes which require some form of locking
>> +	 * other than q->sysfs_lock.
> 
> Nit: "other than" easily fits on the previous line.
> 
Sure, this is addressed in next patchset.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,
--Nilay
