Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848523D7FC;
	Tue,  9 Sep 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418134; cv=none; b=HPtYuFVWrwYtIt4yF0c2j23oyHuYr150rj2XEOk0ZzC/gUGDXdAeH+bQm/+1R6HNBQePg+wiJQUDxkk4urhEMFIgzz6Go0HXbdL0mpzo4pj1vDwa1uG7P5h73hSlSjpo+3C5dLfFIrp8OnqlVj/06Ff9f7Bbh/MBf1/cZDLZNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418134; c=relaxed/simple;
	bh=q4dGnsAwDf75FiY3v9c/9H1PL2OOd5nTuj2WFoyNPCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZvalmrfxkMBYvD/e8Cmhr43mskLOeRkVECJVS8IBUD4z2f219bgi4ha/01daihaaE21vlSG0qgHFif+LKX8vu4Jo3PT+wIfwF0ZAaAOIWLOg+gUOANyJygGmcy8Gx4/LgRf9bKWEArALQYQHByxSasv3ldbTnPhrXUAw2roKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hCbMML71; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hCbMML71"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5895hAQr009402;
	Tue, 9 Sep 2025 11:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sws/Kd
	ImKmn+mnpIY5Jhuj1Y/3Xl6FovAvSTvWom9xM=; b=hCbMML71lodwIWCXy5Kinq
	jhUv7/czZ8OzVTJCN3YbvYtoKIMq23YDNvcGI3wYD/eN/6VbO/tGlxy0vNtDbPju
	ObVAUJs4t3WviTzgChFH8appESmoogr7GP7QXQ5JeT6XcmMXyaOl15e0lumU7v9m
	hTipvJrUrwh5GzsVGJ3C5YsXpqknVRGdnBditebTuBtKhsf7MhyWIyYTYqM1VlPt
	S9/+qOBBhzX3QCYw2gtAYJ7wLmefKEanUiIl7enrzSP7Lu6nTHjVqJmg5ouss3vW
	K/TSRr1K0FFo9s+/E7DuPcYW4oXjfoCBuB+zGkg1m752dk2NjYzYpiPppMSD+eZA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff7fng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:36:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899U2UL020700;
	Tue, 9 Sep 2025 11:36:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0u0us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:36:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BaocU32244360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:36:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55AD45805D;
	Tue,  9 Sep 2025 11:36:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9189F58057;
	Tue,  9 Sep 2025 11:36:46 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:36:46 +0000 (GMT)
Message-ID: <32bba3db-c72c-49f2-bb7e-070ce39a784d@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:06:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 03/10] blk-mq: check invalid nr_requests in
 queue_requests_store()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qyMVSPqd26rp3PAC1hdpiUZ5pPrfKGla
X-Proofpoint-GUID: qyMVSPqd26rp3PAC1hdpiUZ5pPrfKGla
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c01154 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=6i44P1fRDzzwULhiCUcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX28Li2Ue8XQr+
 QG2zS80NzunGonWylu3eeOaqplzvG1FYkCW/zsRHVQRrKRPCmzJI+xqMycdftaLTYXw/lX4p4ld
 NfNb9nrMerpCOaWiOSUbWcstMEf8j2bqOfLdK+x4cqLYVZfuuLrTPyzIsZKYsgMrjtwhJz/lX8I
 m4YyUzYfWbX6XUIfrMqJ+VwuWgK+UJ6bWe+fD8IneCMFYrXys8Mdz/EDS65POU+JwDtpEAwJ9gg
 O25zy96VmS4NSyz5CSkUIErOWoMtCTQ3O4+v3CtcNplCR3X/7DD88ztp6jGTzG9WNMNx9YdLcro
 e102/tFxZYilSWy+9oe8IxjXIEjDjxwztDaLaLAuwcXwIYV6cNP9dZic3wjBNkPA3ncoeVo2g2x
 wpQFKVwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> queue_requests_store() is the only caller of
> blk_mq_update_nr_requests(), and blk_mq_update_nr_requests() is the
> only caller of blk_mq_tag_update_depth(), however, they all have
> checkings for nr_requests input by user.
> 
> Make code cleaner by moving all the checkings to the top function:
> 
> 1) nr_requests > reserved tags;
> 2) if there is elevator, 4 <= nr_requests <= 2048;
> 3) if elevator is none, 4 <= nr_requests <= tag_set->queue_depth;
> 
> Meanwhile, case 2 is the only case tags can grow and -ENOMEM might be
> returned.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

