Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E63FC3
	for <linux-block@vger.kernel.org>; Sat,  5 Apr 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743861638; cv=none; b=KFITh3hYOYWzzKXIxDn8QF610r+Db+RgWw+rCY0L+Vm1lrVMdYQEoHQcFcelrNY8TjnHieRfpgCTYEP8Xakb9OEY7uNrwd5eU5jEx9Cvlb1xvU2yPOht5BiUbrywAtdr6UB2yTYDMJdCtNIAONUN+9iY4/lFrY5oUHMxnJW9DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743861638; c=relaxed/simple;
	bh=qLQdPMyAiUOQhiDTes7ITmTGvMtz3g18Fa2JW71tliU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNkrtONqpsl99LJ47QIndGSJVlIoS7dAXr8VUV75yRwiGZ96pd0pLSBiVB/tLMHXD04fjqVFz8gt6PJg9kPMgKwXeHdVuONImRDtNg7VN0hI3tAiXz0cQ36cH9T7s8ZV10sF6HN2yBaNsW5sWEmsEJmD3hn8Zmjrq63Crsihj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0S1eHiC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0S1eHiC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535CSW7L006210;
	Sat, 5 Apr 2025 14:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h18yjk
	jYXnNManAt4aeMOeRRSzmGFhSE0Y9dlemWftM=; b=r0S1eHiCRhB0e6fudZTw2b
	57bTGOmkMCriCgWCmBs3Q1x10co7KxAg9KrhwIXgjWTveXZHAamX058HkoTR+q1O
	e4JGoP79sex9SfCQbbDRTOztmdbYmzh2vZLktGKjdpqOt4mpfC5GRA7CGZ/6aZ7w
	0Rbkm4KCGWLXFHjiRbD/xduZsOrwMaWKSXE8n0i+X6OUzNE3BJbHdACEUQqAg3BU
	N0tdR6Khp2FFDSnUfjxOGVA/Ot6kh7713OJ6LJY9Ipc3hLGDDFOrKZmJ+hGeo3jz
	2qLDWJyqNt0xlNRl2Qshw/m7J8hM+6Ds9rFrADEe4nEWePo//EJeLbo8qZp3xbiQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45u4jar743-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 14:00:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535ATEt8001928;
	Sat, 5 Apr 2025 14:00:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45t2ch7kx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 14:00:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535E0Ppa21234194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 14:00:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB68858055;
	Sat,  5 Apr 2025 14:00:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 698815804B;
	Sat,  5 Apr 2025 14:00:23 +0000 (GMT)
Received: from [9.171.30.151] (unknown [9.171.30.151])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 14:00:22 +0000 (GMT)
Message-ID: <dfdc782b-1c71-4517-a572-db3e7554c2c5@linux.ibm.com>
Date: Sat, 5 Apr 2025 19:30:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <9933c2e6-1cbd-464c-a519-b7fa722a8e4d@linux.ibm.com>
 <Z-6aMa6vqzsLJMNm@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z-6aMa6vqzsLJMNm@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: loQ2BvfruCmaAj3DmLwTANgTJnkkA06L
X-Proofpoint-GUID: loQ2BvfruCmaAj3DmLwTANgTJnkkA06L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=642 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050087


>> I don't know why we think your earlier fix which cut dependency between 
>> ->elevator_lock and ->freeze_lock doesn't work. But anyways, my view
>> is that we've got into these lock chains from two different code paths:
> 
> As I explained, blk_mq_enter_no_io() is same with freeze queue, just the
> lock in __bio_queue_enter() isn't modeled. If it is done, every lockdep
> warning will be re-triggered too.
> 
Oh I see, because I tested your earlier patches without lock modeled I 
didn't encounter any lockdep warning.

>>
>> path1: elevator_lock 
>>          -> fs_reclaim (GFP_KERNEL)
>>            -> freeze_lock
>>
>> path2: freeze_lock(memalloc_noio) 
>>          -> elevator_lock 
>>            -> fs_reclaim (this becomes NOP in this case due to memalloc_noio)
> 
> No, there isn't fs_reclaim in path2, and memalloc_noio() will avoid it.
> 
Yes correct and so I mentioned above NOP for fs_reclaim in path2.

Thanks,
--Nilay
