Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA11DED40
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861716; cv=none; b=n9u/66m9wmayEz1mmnvce6/XJNzFKhgpswaM+9K5ZYksh+e9o0b69T0ZibG3P4I+nDyQOWbqt5LeMBWErMgl8thk47uXdAGx5hoeaKyOzxblSYXOeQUqPtgKvpK6LDwtYh/F6l6SYqxPsYOtLG6onCklXtZdpYFav46gJ9bYRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861716; c=relaxed/simple;
	bh=TajUXkyYlyIqATmpw2Q+me2bTqQcdVGPwmxDH1MIvpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J04dPO1drTl1fkjWb2cmZv+No5mPNBY4jKLRvEDYEJla1kbMBF8cn0M/P3Y3uSMCT+Q5ezzqwJnJQ6W/gNGuLWpxKd0LyBKyWGlGQGI2CoHHqg9EU7DU8+MLn+GKiTM1XTpsMLr5L1P1niB50Jax0dPv4IQZzcTan6chK5yAg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=INdCPp6V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="INdCPp6V"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U1w7DE008912;
	Wed, 30 Jul 2025 07:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CxSZXT
	bO7vr++FKeDSvECejXXkG2IXFmTbEd7yOIQGg=; b=INdCPp6VMoV0GTBSyNpnST
	daRx1SO7LcUWVA+uIntm/fv3DBjaxfHad2XoCSuwXY85HIk9ykm7m/xi6/27FhDf
	iBOIBzq74zGVjlm8fFjDNUmJc/b6tx8+emtmj5xQIqCoBC5x44Tij+vx3xijMV0C
	ZsQm06qk62p0IbPBwDj9mbjXYV5tz2wOL99vHq/mt7Dc/wIkPs2yZc2qQJu74FP6
	nPkNt0tBqy4XrmDxdXqR6y8TekilmP4FZl8monpvdFBr+P3ub+4NrA4P7ZlIM3ba
	KRTJNs5e6mcMqYX2iRUIqhQE8GesOw2U5fufIh/3jvBKfmFVaLT+MLs4UvtasPYg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcg3e9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:48:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5djUv017353;
	Wed, 30 Jul 2025 07:48:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r06gtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 07:48:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U7mPk527853254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 07:48:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08D9B5808B;
	Wed, 30 Jul 2025 07:48:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92B3058055;
	Wed, 30 Jul 2025 07:48:21 +0000 (GMT)
Received: from [9.43.45.161] (unknown [9.43.45.161])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 07:48:21 +0000 (GMT)
Message-ID: <2fb5a129-caee-4a7b-ba4f-d7dda4c0cfa7@linux.ibm.com>
Date: Wed, 30 Jul 2025 13:18:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 0/3] block: move sched_tags allocation/de-allocation
 outside of locking context
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        sth@linux.ibm.com, gjoyce@ibm.com, Yi Zhang <yi.zhang@redhat.com>
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250730074614.2537382-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1MyBTYWx0ZWRfX9RNy8NSQE9J7
 GqCJdXdGeKS225sDpr7eKUBsh77QnZwjcJHxSzsw3EkvH29ygfUwWMp/4JeqxzyxSnCNaOyGdfz
 kFrLv1zfGyZW5wUSyoREpsNcSgmiv5y1C+MYIksbRD8lU1E1bRrlxKnNbpAqk2D2ubLysfU7Kq2
 cjBUq1WRBt4GKmd23r4KGuYCCtmct4nkVp9I9K0SLh8jOLWqY2AJFl8nI7e8OY8rFYh0gWE/daI
 JdYCY6loVYRIvnQCwvmmBEPzArCmQ2GHZqAPvOAzIUcRKIv/YaY+lx7KeTGAQK9jWy8jDtAwBAB
 gg6SxqkO8XPoIbNHqA8ux3TTn/jneCJyiQl9Np88cdA5y8K4gRUn3M5eQOmP7Pa6sAiO6R5hCE5
 rXi5md0xc+FeFyDKYJtbXS5NPlIlDEaymBO1rSGQju3XYykEyoZglbs78iib2WkALfzCIxfz
X-Proofpoint-ORIG-GUID: nEHQasVnGAWjGsmfp4Z8IC5hObQsGydQ
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=6889ce4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QyXUC8HyAAAA:8 a=siaTx_kKvaWgMKBdMG4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nEHQasVnGAWjGsmfp4Z8IC5hObQsGydQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300053

Hi Jens,

I believe this patchset may have fallen through the cracks. I've just rebased it on
top of the block-6.17 branch at commit 5421681bc3ef ("blk-ioc: don't hold queue_lock
for ioc_lookup_icq()") and sent out v8.

Could you please consider pulling it for Linux 6.17?

Thanks!

--Nilay

On 7/30/25 1:16 PM, Nilay Shroff wrote:
> Hi,
> 
> There have been a few reports[1] indicating potential lockdep warnings due
> to a lock dependency from the percpu allocator to the elevator lock. This
> patch series aims to eliminate that dependency.
> 
> The series consists of three patches:
> The first patch is preparatory patch and just move elevator queue
> allocation logic from ->init_sched into blk_mq_init_sched.
> 
> The second patch in the series restructures sched_tags allocation and
> deallocation during elevator update/switch operations to ensure these
> actions are performed entirely outside the ->freeze_lock and ->elevator_
> lock. This eliminates the percpu allocator’s lock dependency on the
> elevator and freeze lock during scheduler transitions.
> 
> The third patch introduces batch allocation and deallocation helpers for
> sched_tags. These helpers are used during __blk_mq_update_nr_hw_queues()
> to decouple sched_tags memory management from both the elevator and freeze
> locks, addressing the lockdep concerns in the nr_hw_queues update path.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Changes since v7:
>     - Rebased code on top of block-6.17, commit 5421681bc3ef ("blk-ioc: don't
>       hold queue_lock for ioc_lookup_icq()")
> Link to v7: https://lore.kernel.org/all/20250701081954.57381-1-nilay@linux.ibm.com/      
> 
> Changes since v6:
>     - Add warning when loading elevator tags from an xarray yields nothing
>       (Hannes Reinecke)
>     - Use elevator tags instead of xarray table as a function argument to
>       elv_update_nr_hw_queues (Ming Lei)
> Link to v6: https://lore.kernel.org/all/20250630054756.54532-1-nilay@linux.ibm.com/
> 
> Changes since v5:
>     - Fixed smatch warning reported by kernel test robot here:
>       https://lore.kernel.org/all/202506300509.2S1tygch-lkp@intel.com/
> Link to v5: https://lore.kernel.org/all/20250627175544.1063910-1-nilay@linux.ibm.com/
> 
> Changes since v4:
>     - Define a local Xarray variable in __blk_mq_update_nr_hw_queues to store
>       sched_tags, instead of storing it in an Xarray defined in 'struct elevator_tags'
>       (Ming Lei)
> Link to v4: https://lore.kernel.org/all/20250624131716.630465-1-nilay@linux.ibm.com/
> 
> Changes since v3:
>     - Further split the patchset into three patch series so that we can
>       have a separate patch for sched_tags batch allocation/deallocation
>       (Ming Lei)
>     - Use Xarray to store and load the sched_tags (Ming Lei)
>     - Unexport elevator_alloc() as we no longer need to use it outside
>       of block layer core (hch)
>     - unwind the sched_tags allocation and free tags when we it fails in
>       the middle of allocation (hch)
>     - Move struct elevator_queue header from commin header to elevator.c
>       as there's no user of it outside elevator.c (Ming Lei, hch)
> Link to v3: https://lore.kernel.org/all/20250616173233.3803824-1-nilay@linux.ibm.com/
> 
> Change since v2:
>     - Split the patch into a two patch series. The first patch updates
>       ->init_sched elevator API change and second patch handles the sched
>       tags allocation/de-allocation logic (Ming Lei)
>     - Address sched tags allocation/deallocation logic while running in the
>       context of nr_hw_queue update so that we can handle all possible
>       scenarios in a single patchest (Ming Lei)
> Link to v2: https://lore.kernel.org/all/20250528123638.1029700-1-nilay@linux.ibm.com/
> 
> Changes since v1:
>     - As the lifetime of elevator queue and sched tags are same, allocate
>       and move sched tags under struct elevator_queue (Ming Lei)
> Link to v1: https://lore.kernel.org/all/20250520103425.1259712-1-nilay@linux.ibm.com/
> 
> Nilay Shroff (3):
>   block: move elevator queue allocation logic into blk_mq_init_sched
>   block: fix lockdep warning caused by lock dependency in
>     elv_iosched_store
>   block: fix potential deadlock while running nr_hw_queue update
> 
>  block/bfq-iosched.c   |  13 +--
>  block/blk-mq-sched.c  | 223 ++++++++++++++++++++++++++++--------------
>  block/blk-mq-sched.h  |  12 ++-
>  block/blk-mq.c        |  16 ++-
>  block/blk.h           |   4 +-
>  block/elevator.c      |  38 +++++--
>  block/elevator.h      |  16 ++-
>  block/kyber-iosched.c |  11 +--
>  block/mq-deadline.c   |  14 +--
>  9 files changed, 228 insertions(+), 119 deletions(-)
> 

