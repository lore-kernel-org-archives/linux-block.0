Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012178F2F
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071092; cv=none; b=HXeG9D6qO9/2kSHwQsq2e+hdU6j9sEHuGpln/cpUtgH3LI/dH5uoKPUan+raOzkYKmV/I2A+fVQN4Lwy+1BfrBVuON9i7ebKeW3nLP7khWNGKIYLCb+xtGFEABTnN0Qt/uc6gHekSEy2m2QK+NL/1fhYeBm2GiVXKTzfVD7Gn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071092; c=relaxed/simple;
	bh=x0ZDsoWsjqMs90UXa0WaywifwIsow94Xl7zCiQPQ7HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yht8bsB2UYtGVMHuLpQxZg2dH8xsB8RR499ksQd8PmNoL5QFEWAfYd4zdS8DBf6Sy2IWtrSwKa2KZ8/6ED5qiz2ch5RXTImMd5v3xhb+idrR7IIk/nV0Vfq9OGSi3rNkQbPoUjTrooxiqPy3ud85HjDEkE/4fPKbpcYcjGF7cxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TVVK3wYc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TVVK3wYc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JDgKPB024525;
	Sat, 19 Apr 2025 13:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e74ApH
	7vUhBQM667o6/i1LnkoI47Zxt5Bp7vxMoUd50=; b=TVVK3wYc8j8ed6dEkRWw6Y
	7z9y6Zhyl3orAWTc+7Lj9U1cqS3vxG9C8DYnew/kPUbECh9YLdutJXrOeSD9w5j/
	gXbctI3S6CXl9LeU29ghC+/8FXJDHkFdlYBrxQEz1XU5IAaPwB411FvQE14hRyxj
	09XkypwI3nGm9zlNqcxOdiHzbHJGhwzBk53C3QL0RBvQ4UbfsKLQR4QrPep37RJM
	5CM0czqeDXbVOVRhjnNsdYnYkrv3gXf97oF3+aZivkEhrr/BSlaceLEmh9ypq3Iv
	tWzjeTcvMHrHS9rKQrC3jThN3X+THMnbTcL2TCZO1QmXt3o3eMpclL4nIgZ2wJMQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464a9rgep2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:58:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53JBbJwm024880;
	Sat, 19 Apr 2025 13:58:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtyxr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:58:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JDw1rL3146254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 13:58:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7995C58059;
	Sat, 19 Apr 2025 13:58:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96AFE58058;
	Sat, 19 Apr 2025 13:57:59 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 13:57:59 +0000 (GMT)
Message-ID: <aea2e98a-2e5a-49ae-bbe8-16dd7b742218@linux.ibm.com>
Date: Sat, 19 Apr 2025 19:27:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 17/20] block: move debugfs/sysfs register out of
 freezing queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-18-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-18-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GPiY6GtDodYfo014QSBJEtrrqTtb6cmV
X-Authority-Analysis: v=2.4 cv=WJp/XmsR c=1 sm=1 tr=0 ts=6803abeb cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=jN0AObelcw1CF9H-eLUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GPiY6GtDodYfo014QSBJEtrrqTtb6cmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190111



On 4/18/25 10:06 PM, Ming Lei wrote:
> Move debugfs/sysfs register out of freezing queue in
> __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> can be killed:
> 
> 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> 	#1 (fs_reclaim){+.+.}-{0:0}:
> 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> 
> And registering/un-registering debugfs/sysfs does not require queue to be
> frozen.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
