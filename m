Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90208288CC
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745070368; cv=none; b=QDvP3O04/9YsDYMypDs2tL44qx32PY70SzQY5gxbbHwOVh2taHCCygTnQL18z9pDHER8xqWVuVeUV2aXZOEPH2iWvvmNIyrtoEnx6Pxgx0pDX3J6ytzG15JQ1vwB2rcgQeSq9rD9z3zIaOSVbP8e8GbKIMvbZnMwMXxG0RwdoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745070368; c=relaxed/simple;
	bh=aclP742DW33GRrzdAnouk6T1KxqU4qfYJ+4Lj/cxIB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz032SRx2jQ1dXfZT8mLwiIx+kjDhaIJXAwJYVMbBMLhBcF6Vxir68ml8Fqg9/hYJWUMnzz4RFqXi1uF3J7qRLERfbLXayUl6ro9z8J1UEzKsoEe1gCjx1WuGOokifqUCIwu3VEz2Gvvf0Px2cGqp2KNzvtk7Wod2m7WTuVKhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pi1l20fc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pi1l20fc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAeaD6008563;
	Sat, 19 Apr 2025 13:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p/M96R
	2AbDxRh6O7V96C/AJMvQMlpbuCT9F2iOVoDME=; b=Pi1l20fcx0mQcZpYb0HPNe
	hdmAPWd/qtXzg+npfoFkspZdSHpCRj81c5vjUhsIwCAFLTGD1OGwLJIAxQoOT9YU
	lg1FoRM7EEkTesHgv3s7ZR8m5Qu7I0wDxxlHaWFFuheA7nWCuLolAPJzu/uCA+iv
	zAjaGAR9MvX/GjpsvmjViglexj4F+PikkxXmrMYwi2Ed4iKCOIlqdCZw1nppAkzO
	SdUeInNoH6mAvaoJOVQK9VkReOZxc+XAphekfaqKtvK7XS9L8l55CsXB5zPmvNLx
	BEYrlvUsiRr5vBG7/TDb4IhCEoIsIrCPEIVkSDe1lDnBGH7u4Z+R9KVCpgUwQizg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464a9rgdmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:45:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JD3q5L005544;
	Sat, 19 Apr 2025 13:45:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4647kx10md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:45:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JDjwgO51904902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 13:45:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22265805B;
	Sat, 19 Apr 2025 13:45:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D6C58059;
	Sat, 19 Apr 2025 13:45:55 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 13:45:55 +0000 (GMT)
Message-ID: <ee7ded53-bd1c-4af1-9950-749dd28a4db9@linux.ibm.com>
Date: Sat, 19 Apr 2025 19:15:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 15/20] block: fail to show/store elevator sysfs
 attribute if elevator is dying
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-16-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-16-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8UOTM5LsDcqJ7LABXHl47AeGIDfcGtWb
X-Authority-Analysis: v=2.4 cv=WJp/XmsR c=1 sm=1 tr=0 ts=6803a917 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=CN9nN8RuS3pNm5fGDLgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8UOTM5LsDcqJ7LABXHl47AeGIDfcGtWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190111



On 4/18/25 10:06 PM, Ming Lei wrote:
> Prepare for moving elv_register[unregister]_queue out of elevator_lock
> & queue freezing, so we may have to call elv_unregister_queue() after
> elevator ->exit() is called, then there is small window for user to
> run into ->show()/store(), and user-after-free can be caused.
> 
> Fail to show/store elevator sysfs attribute if elevator is dying by
> adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
> elevator ->sysfs_lock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
