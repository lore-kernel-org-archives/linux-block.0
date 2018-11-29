Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3BCC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D2E21019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D2E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeK3B7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:59:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35310 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbeK3B7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 20:59:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so2217348wrb.2
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 06:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JcusGTX8MaRQjNbNVlDqHPVwi9rWrFdLly+MExya1c=;
        b=P629A8Pmd+5s/bUc0gt4CcL/h0hia/cW0TxuG2j6RtbC2PW+6Q3CXhglCqyV0XU3GV
         VCsRix7CKYagkf4N1U7dhBslWDtwWwr1qgrJJUn7mkgZYAUiESIzjtgoWGD2zeQ/NAH2
         T3C/ABwlx3EQ9OP6h0Z8pdXPTKuInl/f3NJm3tn/C45f2cP3G+gqsR/cd2eS0/7hEu/Z
         NG7mqH7R3o7RcRtRInaCErAjGrAMpK5Pkgmgc7H8FPMg/gp4J1DwS7DX5akV+cmGpRTH
         zNB4s3wjlmwBwDjlZeKBcv+KWPWe+1P2w6QOtbLsX8xtuvYyxcRIl2P+UOJEXzlEPWs/
         Z5UA==
X-Gm-Message-State: AA+aEWZudwrmi9geK8RZV2vkeCQbsFmzjxrLNOdKh91qNxaOdNwBuQuh
        UifbOU14maOr9IbzdmN943VtAdOKCuycDz0g+clw46wd
X-Google-Smtp-Source: AFSGD/UoKVxj1AgmcPhlmJ/mdS8htYYa1jNUQ45XR+oV8XoUU/ynu0rc8pcFEo7BEsDVBQiiwIGAq8nmqGHgghbU/DY=
X-Received: by 2002:adf:83a7:: with SMTP id 36mr1724068wre.13.1543503238222;
 Thu, 29 Nov 2018 06:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20181128012552.20568-1-damien.lemoal@wdc.com>
In-Reply-To: <20181128012552.20568-1-damien.lemoal@wdc.com>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Thu, 29 Nov 2018 09:53:45 -0500
Message-ID: <CAHhmqcTR1TTdA3YL6X6VSWXWi4T2zBqNk1obYObjj4ncsgrdRw@mail.gmail.com>
Subject: Re: [PATCH] block: update documentation
To:     damien.lemoal@wdc.com
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 8:25 PM Damien Le Moal <damien.lemoal@wdc.com> wrote:
>
> Add the description of the zoned, nr_zones and chunk_sectors sysfs queue
> attributes to Documentation/block/queue-sysfs.txt. The description of
> the zoned and chunk_sector attributes are mostly copied from
> ABI/testing/sysfs-block. While at it, also fix a typo in the description
> of the io_poll_delay attribute.
>
> nr_zones description is also added to ABI/testing/sysfs-block and
> contyact email address updated for the zoned attribute.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/ABI/testing/sysfs-block | 10 ++++++++-
>  Documentation/block/queue-sysfs.txt   | 29 ++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> index dea212db9df3..3789b32759dd 100644
> --- a/Documentation/ABI/testing/sysfs-block
> +++ b/Documentation/ABI/testing/sysfs-block
> @@ -244,7 +244,7 @@ Description:
>
>  What:          /sys/block/<disk>/queue/zoned
>  Date:          September 2016
> -Contact:       Damien Le Moal <damien.lemoal@hgst.com>
> +Contact:       Damien Le Moal <damien.lemoal@wdc.com>
>  Description:
>                 zoned indicates if the device is a zoned block device
>                 and the zone model of the device if it is indeed zoned.
> @@ -259,6 +259,14 @@ Description:
>                 zone commands, they will be treated as regular block
>                 devices and zoned will report "none".
>
> +What:          /sys/block/<disk>/queue/nr_zones
> +Date:          November 2018
> +Contact:       Damien Le Moal <damien.lemoal@wdc.com>
> +Description:
> +               nr_zones indicates the total number of zones of a zoned block
> +               device ("host-aware" or "host-managed" zone model). For regular
> +               block devices, the value is always 0.
> +
>  What:          /sys/block/<disk>/queue/chunk_sectors
>  Date:          September 2016
>  Contact:       Hannes Reinecke <hare@suse.com>
> diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
> index 2c1e67058fd3..a23952567008 100644
> --- a/Documentation/block/queue-sysfs.txt
> +++ b/Documentation/block/queue-sysfs.txt
> @@ -64,7 +64,7 @@ guess, the kernel will put the process issuing IO to sleep for an amount
>  of time, before entering a classic poll loop. This mode might be a
>  little slower than pure classic polling, but it will be more efficient.
>  If set to a value larger than 0, the kernel will put the process issuing
> -IO to sleep for this amont of microseconds before entering classic
> +IO to sleep for this amount of microseconds before entering classic
>  polling.
>
>  iostats (RW)
> @@ -194,4 +194,31 @@ blk-throttle makes decision based on the samplings. Lower time means cgroups
>  have more smooth throughput, but higher CPU overhead. This exists only when
>  CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
>
> +zoned (RO)
> +----------
> +This indicates if the device is a zoned block device and the zone model of the
> +device if it is indeed zoned. The possible values indicated by zoned are
> +"none" for regular block devices and "host-aware" or "host-managed" for zoned
> +block devices. The characteristics of host-aware and host-managed zoned block
> +devices are described in the ZBC (Zoned Block Commands) and ZAC
> +(Zoned Device ATA Command Set) standards. These standards also define the
> +"drive-managed" zone model. However, since drive-managed zoned block devices
> +do not support zone commands, they will be treated as regular block devices
> +and zoned will report "none".
> +
> +nr_zones (RO)
> +-------------
> +For zoned block devices (zoned attribute indicating "host-managed" or
> +"host-aware"), this indicates the total number of zones of the device.
> +This is always 0 for regular block devices.
> +
> +chunk_sectors (RO)
> +------------------
> +This has different meaning depending on the type of the block device.
> +For a RAID device (dm-raid), chunk_sectors indicates the size in 512B sectors
> +of the RAID volume stripe segment. For a zoned block device, either host-aware
> +or host-managed, chunk_sectors indicates the size of 512B sectors of the zones
> +of the device, with the eventual exception of the last zone of the device which
> +may be smaller.
> +

For the part that says, "...chunk_sectors indicates the size of 512B
sectors of the zones of the device", should it be this instead?

"...chunk_sectors indicates the size in 512B sectors of the zones of the device"


Thanks,

Bryan

>  Jens Axboe <jens.axboe@oracle.com>, February 2009
> --
> 2.19.1
>
