Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B043C433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 07:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08DF20781
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 07:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AuhH1I4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgHKHWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgHKHWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 03:22:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C95C06174A
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 00:22:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so1515246wmd.1
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=squ5z2w04U6wXgTNAA2RvgxeG0GXajibgjylLQZMRNc=;
        b=AuhH1I4hbEcG1U4dZRGn7ip9TqnATlQEcwLnDQ/gXcwhWi/3X9blqfODwg2zYeSv3H
         01yry+OqsxdBsFNmS/wlU+i9+mHkrd1nY+vioSfFSmFTb27ltYVxIH5MXrp/x27N9ofF
         oJ/gOKQpSsX/xDbiv6Tja38vS3to4BhoAuKSNF4BYmadBt8f3zikn8Z0kNrIIPCcrzek
         mZdhRumrpauZKRjyYcFyY/oJd7a/UkCCmuF75MEdcHFElrWj8QbCRJD2+yeZWsyUtD70
         MC95yBQifowEYLKVdJ5ROdsyx5uhUVSpV7jMjx6g7PzOa94U1qJ+oEezvR9TkdG0QbSu
         anaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=squ5z2w04U6wXgTNAA2RvgxeG0GXajibgjylLQZMRNc=;
        b=kRCaoU4mfW7aBZo0kibJOi75W0Yzry8hVM/AMC/HveWDKr74/JVdrLN7aTPfrR9VdX
         jsdyi9PoqpvNyzechE9vwmsI3g/Dt9jadvO51TQwWBLKQtr+GkfR3VJ/ClLf6g/uLNXJ
         DFrwBqbDN7dCcoS4pTv/X/IlWb1pZKuok31sf0YhA45GfWJrGPzJizVZoQ9BlMxaGfmf
         tgQRy3+8ynAfGgV3QFSIpgsYzm8wctqm1LMZ+Z+fUbFVb9sc5dF5XApCm9SD1/9kxAW7
         mCabfWooSlmG1bo2lI5Smg5g8tlkaq+TsEaPUF6Iuu+bUxqX47HsKX7HBrk1RzKe9QL9
         zJwQ==
X-Gm-Message-State: AOAM5302qbZF1SCBaLgFn6nivWLcaX1hcDPXDQ2ThqRgMXC00o6RnHBA
        d9LzWYk+ckvZ3OUpXCTwT1DfrnSt0NQBPFpVgJ+B
X-Google-Smtp-Source: ABdhPJwInIZjpVU3d4fN5xWrHq4lqedXAzN2eALLco2KKtBh8Wi9d7F8pVPyh/+luDU9r2p7rvAzk85Q027RXDIaXYY=
X-Received: by 2002:a7b:c845:: with SMTP id c5mr2783623wml.180.1597130540819;
 Tue, 11 Aug 2020 00:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com> <20200713211321.21123-2-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200713211321.21123-2-guoqing.jiang@cloud.ionos.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 09:22:10 +0200
Message-ID: <CAHg0Huyrn8qjQObhL7cV1SeTBF=t_LfQ+3UjKgnWPdo+XDEG2A@mail.gmail.com>
Subject: Re: [PATCH RFC V2 1/4] block: add a statistic table for io latency
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 13, 2020 at 11:13 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Usually, we get the status of block device by cat stat file,
> but we can only know the total time with that file. And we
> would like to know more accurate statistic, such as each
> latency range, which helps people to diagnose if there is
> issue about the hardware.
>
> Also a new config option is introduced to control if people
> want to know the additional statistics or not, and we use
> the option for io sector in next patch.
>
> Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  block/Kconfig             |  8 ++++++++
>  block/blk-core.c          | 34 ++++++++++++++++++++++++++++++++++
>  block/genhd.c             | 26 ++++++++++++++++++++++++++
>  include/linux/part_stat.h |  7 +++++++
>  4 files changed, 75 insertions(+)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index bbad5e8bbffe..360f63111e2d 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -176,6 +176,14 @@ config BLK_DEBUG_FS
>         Unless you are building a kernel for a tiny system, you should
>         say Y here.
>
> +config BLK_ADDITIONAL_DISKSTAT
> +       bool "Block layer additional diskstat"
> +       default n
> +       help
> +       Enabling this option adds io latency statistics for each block device.
> +
> +       If unsure, say N.
> +
>  config BLK_DEBUG_FS_ZONED
>         bool
>         default BLK_DEBUG_FS && BLK_DEV_ZONED
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..036eb04782de 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1411,6 +1411,34 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>         }
>  }
>
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +/*
> + * Either account additional stat for request if req is not NULL or account for bio.
> + */
> +static void blk_additional_latency(struct hd_struct *part, const int sgrp,
> +                                  struct request *req, unsigned long start_jiffies)
> +{
> +       unsigned int idx;
> +       unsigned long duration, now = READ_ONCE(jiffies);
> +
> +       if (req)
> +               duration = jiffies_to_nsecs(now) - req->start_time_ns;
> +       else
> +               duration = jiffies_to_nsecs(now - start_jiffies);
> +
> +       duration /= NSEC_PER_MSEC;
> +       duration /= HZ_TO_MSEC_NUM;
> +       if (likely(duration > 0)) {
> +               idx = ilog2(duration);
> +               if (idx > ADD_STAT_NUM - 1)
> +                       idx = ADD_STAT_NUM - 1;
> +       } else
> +               idx = 0;
> +       part_stat_inc(part, latency_table[idx][sgrp]);
> +
> +}
> +#endif
> +
>  static void blk_account_io_completion(struct request *req, unsigned int bytes)
>  {
>         if (req->part && blk_do_io_stat(req)) {
> @@ -1440,6 +1468,9 @@ void blk_account_io_done(struct request *req, u64 now)
>                 part = req->part;
>
>                 update_io_ticks(part, jiffies, true);
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +               blk_additional_latency(part, sgrp, req, 0);
> +#endif
>                 part_stat_inc(part, ios[sgrp]);
>                 part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>                 part_stat_unlock();
> @@ -1488,6 +1519,9 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>
>         part_stat_lock();
>         update_io_ticks(part, now, true);
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +       blk_additional_latency(part, sgrp, NULL, start_time);
> +#endif
>         part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>         part_stat_local_dec(part, in_flight[op_is_write(op)]);
>         part_stat_unlock();
> diff --git a/block/genhd.c b/block/genhd.c
> index c42a49f2f537..f5d2f110fb34 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1420,6 +1420,29 @@ static struct device_attribute dev_attr_fail_timeout =
>         __ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
>  #endif
>
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct hd_struct *p = dev_to_part(dev);
> +       size_t count = 0;
> +       int i, sgrp;
> +
> +       for (i = 0; i < ADD_STAT_NUM; i++) {
> +               count += scnprintf(buf + count, PAGE_SIZE - count, "%5d ms: ",
> +                                  (1 << i) * HZ_TO_MSEC_NUM);
> +               for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
> +                       count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
> +                                          part_stat_read(p, latency_table[i][sgrp]));
> +               count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
> +       }
> +
> +       return count;
> +}
> +
> +static struct device_attribute dev_attr_io_latency =
> +       __ATTR(io_latency, 0444, io_latency_show, NULL);
> +#endif
> +
>  static struct attribute *disk_attrs[] = {
>         &dev_attr_range.attr,
>         &dev_attr_ext_range.attr,
> @@ -1438,6 +1461,9 @@ static struct attribute *disk_attrs[] = {
>  #endif
>  #ifdef CONFIG_FAIL_IO_TIMEOUT
>         &dev_attr_fail_timeout.attr,
> +#endif
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +       &dev_attr_io_latency.attr,
>  #endif
>         NULL
>  };
> diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
> index 24125778ef3e..fe3def8c69d7 100644
> --- a/include/linux/part_stat.h
> +++ b/include/linux/part_stat.h
> @@ -9,6 +9,13 @@ struct disk_stats {
>         unsigned long sectors[NR_STAT_GROUPS];
>         unsigned long ios[NR_STAT_GROUPS];
>         unsigned long merges[NR_STAT_GROUPS];
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> +/*
> + * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
> + */
> +#define ADD_STAT_NUM   12
> +       unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
> +#endif
>         unsigned long io_ticks;
>         local_t in_flight[2];
>  };
> --
> 2.17.1
>
Hi,

This feature is very useful to analyse io performance in a cluster of
Linux machines. For example an io is generated in the block layer of a
VM, enters the block layer of the host, passes through a couple of
block devices, is then sent over a network to a number of remote
machines, enters the block layer there, crosses yet another couple of
block devices and finally gets submitted to the disks. Then
confirmations travel all the way back to the block layer of the host
and at some point bio_endio is called in the vm.

- Hey folks, a lower accumulated io latency would be nice.
- NP, where do we start?
- ...
- Ping?
