Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75379C38145
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiIBASZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiIBASZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 20:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C7879614
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662077903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3zSW4akroZH3AEa4Ob/zy2W13gQovdXsrNdOSGyuxY=;
        b=IT5ypTpDjatWfCCtAsZeoWDfj37WyH4b5U9iSD5bvBQ2/l8j6t4AH7Sfoz655aYk7OCfbM
        3WzqaRGDCNUngNQYcUI72CO3buHMqKMoUY1IadFeocWN4LdVhQY0ncbyM5YKpg1BLCBBfn
        7Nlxo29gY6BlI/brggVf6/CFvjDeBWM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-CUqvMr1RPOaMCt0KKtq3tA-1; Thu, 01 Sep 2022 20:18:22 -0400
X-MC-Unique: CUqvMr1RPOaMCt0KKtq3tA-1
Received: by mail-qt1-f197.google.com with SMTP id b10-20020a05622a020a00b003437e336ca7so393554qtx.16
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 17:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/3zSW4akroZH3AEa4Ob/zy2W13gQovdXsrNdOSGyuxY=;
        b=at/9UZGevBZpTo56AQmp297GksORWB3hYzcxcpYuH+Ohrgk6yDMclt4CBTBWOd5WwO
         6ynI0g/AxWKm5Yhr6KRTZ/16mlbsQMHocvYU886NQ5NV7urQx8D0naqzTqIXSzw0mhmD
         1BcMFyZ7xwFGdaGHk0Kg+pvnf6D+ad3xMoBXHNstzkkiKu53daqPeimM688xamH4lQyu
         Kk0HixSRRcJkEhZGOIc4XQjizfI2P6H80t6Me+sLABCdaLwJsvEpTt1Jbsx+iEXZBCEN
         WdO644fdkbIgxnfAcstThNquC9n3jMMXDVKvBgdExmo71vro8EH4J9EW6AZ0FBrMGXLK
         Ra+A==
X-Gm-Message-State: ACgBeo1kpymIz6FJHHBbWg7F0pCNmN4y8+s9bHw8pVSWsHpQJNt98QSa
        Gh3jw92m2dTaTbHM4jbVmkVcficuWyuRupRSBobbHzNxrCtJ0EBvGPbNTDHDyIrHUmtFGCFkkBC
        RO9o30oUbZpiemgj+lJV9PA==
X-Received: by 2002:ac8:58c6:0:b0:343:6ea4:c5d with SMTP id u6-20020ac858c6000000b003436ea40c5dmr25886996qta.371.1662077902202;
        Thu, 01 Sep 2022 17:18:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oRhhYYJ6PrG/1HFlpvhf8UmICNazDZnq0j+/fuj1YsRN/1lRkHtGn1KfEAsjk0buEiHYDsQ==
X-Received: by 2002:ac8:58c6:0:b0:343:6ea4:c5d with SMTP id u6-20020ac858c6000000b003436ea40c5dmr25886979qta.371.1662077902000;
        Thu, 01 Sep 2022 17:18:22 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bn5-20020a05620a2ac500b006bb41ac3b6bsm267782qkb.113.2022.09.01.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:18:21 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:18:20 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
        pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Message-ID: <YxFLzHoYF7damFip@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121913eucas1p11c222f4c57a0132117bb9712e6018668@eucas1p1.samsung.com>
 <20220823121859.163903-12-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-12-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation, and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore.
> 
> Currently, this is not a problem as the targets that support zoned devices
> such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
> and even if they do (such as dm-flakey), they don't modify the
> bio->bi_iter.bi_sector of the cloned bio that is used to update the
> orig_bio's bi_sector in dm_zone_endio function.
> 
> This is a prep patch for the new dm-po2zone target as it modifies
> bi_sector in the endio callback.
> 
> Call dm_zone_endio for zoned devices after calling the target's endio
> function.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Great patch header, explains the situation nicely.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

