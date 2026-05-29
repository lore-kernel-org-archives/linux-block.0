Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4837C0E7
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074845; cv=none; b=aQCISCwWPnV6j29NG8/E9ydPglc+tfZkgAUSU2sFgyO8d6sCpjC86xuXZNToSl+S0z2pBJmfE6EkL2DsJPSE1my0TgBwaY6LL3WBwIxom+K97ivoSg/2iy5WF5IGWZ56C08OZX5KFbbgYk/lbPt8fKKPS+e0jUfC9VUjGksDPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074845; c=relaxed/simple;
	bh=8HC6lEo+47BXbDxBW7LeHpozKQSzeeCMvD/vWAWzKlg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=b5UOP3VTsH0sSM5gzt10lWAbjZFl7HNxXrE+PL4gkuw2YT9ENhlfIbmowZlut+bOK7emMBbqJnEdDDToGOBzbsBZTZ/91Bmgp28axYozXo0Xzz4ZjFwP4vKwVTIFUpwabpP/hIzp3yrEtdoyB/QdLtlP7+i+KmD2ZzXH8/Q7SXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g4z1/dqp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g4z1/dqp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TGXoMA2418040;
	Fri, 29 May 2026 17:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iGXjd1
	GJviT30fWLG/W/VpyRtCI0WO7jsm7Y1r7yJ/g=; b=g4z1/dqpt5HP9dJ8ce5anV
	cg+wNGwLPcbiJK3+N1YWX1blsjhlI9WZKU6P1aTKEzKhtx3ezQ3MABoQLnWid99w
	ZnnJrEljHlpxQQQl1/CBe8MSZRP4TC8I/ZCnbHkGJL51cnMoy/WabHdR02Rv+VZf
	vUaCfAXnJoi0FQCMZDBoXACPCoIq6KpclR0kKxHdLV+S8kIUzdxm7Bwq30IvwIlc
	JaE3Rc47zLsC06WtWn2T727prSfNKG1k5KoCLJM5lDEPzdSCW8EHWLfsPNKCXMl8
	sszofMt8aeRMZtV3f+CNtiap02pWfT/mZ1/ymb5mRK2no3FzoZcj6/zhbY6z5Q6g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884xank-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 17:13:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TH97bF021465;
	Fri, 29 May 2026 17:13:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbhmcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 17:13:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64THDoYr17564210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 17:13:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99BFD58063;
	Fri, 29 May 2026 17:13:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3A9658059;
	Fri, 29 May 2026 17:13:49 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 17:13:49 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 May 2026 12:13:49 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: yukuai@fygo.io
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        tom.leiming@gmail.com, jmoyer@redhat.com,
        Gjoyce <gjoyce@linux.ibm.com>, wenxiong@us.ibm.com
Subject: Re: Observing higher CPU utilization during random IO fio testing
In-Reply-To: <043e357f-5b37-4e05-9433-271504fc1d30@fygo.io>
References: <338169f719c77e4afe58f42e9760349e@linux.ibm.com>
 <1cb74987-34e2-422f-93cf-9174fe913538@kernel.dk>
 <043e357f-5b37-4e05-9433-271504fc1d30@fygo.io>
Message-ID: <f7021a9b85cf1aac489d1a07b4fdaaf9@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19c951 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0jjIex3EyuCsc-lyh7sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lCHAhs4g2y6QeiY1tBOx5SHoCMHYibHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE3MSBTYWx0ZWRfX7pTyJWfPKUAO
 MY6+8MQJc0dq0E1OdFR2RktGxC1A7bZGODV33P1cGL7bLGVY5S63usImxweTNDYgxzlCJoaRtgH
 e8AbS428unXC8jWPTzGVoeBblWGfC8vt9B6DOEELwYV3gSFELUvdSDk/tCLHRou8X6JI+dSJMTr
 cgoMiSinQ89GWC//eKC2L2Mo4OmeI6fAiH3Lqe9WiJGxOvt0MjJnhs+Ib3pzIaUj7IYz5nvxeHl
 7AjIjV59E5qqCdE52m5wtdfKLsxShxoWHnZrETB59rL8rM3Y027/NiVDSdFsrGCEWCKFtQ9CfE1
 32BVv8qDq7/qNWpSnoe+5rmhQNcrxkw6tCNhHtKsaJhPbqzNea/2wiwDhPUT8Sze9V2aNMmH+mg
 a4CkCNbqS66RJg+DiA8vKVGRGG+OcmU5J5LCV417uNyb/T2sEXwpcRgIJ3KThx9+ph9tnjoUOvO
 mNe/b2NPdBwJX6O+oTg==
X-Proofpoint-GUID: 1Er3hZDzRNglShOO-J9yaV2QIgLzX-BT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290171

On 2026-05-25 00:28, Yu Kuai wrote:

> 在 2026/5/22 5:52, Jens Axboe 写道:
> Yes, perf data will be helpful. And please show your test in details 
> and I'll
> check if I can reproduce it.

Hi Yu Kuai,
Have you reproduced the issue yet?

Below is some perf data we took while running random read test:

Test:
FIO random read with qdepth=1 nj=20, we saw higher CPU utilization in 
this testcase.

Perf record:
start fio run on one session and kickoff the script in another session 
while test is running

Perf report:
With blk_start_plug/blk_finish_plug before calling __submit_bio() in 
blk-core.c:
Top.txt
      2.41%  fio              [kernel.kallsyms]                           
     [k] cpupri_set
      1.16%  fio              [kernel.kallsyms]                           
     [k] queued_spin_lock_slowpath
      0.75%  fio              [kernel.kallsyms]                           
     [k] sbitmap_find_bit
      0.47%  fio              [kernel.kallsyms]                           
     [k] set_next_task_rt
      0.41%  fio              [kernel.kallsyms]                           
     [k] pull_rt_task
      0.34%  fio              [kernel.kallsyms]                           
     [k] enqueue_pushable_task
       …
      0.02%  fio              [kernel.kallsyms]                           
     [k] __blk_flush_plug
      0.01%  fio              [kernel.kallsyms]                           
     [k] blk_add_rq_to_plug
      0.01%  fio              [kernel.kallsyms]                           
     [k] blk_mq_flush_plug_list
      0.00%  fio              [kernel.kallsyms]                           
     [k] blk_attempt_plug_merge

Callgraph.txt

      2.41%  fio              [kernel.kallsyms]                           
     [k] cpupri_set
             |
             ---cpupri_set
                |
                |--1.15%--__enqueue_rt_entity
                |          enqueue_task_rt
                |          enqueue_task
                |          ttwu_do_activate


Perf report
  Without blk_start_plug and blk_finish_plug before calling 
__submit_bio():
Top.txt
     0.67%  fio              [kernel.kallsyms]                            
    [k] queued_spin_lock_slowpath
      0.64%  fio              [kernel.kallsyms]                           
     [k] sched_balance_newidle
      0.47%  fio              [kernel.kallsyms]                           
     [k] _raw_spin_lock
      0.39%  fio              [kernel.kallsyms]                           
     [k] sbitmap_find_bit
      0.35%  fio              [kernel.kallsyms]                           
     [k] cpupri_set
      0.28%  fio              [kernel.kallsyms]                           
     [k] work_grab_pending
      0.24%  fio              [kernel.kallsyms]                           
     [k] lookup_ioctx
      0.23%  fio              [kernel.kallsyms]                           
     [k] __schedule
       …
        …
      0.00%  fio              [kernel.kallsyms]                           
     [k] blk_attempt_plug_merge

Call graph.txt:

0.35%  fio              [kernel.kallsyms]                               
[k] cpupri_set
             |
             ---cpupri_set
                |
                |--0.17%--arch_local_irq_restore.part.0
                |          |
                |          |--0.14%--finish_task_switch.isra.0
                |          |          __schedule
                |          |          |
                |          |          |--0.13%--schedule
                |          |          |          |
                |          |          |          |--0.07%--read_events
…..
                        |--0.13%--__enqueue_rt_entity
                |          enqueue_task_rt
                |          enqueue_task
                |          ttwu_do_activate

 From above perf data, looks like
1. High time spent in cpupri_set(): tasks being enqueued/dequeued 
frequently, more IO scheduling.
2. Call more plug routines.

If you need full perf data report, I can email/attach your full report.

Thanks for your help!
Wendy
