Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7000C0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 19:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjG0TCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG0TCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 15:02:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0979A19A7
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 12:02:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so1163641276.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690484553; x=1691089353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4utm2lMgAdVZjS8f1GN893gselvAWKihO7gGvfRYGI8=;
        b=rqx9ocKGdPLdxZSQYAtFjEoV8hgngKATIcoFZ+ixW+G4zNKQ4bsZsWZ2mKB0Qpk2Tm
         QwRkWkem7jfgfEwvDHN8qdqPy9qmAIcNdvQxVfnY9xp8eUKCGuUDsT7XFmv9W2GDoOZg
         Mr1vVoUsH2YlibRNJePNTR1D4b+DJcoAqjB0Yjeje6Yvh0hH+RRojmWRLAdTIPvrA9Ye
         0n6FKamQ/ustZ/D0uFytzJg+3Oa86hUf/p2zCKDIr62EmySSKfd/fG2MgzDkJ/siNg3K
         PDrqvyZfhBEZ55MbjMWucq4LqAjkE6S3zaBpOt0SAPJ9VFGrkhX83I2uQ0fZUShMdd9P
         /F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484553; x=1691089353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4utm2lMgAdVZjS8f1GN893gselvAWKihO7gGvfRYGI8=;
        b=cBMvKVCnzHUDqm6mTIJ3G2bYK6LoHPz6uTafDrNZhz/sIaGL25i1hYnTYdMJ8ywAob
         TZl/OzrnsTlC+0wJkj4ugOPbyCthj3SfstngaPWT82UR4OlrOFTCLG0vTHTEZzqG6B5Z
         vb/rG9/C7V7aPxhKxguCrTs0mOdSxZlvkp3qSW3f8rie+XNavNFL8xCNHGuGyxao7HcT
         tfgpygi/mTb84Sp9JdtwjIi3dT8X27/UFH2JH9qfwh6d6GjWbbNKDjIB16sA7z6p2Bny
         2jlOlfEGAFFMW9xniReYmaH40M7NU+Gce1e8Qnetf8CLnxX2SsPpe/wB/4lFotXCZXwp
         i37g==
X-Gm-Message-State: ABy/qLbWoXY7pozS1ordoj4sHDgOssiuy3qGLS+QB163F1/ZLn7qvRVA
        RgqMr1xiMIWHfgX/QOW0WhAy3/q9gh83/rJA6t0=
X-Google-Smtp-Source: APBJJlGbMavaFPhas3vzrXhf2hmnJKnO7AA/L9dXRISSD164XcJo1qT4q6RcpWen+5ssdcM/HrgMuCdFnuKO/1L96l0=
X-Received: by 2002:a25:d30c:0:b0:d09:544a:db1b with SMTP id
 e12-20020a25d30c000000b00d09544adb1bmr279380ybf.34.1690484553053; Thu, 27 Jul
 2023 12:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230726193440.1655149-1-bvanassche@acm.org> <20230726193440.1655149-5-bvanassche@acm.org>
In-Reply-To: <20230726193440.1655149-5-bvanassche@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Fri, 28 Jul 2023 00:32:21 +0530
Message-ID: <CAOSviJ0kzpKDfo31nrvBtXCxBhXLRyD+s3RYwiyB8QMEHv7ryg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] block/null_blk: Support disabling zone write locking
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 27, 2023 at 2:22=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> Add a new configfs attribute for disabling zone write locking. Tests
> show a performance of 250 K IOPS with no I/O scheduler, 6 K IOPS with
> mq-deadline and write locking enabled and 123 K IOPS with mq-deadline
> and write locking disabled. This shows that disabling write locking
> results in about 20 times more IOPS for this particular test case.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 2 ++
>  drivers/block/null_blk/null_blk.h | 1 +
>  drivers/block/null_blk/zoned.c    | 3 +++
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index 864013019d6b..5c0578137f51 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -424,6 +424,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
> +NULLB_DEVICE_ATTR(no_zone_write_lock, bool, NULL);
>  NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
>  NULLB_DEVICE_ATTR(no_sched, bool, NULL);
>  NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
> @@ -569,6 +570,7 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {
>         &nullb_device_attr_zone_max_active,
>         &nullb_device_attr_zone_readonly,
>         &nullb_device_attr_zone_offline,
> +       &nullb_device_attr_no_zone_write_lock,
>         &nullb_device_attr_virt_boundary,
>         &nullb_device_attr_no_sched,
>         &nullb_device_attr_shared_tag_bitmap,
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/n=
ull_blk.h
> index 929f659dd255..b521096bcc3f 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -117,6 +117,7 @@ struct nullb_device {
>         bool memory_backed; /* if data is stored in memory */
>         bool discard; /* if support discard */
>         bool zoned; /* if device is zoned */
> +       bool no_zone_write_lock;
>         bool virt_boundary; /* virtual boundary on/off for the device */
>         bool no_sched; /* no IO scheduler for the device */
>         bool shared_tag_bitmap; /* use hostwide shared tags */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c
> index 55c5b48bc276..31c8364a63e9 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -96,6 +96,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struc=
t request_queue *q)
>
>         spin_lock_init(&dev->zone_res_lock);
>
> +       if (dev->no_zone_write_lock)
> +               blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
> +
>         if (dev->zone_nr_conv >=3D dev->nr_zones) {
>                 dev->zone_nr_conv =3D dev->nr_zones - 1;
>                 pr_info("changed the number of conventional zones to %u",

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
