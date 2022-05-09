Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76CAC433F5
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiEIQJg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiEIQJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 12:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1284425F783
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652112339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=;
        b=O2iOyWvHQECbahVRCR3auxpkAXjIms3CLRAk9aCWOL5T5OTpFLoBMhdYq++ssMdDbROcn2
        4TJplDqs1Qfb8Jf0GfVNfwesdJUbm04Q9YTB93Juk+0FiR8Rk0USdGs6t4aBG3vVdbldbX
        KI7iiQythNFaLgijQo9QcsUDHuWIwzI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-kDzmINatNoaAwVSHOgyhew-1; Mon, 09 May 2022 12:05:37 -0400
X-MC-Unique: kDzmINatNoaAwVSHOgyhew-1
Received: by mail-qt1-f197.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso12470700qtj.6
        for <linux-block@vger.kernel.org>; Mon, 09 May 2022 09:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeFX2E5ey4pZOwmjvDjcnRprgKudS5nUCFFZ6mjCjw4=;
        b=tG9EffYGZa+1/Ckc1/TIL1KWAsTgn5g5O166VLPuiTLl4CZmUOFtKWLbkngvkjM65k
         BEhF7XjrRScLdG+CB8TPwS4yLBrEJB0EGtZ/jQfXpE3HuHfRDBanhAoKNAL3/j1Tsbpq
         5x+923c/qu3Oc3hlZ5sHNVoOKhc3KA0LBWetVyT8zz+E30ZIVN1M88JQreOT3eDth3tM
         yfdQAKj0Njc+WFraVOO8Lmg3Lbp3+B0SDT6NebsHu6Gr9NNdSaMPcz6Of4DFdqmPDgyC
         K23N2t4KjfFMrg/fTw/h2v7NKUfez8QDPMSdJsWaH8j5ZC+E6S2Fv+HjoW5Vw16Wroq7
         /Cjw==
X-Gm-Message-State: AOAM531DE8YCE59ktktdEYGjlO8gkkeG9i5KTT5wdzsMMhxm+XrfMb3J
        cQ+wHllxtOpNSDSD9z/4R0eVcApFLnHPY1HLc26ti0GaEi0s531fMerjXr4MQ7HGUs93x4BHMJN
        M4mjQXFvrQvzzuwH5AbKmOw==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id az4-20020ad45504000000b0045635e01968mr13785940qvb.126.1652112337400;
        Mon, 09 May 2022 09:05:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb2Vrd1ITeAGMSA0ykyWFDZQi/Pj9RpII0I7NdSUoTuyX2v0W9UQn5F/cD9u0YFL4E+wPA+Q==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id az4-20020ad45504000000b0045635e01968mr13785891qvb.126.1652112337165;
        Mon, 09 May 2022 09:05:37 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x14-20020ac8538e000000b002f3bbad9e37sm7663441qtp.91.2022.05.09.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:05:36 -0700 (PDT)
Date:   Mon, 9 May 2022 12:05:35 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com,
        axboe@kernel.dk, hch@lst.de, snitzer@kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>,
        gost.dev@samsung.com, Josef Bacik <josef@toxicpanda.com>,
        linux-nvme@lists.infradead.org, jiangbo.365@bytedance.com,
        Jens Axboe <axboe@fb.com>, Chris Mason <clm@fb.com>,
        dm-devel@redhat.com, linux-btrfs@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, jonathan.derrick@linux.dev,
        linux-fsdevel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>, matias.bjorling@wdc.com,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <Ynk7z4FhE2zTrzZh@redhat.com>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
 <7f1bd653-6f75-7c0d-9a82-e8992b1476e4@opensource.wdc.com>
 <26ccce4c-da31-4e53-b71f-38adaea852a2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ccce4c-da31-4e53-b71f-38adaea852a2@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 09 2022 at  7:03P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> >> ---
> >>  drivers/md/dm-zone.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> >> index 3e7b1fe15..27dc4ddf2 100644
> >> --- a/drivers/md/dm-zone.c
> >> +++ b/drivers/md/dm-zone.c
> >> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
> >>  	struct request_queue *q = md->queue;
> >>  	unsigned int noio_flag;
> >>  	int ret;
> >> +	struct block_device *bdev = md->disk->part0;
> >> +	sector_t zone_sectors;
> >> +	char bname[BDEVNAME_SIZE];
> >> +
> >> +	zone_sectors = bdev_zone_sectors(bdev);
> >> +
> >> +	if (!is_power_of_2(zone_sectors)) {
> >> +		DMWARN("%s: %s only power of two zone size supported\n",
> >> +		       dm_device_name(md),
> >> +		       bdevname(bdev, bname));
> >> +		return 1;
> > 
> > return -EINVAL;
> > 
> > The error propagates to dm_table_set_restrictions() so a proper error code must
> > be returned.
> > 
> Good point. I will add this in the next rev.

Also, DMWARN already provides the trailing newline, so please remove
the above newline.

