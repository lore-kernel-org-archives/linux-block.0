Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245573FB2C
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866460; cv=none; b=hnrPkwjA/MtB5clpeRoL99Lkw6mewEARtzk7+/T7JgTCMAO1wy0EpEUQ5NTVhYGTAl8tWMIyyfSTib/QC6qm9113WqYHkknMOk9uJGBRk4QwCJ/QU69elQe8OvfzaLak59V0fY3m2RJXj5K9nPeyiFqeQ7WqIaMqRDC10elPXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866460; c=relaxed/simple;
	bh=pOdbEhgqJuyZ4nqqu8GJBIkxJ3sy0bRkUTn9qDhrv+U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=IQgYP74G8yWJlhzJvIkYYLPSQ/RS/IubltqMBr+K69zUw2jt4IKtGC3U+I/y0glPf2hKIEX5xn08dKsDPJl4uAjGbKO82iN3E5cwrs0cbQgE6sZs0LDXFK+xBG/uMkJAGDK5VjNK3oyPCIugaP8ssWeTsILCOq+aj20pIvmF4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gmviLB66; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gmviLB66"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K0lIq1024370
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tIpuKfM0xc5/JHCu1a+1vV
	XykM0oBYN2pPivDEJ736c=; b=gmviLB66ThTZXmAOTsI79SE5oDLDch5KFzuFRw
	/l5ARqB++FCJFL02pZtGNDbepc2JWXIDmZDfoyH+gIQzYwDqC39VhY7YRc+WD6Rs
	BXO1dSxYIf8wAToV4wd9HtKrIMKsecQ+EQdGFP5i3fr9yR+4y6CKWDDW2VusNWG+
	Ohku2JpjYIkj5ZlUpNrEEnL3UW7NbnUdzE9c8t4Fm3v6V7VfMV50JSWYlOfRVHa5
	XJEdH3Z7Fr0F3dYEUoBaIyzzbKQKvnT4dZR3g5xDF3YFAsskHlALmPVTO9h7dyTi
	RNblEo1YMGubBPjE5B5XzrF1nOsio59rgZmdVfsN5WPKK7Ug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yux152886-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:54:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K6sGVR002013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 06:54:16 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 23:54:15 -0700
Message-ID: <6fb677a4-b655-4395-9dd1-450217fec69d@quicinc.com>
Date: Thu, 20 Jun 2024 14:53:36 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kassey Li <quic_yingangl@quicinc.com>
Subject: 6.6 kernel block: blk_mq_freeze_queue_wait in suspend path but
 userspace task held the queue->q_usage_counter in 'TASK_FROZEN' state
To: <linux-block@vger.kernel.org>
CC: Kassey Li <quic_yingangl@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dSo9q53hv8k130X7nutIxDNWpI8vEYNM
X-Proofpoint-ORIG-GUID: dSo9q53hv8k130X7nutIxDNWpI8vEYNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011
 mlxlogscore=924 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200048

hello, linux block team:


a test running suspend/resume, as well some io test where we hit suspend 
on  blk_mq_freeze_queue_wait for more than 20s
where we observed that  blk_mq_freeze_queue_wait wait for 
q_usage_counter put by as userspace task in TASK_FROZEN state.


kworker/u17:3  task B    ['TASK_UNINTERRUPTIBLE']

     [<ffffffdc0c527f10>] __switch_to+0x1e8
     [<ffffffdc0c5287ec>] __schedule+0x6cc
     [<ffffffdc0c528c28>] schedule+0x78
     [<ffffffdc0bb4b828>] blk_mq_freeze_queue_wait[jt]+0x60
     [<ffffffdc0bb4ba10>] blk_freeze_queue+0x70
     [<ffffffdc0bb4ba34>] blk_mq_freeze_queue+0x10
     [<ffffffdc0be4ba00>] scsi_device_quiesce+0x4c
     [<ffffffdc0be55f80>] scsi_bus_suspend+0x48
     [<ffffffdc0bdea798>] dpm_run_callback+0x9c
     [<ffffffdc0bdec62c>] __device_suspend+0x404
     [<ffffffdc0bdec0ac>] async_suspend+0x30
     [<ffffffdc0b4f301c>] async_run_entry_fn+0x4c
     [<ffffffdc0b4e5034>] process_one_work+0x254
     [<ffffffdc0b4e5828>] worker_thread+0x274
     [<ffffffdc0b4ecdfc>] kthread+0x110
     [<ffffffdc0b4168ec>] ret_from_fork+0x10


[ND:0x0::0xFFFFFF881DAF39A0] q_usage_counter = (
[ND:0x0::0xFFFFFF881DAF39A0] percpu_count_ptr = 0x0000004E8F857E9B,   // 
__PERCPU_REF_DEAD is set , PERCPU_REF_INIT_ATOMIC is set

       [ND:0x0::0xFFFFFF881DAF39A8] data = 0xFFFFFF8818EC9F80 -> (
         [ND:0x0::0xFFFFFF8818EC9F80] count = (
           [ND:0x0::0xFFFFFF8818EC9F80] counter = 0x3),


q_usage_counter is 3,
mq_freeze_depth = 0x1


since userspace task A in TASK_FROZEN state, it called 
percpu_ref_get(&this_hctx->queue->q_usage_counter);   from 
blk_mq_dispatch_plug_list, but yet to 
percpu_ref_put(&this_hctx->queue->q_usage_counter)

so here this looks deadlock  ?
can you help to give some debug suggest ?


userspace task A  ['TASK_FROZEN']

     [<ffffffdc0c527f10>] __switch_to+0x1e8
     [<ffffffdc0c5287ec>] __schedule+0x6cc
     [<ffffffdc0c528c28>] schedule+0x78
     [<ffffffdc0c532bbc>] schedule_timeout+0x50
     [<ffffffdc0c529e48>] do_wait_for_common+0x10c
     [<ffffffdc0c529238>] wait_for_completion+0x48
     [<ffffffdc0b4def4c>] __flush_work+0xcc
     [<ffffffdc0b4dee70>] flush_work+0x14
     [<ffffffdc0c091aec>] ufshcd_hold+0xc0
     [<ffffffdc0c0a3bdc>] ufshcd_queuecommand+0xc0
     [<ffffffdc0be4d2bc>] scsi_queue_rq+0x89c
     [<ffffffdc0bb4f6a0>] blk_mq_dispatch_rq_list+0x3c8
     [<ffffffdc0bb59218>] __blk_mq_sched_dispatch_requests+0x430
     [<ffffffdc0bb58db4>] blk_mq_sched_dispatch_requests+0x38
     [<ffffffdc0bb4e69c>] blk_mq_run_hw_queue+0x258
     [<ffffffdc0bb503a0>] blk_mq_flush_plug_list+0xc4
     [<ffffffdc0bb425e4>] __blk_flush_plug+0x118
     [<ffffffdc0bb42658>] blk_finish_plug+0x28
     [<ffffffdc0b6fc7a0>] read_pages+0x31c
     [<ffffffdc0b6fc318>] page_cache_ra_unbounded+0x88
     [<ffffffdc0b6fcb9c>] page_cache_ra_order+0x270
     [<ffffffdc0b6ef380>] do_sync_mmap_readahead+0xd0
     [<ffffffdc0b6eeea8>] filemap_fault+0x14c
     [<ffffffdc0b748eb4>] handle_mm_fault+0x4fc
     [<ffffffdc0c536d40>] do_page_fault+0x294
     [<ffffffdc0c536a90>] do_translation_fault[jt]+0x40
     [<ffffffdc0b43fae4>] do_mem_abort+0x58
     [<ffffffdc0c51ed70>] el0_da+0x48
     [<ffffffdc0c51ec90>] el0t_64_sync_handler[jt]+0xb0
     [<ffffffdc0b411588>] ret_to_user[jt]+0x0


BR
Kassey
