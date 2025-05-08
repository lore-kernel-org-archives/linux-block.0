Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A472211484
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702731; cv=none; b=Jkl3P9GWBCMFQuP4WCStc5tDvNqNKEQZOYwHAlEULIZRuu7JoHOGlxO5tAG3vqYYSDxHXiYERxqU0X9e+e+H00LJPIEI7nSn6wcb59rq0TbQ+yqUgjTIE56c/f3s2w0qzO+puS7Kpw6HdjhsR2A4V2wtu/mXG/NxbPMPb4rJl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702731; c=relaxed/simple;
	bh=v0Y26327z67pp/pLz8MrEfBP6U1HM7jH5JEfWbBQzUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NClCH+bsanSR7mcC0IB8V6V4X9mYfBii58J40j9sgIVudqO+WgBHBXhb4b9hOBx4INslF99hpqMbC74AU97GfXE4jKua25e5AXjvrTqoJuD19rLhDMa7s06vRBonvg8zXd3H3aAzZjOrAbE09vEd6+KRMzbXsZ/L5692m+915/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D/VFr0ig; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D/VFr0ig"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Aesp2011880;
	Thu, 8 May 2025 11:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CDwHp3
	g0d6jpVBAnp/NVYQsuKAhPOnEyy1Hfi7OE9SI=; b=D/VFr0igp4NSgMlES7GSrL
	QIYOsRWkXNSeW3BdfmfeJdsUYS0pLcHPjNnDFdFDb8VWH6BVXOeGNrxgZHKimIWl
	VK062jyTyoNyokZuCYwB2UQXES37GCUu8pPuhzQMO7ndir+E/7FD9hP3NvY/2kpA
	OiyA4aViy20tudRYt7bXEnp2cNiOI4jFWGbzppvk59xLd9L42I2me+IzXi/rwsgV
	EFAm2TBUY4tfX4dZI64QDo+IGxa++Hf0a6a9YYOHJJ0rSsu57zO4Kyw6SqQMUQQf
	D7RODVwLLn8vWWtFb9F1N0aRtvGnJgNNl81wdf2XV5RIHQuKIvzqfL/63HN684mg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t04c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:12:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5489YUND004243;
	Thu, 8 May 2025 11:12:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2a51k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 11:12:03 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548BC2um28246602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 11:12:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B59A258052;
	Thu,  8 May 2025 11:12:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC4458050;
	Thu,  8 May 2025 11:12:00 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 11:12:00 +0000 (GMT)
Message-ID: <69833104-6bf2-4180-b97a-0b4ac7027304@linux.ibm.com>
Date: Thu, 8 May 2025 16:41:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: don't quiesce queue for calling
 elevator_set_none()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250508085807.3175112-1-ming.lei@redhat.com>
 <20250508085807.3175112-2-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250508085807.3175112-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681c9183 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=ne2r-GkAe_ZdeYTjy7sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s8K2Ht3FSeDfWv__gK5ZgOI8nunWPiwK
X-Proofpoint-GUID: s8K2Ht3FSeDfWv__gK5ZgOI8nunWPiwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfXwuboU9q9WsPF i/yr3hIC3nKMGKJlYRCgCMp3snQwjMDTGimoPza8E7LxDLA2zKPXxjfpKOckWLql3tW40+UGH9U NXtUWOu924Ew4hnLWX5PnxDfU8HdjZUWesHJfsVd8s/Le6Uaojfe8PWGGupiw541vSJxdq6mIFP
 JV0X++M0FlqTmC6OT0GJRGN69Any+wCy6K2vZm3JG0y7RTa/S+p51KfsSgFPj4v7UsrdR6qb9Hs RLXV9FrVHAMr60lv3xfcR9MB8iV5Gs9t4AqNN6eh+67ScXEbHbIYYJjVgEbEy+2k6DYAaT8ImxQ xOnYN/hyUcMA+IPgx0XL/P+Az3LXb0+Mfh2Qia/5zRcJX4JPzhQ2ryitHjjAS19+u8wj7LiLE5M
 dMySvn3suQtchxCJDI4Wkp+IAfE7RffcMTIvEkbGGHoeKnkERopXS+ICaSjf5Xk+dIwQZOgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080094



On 5/8/25 2:28 PM, Ming Lei wrote:
> blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> never return if there is any queued requests.
> 
> Fix it by removing quiesce queue around elevator_set_none() because
> elevator_switch() does quiesce queue in case that we need to switch
> to none really.
> 
> Fixes: 1e44bedbc921 ("block: unifying elevator change")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Maybe you should add a link to the issue this commit fixed. I just
saw Shinichiro reproduced it here [1].

[1] https://lore.kernel.org/all/mlycu6p6zl5z5mmqau7otbfw35kcvnajpsnm3hokpfnafc3bwh@m5dp43ypdfpz/

Otherwise changes look good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
 
