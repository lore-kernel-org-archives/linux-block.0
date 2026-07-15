Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414E2EEE94;
	Wed, 15 Jul 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123010; cv=none; b=q/oU4Mr/c7+eWSwA3Qzu4Fe2mRx8DSObKeGoK8yXTBADgjT57GgfohbH7bUfvVSfg6HetmbXWdgLBR5p3ZoKLCIEu1p+QfoFw9UboW0EFSlugKjNzxBHnYhdVvb5W9hUDLblwHxkSZDB9OePb4W+0bZtlTKvOhrEQ/1XtoP4WKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123010; c=relaxed/simple;
	bh=YFBdvhf41/tkIyH3BHFN4sn9SEWOuLYUSZmnxWU99LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N280LShYLcUUtpBRZyYXgoVS8wiSJJssMsQ8jqAwY0DXYiEOI+OGCM6IWqJXAFP7lv2WYil1XeN7gtIIqyzOB+rlpRw96ZS06FDt83WSnuk1gzxygrdS347Cq23HONGOEfl9LIClSpUoa18YELmtrLHcLFY/sxWu74/1oIqYQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lE5dcakN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lE5dcakN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfieI4178660;
	Wed, 15 Jul 2026 13:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lBblO6
	IUCSc7uja4qGF0zYHJfeMpMfnSvmnVUOx1/ag=; b=lE5dcakNKrmjVDDO6GF0Pp
	l0c9n9VofPDSNUgs+VGXMmTqHpq+DGCOEy7wFYR4K7tPGQ6k2hEHIeF84gvLFRcV
	Ze2BEWum5vUd9BvarLodO5OwLmGRos271zLKkqfREk5DcQNUk6rg/Hwyk/sPPqmu
	vTQ6vz61Ty2mUAJBhirdqUXCLLaYA8Zs9aQqIkqBLMjhBo3aIfHce+sNfvfBz0py
	W6pBjVq8s7YfgVkrqcbwOWN12WmDClfwIAwaPsuxvmru3Wvgghn1ZShYqpwCHcqf
	dinY563q5wUs4dyQM7ue9t8Q/PJG9uea1iqExxK/KYD89NCnTQyY96acZDVSt+5g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwu5p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:42:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDYb1Y022222;
	Wed, 15 Jul 2026 13:42:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k0841-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:42:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDgsgo19137132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:42:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE0958051;
	Wed, 15 Jul 2026 13:42:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5485805E;
	Wed, 15 Jul 2026 13:42:50 +0000 (GMT)
Received: from [9.43.121.189] (unknown [9.43.121.189])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jul 2026 13:42:50 +0000 (GMT)
Message-ID: <f024ffe7-4c49-4c8a-bd79-48f58ab06ebb@linux.ibm.com>
Date: Wed, 15 Jul 2026 19:12:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 7/9] null_blk: reject per-device queue resize for
 shared tag set
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-8-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260714041805.1088702-8-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dflumDwFb6eZz1Zav9p20XXa6DibT9eX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfXyWmEpZKVU8Bg
 f4DauESPJHy3Iup+mtyVSAGUzym25IaTvXF1rY34MjJd3LBxllbivJI0SWyUoH3mhYZeDgW/Z4/
 8EUFFHAo8do8gXS+bfoA7H2WG0JkvQvGJfae2xzysnm1RZxX7xY5Xlpa/BaBpi2ZZPm6toY0VxP
 bexi+2elZpWjdib1QsUJPHWE1bmFwrsSwfLe/1xCuHOqYBYYrquV2PxJJt1PY96FS6nZGxFYidd
 fQG6Cfpm4u3/zYyfP8gmVpIzFUuzHAGHLQMClBUbgYGzfIsQmV7IWPdGy38HDk8QVd5pGl29M95
 Ygy1vsnrWZfOczdsNCJl5tPxLZXZPNpoAIuJFpNeqMRVLwC6JhT3f2oprVHwGayPjSO6sC43Vmf
 Xmis8YEMJuR/CsKs9OHpw4GVwQP3eZthehxPDZKH+pyB2ofL0oT4AxOCI2m5F1j5fQyPSm5559G
 WXtktAJumYfYYcIpJDA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a578e60 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Fau5_GYcE56W8S-VOf0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dflumDwFb6eZz1Zav9p20XXa6DibT9eX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX52abNT6QN8o1
 LUHsB/2ZDIBPbKxgF1qBbTY0x1wYbMs6MTzS8ouxnmCvxygfnmRb5EUFNLNmbAw4i0d9JRQ3+Aa
 fnrJIjiQZ+g6VGNDVeXvzwHJ5RyyrWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150136

On 7/14/26 9:48 AM, Zizhi Wo wrote:
> When shared_tags is enabled, null_setup_tagset() makes the device use the
> global tag_set, whose driver_data stays NULL. null_map_queues() therefore
> falls back to the module-wide g_submit_queues/g_poll_queues instead of any
> per-device value.
> 
> Resizing submit_queues or poll_queues via configfs on such a device calls
> blk_mq_update_nr_hw_queues() on the shared set, shrinking
> set->nr_hw_queues.  __blk_mq_realloc_hw_ctxs() only grows the
> q->queue_hw_ctx[] allocation, so on shrink it merely exits and NULLs the
> now-excess hctx slots. null_map_queues(), however, keeps mapping CPUs with
> the unchanged g_submit_queues/g_poll_queues, so mq_map[] ends up pointing
> at those NULLed hctx slots. blk_mq_map_swqueue() then dereferences the NULL
> hctx (hctx->cpumask), crashing the kernel:

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
