Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42276C77B72
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjDTJZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjDTJYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 05:24:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D055AF
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 02:24:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so1992365e87.0
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 02:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681982665; x=1684574665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cufFZMShQIGv7Tp6KtzJ3aFKk01AjlpruMksMwAdX8=;
        b=eO6k38rQ3r87lKie72GTuQGtAoD6IMDbMsTDcGNi2LUpKW1EHM3O4uT5tIitBIb5OZ
         pS9Nik3WazATx9u+KXyb7ZMMJbuO19xOZ8UZ0xMp1DKnqPR6cKcfUkjngbr2y/6WqAdO
         405r8YYIVFjJYDh1mUyB3tunQRX4NipvOxv8BS8i6I2086Parvq+JwQin7x3pwjqCKhV
         ISvxby90gBfz1fcPqUX4tCKTXzh4jcOhgKrJpdC4iElXIxs5UiQOK4iCt+MIrZJkNSGh
         MLPPPbXA0M8mTOOJoOm2Ht2RXQ5CPZQOWNeWHhwhtj1JR+S6rr4anH9v7Gq/WB1IcLWG
         7Ffg==
X-Gm-Message-State: AAQBX9ehQtUcH1M3jB3b/2EbW++/D9hI/egJFxY+uclbv5jcOzSHEA3r
        5lGvdhOP/VKamJxWQp1NSf9EW0oSxdUEtQ==
X-Google-Smtp-Source: AKy350b+q9JavswOfioGNMjpO6qd6aiy58dQmqQl2F2wFMXH45hsrXg11womj/3bCLBXCh/nYYxg/Q==
X-Received: by 2002:a05:6512:96b:b0:4ed:d629:8d34 with SMTP id v11-20020a056512096b00b004edd6298d34mr341149lft.5.1681982665063;
        Thu, 20 Apr 2023 02:24:25 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.246.252])
        by smtp.gmail.com with ESMTPSA id j21-20020ac24555000000b004dc4c5149dasm151363lfm.301.2023.04.20.02.24.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:24:24 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 132A7425; Thu, 20 Apr 2023 11:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1681982664; bh=p3GEyJI5wMAJYPo02UWwZbly8zOIOBhynK6jW4ibyZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xxtx7igzUJFu6YCzZ93BeAYp+aKneqO51czfl9ChbdNuz7D+sOlVfQtEzxT52I5Q6
         SmCAKSlFNz4DZrZlouYWHmh7L5FuK6rVByIITYYHHdUZGz11eCFSj0EAW0EpCaVsWC
         hfoQD2XaLnEVA75iga6q29/PIOllT+SCZPJyeqXI=
Received: from x1-carbon (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 5E3E33B3;
        Thu, 20 Apr 2023 11:23:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1681982630; bh=p3GEyJI5wMAJYPo02UWwZbly8zOIOBhynK6jW4ibyZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4ic5HB2sR5AVxxUhPVuneKmOqdl9v08+TD6Mq7mAwDM8P4nS1f/7V4cs1JPT4erx
         vi5wt5t85Ml5mfuM+FRiE0WJE5otqLrgRoCuQHr2Xf5Z8Rbnbh4c2G7g8jeUKnGz0S
         di+Q3/uBmGd3L9FiPXI6VH0NCXqWAxL7hQcx8V2k=
Date:   Thu, 20 Apr 2023 11:23:39 +0200
From:   Niklas Cassel <nks@flawful.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Message-ID: <ZEEEm/5+i7x2i8a5@x1-carbon>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-11-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:40:01PM -0700, Bart Van Assche wrote:
> Make the zone capacity available in struct queue_limits for those
> drivers that need it.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  Documentation/ABI/stable/sysfs-block |  8 ++++++++
>  block/blk-settings.c                 |  1 +
>  block/blk-sysfs.c                    |  7 +++++++
>  block/blk-zoned.c                    | 15 +++++++++++++++
>  include/linux/blkdev.h               |  1 +
>  5 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index c57e5b7cb532..4527d0514fdb 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -671,6 +671,14 @@ Description:
>  		regular block devices.
>  
>  
> +What:		/sys/block/<disk>/queue/zone_capacity
> +Date:		March 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] The number of 512-byte sectors in a zone that can be read
> +		or written. This number is less than or equal to the zone size.
> +
> +
>  What:		/sys/block/<disk>/queue/zone_write_granularity
>  Date:		January 2021
>  Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..96f5dc63a815 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -685,6 +685,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  						   b->max_secure_erase_sectors);
>  	t->zone_write_granularity = max(t->zone_write_granularity,
>  					b->zone_write_granularity);
> +	t->zone_capacity = max(t->zone_capacity, b->zone_capacity);
>  	t->zoned = max(t->zoned, b->zoned);
>  	return ret;
>  }

(snip)

> @@ -496,12 +498,23 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  				disk->disk_name);
>  			return -ENODEV;
>  		}
> +		if (zone->capacity != args->zone_capacity) {
> +			pr_warn("%s: Invalid zoned device with non constant zone capacity\n",
> +				disk->disk_name);
> +			return -ENODEV;

Hello Bart,

The NVMe Zoned Namespace Command Set Specification:
https://nvmexpress.org/wp-content/uploads/NVM-Express-Zoned-Namespace-Command-Set-Specification-1.1c-2022.10.03-Ratified.pdf

specifies the Zone Capacity (ZCAP) field in each Zone Descriptor.
The Descriptors are part of the Report Zones Data Structure.

This means that while the zone size is the same for all zones,
the zone capacity can be different for each zone.

While the single NVMe ZNS SSD that I've encountered so far did
coincidentally have the same zone capacity for all zones, this
is not required by the specification.

The NVMe driver does reject a ZNS device that has support for
Variable Zone Capacity (which is defined in the ZOC field):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/zns.c?h=v6.3-rc7#n95

Variable Zone Capacity simply means the the zone capacities
cannot change without a NVM format.

However, even when Variable Zone Capacity is not supported,
a NVMe ZNS device can still have different zone capacities,
and AFAICT, such devices are currently supported.

With your change above, we would start rejecting such devices.


Is this reduction of supported NVMe ZNS SSD devices really desired?

If it is, then I would at least expect to find a motivation of why we
are reducing the scope of the currently supported NVMe ZNS devices
to be found somewhere in the commit message.


Kind regards,
Niklas
