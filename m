Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C22EEE8C
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663554; cv=none; b=mje5lmlJ3BvrPUq7l321jQhsQVDpKW34sgEJaWOGfgP4SwkTgaX6/Fp334D/GTQWgBPsyK5THbboQaed+9VwEKPReMazdI/5bFi1DP+YtaDlkbhg/5O5cZ55U1RzDZlzqIV9jKtmQ/qzTIdy0zkRbMm9k40SITQ/W4WKQANzXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663554; c=relaxed/simple;
	bh=b5sujOasI7BciUkGtvewQcsChUtInmNPyLYwLMKH9Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT+1zg+ZXiLcOXZ6Qgnm0qt5VQy/veTviA6Zkt3VdsE7tcqoZPNy27Dz+o7nx9P0+TeQwEu5bJj6NAliIA+zpj9KGu8XiE4x+MAtQhPqt67+chTKCOtaViSuIPhPiXN3Xt2Id+8fcAcafUQbVfEiog0dEOeMUt38S9jG0BhrOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gP1b2SwV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gP1b2SwV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6553CP6A3945052;
	Fri, 5 Jun 2026 12:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DQ2az/
	GHsAihkVEN30KE0FYJrYyLJJVdcr5bxsqICQk=; b=gP1b2SwVtWY/lOzNKn9/wi
	0hW541ybSy6lCqK+/iNHmICKlQFRSeRq5GJqBTDTPS+EqLA1pDwITirkG8sVsZcP
	I9cXwRpg8qWNRM+LGwMVL94pTbH+cSamaXRWKGVbYNk8OhIjV5KFsPu1DgMa4qDA
	/FDoujaQSdG6kGqyLbiBhVRj7MQuWk1wPl0MB2tJa6JJ/uCP6ABZomKPEPzuy1BJ
	tLnaBdHX96n3vnZNfW8uyspQSk7oixrJk7flLehjPQz67+WxuDA7OEW7UVSijdjz
	ARxXqRzTLSFexZldVPIPczCAjuffU6bXAYAOt9/FVv0EsbvWVWh+Q57BCb/OOTUg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4mhhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 12:45:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655Cd5Ve006541;
	Fri, 5 Jun 2026 12:45:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw9t4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 12:45:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655CjfuE64094698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 12:45:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA2365805A;
	Fri,  5 Jun 2026 12:45:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E51658062;
	Fri,  5 Jun 2026 12:45:39 +0000 (GMT)
Received: from [9.43.126.215] (unknown [9.43.126.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 12:45:39 +0000 (GMT)
Message-ID: <013ee998-7b98-4870-950b-806eef46cf9c@linux.ibm.com>
Date: Fri, 5 Jun 2026 18:15:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] Enable lock context analysis for the block layer
 core
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <cover.1780419600.git.bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEyMyBTYWx0ZWRfXzAB2d3R8Tuzq
 A3bbRRyD6n8wPaxQ+Nzu0qiXgaYNzqN4yliJEH7s1/Eo4N2qMCWHD+AHWHdahSA9rFClNB2T/2A
 WUeqZSheIczZ+PlzklIZCftTe91JC0Cb2CKbqR7nnCsBKQ/J3ibY+8v3vbVhOhtTL6vO5SnJ6qe
 ulBLhfbTYcievsl51pIQLnUHBFoC0pYc9Hy4sGDjwXp7SDFc2yE4M0DHnv5akhNxbaTrB0rfz3/
 h89LbXTF/hrI/x10GK2JiUTblBfnhI9p5pXBSi8MeEu7hlUxSl0FnKNXlZ9BQ0vbpl5W7s6Yuuo
 6Nr/QWI+cpQL7L4QXTHR4OZlrd204d5EHo+9d41XxoHzZpANyyccS/k8/v40DZja+WTUebfMgl+
 hcEvyl+5V8mj7W3oY3qmWLJAMVVhKXYFq38ZQOWz7lkTVm1X3Lb/rZUMYHXZh6jjyy3bckTX7jM
 0yb11wYSKb2V4VXusKw==
X-Proofpoint-GUID: 9eXZ1PuFj8iJKwFoHIP4UHfT5h1WZo7j
X-Proofpoint-ORIG-GUID: 9eXZ1PuFj8iJKwFoHIP4UHfT5h1WZo7j
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a22c4f7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=kvhjZrD4pgufEI7LdaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050123

Hi Bart,

On 6/2/26 10:37 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> Recently the following patch series has been merged: [PATCH v5 00/36]
> Compiler-Based Context- and Locking-Analysis
> (https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/). That
> patch series drops support for verifying lock context annotations with sparse
> and introduces support for verifying lock context annotations with Clang. The
> support in Clang for lock context annotation and verification is better than
> that in sparse. As an example, __cond_acquires() and __guarded_by() are
> supported by Clang but not by sparse. Hence this patch series that enables lock
> context analysis for the block layer core.
> 
> Note: although the Linux kernel documentation specifies 22 as minimal
> version for Clang for context analysis support, this patch series requires
> Clang 23 because it annotates function pointers. As one can see here, a patch
> has been queued that fixes the kernel documentation:
> https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2@tip-bot2/
> 
> Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> Bart.

I have reviewed this series and it looks good to me.

One question: I still see a few block-layer functions that document locking
requirements with lockdep assertions. Should we also consider adding the
corresponding Clang context annotations for these where practical?

For example, blkg_create() requires q->queue_lock must be held by its caller, so
it could be annotated with __must_hold(&disk->queue->queue_lock). Similarly,
blk_report_disk_dead() asserts that disk->open_mutex must not be held, so it could
be annotated with __must_not_hold(&disk->open_mutex).

There are a few more similar cases. Would it make sense to cover these in this
series, or should that be left for follow-up patches?

Thanks,
--Nilay

