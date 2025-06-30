Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5464A23
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262475; cv=none; b=VTyAx4xCV6aEjkrwHXjXPC+O8hBBCh7wo2hCIa2/iTstBPQYdRUIVR/MjI9mlxbNt/7zobrJX0z0uVYJeXLJNYUfgxaGcmf95vPfFwWsFN36a7Q1WHTNXQddAqkrBy20y2K7enbRQfHHGd5XA8r+6HBUn0zVrVlKhMen+YUKUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262475; c=relaxed/simple;
	bh=GoIrPg/A+Bel0SFkopp2COuxpIwIKgAHGQV+QQjAGIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GerzzvUSETk4V1vckNx8oxU/pgoh0q/JAfZ82WbTV8XUxOg0BHjqoOCVCt9pjxZYABMIOgJmSdh6fBeXJWZkjWDq0dXvQKqQe62ZUAPqmvWrsVj3aUDdCBGBS0QTRov0WO9IF2EPRbZlR7M6BpR9IpMyYBGDY0fp7x9JBmPeCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kz/vHeOT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kz/vHeOT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TKcXgt021006;
	Mon, 30 Jun 2025 05:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9UXQ2P
	5fEZQAX0BTvB353iCxAAZfWyLc3yHfAuVRW5c=; b=Kz/vHeOTww2ZRyK54LWzue
	3bCS5u5oV7/MC6aOlLPaT2/rA2p0nDpQ1UKpwj0Z3kU5RtTQcozrJfcd7PMEzdWm
	Ed5VOMg2RWcJJ1FaZZIWhJ4Vk41Nls5Epbbgw/FMv8yntF14wBJR2KFsrKzi10WI
	0xed6ULlnM8jhemMd4dwc1UmBKM8eaIK2plw2N8hnkVix0PbrUJFLcChj81KkbPh
	lYid1gPqd9wdcnl1PHVLjqJ/3g2Dh5max25px8Y2BSBMKgX7gOwWWBmtgRtxlhNo
	ZYm+LTsVs8oLm+OZVtk/2ZjK4zd/inH8difsPc1Uo9UVRW85JsegPcgDuC1aQw9g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1ffjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:47:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U1CZWB006841;
	Mon, 30 Jun 2025 05:47:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm49fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 05:47:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U5lfgS46792978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 05:47:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63B415805E;
	Mon, 30 Jun 2025 05:47:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0EC58059;
	Mon, 30 Jun 2025 05:47:38 +0000 (GMT)
Received: from [9.61.92.250] (unknown [9.61.92.250])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 05:47:38 +0000 (GMT)
Message-ID: <61e84b42-d3ef-4154-b57b-ba0dd7bfe7a0@linux.ibm.com>
Date: Mon, 30 Jun 2025 11:17:36 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
To: kernel test robot <lkp@intel.com>, linux-block@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hch@lst.de, ming.lei@redhat.com,
        axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com
References: <20250627175544.1063910-3-nilay@linux.ibm.com>
 <202506300509.2S1tygch-lkp@intel.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <202506300509.2S1tygch-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6YktbqPufYCyy5NlM1H75begU4t0cNdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA0NiBTYWx0ZWRfX0qUAxM9RC8pl +msMYxa/F7oBeldZewzRj6CepnH3k5fF5HQnMZxWdtdWEVQIH7zMVRWFb4jPD5YZf7NQIxmWatf f8PfYEI1nSKlQQd9CgoVKZ19m6mwNJeeMgtkycPUTfjjYJsjOg83LDFy3hBoXQrtD8KwH0Ua93z
 1U1pmVLGr2XdYp/ifvUR2Rw6YsTBuUaiiAhMTjGJP0rkQ6EpDtSrZkkSJTY6kubxEFqzivRDy1X xhbsRKZPvjzL2lPHX9jz3etYg0EPnyaLglI56RD+TV/dUjoNucpRmbTaSflCm1yS10aJHboWjTs otS/oasmdRZUViOE3ZFdLMiYPGvA7gSSp2PbmBoFHmZ0+Xo9epQtUHkVdJDZQ9QEBuV0tj/IiHQ
 9LcZiNTQDXwaUZQ1gupP8t0FWbNCUx6UjXz7FqFpAxCCBElt1s1QBZE0FKg4FlkQ2/i+Y9h3
X-Proofpoint-GUID: 6YktbqPufYCyy5NlM1H75begU4t0cNdf
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=686224ff cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=pRxs1iPa0W0MJsBPqmcA:9 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300046



On 6/30/25 1:22 AM, kernel test robot wrote:
> Hi Nilay,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on linus/master v6.16-rc3 next-20250627]
> [cannot apply to hch-configfs/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-move-elevator-queue-allocation-logic-into-blk_mq_init_sched/20250628-020013
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> patch link:    https://lore.kernel.org/r/20250627175544.1063910-3-nilay%40linux.ibm.com
> patch subject: [PATCHv5 2/3] block: fix lockdep warning caused by lock dependency in elv_iosched_store
> config: i386-randconfig-r072-20250629 (https://download.01.org/0day-ci/archive/20250630/202506300509.2S1tygch-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506300509.2S1tygch-lkp@intel.com/
> 
> New smatch warnings:
> block/blk-mq-sched.c:472 blk_mq_alloc_sched_tags() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'
> block/blk-mq-sched.c:472 blk_mq_alloc_sched_tags() warn: always true condition '(--i >= 0) => (0-u32max >= 0)'
> 
> Old smatch warnings:
> block/blk-mq-sched.c:383 blk_mq_sched_tags_teardown() warn: iterator 'i' not incremented
> block/blk-mq-sched.c:397 blk_mq_sched_reg_debugfs() warn: iterator 'i' not incremented
> block/blk-mq-sched.c:408 blk_mq_sched_unreg_debugfs() warn: iterator 'i' not incremented
> block/blk-mq-sched.c:512 blk_mq_init_sched() warn: iterator 'i' not incremented
> block/blk-mq-sched.c:544 blk_mq_sched_free_rqs() warn: iterator 'i' not incremented
> block/blk-mq-sched.c:558 blk_mq_exit_sched() warn: iterator 'i' not incremented
> 
> vim +472 block/blk-mq-sched.c
> 
>    429	
>    430	struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>    431			unsigned int nr_hw_queues)
>    432	{
>    433		unsigned int nr_tags, i;
>    434		struct elevator_tags *et;
>    435		gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>    436	
>    437		if (blk_mq_is_shared_tags(set->flags))
>    438			nr_tags = 1;
>    439		else
>    440			nr_tags = nr_hw_queues;
>    441	
>    442		et = kmalloc(sizeof(struct elevator_tags) +
>    443				nr_tags * sizeof(struct blk_mq_tags *), gfp);
>    444		if (!et)
>    445			return NULL;
>    446		/*
>    447		 * Default to double of smaller one between hw queue_depth and
>    448		 * 128, since we don't split into sync/async like the old code
>    449		 * did. Additionally, this is a per-hw queue depth.
>    450		 */
>    451		et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
>    452				BLKDEV_DEFAULT_RQ);
>    453		et->nr_hw_queues = nr_hw_queues;
>    454	
>    455		if (blk_mq_is_shared_tags(set->flags)) {
>    456			/* Shared tags are stored at index 0 in @tags. */
>    457			et->tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
>    458						MAX_SCHED_RQ);
>    459			if (!et->tags[0])
>    460				goto out;
>    461		} else {
>    462			for (i = 0; i < et->nr_hw_queues; i++) {
>    463				et->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
>    464						et->nr_requests);
>    465				if (!et->tags[i])
>    466					goto out_unwind;
>    467			}
>    468		}
>    469	
>    470		return et;
>    471	out_unwind:
>  > 472		while (--i >= 0)
>    473			blk_mq_free_map_and_rqs(set, et->tags[i], i);
>    474	out:
>    475		kfree(et);
>    476		return NULL;
>    477	}
>    478	
> 
Thanks for the report!
I've fixed this warning and the fix is on its way...

--Nilay

