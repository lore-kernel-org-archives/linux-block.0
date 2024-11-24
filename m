Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4118B468
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452230; cv=none; b=uKaTv6mY/xhFW6O1UXIIgamG8mUaDWiKmcvkamIpvzdBW0TZaiu/mTd9HwwFzEG3TCDxJXc6Xn5R1SoN5XGeS0/8xnP5m0wayJBQJ3W1kSUMczcEteWOx+0jkN+EymkzmORvWw3nC/s2Dz2kH3cZNQaxUpXCj2We8yHghWG2b8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452230; c=relaxed/simple;
	bh=G+FghIvKQCDq40Re2j/XTvw4oud93iSSegNr04gQZjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH9Tn611ZWB9YIrVXWOtuw8S1HjXq7Ht95hnl2hPJmCjlpwWXc0eBxP/+132jd83w4IcVauMAAo2+fyL6pWY9Cd1UHw/aWDVo74CtmVy8RO/4gfmceqdhyK30bPygvEY/zeCXEcEU0lT0+X5lBrwRawHUMyKDyUNuyG12XxzOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oCSs7T1S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oCSs7T1S"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOBjqAS014663;
	Sun, 24 Nov 2024 12:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=njF8xi
	HlKW1gepR/5HbPE7eYM9cc7ArAKPjzVCMZzNs=; b=oCSs7T1SS1MBmmrNXzb7Ew
	lEQ3PvZz/ZqlclPhi+hPw5ZBI34HIrOtZBXAKJCvEtqyGNgCyU3mc4UZhWgLx/UD
	AA/RDlqYWXxgQOnYFNzp4iNv9mYNRv8C2kMosbbXqPHx0xgc0VVrzOjs0tU+AQ0u
	+jAbHkvdfhEgBDp2t+ZWtgOCce+b/kQVW7KgzCPiE5bmQcz7x78dPxO9iwAiEdeQ
	H+2WCJ+DbJSbTzGZABBpqsyqNc7pJSFjWXhPwMgysaMBXUuCndeTKluB2y+7SVNK
	TONoCHXY7t0TLo0GUh4Ces1G5AZxdY/6zM9B4YB06Q304Z8AXrcDd48h5KhIW1lQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n45yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:43:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO3FOAM026337;
	Sun, 24 Nov 2024 12:43:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30rjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:43:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AOChN1h48693644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Nov 2024 12:43:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6318E58055;
	Sun, 24 Nov 2024 12:43:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACAE5804B;
	Sun, 24 Nov 2024 12:43:19 +0000 (GMT)
Received: from [9.179.4.180] (unknown [9.179.4.180])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 24 Nov 2024 12:43:19 +0000 (GMT)
Message-ID: <54d2875b-0658-46a6-9bc0-4fb5faf5d816@linux.ibm.com>
Date: Sun, 24 Nov 2024 18:13:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
        yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
        gjoyce@linux.ibm.com
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
 <20241122120828.GB25707@lst.de>
 <Z0CqnBhIpmf2snuY@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z0CqnBhIpmf2snuY@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5fqu_IulKl6aVlfSOAiS-Qa45HVd_2T3
X-Proofpoint-ORIG-GUID: 5fqu_IulKl6aVlfSOAiS-Qa45HVd_2T3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=992 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411240110



On 11/22/24 21:30, Keith Busch wrote:
> On Fri, Nov 22, 2024 at 01:08:28PM +0100, Christoph Hellwig wrote:
>> On Fri, Nov 22, 2024 at 02:20:36PM +0530, Nilay Shroff wrote:
>>> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
>>> for copying SG list with all zeros. As ZERO_PAGE would not
>>> necessarily return the virtual-address of the zero page, we
>>> need to first convert the page address to kernel virtual-
>>> address and then use it as source address for copying the
>>> data to SG list with all zeros.
>>>
>>> Using return address of ZERO_PAGE(0) as source address for
>>> copying data to SG list would fill the target buffer with
>>> random value and causes the undesired side effect. This patch
>>> implements the fix ensuring that we use virtual-address of the
>>> zero page for copying all zeros to the SG list buffers.
>>
>> I wonder if using ZERO_PAGE() is simply a little too smart for it's
>> own sake and it should just use kzalloc like a bunch of other identify
>> implementation..
> 
> Sure. That'll make it easier to report non-zero values if we decide to
> implement a non-stubbed version of this identification later.

Ok, so if we prefer using kzalloc instead of ZERO_PAGE() in 
nvme_execute_identify_ns_nvm function, as we're using kzalloc 
at other identify call sites, then I would update the patch 
and send v2 where we would replace ZERO_PAGE() with kzalloc. 

Thanks,
--Nilay
