Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1123AE95
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601839; cv=none; b=Iu7G/MNbztNGz6Vard4rSJhjgeTkooXCmP55ZHJrsiHcHnM0zo0Uy+SSDpNLAGV/4Yp4neiiHTOkv0/U71OXMm13zwWDuhNizLZ4Hc0ypB4lEj/NEby9qk1ngafXFiXs8WTS1s67Xr+hmZCVgSbkWtB432LJJ+fKzJHqlOmi7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601839; c=relaxed/simple;
	bh=4a6UmSCyKoODJby3LXu6YGt7sOZlP4m4qZ2d80vWQNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX3uZs/3v/6I4Tfns7uodlWyLJn2VrP90BiarOJVe8kiiPDqbQ99h4AIpmKb1/+Gux4Ye3t07/6wTJBctzs2HOxYwH86tBGeaEUbxEluy6bBDOZpmq/RwcvHkd+dozPx7r5n4sgYaKq3rcp5zWEr5H5Ph1C5i2D4hv3yRKrktgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rg4jREs1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rg4jREs1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532CTG6d022885;
	Wed, 2 Apr 2025 13:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tLtm6z
	h+ETTVEz3KqxCUTzXDwY1Z1r2/4si8njR4HT0=; b=rg4jREs1UFNZjUQLFtgJ6E
	BEC/yG9d3IiU5Wb7P6bdgjTVvd4LoznOwuMEGfRvkmZx8fE8cLWfK45yGZ9WWYpW
	L7cHrjNDn2IhzpX6H8XJwcTbjSji9JbMIcHKdVifhuto54DXI0MBSjOwRxLH2Zaz
	qZev8Cmrz+HjU/wIP45BBNrfCrO753E1BgIgKuy8e+hclyE6CtoLT9ZF/PD4jlC6
	FTEBAvmak1/GAq+iP4PO2AREwyiAThw/MpcCczKBnEqm1DBSS9I3gtiIo9abLq31
	go3XZIIziVYF8wYQPYs4nC4yGxBAlDzB93aEzFfw1TVwBEyN/ol04rss1b3wziJw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59frdas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:50:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532Bwn2s004788;
	Wed, 2 Apr 2025 13:50:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45puk00a3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:50:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532DoTEI27197920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 13:50:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA2158053;
	Wed,  2 Apr 2025 13:50:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 762E258059;
	Wed,  2 Apr 2025 13:50:27 +0000 (GMT)
Received: from [9.171.6.25] (unknown [9.171.6.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 13:50:27 +0000 (GMT)
Message-ID: <366d8c29-b3ae-47e6-8973-95b57121a4a8@linux.ibm.com>
Date: Wed, 2 Apr 2025 19:20:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: add blk_mq_enter_no_io() and
 blk_mq_exit_no_io()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>
References: <20250402043851.946498-1-ming.lei@redhat.com>
 <20250402043851.946498-2-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250402043851.946498-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EOn8j036Vt2MK6wNZKLSVCmxkJwgPP5b
X-Proofpoint-GUID: EOn8j036Vt2MK6wNZKLSVCmxkJwgPP5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=727
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020085



On 4/2/25 10:08 AM, Ming Lei wrote:
> Add blk_mq_enter_no_io() and blk_mq_exit_no_io() for preventing queue
> from handling any FS or passthrough IO, meantime the queue is kept in
> non-freeze state.
> 
> The added two APIs are for avoiding many potential lock risk related
> with freeze lock.
> 
> Also add two variants of memsave version.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I hope you will spin another patch replacing '||' with '&&' in 
blk_queue_enter and __bio_queue_enter as you mentioned in another
mail. With that change, this looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

