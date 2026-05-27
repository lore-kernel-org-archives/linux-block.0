Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651A2139C9
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862530; cv=none; b=A/wB4ZVni7TvE4JVXOamzQKT3jRB1Hpcsl/si+OH+KWB9fnkbGxt6Lsw7ieJNWRGRbrCv81t53UJaP0mlZl/2851oeIXcQTupuyTPJr1y8XyEkSOPBJu/Pc/r2FXSMIsJSSuBJ4il93WdFt3cQmSrsbZnbPeXGTH8uqyJCAGqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862530; c=relaxed/simple;
	bh=m9t1vnTu44SqWcP2LjVJUa/9n1FVCVvreiRDBCBb1Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdzIDOsccC5dsQ0B4avWk5RZrb8O/gXbYiyQM25Z6S/fWxF5dU+e9Oto19zMR6RDmuaWqeOdHLtFcXcB1xyEMzdAFBtfpvuPA/i+E1WgLDQHLzUfD5ADtngDeBzZ1cBY7dQtLYyG6ItJEN2tmiO+iLUjpkp8h5RJUOHS4N5kn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jG8oi7ho; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jG8oi7ho"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4UWH735258;
	Wed, 27 May 2026 06:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vM81ij
	pVRIfOQpuUNIseAyAOboBzuQON04OLSxcWG7Q=; b=jG8oi7hoYLlFgW9QTX9GI2
	jx1O+DUH1LVUrbBdtDrVSMA+yhLH/WxDgNIZ5J+Q1O1NAY0afBSXi/N4kLzmj7ie
	cZ3ZU7KYl1dJ29XQhMixipQ6ha4BEo2+rZaX5XxOEOSaW1ex55HUS/IvlTXE//Ku
	WgilKyZ6a/rhuHY1BRI4bS9OzsPt1TtGVN6ijHcNJFhsj6+10FjICRJ1ZLn4ng9K
	hmlBhUDQsvYRmYgP5fieeDHFjCw4bhqpRc+o+5pZ4YDOfqSyexG4mPGTyswpqXA5
	nwsm/N5LmeYAo50T3XB/KFrfmJVVAMFnuWS9lRNQXV1j8sgfrQ22U5ahD3NNT0rg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc6nu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:15:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R697VE009592;
	Wed, 27 May 2026 06:15:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbsnfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 06:15:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R6FA8S30278196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 06:15:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8994258060;
	Wed, 27 May 2026 06:15:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6566D5804E;
	Wed, 27 May 2026 06:15:08 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 06:15:08 +0000 (GMT)
Message-ID: <39d29c16-8159-4765-b1e6-09a4354e33ea@linux.ibm.com>
Date: Wed, 27 May 2026 11:45:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20260526153921.2402015-1-kbusch@meta.com>
 <20260526153921.2402015-2-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260526153921.2402015-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a168bf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UFKti7nZLArcjxYJBigA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JW01OkM9uoDNUAqp0-nrJXgUbPVx6NL0
X-Proofpoint-GUID: JW01OkM9uoDNUAqp0-nrJXgUbPVx6NL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1NyBTYWx0ZWRfXxYO+jZRZHjSv
 rbEtE1UqHem20UooKryyFFrMFGn62Xixz3Jn4uQQyO+fs4fnF/Uw3hVDj68GjnwaQAIlzyd9tfJ
 xgN12ESZ5ySV62e2LJdGCUsun8BW7x6BjdpX7/+kTuXcvSdyoKdxiWgS8I9M6h2E1So5x0tvZSW
 GN2woNlj7LmB6nlUrO6Rvguk0L6GyvHqEwDy7pCP9BFPT9NbhW2ZrNZHKOeg5x8U2V3hCRbrZG3
 EYUOVdPw9iq2CfK3OXmuRav7RT7DcNUqQweOtLKa9KvVU6J413O5vjOD1Y5Vng7zMBV6haEt7sz
 NsnHo8PiFNgD8RNWe6TqgjleBSG0yyQ/xAjKmUCQdQDGoZnkKzg4vCf5BxM7bDwhQb791S5H7K1
 vDrvA1w5/HQ8t79Z0Rrz6iVmmJQeD+qmLIU1K8nZRL0Aa6PiTfo3LB5N5VSKzGUCiJ2NY7wrX7q
 3S8Ys7Z5quiab6RWzgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270057

On 5/26/26 9:09 PM, Keith Busch wrote:
> From: Keith Busch<kbusch@kernel.org>
> 
> A user can enable io accounting for passthrough requests, so export the
> helper that checks if the request should be tracked. This will enable
> stacking drivers to to report iostats for passthrough workloads.
> 
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---
>   block/blk-mq.c         | 32 +-------------------------------
>   include/linux/blk-mq.h | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+), 31 deletions(-)

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
