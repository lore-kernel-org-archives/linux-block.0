Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95081EF38E
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448937; cv=none; b=hHX8RXgwxzG9YTWaRbeQXSnMaYBEeQduWgmZdPTOgx8bm6WKXOUJKXBrJKlZki/YohM/gEzMbB/x9e/7ZBY1yVqpTIGMW9S3PkN9+Enpzm2VGwjDb2OgOgjCSl/ymKFOACVtiMRy0IDsggdT9aNRRXxnTm9YuXrswfqU5fFpq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448937; c=relaxed/simple;
	bh=POwKV7Mww41b+dmG2Cv5UFSyrCQBjWoE5PhmAbiC2eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYHD8fH6ZUzGsFSX/Fa1yG6//vcQVPr6oajlxXXtUxUshNIty7OjjC7ZBduZQC2citYO8JU+N0VjM7ZqjmCJBYrQBlr6FgL970P0Qs8Bs/eH8gmjNqVdvtc3LjdzDM0O+jq8JZiLtvALrn22r/PTYXvRoQmRwROc+/UwswoKEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uqc1PUzn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uqc1PUzn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI4NJvq000631;
	Tue, 18 Nov 2025 06:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mpNPU1
	ztQhbBaWnDgD7ekPRZ+5G21v52263lMRR5qXo=; b=Uqc1PUznu9m14QjyrdRIwu
	XpkFp65EBBojb6vvKGC83XFqU567Z8pD6S1V1NzK9s1JuSJsQoXBqBY1HD/hNvE1
	XvRt5DYmr0jD40uiy/9E5Ac9Bm+W/uBzwy8LnSFData/RrsyaIS0V8vxOv9zeBfc
	Uf79piCsjDWpDFWg4BB+uwOi9SoVn1QZLnmyZhiULh41s+CKKFuzx7dp5KAXeQxd
	0dv0ydkO4T5OmcwsQ1mRyJ2Ncl/mU3HovYMyE22BGCMunXMi7nREfb7zRI2wTLYn
	dsmN37hpMV6aGanXmKH04rFvhd+4Kajia48SdDoa4H4zcVjwpwPRxa4oXiisB7wg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk19fbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:55:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI2oDhY022042;
	Tue, 18 Nov 2025 06:55:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umssrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 06:55:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AI6tDao20644468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 06:55:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADCFD58067;
	Tue, 18 Nov 2025 06:55:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 456E358056;
	Tue, 18 Nov 2025 06:55:10 +0000 (GMT)
Received: from [9.109.198.217] (unknown [9.109.198.217])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 06:55:09 +0000 (GMT)
Message-ID: <bd7693b0-42ad-4d71-83bb-7504dc99210a@linux.ibm.com>
Date: Tue, 18 Nov 2025 12:25:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] fs: Add the __data_racy annotation to
 backing_dev_info.ra_pages
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20251114210409.3123309-1-bvanassche@acm.org>
 <20251114210409.3123309-2-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251114210409.3123309-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691c1853 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=N54-gffFAAAA:8
 a=hORVDZkrMQ24SuxRumkA:9 a=QEXdDO2ut3YA:10 a=RMMjzBEyIzXRtoq5n5K6:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ZSaQjxMbKBnh-ucBSgU6QUGATIh_IaEN
X-Proofpoint-ORIG-GUID: ZSaQjxMbKBnh-ucBSgU6QUGATIh_IaEN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0+o8JPKgomQ9
 YpJ7bm5D+MUk3fZljgKQP4ZnkNc14Z5DkqXfFwhCZWRsCNUZlnw9xdoFybpUcbilSfAIQLoKMFn
 cUwsK1zoT57pAHhftUGz4QaQTS0ljBymf8PSSvOCH/dB7P3GWEq1NZLhzwq7cJB5gOnykf6646s
 JOkiFRIyUk6gFzT6AjTBZIKK/aDbHCRlHhLYcBxNeIE+MavCYxTDfPi52pSzISTDW7UAZ0E1ba7
 dr4Vmezsuq4AjFr7s+lLCZHOlGiyCBmYiu2IOwZq+/KdYDnx+vOves2gGuJZXA9Ndwg5nRoI28E
 42or3arItMDqF8c4hScFjYAqa9U0xlTcLbpga8JFfvqVhcsNqC5uXQYe3mEZfs3PpFamGe68WlI
 ip3cS2se5La6SagRDCRlr/oNXmIo2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032



On 11/15/25 2:34 AM, Bart Van Assche wrote:
> Some but not all .ra_pages changes happen while block layer I/O is paused
> with blk_mq_freeze_queue(). Filesystems may read .ra_pages even while
> block layer I/O is paused, e.g. from inside their .fadvise callback.
> Annotating all .ra_pages reads with READ_ONCE() would be cumbersome.
> Hence, add the __data_racy annotatation to the .ra_pages member
> variable.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
