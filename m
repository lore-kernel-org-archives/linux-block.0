Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15554C433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiEPOCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiEPOC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 10:02:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFF1A389
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652709747; x=1684245747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK7baB8oU4=;
  b=McK/7kbXvDhoVG5xH/cfA1XcMSDaTcTaEqIzeZhtCY+uCHaUcTF1v5Bt
   kxj4949EnwXZsRmIb/Qg1Sy2GdFqi9JNIQFe5tBJ7v284W0+aJf04BBVU
   GNpCMafwzORlN0nch1hODfjGLFilxo3JpvFcRgJkQ8OmWe6blv0cGf2ft
   Ee3eueOXRPjIIbfE3OrPpYTLGP8dqcZZYybIWr3ImtEr6hBeDMIogKwlT
   D/SLTOa68YX4nakEl+Ei4Cszcb9j4tY06eYR9NNmsP12L1JMDvuCj+nLd
   UHquCBGNrrrxsJYxICeaL5SRH0akfx83XnAMMC59HNuqGbxB/cDt8G4AI
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205306642"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:02:27 +0800
IronPort-SDR: Ij6V1YiUE/sENgOx7CnI0VaRxhZaNtqB8wLb3FwnG/Uq2VT3Oe2shGdajDIaY4n/7J2Bb5lfTu
 3jXYdne/odR7I7ROBOCst2ZnaXvybRtDnoPZ0yz0gHLq7kTDFrvo4kcG6BzEaNc9+2nS/xlpSD
 heng6ONz2rxRqpcgj6KdfQa7nLhdafUAu7fwggOk4aUvMsyzZ04Tjv5kXbeP2SOlgC8v/RZFrx
 k+SCbPf1UaN6o2NCPw5CkCOXvLgYWmgFtESmWPfiB3DNYDdY6S5SM96tyjNZaPWsLmG9pJg1kC
 UwhC1gH5MnpLdOBpWUMp12TP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:28:10 -0700
IronPort-SDR: JOHCrnOUmCNZGiDgX61nkPA32ANY0uoIV/4EKIGhc+pwIxXIKX2psjEohyT+U4r17SER4pO31t
 3twdr+MjHSyK2axR5JfXrAHErupVM/B6Y9jKXA23nRFQifF2dsjDjQhKMPcBEJ6C+plEx1fGpQ
 ss7Rhk7Itzk9W486oDx3EyJ4hDk4Hq5Xyf2YqKIS7HWHZZm5BB4CLdjNqd2hPCuC5XQ3lgWaqU
 SzApPUF8GiXvlBDsWntqIVinBfbHACoyCJT+K3l6aFSBO7HjXMQ1cWNUAVmZSNWWxdr9pdNMkq
 OEU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:02:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21Cl0Yqxz1SVpD
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:02:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652709746; x=1655301747; bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK
        7baB8oU4=; b=g5HXP5sVUntwSPqraDrwqbiwWoKzSlQz5eNpRQMVQIm31yD1VDg
        9nKU8IqEjHhBNcYQkJHPtfI+YGNRAJ1c1TBWaoYboTZtwJDFX0QG6G9RVr3V92bH
        gJlWbxjzteqSKP2s+7Tz2p1QjT0NOALTmlP/K6iaRYXzn7Jvqx5HYaPe2xenCINW
        tHr3uJtFcizoAIokoF0obIBVu4Y2c8vOxgbIeaw5PcYy3hjrCm+/ZaHJ1rnxnTzG
        PgoUgPdgugkirbK3x/Lq9lJFjztDGzmQFz7LaH2HCUhiemtIQ8/BgxtT6D1qMsqK
        yWagoXwtYZMjv4sNn1AtbIa+DXOcQHhVt7w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vy-AknM_XiOE for <linux-block@vger.kernel.org>;
        Mon, 16 May 2022 07:02:26 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Cb6yPlz1Rvlc;
        Mon, 16 May 2022 07:02:19 -0700 (PDT)
Message-ID: <501aba4d-f4a3-8a4d-ec2a-99c7319b6a4d@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
        Chris Mason <clm@fb.com>, matias.bjorling@wdc.com,
        gost.dev@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4@eucas1p1.samsung.com>
 <20220516133921.126925-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4d..65d2aa68a 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>  				   sizeof(struct nvme_zone_descriptor);
>  
> +	/*
> +	 * Division is used to calculate nr_zones with no special handling
> +	 * for power of 2 zone sizes as this function is not invoked in a
> +	 * hot path
> +	 */

Comment not very useful.

>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	int ret, zone_idx = 0;
>  	unsigned int nz, i;
>  	size_t buflen;
> +	u64 remainder = 0;
>  
>  	if (ns->head->ids.csi != NVME_CSI_ZNS)
>  		return -EINVAL;
> @@ -197,7 +196,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>  
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * rounddown the sector value to the nearest zone size. roundown macro
> +	 * provided in math.h will not work for 32 bit architectures.
> +	 * Division is used here with no special handling for power of 2
> +	 * zone sizes as this function is not invoked in a hot path
> +	 */

Please simplify this to:

	/* Round down the sector value to the nearest zone start */

> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
>  


-- 
Damien Le Moal
Western Digital Research
