Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B49C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8818F65267
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCIL6m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCIL6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 06:58:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DCC06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 03:58:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l11so11520997wrp.7
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7swezB5PKew4k5lUlaSEz9kFZXPj/ChHqRMrfTlR88=;
        b=FB1LxMjKzgtOrB12287iL6KRCu5MHp7SBeK7s0EaEC97Ayc/i9jbTB1EHobMklmsAX
         w5td0w/yfpFpFTuRjOGPWTNpZNcOSnWAqZ1w7yu3ujaXIjEPyjz48qZlkPui65M3JxdH
         OgtgAfrZY9hWBMZY721FC55wfM5u2YkeK5o60Svimbi0P5/N468Jhxzwqn3brts5GaGZ
         A1UmFS/oD+Z9PFFoE7QdFYE/U3+C9ZbTaXA3ZjclpcV4Datbbv+DNczaKMEuX8U2MPi8
         32x++mW9MNGhaawHgCEoJvJSDEfJ3MajfUCDiWE/0as8WJU7n8xrtwB91XhBnbtBckRU
         e+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7swezB5PKew4k5lUlaSEz9kFZXPj/ChHqRMrfTlR88=;
        b=Hg+a4EmuNHCEO2W1ezw6BylKeeOt13IImwS63o8MhNRhMadkSdiVbp6iChsNWemS5F
         c83lGVXo0lt0wW/FksPkeOcCZzCFW2zEzqfb4rHVXKdFJjyM0cHfTv2Ku/KGUXlTD+ao
         tgwgpenXnrBoNCJe/Q3oH8q/ocwokWaFHaGvalFSp4rXXRa2AZxUJkzll7/KCfoXzRdO
         IlY23ZFrX5oufr/MA0Nhiph7LbbScb0UqbQZPmdzF3KwZ07sZnSTwS4Oz71v8Hwr9JvT
         r2OrHbZjFKr4rGP1XZ6OsWNRk+BXbzoI08h3kZkkEK8FiNXx9m7BXqLQkxXEXvsPxRMf
         TsSA==
X-Gm-Message-State: AOAM532pp2a5d9zpGzQMEPqPIUl32tjVjUcIbNiGB+VzIAvhm7hRXhAP
        JVIgdTXlsDsFt9RATyv+9drKBBhDB/DqbcAx/VHzxi0xtk051A==
X-Google-Smtp-Source: ABdhPJwa6cf6A/MPrzXtMu95qZx7xEvvpIl5MeCZgLR1csPvKYKg1EYhwEHtRZ18atI2ssnCclFMSad7QxiWzFgaOOk=
X-Received: by 2002:adf:c186:: with SMTP id x6mr28409624wre.253.1615291113065;
 Tue, 09 Mar 2021 03:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
 <CA+1E3rJjpeX6UVk5HZhGPzeaTo0-VNsmEaPAWkH4-EmSGD9BGg@mail.gmail.com> <BL0PR04MB65140D3B886F8076A9A2DAAEE7929@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB65140D3B886F8076A9A2DAAEE7929@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Tue, 9 Mar 2021 17:28:07 +0530
Message-ID: <CA+1E3rJOmUaa5RS_FOapPAjbXisoHN+eY6uvJoQ_XjazmRmqYg@mail.gmail.com>
Subject: Re: [PATCH] block: Discard page cache of zone reset target range
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 9, 2021 at 4:36 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2021/03/09 14:49, Kanchan Joshi wrote:
> > On Mon, Mar 8, 2021 at 2:11 PM Shin'ichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> >>
> >> When zone reset ioctl and data read race for a same zone on zoned block
> >> devices, the data read leaves stale page cache even though the zone
> >> reset ioctl zero clears all the zone data on the device. To avoid
> >> non-zero data read from the stale page cache after zone reset, discard
> >> page cache of reset target zones. In same manner as fallocate, call the
> >> function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before and
> >> after zone reset to ensure the page cache discarded.
> >>
> >> This patch can be applied back to the stable kernel version v5.10.y.
> >> Rework is needed for older stable kernels.
> >>
> >> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
> >> Cc: <stable@vger.kernel.org> # 5.10+
> >> ---
> >>  block/blk-zoned.c | 30 ++++++++++++++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> >> index 833978c02e60..990a36be2927 100644
> >> --- a/block/blk-zoned.c
> >> +++ b/block/blk-zoned.c
> >> @@ -329,6 +329,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> >>         struct request_queue *q;
> >>         struct blk_zone_range zrange;
> >>         enum req_opf op;
> >> +       sector_t capacity;
> >> +       loff_t start, end;
> >> +       int ret;
> >>
> >>         if (!argp)
> >>                 return -EINVAL;
> >> @@ -349,9 +352,22 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> >>         if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
> >>                 return -EFAULT;
> >>
> >> +       capacity = get_capacity(bdev->bd_disk);
> >> +       if (zrange.sector + zrange.nr_sectors <= zrange.sector ||
> >> +           zrange.sector + zrange.nr_sectors > capacity)
> >> +               /* Out of range */
> >> +               return -EINVAL;
> >> +
> >> +       start = zrange.sector << SECTOR_SHIFT;
> >> +       end = ((zrange.sector + zrange.nr_sectors) << SECTOR_SHIFT) - 1;
> >
> > How about doing all this calculation only when it is applicable i.e.
> > only for reset-zone case, and not for other cases (open/close/finish
> > zone).
> >
> > Also apart from "out of range" (which is covered here), there are few
> > more cases when blkdev_zone_mgmt() may fail it (not covered here).
> > Perhaps the whole pre and post truncate part can fit better inside
> > blkdev_zone_mgmt itself.
>
> No, I do not think so. That would add overhead for in-kernel users of zone reset
> for no good reason since these would typically take care of cached pages
> themselves (e.g. FS) and would not trigger page caching using the bdev inode anyway.

Agreed. In that case moving the pre-truncate processing from
common-path to under BLKRESETZONE will suffice.
With that refactoring in place, it looks good.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

-- 
Kanchan
