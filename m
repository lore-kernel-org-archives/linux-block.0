Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67049C433EF
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 23:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiEYXN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 19:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbiEYXN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 19:13:57 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83712A76C9
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653520435; x=1685056435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eam838EaJRwK9zb6IDgNxPhRl2ur9Z3r3Bih8oVIUd8=;
  b=VrYsnHH7gzSBSEl8xePPy3ZHrLyZzic8zK4Gzo+GQ1PCtrLmKTjrhqdr
   CedFXnya0gt7V5oUkoAcTsGX1wbJPDyepImwTisuq13Vg9JX/ceYnQnGH
   hADP9snWk1XhHmWm+IazNAX92qNVwnZRqIgr9DHPMS5W6kaQTSWW2XVfC
   1hCpV3unRGfXVagjBPGdaMS3JR1otM/fsGRuBLKwWSf2X2l/ch98nA0dR
   EW1OSv+pgp97SY1BplbF69bLsqaofp5Q6WNro/9ofOa3VVU22l7gPVqr+
   VJbkYXwPsHlf/6GP5LIS/6zqc5oU6JGyYmOw06EuZQDqNxgk/TvJp4Cpv
   w==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="305680425"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 07:13:54 +0800
IronPort-SDR: 7YVe6B4EqZH1xIN6PZ8/zxZW/f0iV5kj7sftX4IxlzLUVnNcZEQPbZE6VLeyT15cUarUPV6yLy
 3pGOOzpy/nTMwPIwLH9tTDyJjBi7Oh8uzncMQDJiqbtHqsL6XjHL7/deW9rWfZB2wSovibmNtW
 9TsVZKIkvT/bBb4Uc4soHXN7QInsxBzeVCd5CW98UZQTuh3Kb6Bh9mw4xky4y5AoqfwW2PpUlG
 wjMAMYPCAro43VsFfQm51Lt2YmdJWNZZsk+qj/JsiRDRaRvRxaK3X+ZDqID2Z/jzEFMkftxnVV
 c8El+RlxeqHmxs5dl3mKQAyY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 15:33:25 -0700
IronPort-SDR: LMkJG5huPNGeXeX/OAtow8Y96v1pXER9+gY6P5Pm9OyMYqPoNFn0CA2k232Xp3AX5XLX088ypD
 01uiruxr+uv89lt1KpdTQDuTuJV9wKP5s+2BEKL9uSxjaAs5TxqmjsyBgw0Xgn2aG0NpKeOhOw
 8LiSimToFnfshJ45gz5M8RR9pzkbrrp8eerKJUJlZ4K40aRMh3QLFn3KJ08A9vs+LlAbIGGjvn
 3JfoNVgI0gfDlZUt+ZUiVosE5abaPK83Ms/NtyafW5e6BLyJy5yJHdvuJgyYHkxYxjIjPW+sOs
 jpY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 16:13:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7n1t1g7Hz1SVp6
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 16:13:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653520433; x=1656112434; bh=eam838EaJRwK9zb6IDgNxPhRl2ur9Z3r3Bi
        h8oVIUd8=; b=MH3qrczSSEt7xHyvThV5z8FeiBgRXDKry4Drw1TqJl3BSqFG+Zx
        P3ngOqNGwroS4Du2LnDA4L8o4amixasMJVutO8QpAUjXIM/4x9Ocltnh/9EmK7Fb
        8/0eeirBarsL7a7fDgu/SnOk2YgG57P3/7jKxAghclbupCMh6CXjGa8w8T3qtnLQ
        L5rSs0pkk4yLIH/N/O4nv9Ornln0aQeISTYiFTDyocO5u6+MVk2poxtSiyMNMlov
        n9ZXVtGjtIMkAAy7ybgnGLHnWLT2k6oJT8wqlY68XA6O18AnDV4UBuQSwR1TPCCP
        f794kjEXcUXAuoSWcPqm41miavrLzgB1XdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NnHM1Ny8rZ54 for <linux-block@vger.kernel.org>;
        Wed, 25 May 2022 16:13:53 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7n1p4sHZz1Rvlc;
        Wed, 25 May 2022 16:13:50 -0700 (PDT)
Message-ID: <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
Date:   Thu, 26 May 2022 08:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com
References: <20220525154957.393656-1-p.raghav@samsung.com>
 <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
 <20220525154957.393656-9-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220525154957.393656-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/22 00:49, Pankaj Raghav wrote:
> Ensure that only power of 2 zoned devices are enabled for dm targets that
> supports zoned devices. This constraint can be relaxed once non power of
> 2 zone size support is added to the DM layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-table.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 03541cfc2317..2a8af70d1d4a 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> +		if (!is_power_of_2(zone_sectors)) {
> +			DMWARN("%s: %pg only power of two zone size supported",
> +			       dm_device_name(ti->table->md), bdev);
> +			return 1;
> +		}
> +
>  		if (start & (zone_sectors - 1)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),

I thought the agreed upon idea is be to add a dm-linear like target to
emulate power of 2 zone size so that we can keep btrfs and f2fs running on
this new class of device. So why this patch ?

The entire series as is will fragment zoned block device support, which is
not a good thing at all. Without the new dm target, none of the current
kernel supported zone stuff will work.

The zonefs patch is also gone from the series. Why ? As is, zonefs will
break if it is passed a non power of 2 zone size drive.

-- 
Damien Le Moal
Western Digital Research
