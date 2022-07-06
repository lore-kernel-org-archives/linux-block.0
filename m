Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4BEC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiGFMAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiGFL76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 07:59:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAAA1EC56
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657108797; x=1688644797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S2dmgFWYC+DLGT+2UImPSe0KHi+Xt6J1e3za4GRwE7w=;
  b=FUO+erj1x+y6P1+X/gY1QeJcNI9xyJOEsZIDGoM6LlfxFeMPphsfEdIc
   h18h+fX/olIGdOGz0HecfNBI03QfCW0HUb8mjGuUKcXQY0hxInTYLPKUQ
   w8BGmof3g15uWLSwrMylROZHoVh/vfVvg3J1BT95YUvEt+kDq+RUWDxvC
   8B+dLcTXeh+tiaZivP0XO9vbtebl3fJJtcEnKQ5bWRamwqceZS6hUaRaU
   djTBQMOYZdmaOK7Rz5AaJDxHZViaLb4GwJIyibkO1fYiQclrcbWR1BafO
   j60a0B+fpiHx6GeQMWu6d2S3ekCqZl6bBVCVewnvtD+rbGPQHbBIy8MvL
   w==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="317105231"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 19:59:57 +0800
IronPort-SDR: R4gBCHVpeMcs2ZY929ezkhptdqEntcF4yVK2zt2Tb7MSZ5TzAcRVFsMTkIlc6uqPPst8z0XmJz
 FBhsZxDXfwedh+IehUk6bhZzfvvoyG0a2T1Hoal4oR4FrrYSUCiL8I8AkcIWjclORfFA5dHBS9
 /Q1CuSeY3S08yqcGJfXEDseByq0xLjAhdgygvrDaPHYyM9L/EaZwif/dZunwqe3V4GiGSfbcHa
 IXl5D+7xhAYvHnT7k1VmF2f6OEpwneqzrMv5b5TX1Z1XUd3XqmypXv4uUfbcW82EydKYfbdpoS
 LzTbr20H5jDBPD21VXaV+QeF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 04:17:11 -0700
IronPort-SDR: 8iMGXcC1Oigf1LfsrOdi8ZNGwS1tEW1leKuP18zDB3uLquRjP69+LeeHfXRazCSSIsYnCuf3J4
 xDSeLasGYac9q2/Iu+h9XE52muF0Buvw7hL6H3yx+aipL2CMu1S+KoCc/CsNO5KelDW9FW13FZ
 iUxZQj+qcMo7JCC6yXy0pvyLjnNZ2tosRxh4ALFiP47kzzCbWr8VsCyKjqom8mkiF/uChr4SQD
 K+FZgNwf/lRQEuC4vhblLzxLnSFu8DSQsibGo3yKeqUt4kfa/ruLJ4mPVy4V7gefGBEPFiq4yz
 330=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 04:59:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LdJ4r6nC7z1Rwnl
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 04:59:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657108796; x=1659700797; bh=S2dmgFWYC+DLGT+2UImPSe0KHi+Xt6J1e3z
        a4GRwE7w=; b=avHgtOoHfjG2jZbK/Ao6W/WEgzDeTcABzDscIyeIu1p+yuqVxUA
        lJw8q+ItgcV6S/fQQD7aYlkqS242FQGlSRu8GD/YNdTXno/fccZN40gWFPal71Dx
        H54S7gz+49t8UFuxiiRFuqcuOJpa4Ae79aiiv6Td3g2wu4XazfLEzKx/+yBr2Twu
        10oAdTgJTPSsFHwff4ZYe2z8PbQJoDdu/bjHOU5vk6FzYayBQqy6rFKTSHLwXIdV
        zUhDbYe608WcO3MTSHNtOBJQ7lTDXX/DhbvkWzvCnfGWe/4aFwXnB7MAyRiC3TU9
        zmzfluzOggYYn1il0WKL4anelfrTwfCchvw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TH1dNCtTQxjT for <linux-block@vger.kernel.org>;
        Wed,  6 Jul 2022 04:59:56 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LdJ4q5LQPz1RtVk;
        Wed,  6 Jul 2022 04:59:55 -0700 (PDT)
Message-ID: <07305397-4756-52b3-eda9-a572b5cdb3c4@opensource.wdc.com>
Date:   Wed, 6 Jul 2022 20:59:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/16] nvmet:: use bdev based helpers in
 nvmet_bdev_zone_mgmt_emulate_all
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220706070350.1703384-1-hch@lst.de>
 <20220706070350.1703384-14-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220706070350.1703384-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/22 16:03, Christoph Hellwig wrote:
> Use the bdev based helpers instead of the queue based ones to clean up
> the code a bit and prepare for storing all zone related fields in
> struct gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/nvme/target/zns.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c4c99b832daf2..9d8717126ab31 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -413,7 +413,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
>  		ret = 0;
>  	}
>  
> -	while (sector < get_capacity(bdev->bd_disk)) {
> +	while (sector < bdev_nr_sectors(bdev)) {
>  		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
>  			bio = blk_next_bio(bio, bdev, 0,
>  				zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC,
> @@ -422,7 +422,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
>  			/* This may take a while, so be nice to others */
>  			cond_resched();
>  		}
> -		sector += blk_queue_zone_sectors(q);
> +		sector += bdev_zone_sectors(bdev);
>  	}
>  
>  	if (bio) {


-- 
Damien Le Moal
Western Digital Research
