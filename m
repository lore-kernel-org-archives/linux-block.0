Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB82DF14C
	for <linux-block@vger.kernel.org>; Sun, 29 Mar 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787482; cv=none; b=Y+4ruguUdLwsFw+GlXUs+Ir8vcg3AU/HtmKM0j+ky/AHnW1CdEeocFIAWolToW9daIopVKGWhAATGEkDb2x17qNHxzG8M9TdIh8MkYdTjNJXxZ8Sa7IDt5S4hoOOKNChDerabCHI++mWsSR/kPwlNGrMu2DH2+Q4+PGULKwdipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787482; c=relaxed/simple;
	bh=33OkRek6Krd+TFY8akQZ7vdC74InuFMhpjGZzP1sWy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rhx6QJ5xSFa6fNwFo9wsxnf9OAEG4B7of3tWiuZa7ilxlF4Tfqq85nDVqjJzDIPdmNqV+ttRYYs5z3izD0M8puClPOovDwqgpYo2I9TFDN3vpcbCuXXH/tYmaihA9AFhSJArHKAZBsEvIFIL0nlOhyRM30xfCaGTAImQrE9oHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fg0sKv9G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fg0sKv9G"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T7SPn22736917;
	Sun, 29 Mar 2026 12:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=onhmQC
	73cFdrkmDtUrDwvyWy+MB9t5V5bmzXLh0AugM=; b=Fg0sKv9GCqKjSucvAv5O6F
	hsPBQiM2wG6UFm9Vv0OR/gpMlj5GUgbKPQs/qUpCxRUB4q2sNzKWbFphdSTS38+7
	OTH6IwcI5MxrXnAJW5HgraUOISu39suNJ130bsu/tHYfdjcqVeIR3FInvlmspwDw
	3sYrj+Upc84EcUVDEYCI9p20EgbLZGyeVAd9ES1CA8hgZorFZoDukAh5VLAOgmRa
	g6mGTXdE9raX8gJ/2Kh0G3lK80mJpDqG/MrU7qYoMzGUpwFB89rYBDFSS3WNcav7
	0bsge14Q99HfJG0E//fM9lJVyuxkqMRGStQpA5wmh5Iwbw6KX8HnBGG2eYVCxDLQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgbe7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 12:30:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62T9Sha4013919;
	Sun, 29 Mar 2026 12:30:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttk97a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 12:30:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62TCUfqW24838758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Mar 2026 12:30:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A885758051;
	Sun, 29 Mar 2026 12:30:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F645805A;
	Sun, 29 Mar 2026 12:30:34 +0000 (GMT)
Received: from [9.124.221.251] (unknown [9.124.221.251])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 29 Mar 2026 12:30:33 +0000 (GMT)
Message-ID: <c084beea-6c42-41f3-8f85-bf477ab0d893@linux.ibm.com>
Date: Sun, 29 Mar 2026 18:00:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] null_blk: Support configuring the maximum DMA
 segment size
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hans Holmberg <hans.holmberg@wdc.com>, Kees Cook <kees@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-6-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260327211349.2239633-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA5NiBTYWx0ZWRfX+9CRZGQ/2j6v
 mj+whVjcAHFheyc6vKRzTZEFr/JYUgAChYRZ5USTscrtmc10KqWZKpazKjXcrvgQWos8EbS5i7+
 WVje9uRSokIgvjBD17FItjNLuVQPy4RuhO9JV8SD9yBbviLr9ysk1dDXdnpeX36GMy1AiJgLtDu
 NJw3kccvYzfYx8+XKIICy5l+pyhBd43/565WatkOgouonF/rRygqqvfaeeMDqqZE20k5yIImkob
 hoS92DgDlehUBrxqI8EMQjx8TkvBaPfRHHW7mzxAFpJw3YmW4zjSJ1Rtve24ujQxP3+W+EEdClL
 X+hGv3lP3GQTUNBVtidxaCf4jJL2uY8bgny6tYqe+me3fs5HtUudEhX/Css30bl5PqDjL+ryQow
 Ub7FhWFm9yHr5DwpwHPIUoks5oho8SNQS9iAJF321nLIOUwQ01JswMgAYpMg3QRmqws0dwnsK3t
 JiM2KT2gNc6b+oiNjCQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69c91b73 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=JF9118EUAAAA:8 a=Ikd4Dj_1AAAA:8 a=N54-gffFAAAA:8 a=tID8PMhxCktFznVnzLEA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: ob3XU8gVHVnUWDF3ee3lIkYnNLAZkcGz
X-Proofpoint-ORIG-GUID: FZF55A-9R15x1Uj255NTN_g5BCMWW-BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290096

On 3/28/26 2:43 AM, Bart Van Assche wrote:
> Add support for configuring the maximum DMA segment size. The maximum DMA
> segment size may be set to a value smaller than the virtual memory page
> size. Reject invalid max_segment_size values.
> 
> Since rq_for_each_segment() may yield bvecs larger than the maximum DMA
> segment size, add code in the rq_for_each_segment() loop that restricts
> the bvec length to the maximum DMA segment size.
> 
> Cc: Christoph Hellwig<hch@lst.de>
> Cc: Ming Lei<ming.lei@redhat.com>
> Cc: Damien Le Moal<damien.lemoal@opensource.wdc.com>
> Cc: Chaitanya Kulkarni<kch@nvidia.com>
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> ---
>   drivers/block/null_blk/main.c     | 43 +++++++++++++++++++++++++++++++
>   drivers/block/null_blk/null_blk.h |  1 +
>   2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f8c0fd57e041..d5fbbc5d63ed 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -169,6 +169,32 @@ static int g_max_sectors;
>   module_param_named(max_sectors, g_max_sectors, int, 0444);
>   MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>   
> +static unsigned int g_max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +
> +static int nullb_set_max_segment_size(const char *val,
> +				      const struct kernel_param *kp)
> +{
> +	int res;
> +
> +	res = kstrtouint(val, 0, &g_max_segment_size);
> +	if (res < 0)
> +		return res;
> +
> +	if (g_max_segment_size < BLK_MIN_SEGMENT_SIZE)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops max_segment_size_ops = {
> +	.set = nullb_set_max_segment_size,
> +	.get = param_get_uint,
> +};
> +
> +module_param_cb(max_segment_size, &max_segment_size_ops, &g_max_segment_size,
> +		0444);
> +MODULE_PARM_DESC(max_segment_size, "Maximum size of a DMA segment in bytes");
> +
>   static unsigned int nr_devices = 1;
>   module_param(nr_devices, uint, 0444);
>   MODULE_PARM_DESC(nr_devices, "Number of devices to register");
> @@ -442,6 +468,14 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
>   	return ret;
>   }
>   
> +static int nullb_apply_max_segment_size(struct nullb_device *dev,
> +					unsigned int max_segment_size)
> +{
> +	if (max_segment_size < BLK_MIN_SEGMENT_SIZE)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>   NULLB_DEVICE_ATTR(size, ulong, NULL);
>   NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
>   NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
> @@ -450,6 +484,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
>   NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
>   NULLB_DEVICE_ATTR(blocksize, uint, NULL);
>   NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
> +NULLB_DEVICE_ATTR(max_segment_size, uint, nullb_apply_max_segment_size);
>   NULLB_DEVICE_ATTR(irqmode, uint, NULL);
>   NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
>   NULLB_DEVICE_ATTR(index, uint, NULL);
> @@ -608,6 +643,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>   	&nullb_device_attr_index,
>   	&nullb_device_attr_irqmode,
>   	&nullb_device_attr_max_sectors,
> +	&nullb_device_attr_max_segment_size,
>   	&nullb_device_attr_mbps,
>   	&nullb_device_attr_memory_backed,
>   	&nullb_device_attr_no_sched,
> @@ -805,6 +841,7 @@ static struct nullb_device *null_alloc_dev(void)
>   	dev->queue_mode = g_queue_mode;
>   	dev->blocksize = g_bs;
>   	dev->max_sectors = g_max_sectors;
> +	dev->max_segment_size = g_max_segment_size;
>   	dev->irqmode = g_irqmode;
>   	dev->hw_queue_depth = g_hw_queue_depth;
>   	dev->blocking = g_blocking;
> @@ -1248,6 +1285,9 @@ static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
>   	unsigned int valid_len = len;
>   	void *p;
>   
> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
> +		  dev->max_segment_size);
> +
>   	p = kmap_local_page(page) + off;
>   	if (!is_write) {
>   		if (dev->zoned) {
> @@ -1295,6 +1335,8 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
>   	spin_lock_irq(&nullb->lock);
>   	rq_for_each_segment(bvec, rq, iter) {
>   		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>   		if (transferred_bytes + len > max_bytes)
>   			len = max_bytes - transferred_bytes;
>   		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,


IMO, since max_segment_size is now configurable, should we consider using
blk_rq_map_sg() instead of rq_for_each_segment()?

rq_for_each_segment() iterates over bio_vecs, and these bvecs are not
guaranteed to comply with max_segment_size and seg_boundary_mask. Simply
clamping bv_len inside the loop does not correctly model how DMA segments
are formed. In particular, this approach does not account for merging or
splitting behavior based on physical contiguity or segment boundaries.

blk_rq_map_sg(), on the other hand, constructs a scatter-gather list that
already respects max_segment_size, seg_boundary_mask, and max_segments, and
may merge physically contiguous bvecs.

Given that, it may be cleaner to:
1. Call blk_rq_map_sg() to build the SG list
2. Iterate over the resulting SG segments
3. Perform data transfer using null_transfer() per SG entry

This would avoid modifying bvecs directly and ensure that segment
constraints are handled consistently with the block layer.

Thanks,
--Nilay

