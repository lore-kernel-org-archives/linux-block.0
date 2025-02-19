Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546D1DE2C2
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954505; cv=none; b=QkTi+yb5dcP1HpEAnVIK0Z7SVTfMMADvWwedcGpKGy8UBONzmbEb1v51LgLTurrTKSRaXlbLNbdBVgwNEozG57cMTRdt5tZ5nGU6/iEE4tuTAOGZQb4D+w9uPgGJNq49IUpbzbQoFOBVra0xzv2I3m5nvgaHcTZs+xaRGPjRpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954505; c=relaxed/simple;
	bh=MJ3uSmhPz46EcFb8b/v6R+YheaMqwShXCuP18UbPl4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptNdtLz/gHvU0BswWtSKFSJReZ8ju7VhMcCCO6PX35RbKAC/4v5NbXMrzBQycIhWnC0d4s4WhKWe0NZTfeZ564fyUWnQxhm45sQsIU2LHWY6R4gTWebY2X4i0YT/PzmKehjaaQc49PE+0ZpiEHNiVN8/niV5eMp1bIDEH9q9JCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ik9vzXNS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ik9vzXNS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75DFk011701;
	Wed, 19 Feb 2025 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Js0CPy
	J+6rX42tDtLUE5JOv6OCBlFpmiR0O3jZy+NFk=; b=ik9vzXNSuvLRiKPcRYE7ia
	fvZyRi7JFzR0MICdGjsBPYYLC9kpBNECZgCvoa0pgijYcZHKAhjQSC9Cbe1PYhCu
	7dqlvqtsbsQU3zB5qEv7/Nqu/hryNXNiZ3hrvzvEq0irRqQL6TrsPmTICGMgGs0+
	Lgtv6mxh88gvqOMff5zfjqIT60GfMYumHGgugHUXaWT4XspWFPBXJVi87q0dwBo3
	15iUQ5lzZI27BdzTtTIvMylGKA3gci3ZMZaSYuz/CeYQxD4N3ccOC3b9qr19jo3I
	9ewnoPd6rJxXtrF1O8CFqgEkWj20eQa9Rnb4Mf+RFf46pLm2tSXGTjGkr2SYoPXg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w5c99mpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:41:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J6i8r4030118;
	Wed, 19 Feb 2025 08:41:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x33ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:41:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J8fSAh53084482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 08:41:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4A558056;
	Wed, 19 Feb 2025 08:41:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B369458052;
	Wed, 19 Feb 2025 08:41:26 +0000 (GMT)
Received: from [9.61.184.147] (unknown [9.61.184.147])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 08:41:26 +0000 (GMT)
Message-ID: <3a993bd2-e982-42f9-a74e-1afc20b1dc70@linux.ibm.com>
Date: Wed, 19 Feb 2025 14:11:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/6] block: Introduce a dedicated lock for protecting
 queue elevator updates
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-4-nilay@linux.ibm.com> <20250218090516.GA12269@lst.de>
 <e54fc76f-2bb8-4d22-b297-7cd1c94b7e88@linux.ibm.com>
 <20250218163235.GB16439@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250218163235.GB16439@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -0E_oBpEIZpsrobMQCor7qWo67sSOzyI
X-Proofpoint-GUID: -0E_oBpEIZpsrobMQCor7qWo67sSOzyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=961 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190066



On 2/18/25 10:02 PM, Christoph Hellwig wrote:
> On Tue, Feb 18, 2025 at 04:44:44PM +0530, Nilay Shroff wrote:
>> So now if you suggest keeping only ->store and do away with ->store_nolock
>> method then we have to move feeze-lock inside each attributes' corresponding 
>> store method as we can't keep freeze-lock under ->store in queue_attr_store().
> 
> Yes, that's what I suggested in my previous mail:
> 
> "So I think part of that prep patch should
> also be moving the queue freezing into ->store and do away with
> the separate ->store_nolock"
> 
> 
Alright, I'm addressing this in the the next patchset.

Thanks,
--Nilay
