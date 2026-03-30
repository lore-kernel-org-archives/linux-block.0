Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014318EFD1
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851569; cv=none; b=VbjWV5Z0ArWgN7H07E7ck70wXbzketr2i303kB1RbqkKF+pgTNOf0JFcgdBmgTe1fgaSPN42kFMQyMFVTiCCoTn0iAAELUdHEAO9XvyT66oWFqeZL0e8xdY5bh0fFQPlTfPY38aqQMW0AgTQcz0Rl9+/KMG5JaM4xHCfifoZVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851569; c=relaxed/simple;
	bh=oAya6wmvcT0tQFonjIOySAaTiabuCA4aI1rZDJS0cho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwAXJr8HMcwaNZI4OHBss6bIiunA6G5fYzj51eQvUCYfEX8KzgPJhjKlmxtgP1jW3+6RYijGSyMVWDkc34Wl6BofoDhhwih6oT4HAh1pFzTUg/dfXBpcdWBM3lySEuselR8wNFzhOxZ+g5L0umh7WZ9+7vxejTGiGOTptAxZBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hwC7lGyX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hwC7lGyX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TKn14Z033664;
	Mon, 30 Mar 2026 06:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CtxI31
	coir7GRcbJFGS/Zr9qnQqK+9GHcFapTjJSaA0=; b=hwC7lGyXM+SGNSzBl2CIZ9
	2QpunKnWVSqDW7kh0kIjjefmsuKhud+qOUbzJOwOurzVRC9Yg+Ab3FJKLdkcUTUp
	4W0Zf+KM2a8NK1bd/rmm6DhuG3cR63LG6BnVVEX6nTD997RYNj8ocLhGfNEAU75X
	57v3N3qVpkt5L7l/Czr90IRB8jAdsZ3p1uhRwP6xOF2PEzqbPseQFQYHtVorcf6J
	5t0mXaKGTIsb8SfPqNN9215E+k61IVhBl0kFelsTfXhhwYPBpzIqNLuiQJSO4Y/q
	kTpWV/A6+Ye0QFE4i7G/9XH8hXBrRScbz6Qn3Z1VbD0blgfIXHkq2h8Wjjmiprrw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgdbhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 06:13:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U5vE96022217;
	Mon, 30 Mar 2026 06:13:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamum4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 06:13:50 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62U6Doxm31523554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 06:13:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F7DC582AB;
	Mon, 30 Mar 2026 06:13:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C0F582A5;
	Mon, 30 Mar 2026 06:13:45 +0000 (GMT)
Received: from [9.123.2.203] (unknown [9.123.2.203])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 06:13:45 +0000 (GMT)
Message-ID: <c40349bf-9356-407b-954b-60aa99217028@linux.ibm.com>
Date: Mon, 30 Mar 2026 11:43:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] null_blk: Support configuring the maximum DMA
 segment size
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
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
 <c084beea-6c42-41f3-8f85-bf477ab0d893@linux.ibm.com>
 <acnesO__-9NRkpgY@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <acnesO__-9NRkpgY@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA0MiBTYWx0ZWRfXxnBZHaxeFnC9
 dwZBKwHNsvdqPvmzXy3GkuYA1QxxtGudxqnpAtpXMs0G1qf/Mg4tTnDJ+z16gfbEHwBQLbA3a1h
 TXmMQyDWPpZ02zmB0bRfIBJ5UdCpc1t5c9Ig9BeoJXnwCEQnoCajJV6ITZ/TGH6BticypuCV1BI
 YVy5dtQlo2X/vX3SwB4q+NCuR+o4HLYA6P+Q3SgrxvYKJcrG6zf4sBZEGheNevIeqloyRwm8Bt9
 odesoRI2oKOfjmYiD1ObCVb+v/APL8myID+2yi05/dDU5rqrQIgTWfrf0VwLytgR68wJRgEDfi5
 GGhhVie8TiV1eBh9roAci7KA8e1Pr4LzGCcQJ1jNagIbx8i+VT9UGOVF6XheITyZt2lNlYWCaup
 XI55Dy/B3qTlKvsg6wz2RRRgCf8zL89VbSA4GBzfrW8suShLQWvBktGeA9ekbwiwqVV0L/3FqT2
 f8kLP7iClrQoFpcaeRQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ca14a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=JF9118EUAAAA:8 a=Ikd4Dj_1AAAA:8 a=N54-gffFAAAA:8 a=k1Wa_n_pwMdX0p3gYqEA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: 9e4gd1l2lcIGmAm8oenQrfVM6PQCozVy
X-Proofpoint-ORIG-GUID: zK3Kxdul_S81KLlS3PhQ4M568Kqf_vcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300042

On 3/30/26 7:53 AM, Ming Lei wrote:
> On Sun, Mar 29, 2026 at 06:00:31PM +0530, Nilay Shroff wrote:
>> On 3/28/26 2:43 AM, Bart Van Assche wrote:
>>> Add support for configuring the maximum DMA segment size. The maximum DMA
>>> segment size may be set to a value smaller than the virtual memory page
>>> size. Reject invalid max_segment_size values.
>>>
>>> Since rq_for_each_segment() may yield bvecs larger than the maximum DMA
>>> segment size, add code in the rq_for_each_segment() loop that restricts
>>> the bvec length to the maximum DMA segment size.
>>>
>>> Cc: Christoph Hellwig<hch@lst.de>
>>> Cc: Ming Lei<ming.lei@redhat.com>
>>> Cc: Damien Le Moal<damien.lemoal@opensource.wdc.com>
>>> Cc: Chaitanya Kulkarni<kch@nvidia.com>
>>> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
>>> ---
>>>    drivers/block/null_blk/main.c     | 43 +++++++++++++++++++++++++++++++
>>>    drivers/block/null_blk/null_blk.h |  1 +
>>>    2 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index f8c0fd57e041..d5fbbc5d63ed 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -169,6 +169,32 @@ static int g_max_sectors;
>>>    module_param_named(max_sectors, g_max_sectors, int, 0444);
>>>    MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>>> +static unsigned int g_max_segment_size = BLK_MAX_SEGMENT_SIZE;
>>> +
>>> +static int nullb_set_max_segment_size(const char *val,
>>> +				      const struct kernel_param *kp)
>>> +{
>>> +	int res;
>>> +
>>> +	res = kstrtouint(val, 0, &g_max_segment_size);
>>> +	if (res < 0)
>>> +		return res;
>>> +
>>> +	if (g_max_segment_size < BLK_MIN_SEGMENT_SIZE)
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct kernel_param_ops max_segment_size_ops = {
>>> +	.set = nullb_set_max_segment_size,
>>> +	.get = param_get_uint,
>>> +};
>>> +
>>> +module_param_cb(max_segment_size, &max_segment_size_ops, &g_max_segment_size,
>>> +		0444);
>>> +MODULE_PARM_DESC(max_segment_size, "Maximum size of a DMA segment in bytes");
>>> +
>>>    static unsigned int nr_devices = 1;
>>>    module_param(nr_devices, uint, 0444);
>>>    MODULE_PARM_DESC(nr_devices, "Number of devices to register");
>>> @@ -442,6 +468,14 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
>>>    	return ret;
>>>    }
>>> +static int nullb_apply_max_segment_size(struct nullb_device *dev,
>>> +					unsigned int max_segment_size)
>>> +{
>>> +	if (max_segment_size < BLK_MIN_SEGMENT_SIZE)
>>> +		return -EINVAL;
>>> +	return 0;
>>> +}
>>> +
>>>    NULLB_DEVICE_ATTR(size, ulong, NULL);
>>>    NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
>>>    NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
>>> @@ -450,6 +484,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
>>>    NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
>>>    NULLB_DEVICE_ATTR(blocksize, uint, NULL);
>>>    NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
>>> +NULLB_DEVICE_ATTR(max_segment_size, uint, nullb_apply_max_segment_size);
>>>    NULLB_DEVICE_ATTR(irqmode, uint, NULL);
>>>    NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
>>>    NULLB_DEVICE_ATTR(index, uint, NULL);
>>> @@ -608,6 +643,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>>>    	&nullb_device_attr_index,
>>>    	&nullb_device_attr_irqmode,
>>>    	&nullb_device_attr_max_sectors,
>>> +	&nullb_device_attr_max_segment_size,
>>>    	&nullb_device_attr_mbps,
>>>    	&nullb_device_attr_memory_backed,
>>>    	&nullb_device_attr_no_sched,
>>> @@ -805,6 +841,7 @@ static struct nullb_device *null_alloc_dev(void)
>>>    	dev->queue_mode = g_queue_mode;
>>>    	dev->blocksize = g_bs;
>>>    	dev->max_sectors = g_max_sectors;
>>> +	dev->max_segment_size = g_max_segment_size;
>>>    	dev->irqmode = g_irqmode;
>>>    	dev->hw_queue_depth = g_hw_queue_depth;
>>>    	dev->blocking = g_blocking;
>>> @@ -1248,6 +1285,9 @@ static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
>>>    	unsigned int valid_len = len;
>>>    	void *p;
>>> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
>>> +		  dev->max_segment_size);
>>> +
>>>    	p = kmap_local_page(page) + off;
>>>    	if (!is_write) {
>>>    		if (dev->zoned) {
>>> @@ -1295,6 +1335,8 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
>>>    	spin_lock_irq(&nullb->lock);
>>>    	rq_for_each_segment(bvec, rq, iter) {
>>>    		len = bvec.bv_len;
>>> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
>>> +		bvec.bv_len = len;
>>>    		if (transferred_bytes + len > max_bytes)
>>>    			len = max_bytes - transferred_bytes;
>>>    		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>>
>>
>> IMO, since max_segment_size is now configurable, should we consider using
>> blk_rq_map_sg() instead of rq_for_each_segment()?
> 
> blk_rq_map_sg() requires to allocate sgl, actually it can be done in
> request sg iterator way:
> 
> 	blk_rq_map_iter_init();
> 	while (blk_map_iter_next(rq, &iter, &vec)) {
> 		consume each segment;
> 	}
> 
> Just the two helpers needs to be exported.
> 
Yeah this should also work (and a good start as it avoids
allocating sgl), if we could export those two helpers.

Thanks,
--Nilay

