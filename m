Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFB272814;
	Wed, 10 Sep 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498789; cv=none; b=rKwRZFqSw/7mI1IA9/MZwoIEzPGRJILgR7hzm42KT+brYuTJVVxRgiypmE00rZxtII56NS12klrBeqfOJsEJUTsdV4NQy/DVfDLHdnG9vX4ksQmBy7aYKTjYefL1j9mqLhTSFsufQk/SjZ9VJcZOqRekgzdF1aMxuN1ZO2VO090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498789; c=relaxed/simple;
	bh=MQe/zFi9lutWoAVaO0chrP+ZA85GWJhaMSIO/dMZHaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiUPy4j96wkl5RB9qjmgG2J+BD7CnZQ7IAWkf8Ibv8tVzxcs9uL/iBWMJiMUmsixxUCsdZ2qiTWyjeucdbAEZT6laRdrarEDCzkQ7c0ZcVQhZ0IMIHEM7F/myrT8e7LqMoGVtqo547aesLqXH1cT7UO/9egI0iy9FDdRfjoLQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fZwdYxot; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fZwdYxot"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7fFQL010489;
	Wed, 10 Sep 2025 10:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HZtM4t
	rzJRNSwlH3xD0EESxQmyE4heJx0P1ad4aRDlU=; b=fZwdYxotCgN5nPBl7hURDM
	FajunB8rpehz0WKiXFte8aqzqcEm3TIVnaZ96sEO+meig4476uC7fjxZjXTZzptM
	0pSc+7p0kA5Sbz7EJcIb3WQznX+i1XijmW1NaTiWYI72zIXnoNEBgBZqoi2nYt7f
	ogzp4ddwmwLdPjf4EUmJhrNhDIMbuK0E6kjMdR6yKd/1MrI8GEQizNwSZhsBTVVs
	CuX0Mt0UuKcfW/sJBy9suOW9Qy/fhhFg6arnG6VOGMzxA5wGhaJcONTHXSuWGZRS
	RpAt9iMdjn+UWgPsKJHoUBlTaHxVxycTjXNpqIp5dSRhxNVVX4k+VgNaDnvKb5kg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffdcdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:06:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9VoDL020695;
	Wed, 10 Sep 2025 10:06:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp100e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:06:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AA61jl35258802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 10:06:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59DCB58055;
	Wed, 10 Sep 2025 10:06:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28CAD58059;
	Wed, 10 Sep 2025 10:05:57 +0000 (GMT)
Received: from [9.43.57.88] (unknown [9.43.57.88])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 10:05:56 +0000 (GMT)
Message-ID: <66eea7dc-48b9-43b9-ab3c-1c9c8a00fcac@linux.ibm.com>
Date: Wed, 10 Sep 2025 15:35:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-6.18/block 04/10] blk-mq: convert to serialize
 updating nr_requests with update_nr_hwq_lock
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
 <20250910080445.239096-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250910080445.239096-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2vjdUhL-cV-0VOV-JHh23D50pslOfNvm
X-Proofpoint-GUID: 2vjdUhL-cV-0VOV-JHh23D50pslOfNvm
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c14d8a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=FnwBxSr36n09Vd6Btt8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfXzx20bEwcRzy8
 sBKePjchIM1Memybdm2rET8y+zk+JF3IpmoyeFbRZc80cw8Z4FF3jTpabVMbnpfriYLzpjKb1f1
 a/0k9gnA2biyZxt1DO6yIJAL8VcV2xgYUAh+Z1xzrxTlHV2ePQTYD3qdB1sIvePhPZhYI8/xd8n
 Xxznyl1S2DFTADfK34xkSHvStrjLqZmk+t3Qz1pBG2DqnSOfY1wMzvaOEPo8QRECaGFjAgehgu7
 +dhE1ZNoqmwbh+s+bA2ByZvfPLBgw2sbESKcRc5ZA20aslZ/qLFlN9x/+fbtQuzdSCCL9ccMF35
 OxTC/BBprp7anI53VarVf7ReSf7oTSv0cU9DH1s6ekZxPjVXJIB50cj8cej99XDdetiENbiKslH
 UDNO17KL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/10/25 1:34 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> request_queue->nr_requests can be changed by:
> 
> a) switch elevator by updating nr_hw_queues
> b) switch elevator by elevator sysfs attribute
> c) configue queue sysfs attribute nr_requests
> 
> Current lock order is:
> 
> 1) update_nr_hwq_lock, case a,b
> 2) freeze_queue
> 3) elevator_lock, case a,b,c
> 
> And update nr_requests is seriablized by elevator_lock() already,
> however, in the case c, we'll have to allocate new sched_tags if
> nr_requests grow, and do this with elevator_lock held and queue
> freezed has the risk of deadlock.
> 
> Hence use update_nr_hwq_lock instead, make it possible to allocate
> memory if tags grow, meanwhile also prevent nr_requests to be changed
> concurrently.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
