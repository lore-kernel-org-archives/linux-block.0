Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68B12E5B
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813247; cv=none; b=boef/rZCM1FGBtX5BAyFo1GqacLSAYOy2Y36twpM/1+dFFFUVZEXfSkcZnpayyASJYejYDpN1gFinw6pBjbD35g4lw3lkRRLwHRajXXSTwHP//iui+Tuh+emUcsuHh3AcUER+M2UkPiwmHqSIoFMhKiVpId4NkhMjiWaqwXNJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813247; c=relaxed/simple;
	bh=pm7eD/nMrVRL7yC8PXeVwHS6xaGhwn4FyJR7MNA6dXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvmPCESVr4c+FtDp04TKIdZSqTht6q0KuECTq4vdMJA27SWqLKJGcbX3nQGNTtNqqBpG4jFnwGR4vs8w/ADeqP9nhkXUw7+VjD1B9/cXToXpcf725xXQBJ/fBmrX8o5mrUczhAXLIzbdlX34Wu3YJ20jfmdJKiez8qfImi4BhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vy4RXdln; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vy4RXdln"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L46CYA024542;
	Wed, 21 May 2025 07:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1/E641
	Jk4/KGAd3cGVrZ5QO+NnDaSZWxWllNDteSISs=; b=Vy4RXdlnOl8JzBcatvODd9
	tvu31+GvL3Sw9PPCxl6pez261jEc18GKjGKjefH5qqTvCDYUOCr6xLwp7ok1qIUD
	CyiaRCLU/krxClS8QjlRsH5faatcq9CyYCWw1U7uCfE+pnR+Wc84g3Xd+USZi6mL
	3VT1KzYSwLf1qJlZo5OieonB0x5+wksUzvWeJDhO8w3eMhOd33qmlzi0G1kGEWa/
	QgM6K+9j59Em39Bq6oUJYkzvU7tesieUrKRfzWNRxqONPi5docfsqvfPAfjPNgBu
	u+5HBvAxB89/mFRkvp4Iz7Um+P8oDGTP0EskhdlP//Fx88w+aM7jXztGhBhCAkPg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rxaak1a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 07:40:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L5TqNE015487;
	Wed, 21 May 2025 07:40:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnb3jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 07:40:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54L7ebfJ26018462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 07:40:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6073458043;
	Wed, 21 May 2025 07:40:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A0BE58063;
	Wed, 21 May 2025 07:40:35 +0000 (GMT)
Received: from [9.109.198.223] (unknown [9.109.198.223])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 07:40:34 +0000 (GMT)
Message-ID: <fc27de62-10a7-450b-a733-c9546948fcbe@linux.ibm.com>
Date: Wed, 21 May 2025 13:10:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix lock dependency between percpu alloc lock and
 elevator lock
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250520103425.1259712-1-nilay@linux.ibm.com>
 <aC1Ropdb5x05WCIc@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aC1Ropdb5x05WCIc@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CMEqXQrD c=1 sm=1 tr=0 ts=682d8377 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7StwjRqtq80G7lL7sJEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: v9_gQzA18AA9lVwkBKUuL8edmZQc5i2e
X-Proofpoint-GUID: v9_gQzA18AA9lVwkBKUuL8edmZQc5i2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA3MyBTYWx0ZWRfXyDcMavhBLCIo 8vLmDEvu2X+IjjyzbzB7jLjN96QpIlHaEW4IlLOiLt97NS5AUdLp2H3VwdxjS5bv7QVg1RQBGv6 3i3OW2m3SgRKXVWEJBhjSERC3Ww/vp/1NPVk6ouyXN/MPJ8OIwss6Am/GdK311J6XgFOWEG5M26
 C/O5+r4rcB5dGa1YBZu8RbajnnHL7+iL9VhJFjrwPY4kWuwDkdPupHD14xv/SFs1MGBJBOWGt9T eI9hw4dAAwkydBZcqtzMpyRtH4J06Rx088nJY1H+BegD+nGTZu8bOhimUqg9505Vdhigs0Bf5iU xn+0pNfAfwAgSzxDtgGCAJrrXGeG+3xd7sC/9Uwe2lcK1avnAT3fu1vGAvKMa7R5fpMnXAI11ix
 NLjGwWV7t0FvtBhiYGmsGT/hf3LFu9S0L+sqgmVqXdDAD1BQgt/6ZhfPQhrq5L2pZLQCMDnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxlogscore=918 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210073



On 5/21/25 9:38 AM, Ming Lei wrote:
> Hi Nilay,
> 
> On Tue, May 20, 2025 at 04:03:49PM +0530, Nilay Shroff wrote:

> 
> Not dig into this implementation, will look into later.
> 
> I guess it should work by extending elv_change_ctx.
> 
> However we have other elevator_queue lifetime issue, that is why
> ->elevator_lock is used almost everywhere.
> 
> Another solution is to move all `sched_data` into 'struct elevator_queue':
> 
> I feel it may be simpler in concept:
> 
> - sched data and elevator queue share same lifetime
> 
> - kobject_put(&eq->kobj) is already called without holding ->elevator_lock &
>   queue isn't freezed
> 
> - replace unnecessary ->elevator_lock by blk_get_elevator()/blk_put_elevator()
> 
> But it needs some cleanup/refactor on scheduler interface.
> 
> What do you think about the above way?

IMO moving scheduler specific data/tags into 'struct elevator_queue' is
a good idea. So instead of extending elv_change_ctx for storing/restoring
sched_tags (which this propose patch implements), we may now store the
sched_tags inside elevator_queue. And as you mentioned, the lifetime of 
elevator_queue and sched_tags are similar, we can release the sched_tags
along with releasing the elevator kobject (which anyways happens outside
of ->elevator_lock and ->freeze_lock). Also elevator queue alloc code 
can be moved out of init_sched before we acquire ->elevator_lock and 
->freeze_lock. And, as Christoph mentioned in another email, the changes
might be invasive but it seems doable. 

I will send another patch with the above changes. 

Thanks,
--Nilay

