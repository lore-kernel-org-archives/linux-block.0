Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860C3947AB
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239328; cv=none; b=QiFJcORu3zE5taVOcmo1GBbi4JOOgx5C7g9TEk+GT7d7sPb7fUJBj4ZLIw9OQ9Ez7h2FKWsjE/c+RFI/vqSELCeoSDwVuY8+el4BeE7/KWTvZ93xz+WKneBPJHjse+ZnorAve2iI9sJ4YNUQD/d0ZJHj0/MOm8CSKb6lqpUW15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239328; c=relaxed/simple;
	bh=8N3PGt8JkqWcRTP5VRj6AUwC+XlfqqGHO1JLbv32k0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrqvJcC/flFvRLHJ2Fq+VrfOIZZW4CfO4Pibn64WLPH9cZ+CIeUpTjHYQ3YGwqf34+JLzK3udc7hfYR/NPK4V5YJBYZ4NauvFLJ2iai6NZm+z71VbAH8CkUVrMjUnwilnO43zyTbJX8LLZ/hIjliqQrkw3Cp4Sp+WSutKWnj1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZqKQFDz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZqKQFDz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6489IHv22080466;
	Fri, 8 May 2026 11:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wkhfMx
	Aw3rqbRULFytQvfkpKck6LBK6DwbV8CFYbmAs=; b=gZqKQFDzJSFIBugRQ1kJk7
	Rcq6LOIbMsoMVySIQJnrkmJ+QUsL71YlogMsPSeHn3J7XO1bpXwWu3uYZwdLEi6U
	4iDh1/Yn3Nd0vBzvHclIrxaV8OBzP0D8qz0vck4715n+g3s2SFlouqrHDjJHgKiu
	tHOlqiWHk3FNLSsvkak7u34IO+Rll5s4+S38KK94Xupw9s91n+YSUGXbmGui0vvD
	+ivKeensLgsEdE5E+zeZO6DhHETEpXLqrJPKgx9tzQD0apjLc/AWcpHurlKx7G67
	pA+UBgVTXq7gZONjGUg4go8d4ckk6esxv9Cxbl4LSMzWF0JytVnphaybGRbXRb6g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy229p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 11:22:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648B9XqE011688;
	Fri, 8 May 2026 11:22:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hfvh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 11:22:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648BM3t261276430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 11:22:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED82E2004E;
	Fri,  8 May 2026 11:22:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 002712004D;
	Fri,  8 May 2026 11:22:01 +0000 (GMT)
Received: from [9.39.21.154] (unknown [9.39.21.154])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 11:22:01 +0000 (GMT)
Message-ID: <f3617b18-526e-4006-a692-b704925de24b@linux.ibm.com>
Date: Fri, 8 May 2026 16:51:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] blktrace/001: Skip test when kernel lockdown is
 enabled
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20260424141143.64528-1-disgoel@linux.ibm.com>
 <afIGq_uV-l9_98Px@shinmob>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <afIGq_uV-l9_98Px@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExNSBTYWx0ZWRfX4UiC7HgBPjnE
 g5yYN5WsG8hD0qhn72Ysx93D87DTagnQRnr13d4x25oPwQuC/Pp2FXE65a2+Imzu3sbp/ijAAsd
 AdLjTH1uGG+JhqPloOugAm4L04ua7HFmzHlNVCbDeMmv3bFytUsSvi0DlK9df56dRgRm30xD73v
 e/q+vRc8QQdO15wQPr1DOD1Ho8UDbvGsaFo+WtuOaxXF3ksOMwuA1x2s1nyEhRIh20QjzEmCxj4
 0756Nz5ZksS7NW2u/zoLOwpe35su7qofandcXJym4r+fxx0KACOQ6pG8FbsXOZ5l+7AOdp8eMpa
 WFQJW0+AkM3tqqNoY5H5v7R65h1RVSC5MYNK2ChZHd7sqVswudlvorq6zSqo0Ay3N5BiAooqVUF
 1CQcLXo9nMWcIpRBfEw+g5pHUm3/V7dj+T4BTiJ8HoyQ4d3tSI/29Js+uOlnelrFOQC2JvXK7C3
 hbWczTaMitrVgYdkHmA==
X-Proofpoint-ORIG-GUID: 1W2xKQhsthVnKcVaCZ-bhyMLz3o-wdsC
X-Proofpoint-GUID: 1W2xKQhsthVnKcVaCZ-bhyMLz3o-wdsC
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fdc75d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=_70HN8rbEmtdPUJScUoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080115

On 29/04/26 7:22 pm, Shin'ichiro Kawasaki wrote:
> On Apr 24, 2026 / 19:41, Disha Goel wrote:
>> The blktrace/001 test fails on systems with Secure Boot enabled due to
>> kernel lockdown preventing access to debugfs. The test attempts to run
>> blktrace which requires access to /sys/kernel/debug/block/*/trace*
>> files, but kernel lockdown (enabled automatically with Secure Boot)
>> blocks this access, resulting in "Operation not permitted" errors.
> 
> Hello Disha, thanks for the patch. I tried to recreate the "Operation not
> permitted" error on my test node, but I can not recreate it. I tried the
> command lines below, and saw blktrace worked fine with lockdown=confidentiality
> condition. This means that blktrace can access /sys/kernel/debug/block/*/trace*
> even when the kernel is locked down.
> 
> ---------------------------------------------------------------------
>    root@testnode1:~# cat /sys/kernel/security/lockdown
>    [none] integrity confidentiality
>    root@testnode1:~# echo confidentiality > /sys/kernel/security/lockdown
>    root@testnode1:~# cat /sys/kernel/security/lockdown
>    none integrity [confidentiality]
>    root@testnode1:~# cd /tmp
>    root@testnode1:/tmp# blktrace -d /dev/sdc &
>    [1] 1014
>    root@testnode1:/tmp# dd if=/dev/zero of=/dev/sdc bs=4k count=1 oflag=direct
>    1+0 records in
>    1+0 records out
>    4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00274992 s, 1.5 MB/s
>    root@testnode1:/tmp# kill 1014
>    root@testnode1:/tmp# === sdc ===
>      CPU  0:                    6 events,        1 KiB data
>      CPU  1:                    0 events,        0 KiB data
>      CPU  2:                  658 events,       31 KiB data
>      CPU  3:                  797 events,       38 KiB data
>      Total:                  1461 events (dropped 0),       69 KiB data
>    
>    [1]+  Done                       blktrace -d /dev/sdc
>    root@testnode1:/tmp# blkparse -i sdc | head
>      8,32   2        1     0.000000000  1048  Q  WS 0 + 8 [dd]
>      8,32   2        0     0.000013242  1048 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 1 depth 256
>      8,32   2        2     0.001495890  1048  G  WS 0 + 8 [dd]
>      8,32   2        3     0.001497997  1048  P   N [dd]
>      8,32   2        4     0.001499079  1048  U   N [dd] 1
>      8,32   2        0     0.001574560  1048 1,0  m   N bfq0A new_ioprio 4 new_weight 40
>      8,32   2        0     0.001577177  1048 1,0  m   N bfq1048S allocated
>      8,32   2        0     0.001581069  1048 1,0  m   N bfq1048S get_request 00000000e21f70ba: bfqq 000000001cef6c8d, 2
>      8,32   2        5     0.001583291  1048  I  WS 0 + 8 [dd]
>      8,32   2        0     0.001584861  1048 1,0  m   N bfq1048S add_request 1
> ---------------------------------------------------------------------
> 
> I would like to understand why the blktrace error happens in your environment
> and does not happen in my environment. It will affect how to judge the skip of
> the test case blktrace/001.
> 
> Could you share your system set up conditions? FYI, I used Fedora 43, QEMU VM,
> Intel server and v7.1-rc1 kernel for the trial above. I'm guessing any
> difference between the two environments causes the blktrace behavior difference.
> 

Hi Shin'ichiro,

Thank you for the detailed testing and feedback.

After further investigation, I've identified the root cause. This
failure is seen on SLES 16.x and RHEL 10.x with 6.12-based kernels when
Secure Boot is enabled (kernel lockdown active).

I tested on upstream kernel v7.1.0-rc1 with lockdown enabled, and the
test ran fine. My apologies for not testing with upstream earlier.

The issue is caused by missing debugfs fixes in the distro kernels.
I'll work with SUSE and Red Hat to get these patches backported to their 
6.12-based kernels.

I'm withdrawing this patch as it's a kernel bug, not a test framework 
issue. Thank you for the thorough review.

> P.S. I found that kmemleak does not work when lockdown=confidentiality
>    condition. This indicates that the kernel lockdown feature works for kmemleak
>    as expected.
> 
> ---------------------------------------------------------------------
> root@testnode1:~# cat /sys/kernel/debug/kmemleak
> root@testnode1:~# cat /sys/kernel/security/lockdown
> [none] integrity confidentiality
> root@testnode1:~# echo confidentiality > /sys/kernel/security/lockdown
> root@testnode1:~# cat /sys/kernel/security/lockdown
> none integrity [confidentiality]
> root@testnode1:~# cat /sys/kernel/debug/kmemleak
> cat: /sys/kernel/debug/kmemleak: Operation not permitted
> ---------------------------------------------------------------------
> 

-- 
Regards,
Disha

