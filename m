Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B09FC433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 14:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiCIOeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiCIOeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 09:34:11 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B83BA60
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 06:33:10 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220309143309euoutp02371231e287f5881a3e4704484f5696dd~avPiHZsEY2181621816euoutp02I
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 14:33:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220309143309euoutp02371231e287f5881a3e4704484f5696dd~avPiHZsEY2181621816euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646836389;
        bh=ASTEztd/FODMNbtIOyvsGPvpdt50iF3JQ1WxV3pomFI=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=shXY8JDZjsi+XGpvoQ31AsIjoVn/0tH8bXhNupMLuPawbq7BwAfRqh93xaEcAGpUQ
         rGjP2c5YwODgSzIERTkg8/HnSxxD8GH4vG6fh1xiSJeSk9Fwhgbva8M2WXgjEGKFXi
         53oR7/tP8E5Y9tej0wD3gHaQ0fUc/GrUhb/FDEtQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220309143308eucas1p265cb68b95267ade7e0c74a5daaee3ff9~avPhuEo7V2599125991eucas1p2K;
        Wed,  9 Mar 2022 14:33:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DC.B2.09887.4AAB8226; Wed,  9
        Mar 2022 14:33:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220309143308eucas1p13bd486d41c1e4f4126d00fdfccf2a647~avPhLSi5E1276912769eucas1p1Z;
        Wed,  9 Mar 2022 14:33:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220309143308eusmtrp1f4581d5c4b74493dbbbc412ccefe5a31~avPhKPHqH2280722807eusmtrp1E;
        Wed,  9 Mar 2022 14:33:08 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-0e-6228baa4644f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.F0.09522.4AAB8226; Wed,  9
        Mar 2022 14:33:08 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220309143308eusmtip1a53b450a70b6f5e6f2854d960aa02998~avPg-wnHX1616516165eusmtip1x;
        Wed,  9 Mar 2022 14:33:08 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 9 Mar 2022 14:33:03 +0000
Message-ID: <cf527b75-8fba-96ba-659d-fbb46fbe9de7@samsung.com>
Date:   Wed, 9 Mar 2022 15:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 4/6] nvme: zns: Add support for power_of_2 emulation to
 NVMe ZNS devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        <jiangbo.365@bytedance.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7pLdmkkGby8ZGqx+m4/m8Xvs+eZ
        LVauPspk0XPgA4vF+beHmSwmHbrGaLH3lrbF/GVP2S0mtH1ltrgx4SmjxZqbT1ks1r1+z+LA
        4/HvxBo2j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9swEo13qf1ePzJjmP9gPdTAFcUVw2
        Kak5mWWpRfp2CVwZqz+uYSm4HVuxdo57A+N37y5GTg4JAROJJ4famLoYuTiEBFYwShx98YId
        JCEk8IVR4vBaAYjEZ0aJ65M2sMB0rHq9ixUisZxR4uCGZWxwVY/Wr2eBcHYxSmzbdw4ow8HB
        K2AnMXsVH0g3i4CKRPvRG8wgNq+AoMTJmU/ApooKREi8PPKXCaRcWCBO4sTbHJAws4C4xK0n
        88HOExE4xyxxsWMyK0RiIqNE5y5zkHo2AS2Jxk6wqzkF3CT23LrMDFGiKdG6/Tc7hC0vsf3t
        HGaQcgkBZYnX620gfqmVWHvsDDvIeAmBU5wSWzZfZ4JIuEjs+L4WyhaWeHV8CzuELSNxenIP
        C0RDP6PE1JY/TBDODEaJnsObmSA2WEv0ncmBMB0lXn4ugDD5JG68FYQ4h09i0rbpzBMYVWch
        BcQsJB/PQvLBLCQfLGBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY3k7/O/5lB+Py
        Vx/1DjEycTAeYpTgYFYS4W0K1UgS4k1JrKxKLcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1
        OzW1ILUIJsvEwSnVwCRXt+S8TabxgqUHNOasf9Kx5p3S1msualOnMJ+28851j/TbffBCgYLo
        y1+fnoufjrx0qzI/aq7++WCzWlHtn03eYl7nHV1r+s2XLX5//ZNzR4uXc6qZ33ujc1Id8+1e
        7+Gew/F1geSsRA9FidbZa6o5V4fIXD2kx/2d2ewbrwPzUu+z5sH5V5kev7mVyvT/6YKI8wmc
        V128xCqlVx+WOv8g6C7fssr03uRQ9dR2fdZtltERHswHpxlsaNqw9MOl/zkmstcXvp51YHnv
        W1Ut1e6T8QHMa632nKv/O1ctovxooNkKnYsN10o4Dy6a8z92929psRe3mbh8noXqK+57ax7A
        3DXfRmFfU0fE7uA6ISWW4oxEQy3mouJEAMmnGKveAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd0luzSSDP7OErBYfbefzeL32fPM
        FitXH2Wy6DnwgcXi/NvDTBaTDl1jtNh7S9ti/rKn7BYT2r4yW9yY8JTRYs3NpywW616/Z3Hg
        8fh3Yg2bx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2QCUa73P6vF5k5xH+4FupgCuKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M1R/XsBTc
        jq1YO8e9gfG7dxcjJ4eEgInEqte7WLsYuTiEBJYySrzetpQVIiEj8enKR3YIW1jiz7UuNoii
        j4wSjefeQDm7GCXOfp3P2MXIwcErYCcxexUfSAOLgIpE+9EbzCA2r4CgxMmZT1hAbFGBCIm2
        ZVOYQcqFBeIkTrzNAQkzC4hL3HoynwlkpIjAOWaJix2TwS5iFuhnlFgy5QfUeb8ZJTb+7WIF
        6WYT0JJo7AS7jlPATWLPrcvMEJM0JVq3/2aHsOUltr+dA7ZMQkBZ4vV6G4hnaiVe3d/NOIFR
        dBaS82YhuWMWkkmzkExawMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAxbDv2c/MOxnmv
        PuodYmTiYDzEKMHBrCTC2xSqkSTEm5JYWZValB9fVJqTWnyI0RQYRhOZpUST84GpKa8k3tDM
        wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSlOrtb5036245YX+KfOFd7E
        9q6ag1XwsmjljCTrp8XMEbX5tmnfZyyJWRQxz4irz4JRVac2trd3Uc3cj+zn0o+rHo9qj+Wt
        mNV0LeT4NNu5/8+dj3FY0jf/3YrQIzb/P1xuVNHW757Rv7NKzCphh+3yP2eaouNf+Gn4h5Ue
        ywyakPFKkrGs8wTf9CqRXXEeSX8rk04L/m9+XsYU82bb1NuanIe3/O1LmC2g+sLUlGNP0qa/
        p3Y3xCdzTFM/8jN6Zuw23w+1GxW3OPp+6b0Vr8S1fp7h/CIjhp/XNf9WNl+pY+79y/3UasGc
        6RrK3+XC9ZeE2Ip9/r9ItGmm/zTdJD/2ODXmmSG/A70uN5z4ocRSnJFoqMVcVJwIAGXPyIGV
        AwAA
X-CMS-MailID: 20220309143308eucas1p13bd486d41c1e4f4126d00fdfccf2a647
X-Msg-Generator: CA
X-RootMTR: 20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165436eucas1p1b76f3cb5b4fa1f7d78b51a3b1b44d160@eucas1p1.samsung.com>
        <20220308165349.231320-5-p.raghav@samsung.com>
        <d13c40a5-3f87-fb2c-155e-dd64535067ac@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022-03-09 05:04, Damien Le Moal wrote:
> On 3/9/22 01:53, Pankaj Raghav wrote:
 
> Contradiction: reducing the impact of performance regression is not the
> same as "does not create a performance regression". So which one is it ?
> Please add performance numbers to this commit message.

> And also please actually explain what the patch is changing. This commit
> message is about the why, but nothing on the how.
>
I will reword and add a bit more context to the commit log with perf numbers
in the next revision
>> +EXPORT_SYMBOL_GPL(nvme_fail_po2_zone_emu_violation);
>> +
> 
> This should go in zns.c, not in the core.
> 
Ok.

>> +
>> +static void nvme_npo2_zone_setup(struct gendisk *disk)
>> +{
>> +	nvme_ns_po2_zone_emu_setup(disk->private_data);
>> +}
> 
> This helper seems useless.
>
I tried to retain the pattern with report_zones which is currently like this:
static int nvme_report_zones(struct gendisk *disk, sector_t sector,
		unsigned int nr_zones, report_zones_cb cb, void *data)
{
	return nvme_ns_report_zones(disk->private_data, sector, nr_zones, cb,
			data);
}

But I can just remove this helper and use nvme_ns_po2_zone_emu_setup cb directly
in nvme_bdev_fops.

>> +
>>  /*
>>   * Convert a 512B sector number to a device logical block number.
>>   */
>>  static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
>>  {
>> -	return sector >> (ns->lba_shift - SECTOR_SHIFT);
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	return ns->sect_to_lba(ns, sector);
> 
> So for a power of 2 zone sized device, you are forcing an indirect call,
> always. Not acceptable. What is the point of that po2_zone_emu boolean
> you added to the queue ?
This is a good point and we had a discussion about this internally.
Initially I had something like this:
if (!blk_queue_is_po2_zone_emu(disk))
	return sector >> (ns->lba_shift - SECTOR_SHIFT);
else
	return __nvme_sect_to_lba_po2(ns, sec);

But @Luis indicated that it was better to set an op which comes at a cost of indirection
instead of having a runtime check with a if/else in the **hot path**. The code also looks
more clear with having an op.

The performance analysis that we performed did not show any regression while using the indirection
for po2 zone sizes, at least on the x86_64 architecture.
So maybe we could use this opportunity to discuss which approach could be used here.


>> +
>> +		sector = nvme_lba_to_sect(ns,
>> +					  le64_to_cpu(nvme_req(req)->result.u64));
>> +
>> +		sector = ns->update_sector_append(ns, sector);
> 
> Why not assign that to req->__sector directly ?
> And again here, you are forcing the indirect function call for *all* zns
> devices, even those that have a power of 2 zone size.
>
Same answer as above. I will adapt them based on the outcome of our
discussions.
>> +
>> +		req->__sector = sector;
>> +	}
>> +
>> +static inline bool nvme_po2_zone_emu_violation(struct request *req)
>> +{
>> +	return req->rq_flags & RQF_ZONE_EMU_VIOLATION;
>> +}
> 
> This helper makes the code unreadable in my opinion.
>
I will open code it then.
>> +#else
>> +static inline void nvme_end_req_zoned(struct request *req)
>> +{
>> +}
>> +
>> +static inline void nvme_verify_sector_value(struct nvme_ns *ns, struct request *req)
>> +{
>> +}
>> +
>> +static inline bool nvme_po2_zone_emu_violation(struct request *req)
>> +{
>> +	return false;
>> +}
>> +
>> +#endif
>> +
>>  /*
>>   * Convert byte length to nvme's 0-based num dwords
>>   */
>> @@ -752,6 +842,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>>  long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>  		unsigned long arg);
>>  int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
>> +blk_status_t nvme_fail_po2_zone_emu_violation(struct request *req);
>>  
>>  extern const struct attribute_group *nvme_ns_id_attr_groups[];
>>  extern const struct pr_ops nvme_pr_ops;
>> @@ -873,11 +964,13 @@ static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>>  int nvme_revalidate_zones(struct nvme_ns *ns);
>>  int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>  		unsigned int nr_zones, report_zones_cb cb, void *data);
>> +void nvme_ns_po2_zone_emu_setup(struct nvme_ns *ns);
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>>  				       struct nvme_command *cmnd,
>>  				       enum nvme_zone_mgmt_action action);
>> +blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req);
>>  #else
>>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
>>  		struct request *req, struct nvme_command *cmnd,
>> @@ -892,6 +985,11 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>>  		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
>>  	return -EPROTONOSUPPORT;
>>  }
>> +
>> +static inline blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req)
>> +{
>> +	return BLK_STS_OK;
>> +}
>>  #endif
>>  
>>  static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 6a99ed680915..fc022df3f98e 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -960,6 +960,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  		return nvme_fail_nonready_command(&dev->ctrl, req);
>>  
>>  	ret = nvme_prep_rq(dev, req);
>> +
>> +	if (unlikely(nvme_po2_zone_emu_violation(req)))
>> +		return nvme_fail_po2_zone_emu_violation(req);
>> +
>>  	if (unlikely(ret))
>>  		return ret;
>>  	spin_lock(&nvmeq->sq_lock);
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index ad02c61c0b52..25516a5ae7e2 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -3,7 +3,9 @@
>>   * Copyright (C) 2020 Western Digital Corporation or its affiliates.
>>   */
>>  
>> +#include <linux/log2.h>
>>  #include <linux/blkdev.h>
>> +#include <linux/math.h>
>>  #include <linux/vmalloc.h>
>>  #include "nvme.h"
>>  
>> @@ -46,6 +48,18 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>>  	return 0;
>>  }
>>  
>> +static sector_t nvme_zone_size(struct nvme_ns *ns)
>> +{
>> +	sector_t zone_size;
>> +
>> +	if (blk_queue_is_po2_zone_emu(ns->queue))
>> +		zone_size = ns->zsze_po2;
>> +	else
>> +		zone_size = ns->zsze;
>> +
>> +	return zone_size;
>> +}
>> +
>>  int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>>  {
>>  	struct nvme_effects_log *log = ns->head->effects;
>> @@ -122,7 +136,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>>  				   sizeof(struct nvme_zone_descriptor);
>>  
>>  	nr_zones = min_t(unsigned int, nr_zones,
>> -			 get_capacity(ns->disk) / ns->zsze);
>> +			 get_capacity(ns->disk) / nvme_zone_size(ns));
>>  
>>  	bufsize = sizeof(struct nvme_zone_report) +
>>  		nr_zones * sizeof(struct nvme_zone_descriptor);
>> @@ -147,6 +161,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>  				 void *data)
>>  {
>>  	struct blk_zone zone = { };
>> +	u64 zone_gap = 0;
>> +	u32 zone_idx;
>>  
>>  	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
>>  		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
>> @@ -159,10 +175,19 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>  	zone.len = ns->zsze;
>>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>> +
>> +	if (blk_queue_is_po2_zone_emu(ns->queue)) {
>> +		zone_idx = zone.start / zone.len;
>> +		zone_gap = zone_idx * ns->zsze_diff;
>> +		zone.start += zone_gap;
>> +		zone.len = ns->zsze_po2;
>> +	}
>> +
>>  	if (zone.cond == BLK_ZONE_COND_FULL)
>>  		zone.wp = zone.start + zone.len;
>>  	else
>> -		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>> +		zone.wp =
>> +			nvme_lba_to_sect(ns, le64_to_cpu(entry->wp)) + zone_gap;
>>  
>>  	return cb(&zone, idx, data);
>>  }
>> @@ -173,6 +198,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>  	struct nvme_zone_report *report;
>>  	struct nvme_command c = { };
>>  	int ret, zone_idx = 0;
>> +	u64 zone_size = nvme_zone_size(ns);
>>  	unsigned int nz, i;
>>  	size_t buflen;
>>  
>> @@ -190,7 +216,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>>  
>> -	sector &= ~(ns->zsze - 1);
>> +	sector = rounddown(sector, zone_size);
>>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>>  		memset(report, 0, buflen);
>>  
>> @@ -214,7 +240,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>  			zone_idx++;
>>  		}
>>  
>> -		sector += ns->zsze * nz;
>> +		sector += zone_size * nz;
>>  	}
>>  
>>  	if (zone_idx > 0)
>> @@ -226,6 +252,32 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>>  	return ret;
>>  }
>>  
>> +void nvme_ns_po2_zone_emu_setup(struct nvme_ns *ns)
>> +{
>> +	u32 nr_zones;
>> +	sector_t capacity;
>> +
>> +	if (is_power_of_2(ns->zsze))
>> +		return;
>> +
>> +	if (!get_capacity(ns->disk))
>> +		return;
>> +
>> +	blk_mq_freeze_queue(ns->disk->queue);
>> +
>> +	blk_queue_po2_zone_emu(ns->queue, 1);
>> +	ns->zsze_po2 = 1 << get_count_order_long(ns->zsze);
>> +	ns->zsze_diff = ns->zsze_po2 - ns->zsze;
>> +
>> +	nr_zones = get_capacity(ns->disk) / ns->zsze;
>> +	capacity = nr_zones * ns->zsze_po2;
>> +	set_capacity_and_notify(ns->disk, capacity);
>> +	ns->sect_to_lba = __nvme_sect_to_lba_po2;
>> +	ns->update_sector_append = nvme_update_sector_append_po2_zone_emu;
>> +
>> +	blk_mq_unfreeze_queue(ns->disk->queue);
>> +}
>> +
>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)
>>  {
>> @@ -239,5 +291,24 @@ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>>  	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
>>  		c->zms.select_all = 1;
>>  
>> +	nvme_verify_sector_value(ns, req);
>> +	return BLK_STS_OK;
>> +}
>> +
>> +blk_status_t nvme_zone_handle_po2_emu_violation(struct request *req)
>> +{
>> +	/*  The spec mentions that read from ZCAP until ZSZE shall behave
>> +	 *  like a deallocated block. Deallocated block reads are
>> +	 *  deterministic, hence we fill zero.
>> +	 * The spec does not clearly define the result for other opreation.
>> +	 */
> 
> Comment style and indentation is weird.
>
Ack.
>> +	if (req_op(req) == REQ_OP_READ) {
>> +		zero_fill_bio(req->bio);
>> +		nvme_req(req)->status = NVME_SC_SUCCESS;
>> +	} else {
>> +		nvme_req(req)->status = NVME_SC_WRITE_FAULT;
>> +	}
> 
> What about requests that straddle the zone capacity ? They need to be
> partially zeroed too, otherwise data from the next zone may be exposed.
>
Good point. I will add this support in the next revision. Thanks.
>> +	blk_mq_set_request_complete(req);
>> +	nvme_complete_rq(req);
>>  	return BLK_STS_OK;
>>  }
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 3a41d50b85d3..9ec59183efcd 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -57,6 +57,8 @@ typedef __u32 __bitwise req_flags_t;
>>  #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
>>  /* queue has elevator attached */
>>  #define RQF_ELV			((__force req_flags_t)(1 << 22))
>> +/* request to do IO in the emulated area with po2 zone emulation */
>> +#define RQF_ZONE_EMU_VIOLATION	((__force req_flags_t)(1 << 23))
>>  
>>  /* flags that prevent us from merging requests: */
>>  #define RQF_NOMERGE_FLAGS \
> 
> 

-- 
Regards,
Pankaj
