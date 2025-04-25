Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE612CD8B
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585332; cv=none; b=IP5VCTfVa7jM6lMhUskh6mQozP9oSFxRLhFh3XfLnCnWjYk7nGpjPLMYJr6VdPQMmkvCe09+wja8ODvnh6iaRaOYljIGpQtoOkHBHDZeax67B11ZplInkNPj6jKeZ/K1kgOT6TsEW+vHBcm5nN6GzpVcj+xaLTxJkQtjhSOts3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585332; c=relaxed/simple;
	bh=xwYLB6XMkcKr/iyK1q2T/r0YPlDAzzstDcCWLDpwha4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf+A5URA2CuuCgfxZ2Gt5qfJfa28vkCucSEsza037PpP54zHgoLMTQuC6j9ywDQ5rtJtovi6E8Hm0i/EwhJ6KQ1JwmrIV/ynOQzxiTxG3fr3IGGv5KqYBOIY8dmOXOAumqTnEZTd57QsHJvyFwcdn1EJ8Atw/Ymf5kFBK4oWgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhhLVoKk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhhLVoKk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAf9Xu023440;
	Fri, 25 Apr 2025 12:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cvHPHU
	kOFEgoZis2KKDETsRdxRDiRBtD3NGUvGr0N0k=; b=bhhLVoKkerbmfbr11/Vuea
	nTazllW5ZmwleNQkSRgX6Bm3cIzCeg2c8kNkoP7iN+e67ZcwgsIn3UG90xHbngut
	cXGjz4HBZZBswgcEqHUCjOEijlssAzEOCZjKVtLmyp+ZlfwGF/GkhBB0olyT6koJ
	MRlljnUaYMfuNhIkPAzNB4txwPokdMRBH9LYNQjnoSbMKRQnAeShDKO9kTDsZIB4
	C3xX9s4VF3vV65AxC5RQQx3cIzJIzxG4/uyGMHhPQ3HyU481ArrYFDYANoucHxlm
	0xag3FK4Akb6zQoxlPzv68ZCOEynD6byV9f9xPb5UqwvDGBnZ9CGCyRoPJn63cow
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688usggyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 12:48:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCBiQr001310;
	Fri, 25 Apr 2025 12:48:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy57t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 12:48:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PCmcem53477708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 12:48:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80FC158058;
	Fri, 25 Apr 2025 12:48:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1063A5805D;
	Fri, 25 Apr 2025 12:48:36 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 12:48:35 +0000 (GMT)
Message-ID: <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
Date: Fri, 25 Apr 2025 18:18:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=680b84a7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=x7ZvaqbR7zz2ZO2uWZAA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MSBTYWx0ZWRfX8TkHc+BK9ast yvKa4qXcbYFT/mzSNnVrGtFaoCi189oNpVR71Q3sytdFPOJc4bfDXLuoaW3W4457UpdkjdFYOPb ElL7L5zl/5mDTjAVDWYye2HmIxMSyHFO7JkjSpV7b6WczOmZQDqqtc91ArUWkNeO6ol9UD0BHPG
 3hi9X6gL31c39qCLEBs979tJuxoe9W3GBXxAMPOqHHrbqoW37AQZ7JZO7AXaoAvnZXNKhrzEH4c g/Dfx7Lu+p3S5xFwC6RB0PNNOAeWpXLTsN2GFM3XmZKSEidG8zy4AUyvVkf2Uj5S0R9w+Tq0QEl fr+S/E1h72hPEVsDQNXbDm0+/inBMZzV4i5UdMy3G5rQ/Lx6ALIQR4fgVkFiDBsjkX0Y9CPrcy5
 ASUzrQ0Z6jdJ90HsZbGgYp6R3eW2NaMLgxe8uYpdD53gYBtW8FXfelcO2YanHTjO7mD0V5RU
X-Proofpoint-ORIG-GUID: wcRuk8S2ji1t_uxm7JgzPnzC4-eupEBC
X-Proofpoint-GUID: wcRuk8S2ji1t_uxm7JgzPnzC4-eupEBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250091



On 4/24/25 8:51 PM, Ming Lei wrote:
> Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
> path, so it can't be done if updating `nr_hw_queues` is in-progress.
> 
> Take same approach with not allowing add/del disk when updating
> nr_hw_queues is in-progress, by grabbing read lock of
> set->update_nr_hwq_sema.
> 
> Take the nested variant for avoiding the following false positive
> splat[1], and this way is correct because:
> 
> - the read lock in elv_iosched_store() is not overlapped with the read lock
> in adding/deleting disk:
> 
> - kobject attribute is only available after the kobject is added and
> before it is deleted
> 
>   -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
>   -> #3 (&q->limits_lock){+.+.}-{4:4}:
>   -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>   -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
>   -> #0 (kn->active#103){++++}-{0:0}:
> 
> Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/elevator.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 4400eb8fe54f..56da6ab7691a 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	int ret;
>  	unsigned int memflags;
>  	struct request_queue *q = disk->queue;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	/*
>  	 * If the attribute needs to load a module, do it before freezing the
> @@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  
>  	elv_iosched_load_module(name);
>  
> +	down_read_nested(&set->update_nr_hwq_sema, 1);

Why do we need to add nested read lock here? The lockdep splat[1] which
you reported earlier is possibly due to the same reader lock being acquired
recursively in elv_iosched_store and then elevator_change? 
 
On another note, if we suspect possible one-depth recursion for the same 
class of lock then then we should use SINGLE_DEPTH_NESTING (instead of using
1 here) for subclass. But still I am not clear why this lock needs nesting.

Thanks,
--Nilay 
