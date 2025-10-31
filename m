Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA831984E;
	Fri, 31 Oct 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914390; cv=none; b=p8O95qpNTH5JNWNSqtb9/qHttHHlzjK6IbVlFgldj7yJelOf1wwBMXoBZvWYhB3yyv83uPHzaQuvapqd/xZ9dtmKkMdnRz2HAOPCSo3ctkBe1Y+lIdu0o4VG4vEWd8s4X86rVdG0/1JTU7FTX64HN6IU0ri1BXkHqn8LOlN5qyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914390; c=relaxed/simple;
	bh=1buScPTeb/ox8Bga8aRVncUBu+gAauXXjelfBteBYJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMAjBo7Lu7UjYNhMOyIkXj90wwPTXc3jElL6BN6tE78/cOdCx8f5PrGdzHa5J79RaYqiVjAOzpBEPSuPI/OfwKIEq8ep4Tee6k9n0Rp+vfNbSKJHIqufeZUQ4Y+NmdgxLOxiFbnPJu3Ca0ue48QEF4mv6jYwRxHlnT81l+jRYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SyUol3iE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SyUol3iE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VBfplw003476;
	Fri, 31 Oct 2025 12:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x6FGaQ
	QxBeqtle+k2oD7/XqlNemqN7h62fEHwf4FQh0=; b=SyUol3iEjzBVuT6yitlrX8
	tZqTxSBiHee3AeC4pQzof8giTFIJDwJugSoWH2LsuXDtAa+tIj0P0P9MK9SvYLja
	XXfHsZBqr/ya1A9nPISzdIYZENJpzzQ7FOFYZNoJLbuH41Lb2JmW3NwwjdAkubeW
	j9VlibYn5ePaFfYWdadJjRVbH4/VgSPSudxJL2eKIKtR5g4C0CqpvgUnZ/9Qi6rD
	vbjQMgvdyhgYi1rDsHJd9Rule9TJ4fZQxTaAc6UVhkfeyKNoU86j4s9ODsf7lQu4
	yfFtc6o9JeuTDOXdzPBPOF1c3pHOvimSFp5Q+poAwUTIcQrPmQr8NXGj9SDqD41Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8wvev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 12:39:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCHfPN023873;
	Fri, 31 Oct 2025 12:39:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vxe5fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 12:39:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59VCdUgE6685580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 12:39:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C575805C;
	Fri, 31 Oct 2025 12:39:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4782758051;
	Fri, 31 Oct 2025 12:39:27 +0000 (GMT)
Received: from [9.61.177.173] (unknown [9.61.177.173])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Oct 2025 12:39:26 +0000 (GMT)
Message-ID: <befb4493-44fe-41e7-b5ec-fb2744fd752c@linux.ibm.com>
Date: Fri, 31 Oct 2025 18:09:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs store
 callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
References: <20251030172417.660949-1-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251030172417.660949-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6904ae04 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wizq8IQFKyYBxb2gEWYA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 3WH8RB96vTR3Ehmtv8oV1nasuG6HEVdu
X-Proofpoint-ORIG-GUID: 3WH8RB96vTR3Ehmtv8oV1nasuG6HEVdu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX+BI3tCCGE8z+
 NkGLmSVaODbbBdDvXW6RrpKTh+60gGSQ0c3lqpUWINdd1nHongs+p7XaMbEzn7ajGnYR006IdwN
 Vual9ssMdpZ+KZWWIgmIHNJFewthv8ihS1lEFNhoma4p77gm6Zn6J/pPqwdNqdd6pCHtwY5yggD
 Fi2LxXDwqJ6a6r+BMDYxzky0HOi82/WAyHzflbE3644P2njK5NCk69Pa3iJeuFEEDwnAnUCW58S
 kiRW6ou7kpsdfbVsiIlWIMohulIOQ+Il7eViSLftEh3A/Ah8PBwNr6Yqt4N1vDMr0inRMOH7Rq0
 GJYfEf8CCnztMrgN5RqkGcfy+5jMypQ+6wG1WtS1tPqWI8PA7gYLu27DIwH2iIKYc6oHgA8ip1l
 vCUbxWLOtzTqrmtlOFs/U1GjBCCyxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166



On 10/30/25 10:54 PM, Bart Van Assche wrote:
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.
> This patch may cause a small delay in applying the new settings.
> 
> This patch affects the following sysfs attributes:
> * io_poll_delay
> * io_timeout
> * nomerges
> * read_ahead_kb
> * rq_affinity

I see that io_timeout, nomerges and rq_affinity are all accessed
during I/O hotpath. So IMO for these attributes we still need to
freeze the queue before updating those parameters. The io_timeout
and nomerges are accessed during I/O submission and rq_affinity
is accessed during I/O completion.

Thanks,
--Nilay
