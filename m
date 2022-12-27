Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6AAC4332F
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 02:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiL0CNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Dec 2022 21:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0CNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Dec 2022 21:13:36 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D1626E9
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 18:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672107215; x=1703643215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cVu7fj24W4BJwZ7vTxNXG9bkiimtTOquutzOZ81T+Pw=;
  b=FSckOd5vfZKgeIAin3z6j5wvBxJCLn+p44oXgH/M/3vfeYSPSJglHlZ1
   5aQT1vuRTyVYHrv1iGLSdybCCvRx4kIOnPxumeiC8CVxOKbyjPM0hPtNn
   cmcZsSdMqqRGaX/PecnGizjVS4KZ00u3wWMM3ZP2sNxsx9nKd/dzIX7rM
   yBZRvrh/YUcXPRTaFH06Vgum6Wn/aFMAmcQcmn5rYdqlTyCUKAATDnf4S
   rdVXshdA1MfkKnF+XJw9b7fP3/57PPXRfDCzA23pk0qkI30vJYjWicO0v
   RbZz7tnwgWX5ZiB7gX4yP9MCssul1IrZRPGQdDoLCIiaJMktQ7QGEmPFZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,277,1665417600"; 
   d="scan'208";a="224610824"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2022 10:13:34 +0800
IronPort-SDR: jskmGK0JMPXh+J+KcvldYvUBnEkS28m8iBwuX74X6uoiEdRVjEQk7NlZMOTAP6oZ9nQk2QUmLP
 Vc0P4Nsylc6KYZI9G1qY1andqC8BuCU7a+TUUiav3mJs1m7svepQVZzAOQyCP6wazcN93GpmDl
 COQ51DTSpwnISqZqpe62trH9UVSGvHmjGbLF0Xmz88iew5UnV8QYVMJ02OIbAZTzBeMlljdt5i
 RmjF54UbDRJWAC+AwAxdhJ2uf0cuMRNav1j/dQVtihMWxK0mVXmCsPf6h/8af7/RkkywI1u1Ks
 6Go=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Dec 2022 17:25:57 -0800
IronPort-SDR: UTjSFVsaNvioHhhcitZrXADJpG4vR/CanpRz7Dx8KgORJqWWMYvHIvo2qoWsTkq26M0/J1IYtv
 80+nsxJ3HW1a3F+JRzNtoC2nN7Tf7/vOISrGGOVIlL9e2PjFdoRtrjHoLgM5DjLYUP2cPY78Ek
 98K4efJ+6kA2V0IC4f7K6t8VCE8xw7N8Ar4f8vOcZC9K5uhzOKpf8yv41gQkOJKy4nFIP1Y/wj
 wOTd5r9kro61z79kBD/zBNHYqDG7mQ2UVECXc5viEfvi08XoEJLW266ifsPIYgXW2VqNKWiYs2
 +o4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Dec 2022 18:13:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ngyqy11Zpz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 18:13:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672107213; x=1674699214; bh=cVu7fj24W4BJwZ7vTxNXG9bkiimtTOquutz
        OZ81T+Pw=; b=jlFWfis/SqKacy9nru/nlRwohpXG9hHV6Bzh7jubSlByLnzkngJ
        1MqFA8j+BbmJFDxKXum2a6zyp9uDaIVCkADk2Fb8i1YEG26j1NNleqrSlXTf/He7
        Kc63wszBMdstalUwEe7qzervsJFz1CYqzErnm7T8HhgvlN34WLHbzo+n+rdjm0Dm
        1uEAptqbs+9m+4+ZHrZzlo8jXOSNmLZIFo3r7vTtpaJ8mZJI27FXcof0ZbI/blF6
        m/wOM4ACwIrUn48CTuMi/JVDEp2+LAa+cFVQdGvVy33jQ28cVPCUSXwPta8jNCeT
        I40OlGRAgkaps4g92fVjo8Dl6ZdEwTAx92Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id khLztKE4jqov for <linux-block@vger.kernel.org>;
        Mon, 26 Dec 2022 18:13:33 -0800 (PST)
Received: from [10.225.163.117] (unknown [10.225.163.117])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ngyqw25nGz1RvLy;
        Mon, 26 Dec 2022 18:13:32 -0800 (PST)
Message-ID: <e0af2057-df79-c0e9-e4cb-36a9552049dd@opensource.wdc.com>
Date:   Tue, 27 Dec 2022 11:13:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: save user max_sectors limit
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>
References: <20221222175204.1782061-1-kbusch@meta.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221222175204.1782061-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/22 02:52, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The user can set the max_sectors limit to any valid value via sysfs
> /sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
> are ever rescanned, though, the limit reverts back to the kernel defined
> BLK_DEF_MAX_SECTORS limit.
> 
> Preserve the user's setting for the max_sectors limit as long as it's
> valid. The user can reset back to defaults by writing 0 to the sysfs
> file.

Updating Documentation/ABI/stable/sysfs-block about this change would be
nice too.

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-settings.c   |  9 +++++++--
>  block/blk-sysfs.c      | 10 +++++++++-
>  include/linux/blkdev.h |  1 +
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0477c4d527fee..e75304f853bd5 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -40,7 +40,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->virt_boundary_mask = 0;
>  	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
>  	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> -	lim->max_dev_sectors = 0;
> +	lim->max_user_sectors = lim->max_dev_sectors = 0;
>  	lim->chunk_sectors = 0;
>  	lim->max_write_zeroes_sectors = 0;
>  	lim->max_zone_append_sectors = 0;
> @@ -135,7 +135,12 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  	limits->max_hw_sectors = max_hw_sectors;
>  
>  	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
> -	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
> +
> +	if (limits->max_user_sectors)
> +		max_sectors = min_not_zero(max_sectors, limits->max_user_sectors);
> +	else
> +		max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
> +
>  	max_sectors = round_down(max_sectors,
>  				 limits->logical_block_size >> SECTOR_SHIFT);
>  	limits->max_sectors = max_sectors;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 93d9e9c9a6ea8..db5d1d908f5d9 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -250,8 +250,16 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
>  	max_hw_sectors_kb = min_not_zero(max_hw_sectors_kb, (unsigned long)
>  					 q->limits.max_dev_sectors >> 1);
>  
> -	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
> +	if (max_sectors_kb == 0) {
> +		q->limits.max_user_sectors = 0;
> +		max_sectors_kb = min_t(unsigned int, max_hw_sectors_kb,
> +				       BLK_DEF_MAX_SECTORS >> 1);
> +	} else if (max_sectors_kb > max_hw_sectors_kb ||
> +		   max_sectors_kb < page_kb)  {
>  		return -EINVAL;
> +	} else {
> +		q->limits.max_user_sectors = max_sectors_kb << 1;
> +	}
>  
>  	spin_lock_irq(&q->queue_lock);
>  	q->limits.max_sectors = max_sectors_kb << 1;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 301cf1cf4f2fa..71e97f0a87264 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -288,6 +288,7 @@ struct queue_limits {
>  	unsigned int		max_dev_sectors;
>  	unsigned int		chunk_sectors;
>  	unsigned int		max_sectors;
> +	unsigned int		max_user_sectors;
>  	unsigned int		max_segment_size;
>  	unsigned int		physical_block_size;
>  	unsigned int		logical_block_size;

-- 
Damien Le Moal
Western Digital Research

