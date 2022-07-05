Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6288FC43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiGECmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiGECmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:42:01 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F212777
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988920; x=1688524920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eLFQwSzFJECaf6OosUXPb3bAWqxxfdqOwKldJTt0WWA=;
  b=d4eYkbx1CnfHBlgK8dEec2LQZNdTMyJuLT3ufINdvkyWXznWvkzxribN
   CU51Lc4COFZ2vTp97ROdqJMJNDVhqvdYaGp0CnHBdVv3uXE1iyHSCZHq6
   RhRMmE4gSKWqB0BgexqzYtrnQkPJnoRZIqUH4/kNbzr6wo4Pii3i2H4ge
   AfAmjx6+P4uzm5C+CMBL/iNDcq5rq2oyxuKqwRUDmWZY85jtoTCSx9Sim
   oVXcevB92ExhUDUw+8R2rDKWPEC1FeDgPrsY+P1cyv+6oE4jvHSxqHuNr
   Ta1EqJFVu2gd8KZ7WhN62NVXEejtc7wwcdywEx/hxEVCq/mwa3NsiOk7G
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="309130061"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:41:58 +0800
IronPort-SDR: KGpS7VRJCZlIHvKvq8Yte9wAosGSX0LPaxn1gDB39modTQ6/lRTjfnTs+W5M6W4Ov7VqYYZ4Vm
 bBhz37HIvEcnIh/G5KDun6MJvWr4DAC2r2+Qsbh6R3tADvf/1hFbsLM9IEvyKyV2FwCvHtBS3e
 E8tGTVdb8In1Mcpo+AQkh9AQOkuzA7OT3KXi8TlzfjliS8S2LRQFM1Mv7GlDRVke4lsKzR3yz+
 S6G96FrWENuoEFDCiuLu8UWb/iN7WAdVp5QDoCQcWNsKiodcwHgVuARMTsDAz0utEmV2CGNopx
 XDJ2+aWPfEgEImnnYoh3XLH+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:03:49 -0700
IronPort-SDR: s4qe6FOMFnvGvFEonO5FGEUrnBfINZjwAE69uKicA76NR0Xm81EgXnbgd601OHOtbquA+yo7pB
 gYODhQciEGY9m2fduRAW1ErdWkYdCPpFDkWhsjOsrBWBayWR2D8g12G+gfD4Xd6LeVOkCp22GZ
 CPIu5Wfk0R20lfiOEa1YT9G0I9BQVdTB//My4835rU+cmzj1DVDH9bWFp4iUkquSt89DiV8Oah
 J03ufF7Wv7efbeHQ6MFAu5kiVsFFn+4i07QHv1kOPpn8W5XPab0kyBR3+VuhLtvQ1cprN0kTGx
 l2c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:41:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRlV0bkFz1Rwnl
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:41:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656988917; x=1659580918; bh=eLFQwSzFJECaf6OosUXPb3bAWqxxfdqOwKl
        dJTt0WWA=; b=LxNrLO6ZbhFAEyfNq/L4fgqsvZQ2q8/DaqYFxH1c3UdTOPTE1r5
        7l/q3VK5nUDxITXFtViV5NQBYZ37l6jLhNJiEokGXl9mH/iQ6YtBEcrPYx1GKuCx
        huC8gnq5XN9+Qbjxix/p6z7sl5bD2f6NyMovHjXKZkHhA9IF37hNwGl4oLgxMgko
        cENFGIVP2uLj7rt1UtxGAJa+/ey8TEnbEUXLHMi/3RZvTSHPxUuu8luydePeF+Ga
        5PiVtNhx8ZweXEoOvw1fkTwnPOguw488PeZdw2302XHTcJETVehzzN18n9/D8gUt
        GC5xZaBbhqWaTWyWdI3I99yYZLTLcpqeB+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r_8uJdtSanA9 for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:41:57 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRlS47xBz1RtVk;
        Mon,  4 Jul 2022 19:41:56 -0700 (PDT)
Message-ID: <fe0c09f3-0c0c-0527-88aa-21e13d91a23c@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:41:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/17] block: pass a gendisk to
 blk_queue_clear_zone_settings
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-10-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Switch to a gendisk based API in preparation for moving all zone related
> fields from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-settings.c | 2 +-
>  block/blk-zoned.c    | 4 +++-
>  block/blk.h          | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 35b7bba306a83..8bb9eef5310eb 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -946,7 +946,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		blk_queue_zone_write_granularity(q,
>  						queue_logical_block_size(q));
>  	} else {
> -		blk_queue_clear_zone_settings(q);
> +		disk_clear_zone_settings(disk);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(disk_set_zoned);
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 7fbe395fa51fc..5a97b48102221 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -622,8 +622,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>  }
>  EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
>  
> -void blk_queue_clear_zone_settings(struct request_queue *q)
> +void disk_clear_zone_settings(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	blk_mq_freeze_queue(q);
>  
>  	blk_queue_free_zone_bitmaps(q);
> diff --git a/block/blk.h b/block/blk.h
> index 58ad50cacd2d5..7482a3a441dd9 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -406,10 +406,10 @@ static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  void blk_queue_free_zone_bitmaps(struct request_queue *q);
> -void blk_queue_clear_zone_settings(struct request_queue *q);
> +void disk_clear_zone_settings(struct gendisk *disk);
>  #else
>  static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
> -static inline void blk_queue_clear_zone_settings(struct request_queue *q) {}
> +static inline void disk_clear_zone_settings(struct gendisk *disk) {}
>  #endif
>  
>  int blk_alloc_ext_minor(void);


-- 
Damien Le Moal
Western Digital Research
