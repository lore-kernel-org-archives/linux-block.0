Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC8251797
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792848; cv=none; b=V8pE3qlV2XcD3YqQijexhpXxnffYVyMAb22fR6ner3Afma92USdU33GiijPQUvc/vbiDIuPtKd65xxrEPmXFW21vnlAwLojluEJmIF1sozzcXdM+mqqGO2ANF1qH4XkgIokXhu5HDP+7Od96lFNqB/1TsNulQGMS0SiL4nv3UmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792848; c=relaxed/simple;
	bh=qKRNbi1Xw7gX2CgxUYZvlt0A4c9pTiZyAGQUbmtoD98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm9oKo7J7+BXKYmEX66QmvUPZtLeEf3VMg9odLEuYGF6HwDOVsc9z74b1reCCyvBwQJxmjXjSgw46X2RfCWcxahijh42v52AxJOlOREZMgSi6YF4VFIxSRWyfUGf9MWlAOiH1H3wSTq991nSFutzlv5g1qK3N/gS5IL6JODQkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPMO1Xi2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPMO1Xi2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdmV6020071;
	Wed, 12 Mar 2025 15:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PX0kNF
	JWfpYNwm1oYrG4fw4H9ApUdZ2CZZLhEKe9Qtw=; b=pPMO1Xi2YEcDhTk5LPteUy
	HIzTb/usJFVuug/ogkAwpgbbLAyjn178sNuipjpTFSBvLqsTqQiqS16Uov4qK4l+
	3BsQvUbt0UUf5UDWVIVUxkrFqM2rzQMjyyQKWL7zFAMcjbQQ0W5OJhRPvl9xpDnO
	1veUQ95mn+cjtsnV9ESr5/rKSGd3lhLaBU8bO+tNFIrpQao0od3vLASPnoKWBG8b
	zOi1UY5LfejI5mFrSxgLQQs0ApbwuVRkiEX0Twy+baLxzQyj57FaIBprL3vN+4MO
	PzcqRKmz4O1XnIWhzvLdF0REFPrdrRTi2ogQUx/ePnQW1gmqNlGGzIIoyMEFvrXQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4cmkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:20:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CE1fmv007468;
	Wed, 12 Mar 2025 15:20:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr4rft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:20:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CFKfqL11665888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:20:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E6B558052;
	Wed, 12 Mar 2025 15:20:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21AB758056;
	Wed, 12 Mar 2025 15:20:40 +0000 (GMT)
Received: from [9.61.69.177] (unknown [9.61.69.177])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 15:20:39 +0000 (GMT)
Message-ID: <67682ed5-ecf4-4b84-bdbc-b4d8c0aabe03@linux.ibm.com>
Date: Wed, 12 Mar 2025 20:50:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix a comment in the queue_attrs[] array
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250312150127.703534-1-hch@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250312150127.703534-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v7R25C8hOrssxnRNTvXz14pEa7U2brIU
X-Proofpoint-GUID: v7R25C8hOrssxnRNTvXz14pEa7U2brIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=844
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120102



On 3/12/25 8:31 PM, Christoph Hellwig wrote:
> queue_ra_entry uses limits_lock just like the attributes above it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
Thank you for fixing this!

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

