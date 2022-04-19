Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 04:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbiDSE5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbiDSE4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 00:56:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82333365
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 21:51:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o2so27295778lfu.13
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=;
        b=SJ+jl8otuJP8V2SgmRrkKx5N5mzchzJWNs3wHGu/KEMaBtHJMlOSyPwEwTYRCJOsK0
         +ub417XW+OB47SmEbjExHhWdvjVWNP6f4maHx7wpcQ/meMLPTDZio2MhC3cJJ+CFcG7A
         WyaAXMErjpaI/XL4ZkxN4ZoByVo51Plmy8MlzTn6CKA4kPvTL6QPTM/FElDnmxz/4bAo
         dNPevLcXfcZa94Hc/QRZN/ahpyGhXVxqtHvMswx1d+ioXM8CH8EB0Ocsp4CDYa7mfCxx
         3EMIYtoYuS9+fNRK0znetQsYbQBpHaSNFwuzb6Pw3NmrbbAzHjf8OVLAsic0niCU/6Hj
         1cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=;
        b=yGUVZqAzYkg7lzb8z/DOZ+LFgDQPEFPuP0VhXQvUt88iPVZ24qVrVC8vPpg9FRFEW7
         tY8r7YEhT477IZSE28Y6z/v31VWZ57I15RDBLF/dJY2P8b+2UunrB3w//8SR2CIGT8YT
         jxM3VDRBoHM2B9X+ZyrTME/AzP+wDuBtGTswmA6kh98TMTpbakRNpoGIdJHsAgnkSewB
         azPfAfbTJ/sCBdiMAm36T7i/GhoXVHDDBuv8drS5DNGe1HaWEj3Q2Z+D2zUz0Phxykgt
         zec7EPnXAXPNERJ09A13z0wNIxwbTghkBy/MLpaFrMwS6L4NbRvKMRV/gmZ1UoDVzQdM
         yiqg==
X-Gm-Message-State: AOAM5323PTVjqbDLAmhgRV7Pki8JYwsptXfuFqsukzRbP75U2hZFFJw0
        t+Lcy3HT6DtJ5gikJ0oa0oVecIpaFgVgFo5Du5+Sk1boKiY=
X-Google-Smtp-Source: ABdhPJyLR4ZusRr2xSa6FgTHa9kgMMN14+gTuhXJUl7advlAotvmYnqJxqDiVIivr0X1ZGDx839mhVaChBp2powMkIg=
X-Received: by 2002:a05:6512:10c5:b0:471:a703:bca4 with SMTP id
 k5-20020a05651210c500b00471a703bca4mr1289967lfg.581.1650343907228; Mon, 18
 Apr 2022 21:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de> <20220418045314.360785-11-hch@lst.de>
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 19 Apr 2022 06:51:12 +0200
Message-ID: <CAMGffEnxwHE_QgN2OS93BHe6U+XdYc_R5OmSROmF5F-HXK_E4A@mail.gmail.com>
Subject: Re: [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 18, 2022 at 6:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index d080a0de59225..4309e52524691 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -59,7 +59,7 @@ static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
>
>  static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>  {
> -       return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +       return bdev_discard_alignment(dev->bdev);
>  }
>
>  #endif /* RNBD_SRV_DEV_H */
> --
> 2.30.2
>
