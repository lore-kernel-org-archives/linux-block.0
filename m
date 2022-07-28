Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E240DC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 03:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiG1DUr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 23:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiG1DUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8D54671
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978433; x=1690514433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hgHCcX+r6a1k41oBN3+yo/cGQgZRJNC14DbPvta/5ZU=;
  b=dahKuDaPnUjPWfo/RwN3fqtxzx2VIm8X8IzQFY/B+CJDS1QijQnXKADQ
   tzZmT5DslHCFYQ6Vf74ywR08FavLwts/GrBCWmGbCPDhTViX79G4Pz8KN
   OhEudwRfZuvfW8Ze1oEcVlIiM5ROEZzUKZH7NuybwWGUyVMh1pPMvTTX0
   DVBcSFXQyAn/vOkOl4YjCpE71Dzq+lsSRyFwD60YN3nuXveH19upI969q
   CgPA1kl79zRXNpxA7V9rhvZC6DR28uKuPt3+kocz5YLKIY/fF9Tn9sx+4
   ub7zT7vH7IYmv9XfZ7cJfuhFd7k75tb9MjMpkxmuUV2fTIvnsONqok81F
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="207109474"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:20:32 +0800
IronPort-SDR: QEeOu6P0bvVLyY8yC11heK3NDC1IkKKJ3dfm/gSzXxdKDgLRqW9rwD85ZfRcLygYLRC6bStUw9
 pLD+ur845axvPVpYjK8BDiMFDg7EuGCbu5bIVXoAll8eglOvfpH12L5+IzgPw4WKrIi9Q6Aqcx
 i+1ZBiHCkYp62jnZgE3CDjvltZup3FqJMwtgb8YN2Sj1owF2ifGWo8VF/OCFucNxVPIZkYs60r
 UacGZXRtdI+j5j16yDj1qUYq+pHdYRix+7/SkxSdVHqNl6yhBw9jo7KRN3ploDvQoaclYh1Y+P
 BAW6MpCPDVxwi29FQGB/Ub+m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:41:44 -0700
IronPort-SDR: p2Mj8j5+TtMRoW2WiaNtldbFE12zAMpl7+8U2t5gGawO2PEd0rBvlbAJXrpqrUhyOBU+dUD93o
 UoRz8Skl1+Oindm5W9Es1ic1y/hIOX6ziZe8A97RTLTkG2q6Vz3OEPX/yFRzTkzqNN3mC/5cz3
 kgpAl0syYFTFKFLMu+vJcV40nSltyteuQnqMDA1iJa+J6Z1/h+OhUDFRqI4rnQ84bB1mJIRwX4
 f8ycnUxc8FT0HWS5RHiaitupPYOEYfv3JdbUYK60Eo4bsxSPXQq6fhWugiJ0yTBRPFJmJkswN2
 0cw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:20:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbWP52mRz1Rwnx
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 20:20:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978432; x=1661570433; bh=hgHCcX+r6a1k41oBN3+yo/cGQgZRJNC14Db
        Pvta/5ZU=; b=NKStJLOIOnUZKambVwNOSsQrcKFb7GHwVZOLxOjRjCMmL1Yx+9L
        LQ0ITW6boOQntA60H4ee2oW3m4m3speBRffYVVM5NTXAydmLZtkVExzFd6bvlzEd
        He/vsJaY6a9NKqUMpY/9kW6JffapuGVk+NicNR4ALQUfQ8HZJNFzt46URym/5KCG
        u91hHGZ1llYcCsI2cHxw2xWYetBKu4uVUQw2xqW4+0uYAD1S0EK3BoIR6xXl0fcK
        nm+ppd75mFR9x1kvy6pZiZNRYM6cJqkb8frFWy3ip0Foe85MNkJhqKYkDZP+cz+7
        Hh59MC/ED6mwR+u9hB/zaYG6zUOd7q+tExA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z3Ofz-2PE_v6 for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 20:20:32 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbWK6WzGz1RtVk;
        Wed, 27 Jul 2022 20:20:29 -0700 (PDT)
Message-ID: <63350fdc-9cc8-3034-c8d6-8dcff50780f4@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:20:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 08/11] dm-zone: use generic helpers to calculate offset
 from zone start
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
 <CGME20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd@eucas1p1.samsung.com>
 <20220727162245.209794-9-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zone.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3dafc0e8b7a9..31c16aafdbfc 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -390,7 +390,9 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  		/* Writes must be aligned to the zone write pointer */
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if ((bdev_offset_from_zone_start(md->disk->part0,
> +						 clone->bi_iter.bi_sector)) != zwp_offset)
> +
>  			return false;
>  		break;
>  	case REQ_OP_ZONE_APPEND:
> @@ -602,11 +604,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
>  		 */
>  		if (clone->bi_status == BLK_STS_OK &&
>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
> -			sector_t mask =
> -				(sector_t)bdev_zone_sectors(disk->part0) - 1;
> -
>  			orig_bio->bi_iter.bi_sector +=
> -				clone->bi_iter.bi_sector & mask;
> +				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
>  		}
>  
>  		return;


-- 
Damien Le Moal
Western Digital Research
