Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FE2E7F24;
	Thu, 14 Aug 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160881; cv=none; b=D9uVhJkx+tkdPsZNTxmbJMZoJIhtM+T64/TfLI+sQhWeW3SYUpVqkGuPIwIA+jI/u1kmEeuZ5vQ2Ji4oIrIK2g09axmDBy1/9n7trkxUqYMyL6cDeZoaFsCSgsUL4oSRFG5zfLDk6a1H6rxfu8+hzDDI6P23N5zUUtIxIwtkW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160881; c=relaxed/simple;
	bh=urFHfDpAaEwD3x6zhyUk0BuKL3I2COp/MxP4vvc5kWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaKIxgILvUW+2gHoHLf13btl5dQROx+oPp5Z3LS/s3L1r80hNbfVgQNow0Gb7F1nCQZeS3nMMMAr0gsdFoA8CT13PugZ+QsjfZJzdl4RVN2vbXaNCDfjZQ83p3LFIrXYyRbbraLDyBP5aTyOf+YUNjfa+/63K3g6rtZIihEeaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GeT6h+X6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GeT6h+X6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLjgIf017660;
	Thu, 14 Aug 2025 08:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JHCNvm
	2+ynE9Uw84mKesX+gkhWJLcGGCJebpw1P34HY=; b=GeT6h+X6muJh4le82ea//5
	KO5nbb1ywh3nFGui6C17l4psGvLla/jEhyEeuw2TM84zVD6yb2EHbV/ri3SdpBlK
	R0JbKzbcJbZ4LhKRYcOJQGvRLDSWZt4BMP5SrGzy7zK5dm8xlrfalIqehFwBKwso
	0TW6YNznNsTk4sYvXvJ3xeOjUy5gEaR5QUR6QKj91/rhAMCh2wp725TpPwJopEOe
	n8qmxc7vmunivUvJWZgtM8uPEsHzZQENppODBV+10SVjoMG9Y3SQ8CxBZuRocmM6
	FFtA7bdhXPYs+iYLwds7h3yd7p+DM9ci/5viobXTbPbtj1XZr5rIZEu/cG6vjCpg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14s25g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:40:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57E8cKDg011567;
	Thu, 14 Aug 2025 08:40:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14s25d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:40:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E88Gqw010646;
	Thu, 14 Aug 2025 08:40:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnuukec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 08:40:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57E8evP735455702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 08:40:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EF9B58058;
	Thu, 14 Aug 2025 08:40:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 070C158057;
	Thu, 14 Aug 2025 08:40:54 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 08:40:53 +0000 (GMT)
Message-ID: <36e552a1-8e8e-4b6f-894b-e7e04e17196e@linux.ibm.com>
Date: Thu, 14 Aug 2025 14:10:52 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: restore default wbt enablement
To: kernel test robot <oliver.sang@intel.com>,
        Julian Sun <sunjunchao2870@gmail.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Julian Sun <sunjunchao@bytedance.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, ming.lei@redhat.com, stable@vger.kernel.org
References: <202508140947.5235b2c7-lkp@intel.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <202508140947.5235b2c7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gNxq9_Qka0gGmz5WeRklr3lWt7EmU34V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX8nqxcqX6dKuc
 e1zAqSwHirjxY79bsTNW+drzxQ4a9kOualx0rWBpgIGdgD4/1m6a9oFuk8PDC/3ATbO+ITGYjj2
 /aEv80MrIZnE5fR5l8ScmSwPsd1V5A+3CBdwXbaWFSS4ewfWXZRwedsEXjvmRs1lBWDZ0RabtvB
 LHnAXXcCvKMwC6Rxt13j5BSCSNAb+v+CIVr6KRntrft+xXJlgEjfRZGzT7liwckabna/SL+yICC
 j2JaNYjRSG+o+DIfKjDk/BNS6iIZ4joo7+ZjmKxwYlfrnm2k5biOSYOxbC72sqYvem9eh3XNocx
 9BaRgCXYK3QANWeQTOxXi9lwafA0ygq9PonID2eZwy9T8HPANYeNu9eby65GSFO8BcjrqMa1mmG
 D9vYa7q1
X-Proofpoint-GUID: OzzEr4B4xzQUohPLpKXrvhXUZ93T4Wgb
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689da11b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=968KyxNXAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=AdoSGP2KCbnpTv79-mAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224



On 8/14/25 1:38 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:
> 
> commit: 555859c514d9b8ca62ca2f1553bf6291ceee1e3a ("[PATCH v2] block: restore default wbt enablement")
> url: https://github.com/intel-lab-lkp/linux/commits/Julian-Sun/block-restore-default-wbt-enablement/20250812-234518
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> patch link: https://lore.kernel.org/all/20250812154257.57540-1-sunjunchao@bytedance.com/
> patch subject: [PATCH v2] block: restore default wbt enablement
> 
> in testcase: boot
> 
> config: i386-randconfig-012-20250813
> compiler: gcc-12
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508140947.5235b2c7-lkp@intel.com
> 
> 
> [    1.575968][    T1] WARNING: possible circular locking dependency detected
> [    1.575968][    T1] 6.17.0-rc1-00012-g555859c514d9 #1 Tainted: G                T
> [    1.575968][    T1] ------------------------------------------------------
> [    1.575968][    T1] swapper/0/1 is trying to acquire lock:
> [ 1.575968][ T1] 420f00b4 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_inc (kernel/jump_label.c:191) 
> [    1.575968][    T1]
> [    1.575968][    T1] but task is already holding lock:
> [ 1.575968][ T1] 46342678 (&q->q_usage_counter(io)#9){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave (block/blk-mq.c:206) 
> [    1.575968][    T1]
> [    1.575968][    T1] which lock already depends on the new lock.
> [    1.575968][    T1]
> [    1.575968][    T1] the existing dependency chain (in reverse order) is:
> [    1.575968][    T1]
> [    1.575968][    T1] -> #2 (&q->q_usage_counter(io)#9){++++}-{0:0}:
> [    1.575968][    T1]
> [    1.575968][    T1] -> #1 (fs_reclaim){+.+.}-{0:0}:
> [    1.575968][    T1]
> [    1.575968][    T1] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> [    1.575968][    T1]
> [    1.575968][    T1] other info that might help us debug this:
> [    1.575968][    T1]
> [    1.575968][    T1] Chain exists of:
> [    1.575968][    T1]   cpu_hotplug_lock --> fs_reclaim --> &q->q_usage_counter(io)#9
> [    1.575968][    T1]
> [    1.575968][    T1]  Possible unsafe locking scenario:
> [    1.575968][    T1]
> [    1.575968][    T1]        CPU0                    CPU1
> [    1.575968][    T1]        ----                    ----
> [    1.575968][    T1]   lock(&q->q_usage_counter(io)#9);
> [    1.575968][    T1]                                lock(fs_reclaim);
> [    1.575968][    T1]                                lock(&q->q_usage_counter(io)#9);
> [    1.575968][    T1]   rlock(cpu_hotplug_lock);
> [    1.575968][    T1]
> [    1.575968][    T1]  *** DEADLOCK ***


This issue is already being addressed here : 
https://lore.kernel.org/all/20250814082612.500845-1-nilay@linux.ibm.com/

Thanks,
--Nilay
