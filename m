Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB48CC19F28
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 03:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiG1DSP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiG1DSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 23:18:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12CBF44
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978293; x=1690514293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QUbay5Dzz476bfBAfIiryaPk/r7bibYqxCGIlUR7KkE=;
  b=fovpTiiDkRdsYnOcwf5hkwUyfRXoATl/WDftmccIbKhve5eqlng9c/K1
   0FAQ2trNGaRxSq6RiTQ3nWh5W4b5FNLuFqKLsPNSu4+OhU+ipMpu5Gi9X
   yd1XdP/ZtCDE1Y8af8qMqBnxcFIUvhckmzihp2bBAiO59Pcjft5h8awCo
   VPtMLYbjt075Tk9Vtd1oygBc0cOe2jCnf/ngZ5oct3qJEXbT9q10By23u
   GJZjdKetdApmG0Q6MD0jDhzJSC5NzrY8tnpmvoMYyhyB454oVm2k35AHo
   dYVUpj8zGwsUhjZLeEEKxlDWq3aIHmowXf2AEvxzVFwiBSgSVBsgo5D29
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="207730979"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:18:12 +0800
IronPort-SDR: EVMpHxthaFC/ZMmPLiOvS1JrMY7Q4Eb4i818skD8/SNKX080OaKnpowDOO5HAgf9VeLbVhoi1i
 f2ZazvXf8ALQLOje95i449zaEjr2C9RFLa+735WIfK6c79CegKU9NDXnozCEWxpw5vExQWGXBO
 oOI/xYto46hW/DTNZtjEA+0vti0XLH4/bBQxPIggB4W7IbIgYak12/GlRqyjwD6yL91xaEYhM7
 0ocTEKTo3K8Y5b8pvy4kYGoNVT79RFQ9hIpMbfCOq4zN+AXXVwHlg28+TjbeJh5MEYzO75EZDp
 489PuvM6WLFGaard1wIJ6sr0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:39:23 -0700
IronPort-SDR: ZyoKmsylhSedXicuGgnzsAKI7Nq64lSiO7Bf+g/fbrjfGpPsizr6wjBsVuPgnxniXJaepDx9vX
 /RUI8ity6NKZa2KWdUZUyASDyBjpSnKyGg4Z2EEHee8untQKH0Iq/cH1Yo712/lYDU7ap2ypaP
 tV81ns+gZ9+O/38dCYa1uk1wmjUh8RXkSNLYZobdXUSoTfsRttLIj/SB/Zjt3mMqurkgasJItq
 HPrsrNJnXLoazYM31GSHstLYoNBhOLKp46Tlf2g0ekwRnNc/TUya6RE4u3rUUmpl0zxwXhjHF+
 8LE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:18:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbSg4WFcz1Rwry
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:18:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978290; x=1661570291; bh=QUbay5Dzz476bfBAfIiryaPk/r7bibYqxCG
        IlUR7KkE=; b=V7tN3bTJ2CDYKTvT5s/9ZlNbVU9X4rTa2Lxiic3JgytO51jLDYa
        uM/rh7HmMK6VgDQzdHO7x27RlAwVkq0+Ug+LOFTXs2rooZsqcpOwt2070rYWwLG/
        QFFmQxJRQLcVJaBmGeZVfR5IggkL7wqKerSPYCTD+ZENqvWBfFXsBSnQGHaXALPW
        1b7MaBWtRfQ5dRtH6t5odgTo4yfoadbRkVc/JzWAxvChHXjqcKPORMuOA+OYPml8
        QinPCxuR7AMmTk3sgh4rsVFgGGJDiVZmCqsclVxOeuhqpUCUe7jRo0ttbhGInwE0
        FNffb0GTniss+8dnOh6WUdv6wuSRhlbkOFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vr7PRCdUcDCV for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 20:18:10 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbSc2CCQz1RtVk;
        Wed, 27 Jul 2022 20:18:08 -0700 (PDT)
Message-ID: <6f93c6f4-240d-2d61-c53d-b5e66895ebcf@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:18:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 07/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f@eucas1p1.samsung.com>
 <20220727162245.209794-8-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-8-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> non po2 support is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zoned-target.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 95b132b52f33..16499b75c5ee 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  				return -EINVAL;
>  			}
>  			zone_nr_sectors = bdev_zone_sectors(bdev);
> +			if (!is_power_of_2(zone_nr_sectors)) {
> +				ti->error = "Zone size is not power of 2";

Let's clarify:

	ti->error = "Zone size is not a power of 2 number of sectors";

> +				return -EINVAL;
> +			}
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
> +			ti->error = "Zone size is not power of 2";

Same comment.

> +			return -EINVAL;
> +		}
>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
