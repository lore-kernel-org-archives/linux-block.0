Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C217202F97
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296529; cv=none; b=QbFO8QDdAcZ/1N4IHstaCYoDKTyDEZgxzfZTVWjlbNKjbTdAnaV3m1kBIJA7WTd6Fq+mvq4Q0qPDGmzyveLb65ZWKMklJ7DjeiFyGs1kAEx0aKgUIXcrc+/dfcdZRckO3eDpex7JYIkZ3CS7f6qH4RI0TWyI5dOT4vDWV26JbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296529; c=relaxed/simple;
	bh=r5fralXCrsyjZCxXOuGFf4XbHkkusfoSksmz3QkWApk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/2bCyGBI7gOVXSTLeSkG4KUgFsm2pEozS2tinvXf3BdtBxfFfdYD2RcQiJCDH245svUJpYrMnQl/1pjjYMYCzZc8KFCn2jF4+EMUABxF63ojfmbOT4eNKIy+AXG8ajEMSlFTe0bpcW1q7hCXrjeubq8jcHhKL2GTFdom2iKq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I/notMIB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I/notMIB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6kUPu022695;
	Thu, 10 Apr 2025 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4CiXg9
	B8BTHCWnk0iy8NNO89XFAnC52HMDDFUg0NHMU=; b=I/notMIBpOirC+Z35GPzqB
	8C4FWKbOKZbizzvsUVWwtMW7y+2GASXgaOo0U9/tNgUKCV2wyt44xf6drkK87Bm2
	Pthk+2/SIg8BxBTn/C99+I7TaFumYbZosMxXBtdiZFYb1ZhsCRK+z6rnyrv7QTlF
	g3VgMx/Nf8Mdu4hEuXCb97GbhVq/xkYDuajxYMSeqyk6N1LTx3HOgdOF4/7PLMVF
	Ie1lrxdMmJTxEI2DI2X2qHXHPHb/li11IET8uakhlF2L429Ib4sbABWI4LI08hkw
	eEqrXv7XfN/ldRChji9j8Jkl6ecxymtF7qGrO+h1Pkp9nfwcE+s9g7J41lTaKJxA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x02qdb4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:48:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADnfMO017702;
	Thu, 10 Apr 2025 14:48:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kx9dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:48:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AEmd0B24183352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 14:48:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 691655805D;
	Thu, 10 Apr 2025 14:48:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B4B5805A;
	Thu, 10 Apr 2025 14:48:37 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 14:48:37 +0000 (GMT)
Message-ID: <c0f4c3cc-66aa-4a27-8d69-c9d2c6b460bd@linux.ibm.com>
Date: Thu, 10 Apr 2025 20:18:36 +0530
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
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
 <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
 <Z_Z_Vt2Rv2UfC1qv@fedora>
 <5c2274c0-fd82-4752-b735-32e52de2a80f@linux.ibm.com>
 <Z_concavD65-DXqA@fedora>
 <917201e2-acac-4ab0-982e-04635806304c@linux.ibm.com>
 <Z_fUaumnM2lzQKIh@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_fUaumnM2lzQKIh@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9PNRk16WkKR_wNB2gtxE73DX-TZz2hoK
X-Proofpoint-ORIG-GUID: 9PNRk16WkKR_wNB2gtxE73DX-TZz2hoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=948 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100105



On 4/10/25 7:53 PM, Ming Lei wrote:
> 
> I just sent out the whole patchset, which did one thing basically: move kobject
> & debugfs & cpuhp out of queue freezing, then no any lockdep is observed in my
> test VM after running blktests of './check block/'.
Sure, I think our emails crossed over. I will review your changes.
> 
> So the point is _not_ related with elevator lock or its order with
> freeze lock. What matters is actually "do not connect freeze lock with
> other subsystem(debugfs, sysfs, cpuhp, ...)", because freeze_lock relies
> on fs_reclaim directly with commit ffa1e7ada456, but other subsystem easily
> depends on fs_reclaim again.
> 
> I did have patches to follow your idea to reorder elevator lock vs. freeze
> lock, but it didn't make difference, even though after I killed most of
> elevator_lock.
> 
> Finally I realized the above point.
Ok great:)

Thanks,
--Nilay
