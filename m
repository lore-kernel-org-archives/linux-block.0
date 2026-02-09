Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13AE2E542A
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638537; cv=none; b=LdoZqiVJ1nxYl9WgoYW9aer8tzyECXCWYP22Ek9Vonabo1B5mbu5p3YaPd+onYqKOHfM4oW4ujPt7A+xadQ3YjW9bJiSSLLS1Svwl+bSCGs0WbW0coiaAS/5YIWuMVEkutyJWtbEfENNsFjfz4pX/tGmUZ01O8fBmAPqGueVqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638537; c=relaxed/simple;
	bh=7C07J6jSmYGWYG+7USL+sSOBiH2cX4O0C5tQmk+MUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijoKEZjT7SZ2R/IqznVwZoTTHpGlpY8N7FJrrj0luml2pRqeLzhf70RpD0p7bzGn4YFevlMpM2y2CjUTWauIX0+tdu5sTTZe0dYAoB7E/qebB9rAmxX2f87F/DGtEo8vUoXmKzpxLcNuDFjDPRQpOEATEysEaH5zC6AyKQ3K7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Px584EiF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Px584EiF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6190Rsk9608141;
	Mon, 9 Feb 2026 12:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PHfXuG
	Xdkin7WaQJ/hXTDVhFvLZMkLitpMTNwa9cb4c=; b=Px584EiFw/8UrpQHYgzGm1
	2kpjbGjJIxbtwoa5cIREhKR9tYpsizXl/v2V+5Msi/bAw+ryc2rfCM8Dre6LGI3L
	tp/yadTJrzhy+fARBXoy20Jgmh23Xu5OZbMijhZDCBReWntXcI/01rALGfY72/ZT
	89zo3GYz8mTNeoOfgja0PbUXTdJwb0NlJglSp8kWVYDeNiUIchIZ1dboHWWAYek5
	3Pg8shhqBjB4091m9hCA6fKx2g2NnbL6Wgb/hBAIKUmsaGkCC4d0mg8ynBfUVbcJ
	ZN4M422oDkjXiXalo9hCnh0y6xa95CZMGm0fhzRxRKCJ9gqnQh/vd3n4PavD8lgQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uwkew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 12:02:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6199erkR019246;
	Mon, 9 Feb 2026 12:02:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxjvsuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 12:02:12 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 619C2Bbg24707734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Feb 2026 12:02:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E605803F;
	Mon,  9 Feb 2026 12:02:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32085804E;
	Mon,  9 Feb 2026 12:02:08 +0000 (GMT)
Received: from [9.111.86.70] (unknown [9.111.86.70])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Feb 2026 12:02:08 +0000 (GMT)
Message-ID: <42e27ffb-6b30-4737-9c80-76e3b9ccd4b7@linux.ibm.com>
Date: Mon, 9 Feb 2026 17:32:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at pcpu_alloc_noprof+0x8a3/0xd90 and
 __blk_mq_update_nr_hw_queues+0x76c/0xca0
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com>
 <95f56935-9df0-4012-9d82-8f10b021c9f5@linux.ibm.com>
 <CAHj4cs_iETU_7VnfYkA8RF41PHgXsEqw82oCH9_pJp_usZDRYg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs_iETU_7VnfYkA8RF41PHgXsEqw82oCH9_pJp_usZDRYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d9ldzLltHrfG6tLecbvcqlwhUaG5JqJ_
X-Proofpoint-ORIG-GUID: d9ldzLltHrfG6tLecbvcqlwhUaG5JqJ_
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=6989ccc5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ZbyQEeeQdriBWLpqdCEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA5OSBTYWx0ZWRfX5YI9VD12uvXp
 l9Ht+uSIh24CH1yLxQAuXDrHATFssThX+wXWcpkccNQIiywZ/Wd2yHnGJ64f0Glum/BHAX7OH90
 SIfh8JchndgrIOwUjaHYB18ozCtvTokEFo1DVrMCizUYM+1H5eJUY09XQAizmnRZcghAOTPgSBo
 zKv0/gb6j8sO0/Um9MDTPGk3aJEQuCcOFYAy1moo8Izc5yANtyYHroQW8XxPfA5BNwaoD/BqVm+
 5pt+KzqdJNCj7kH2OtImRlYTW0ZSBNNGEMWslIB5u4lvWpqL3w/5CuXWOB9i0XTeCNhH5/palxZ
 7ORAqqDBlX31svj8U83zA1Gf9T3Wwq4lxSYMgA3AeFtz3EiTR5CoQ0nwm8mJ3IZc586TolN/M3K
 5AoERfbDXHSH9XJ/2nLCMQ1qYEpxyXh/qq6EdjppyZFssGlKfaJU1Ofk3g8QirM/rfK2N33LFeI
 3urwAXIHKWoix4538Pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090099



On 2/9/26 12:13 PM, Yi Zhang wrote:
> Hi Nilay
> 
> In case you missed this bug report, this issue can still be reproduced
> on the latest linux-block/for-next, thanks.
> 
> [ 1549.643282] run blktests block/029 at 2026-02-08 08:22:30
> [ 1549.968483] null_blk: disk nullb1 created
> 
> [ 1551.208843] ======================================================
> [ 1551.215023] WARNING: possible circular locking dependency detected
> [ 1551.221203] 6.19.0-rc8+ #1 Not tainted
> [ 1551.224962] ------------------------------------------------------
> [ 1551.231142] check/12517 is trying to acquire lock:
> [ 1551.235933] ffffffffa8356190 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> pcpu_alloc_noprof+0x92f/0xf10
> [ 1551.244565]
>                but task is already holding lock:
> [ 1551.250397] ffff888227b5c7e8
> (&q->q_usage_counter(io)#28){++++}-{0:0}, at:
> __blk_mq_update_nr_hw_queues+0x758/0xd00
> [ 1551.260849]
>                which lock already depends on the new lock.

Oh yes, I missed it. Thanks for reminding! I will send out a patch to
fix it.

Thanks,
--Nilay
