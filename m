Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509A34BA59
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759071726; cv=none; b=N90sYiZEZLosdfLCrbdBQBJQLwiDqXghBKlQ3AbCDTvr52j2+FJdWzXFq1MNn5Q/km2PYT3aPyxo5r+ZrKZTVQ/hXgRj+fx70fwVVlvd7zS7ovBImOQKhJmR7d2RlZu9woVwgCSccrcIBqslKuAa3NajpJ0klpqk6rlvzqj00Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759071726; c=relaxed/simple;
	bh=1P/BK8fLD6+Fe2Sh5ePmuyqiayQLSjgWAj3oOBa0ZbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USXN8oEO7/hj1Nhaw2Ew0EPzzFKPiarigw6MtOTEfF/tr6axT1FZwZgRlfuA8Dw8OmRZcLXP0vIJW9Nc8hh9CkZ0ZVTjfaJhsGlqAi95a9fWoIVWNp1QQIzUHRb8DC8EI/sM4Wind44sCYCZ/cOTAPj+4NPrUfBumcii20g1yHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DNzfMAlV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DNzfMAlV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SAK5B8008510;
	Sun, 28 Sep 2025 15:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AYfXGs
	QBDFXJRcKXSfquRb1hEODFJZgk+R+FxXnl0Ss=; b=DNzfMAlViGI4y+gaDZYfVF
	1dlYtUUl3iJE2rXQK3QwvHE0fTa2PMQ5OPQwkzWZDwRIRSn+1iDfxTq+NwGqlZIN
	9RHOVkYLJ1xC5pwut9uIm8lAICySSaEmJl/L/OZt5WDAp6PMlBj0rajiveqCg8rq
	M5A/EW4G2VNw2mu/ouY89tIyEQFb4UIv/xroDJd0xQr8uYufNWl/hEvvWSSd8oXU
	97AgV9JP5r/tV8CXldlL2NNev2e2UnpnDVhg+7UvbR6BT1i+tCjH2EC/ZvJjZATC
	ydrHA1NUE2RaeT2tqF9G44Vx8lHQUBpgYLrMOLWYj691R5Jpq1mBozSyP0p4clJA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ktwypd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 15:01:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SEaq74024121;
	Sun, 28 Sep 2025 15:01:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0ss44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 15:01:49 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58SF1m6G15794870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Sep 2025 15:01:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C3E58045;
	Sun, 28 Sep 2025 15:01:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A4A58052;
	Sun, 28 Sep 2025 15:01:43 +0000 (GMT)
Received: from [9.43.71.234] (unknown [9.43.71.234])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 28 Sep 2025 15:01:42 +0000 (GMT)
Message-ID: <84f405e1-8726-4c90-aa40-dacbb28ee29f@linux.ibm.com>
Date: Sun, 28 Sep 2025 20:31:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Double-free in blk_mq_free_sched_tags() after commit
 f5a6604f7a44
To: Niklas Fischer <niklas@niklasfi.de>, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Cc: vbabka@suse.cz, akpm@linux-foundation.org, axboe@kernel.dk,
        ming.lei@redhat.com
References: <37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68d94dde cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=8QDA8OVxI78L4LCaHNkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: v5Y98ae59iHT99A7FWHGbFXIt84RXoJ-
X-Proofpoint-ORIG-GUID: v5Y98ae59iHT99A7FWHGbFXIt84RXoJ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX4jqWQW6W4b9b
 hO7k3ij3cq1RBtqVCkzqSFIjgjtRre+e7tz66cvYniYxrwbAANt6tDE1QCPK5fiNKGjuH/OwS4S
 cMX8heqDdidjvM65anmaBGAyc+Nl5d/7NrRWEsgIQilJlJfrr2scPrG2oITMY9Q8xnF56gDni4q
 oxMFW5KJ1CGgrSr8Dapjgg5zt21XXexdrx1J/fDyp5fYl0c2+9j5Gx4NQca+dDMURdqL6WVvYLd
 K7HOQkWF6WSRpKro+NMXJd76pTWY0sFXnIo2mIgfIGkQhQQjYiEdO5Oz+ngIS/jeKR2PsTRUU8+
 qAGa4zMGeSapWisfVaEBuwex8Oe1kBlWQ/rFCCiISjE+qEZ7PdL7MYffD9A1Fp8UugQ+3F/xwLl
 f7fg//vShxN6IZ06X/K2M9MrM+a1kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025



On 9/28/25 5:38 PM, Niklas Fischer wrote:
> Hello,
> 
> I'm reporting a kernel crash that occurs during boot on systems with multiple storage devices. The issue manifests as a double-free bug in the SLUB allocator, triggered by block layer elevator switching code.
> 
> === Problem Summary ===
> 
> The system crashes during early boot when udev configures I/O schedulers on multiple storage devices. The crash occurs in mm/slub.c with a double-free detection, traced back to blk_mq_free_sched_tags().
> 
> === Crash Details ===
> 
> Multiple crashes occur during boot, showing a severe race condition. Seven separate kernel oops/panics are observed:
> 
> * Oops #1 (CPU 13, PID 928): General protection fault in kfree+0x69/0x3b0 - corrupted address 0x14b9d856a995288
> * Oops #2-4, #6-7 (multiple CPUs/PIDs): kernel BUG at mm/slub.c:546 in __slab_free+0x111/0x2a0 - SLUB double-free detection
> * Oops #5 (CPU 1, PID 952): General protection fault in kfree+0x69/0x3b0    - corrupted address 0x2480af562995288
> 
> All crashes share the same call stack pattern:
> 
> elv_iosched_store+0x149/0x180
> elevator_change+0xdb/0x180
> elevator_change_done+0x4a/0x1f0
> blk_mq_free_sched_tags+0x34/0x70
> blk_mq_free_tags+0x4b/0x60
> kfree+0x334/0x3b0  <-- crash here
> 
> === Bisection Results ===
> 
> I bisected the issue to this commit:
> 
> commit f5a6604f7a4405450e4a1f54e5430f47290c500f
> Author: Nilay Shroff nilay@linux.ibm.com
> Date: Wed Jul 30 13:16:08 2025 +0530
> "block: fix lockdep warning caused by lock dependency in elv_iosched_store"
> 
> This commit moved sched_tags allocation/deallocation outside of elevator locks to fix a lockdep warning, but appears to have introduced a use-after-free or double-free bug in the process.
> 
> Reverting commit f5a6604f7a44 against the v6.16.7 tag results in merge conflicts due to subsequent block subsystem changes, making a clean revert test difficult without significant manual conflict resolution. I have therefore not tried this.
> 
[...]
> P.S.: This is my first kernel bug report. I've tried to follow the proper conventions, but please let me know if I should format or present anything differently.

Thanks for the report!

It looks like you were running a tainted kernel, and the kernel version
differs from the stock upstream version. This likely means some modules
were modified, built out-of-tree, or unsigned.

I recommend trying to reproduce this issue on a pristine upstream/stock kernel.
That will help ensure the bug isn’t caused by external modifications. Otherwise,
you may consider reporting the issue to your distribution. Bug reports get the
most attention when reproduced on an untainted, upstream kernel.

From your log, it seems the tagset (request queues) being freed had already
been freed, or memory may have been corrupted in between. If you can reproduce
the issue on a stock kernel, I suggest enabling KASAN (CONFIG_KASAN) and 
reproducing the bug. The KASAN logs will be very helpful in identifying the
root cause of any memory corruption or double-free issues.

Thanks,
--Nilay   

