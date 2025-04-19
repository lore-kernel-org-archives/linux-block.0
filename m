Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8615665C
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745058478; cv=none; b=Ati67mcBWvtZq9VDc/ZQy62lgCgDzTS13+CFQIuocS6KKv5bxRtdYOAJow/k//d+PJ9QswRLxZqktc5NtGwbr0hsLLAawRMIdBeLWS1Ms4CSgklORVJVSZqdHb/xVZE+ynZAyQf4SH0fgFiDcJj/scbShfqNzUbNLzPpRS4nD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745058478; c=relaxed/simple;
	bh=PpxZfBk0dvJi4L2jmRRhPr7iMDSE9vSHkTimKLBtpcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lvi8q8MhWoM8m4BD+lV2yJ2rS2E1v6RrMZzfLFYWygM1ItaHSFVqEMATyaQaO5Bg1P0eWRHL6ioa8ov2TurxcAY6Rg9i5aCFvApCqM/60oQihaSDtU4aH05GVXP6XIAiOpXTEFpeFBKqnbqOwYrEUmd8TrYq1fK4Vc8KPvp6rbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fph3U1eL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fph3U1eL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J3V32Y017523;
	Sat, 19 Apr 2025 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YwuNHX
	Mn1aLRLjDikjnfCbL0gBauFzAb1A2YAs5EbaY=; b=fph3U1eL9u6b5kqH7g9Kwu
	JbU72MWC4rhvmOMNCBdHbQ06PBS+aZ6O6izEs18I5YTUbdnd3JOmO7MZCWBQkLPu
	qvQdmwWlCyWKhb1HCGnxGad5cWCntDVtvM/YVfL8GPbFRdinmLO79mYOalHDeAOY
	YdrXXU/7bvE2aToV4A3nBQjLFbSr78oaJxHtOaNfLcYqfkaN7P5QdVD8+U2u7zhq
	A0mYCHVagKJttRxNW3/dGqyP56mefTLznmndyE7bf+llcfKIRnw9D4fRh0rQ5S6p
	V2pwhjVnBvqSzN4aIYEEA+L45rnh20ecUdMCKhLbrT2NEnW7wUTlkWERZxtKA3Bg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46418r9awh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 10:27:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J7rXUi000901;
	Sat, 19 Apr 2025 10:27:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w0f8dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 10:27:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JARnCd5833334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 10:27:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735805805B;
	Sat, 19 Apr 2025 10:27:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7787058058;
	Sat, 19 Apr 2025 10:27:47 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 10:27:47 +0000 (GMT)
Message-ID: <5b243f9f-79a5-4c6d-982c-e8e405da4d4c@linux.ibm.com>
Date: Sat, 19 Apr 2025 15:57:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/20] block: add two helpers for
 registering/un-registering sched debugfs
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-5-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YynJpMJtvtF1dzOvN9N-bgw69bUf8iFd
X-Authority-Analysis: v=2.4 cv=BO+zrEQG c=1 sm=1 tr=0 ts=68037aa6 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=NHbPxljx4zl8-zQlNjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YynJpMJtvtF1dzOvN9N-bgw69bUf8iFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=929
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190080



On 4/18/25 10:06 PM, Ming Lei wrote:
> Add blk_mq_sched_reg_debugfs()/blk_mq_sched_unreg_debugfs() to clean up
> sched init/exit code a bit.
> 
> Register & unregister debugfs for sched & sched_hctx order is changed a
> bit, but it is safe because sched & sched_hctx is guaranteed to be ready
> when exporting via debugfs.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
