Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A76C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 03:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiCIDrU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 22:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCIDrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 22:47:19 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BDA4A3FD
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646797581; x=1678333581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zNtApz3foCC8So0mUtisC64g+reBs2txhpJweWOmqPc=;
  b=AnZsIFLUxL/thPqvbhBnllKBvwuBvV4l7CyUqNaaini9Sja1+AxiP60G
   tUZhUrrMoj5OONT9Pkp492N0H04ZdXbT7p1LG7R1vURRQ/VmrV6knl+14
   3YyV/W37lgsjSqAyIZM0r9fXSd1Xs/h864cJHaPKLKa2rjCxzUHq7jGnI
   eFxJwW6RlZTRgcKpxVBnxqgG2qs8M0oO0iRDZnVS+apEYGVzpctZhPmgA
   upr0Kmhlpd+tpe8zHyCFA2ImgOvDvEkg//75kiL09k5F2pGiysZT1FGU1
   KbLK2wJCW4u03seklpOobGI1P6a7BeDUw5ufYsPy1GWpWnTIBH8mwhYot
   A==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; 
   d="scan'208";a="193752929"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 11:46:20 +0800
IronPort-SDR: 0lEOtr0gtsI0pRpoF0hZmRfT/dR7ivpfnLD2kfJHlKqW+YNEyRvEMMekwg2ewJDPLNheazKLz0
 qfv5WqrXl4rM4roF1ZUEst9o5dClIFIKo3XUZKW2oB3uWr4jSEZo7ddQPMWRvyS0Wl2QDUwk2n
 ic+nwSKzqrE87MUcMt1LBytfIAgKpyps87AXSQPOpwhsDT2tTh2azaX93nPHCxU+nSBBX+qDqE
 vX0zPwgBtzA4ftDB2SenCEazKwt/FHhhbyj/Q5xPmGcLIofI6ipj0OaTic0JUu7Fkt4cJ/rIs5
 N0UDXK3UJwK0VUJCCwb+LdsU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:17:36 -0800
IronPort-SDR: qQ9mWtCDeKp5Xr//YT4fg5eKJCM7CV4lIDGa4I75Ix+dsCS6qWS35F2rjJAQHD9ftssG3GdwAl
 xgIchEAdLQotCS2M2rHSgHKOJx0F6jRfwJWwt4lrDOJLAL8a/2BHyDM85rQHG4dCM7JJXVJuwB
 7vqe+NlT831iYxy65jXe+UibNBvryq7cThrv40pEDSgBNdXxsbd5v93FGLIh6xYiZYzbY8SycV
 ovsgWv1J/zgkNRJZnau6AZT1oKcwC9meyc27TOD092gMnDyHJMETy7NZ9adF0yq4o1TGoPrpc4
 uIQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:46:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCymD0yqgz1SVp4
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 19:46:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646797579; x=1649389580; bh=zNtApz3foCC8So0mUtisC64g+reBs2txhpJ
        weWOmqPc=; b=iV4wHSmLPcZqZWoDacHmXKv6c0URhDLgWWIhhfrDSTRsiDv1mXo
        fBOUS9povmjjJnx5UfTUXimy2apNPrqw0tJK5uV9ZrZT6ptFO/XKZ3lXMEQwZe89
        0iR/lTgMWvUtTL+6eOosRA+TXPLYMnDGewAnbsvTFJoqAGgLdjdjhBbg5aAMuRvH
        ZAPut2VIYouqGww4L+3DOtgZ8n6WdPQD6y2riNb1736N4l4fPXZVa7UqbPUB9lwc
        An7dEy55yHcmujX8OtXbKkvTX/uTkk6S9w/e1mkZhNdHqV4DP3QeomsUVt/sQCZu
        SX+0Uns0apGRVvJm0n6MpDr8oZ38m0gWgBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qJwpdgSxoS4k for <linux-block@vger.kernel.org>;
        Tue,  8 Mar 2022 19:46:19 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCym86Zh6z1Rvlx;
        Tue,  8 Mar 2022 19:46:16 -0800 (PST)
Message-ID: <f08307fe-75f0-0c13-04b3-1b5074d32ec8@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 12:46:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/6] block: Add npo2_zone_setup callback to block device
 fops
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d@eucas1p1.samsung.com>
 <20220308165349.231320-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308165349.231320-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/22 01:53, Pankaj Raghav wrote:
> A new fops is added to block device which will be used to setup the
> necessary hooks when a non-power_of_2 zone size is detected in a zoned
> device.
> 
> This fops will be called as a part of blk_revalidate_disk_zones.

And what does this new hook do ? You are actually not explaining it, nor
why it should be called from blk_revalidate_disk_zones().

Also, blk_revalidate_zone_cb() uses bit shift but this patch, nor the
previous one fix that.

> 
> The primary use case for this callback is to deal with zoned devices
> that does not have a power_of_2 zone size such as ZNS drives.For e.g,
> the current NVMe ZNS specification does not require zone size to be
> power_of_2 but the linux block layer still expects a all zoned device to
> have a power_of_2 zone size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-zoned.c      | 3 +++
>  include/linux/blkdev.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 602bef54c813..d3d821797559 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -575,6 +575,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>  	if (!get_capacity(disk))
>  		return -EIO;
>  
> +	if (disk->fops->npo2_zone_setup)
> +		disk->fops->npo2_zone_setup(disk);
> +
>  	/*
>  	 * Ensure that all memory allocations in this context are done as if
>  	 * GFP_NOIO was specified.
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a12c031af887..08cf039c1622 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1472,6 +1472,7 @@ struct block_device_operations {
>  	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
>  	int (*report_zones)(struct gendisk *, sector_t sector,
>  			unsigned int nr_zones, report_zones_cb cb, void *data);
> +	void (*npo2_zone_setup)(struct gendisk *disk);
>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
>  	/* returns the length of the identifier or a negative errno: */
>  	int (*get_unique_id)(struct gendisk *disk, u8 id[16],


-- 
Damien Le Moal
Western Digital Research
