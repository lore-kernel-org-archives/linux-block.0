Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E93C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiDFQPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiDFQPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 12:15:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452913C712
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 06:41:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j8so1957413pll.11
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGv2VZFTPO8KjXG6uEJQMGP0+jq5fPssIdseb/TM2ao=;
        b=iycg+VProGtKW47+Qfdde8AL4EyZCchv+x8gs2dqawiJlo97QA0r0rCftfoM1j3KHI
         27xnc2NEt0dsLWUx43Wl3EQsHeFrRdBavcaXzfoxk2CY3NnEzBE18uBfM9EEk4D6OvFs
         4vX06mCT7m8qKrclGgbSPzbw5BoI3rPeQYyo2gYccNE+ezflNWObpiAH9kzQpa7dAC7g
         UhBMh3UirMXvtMdA3Zk67t6ycxxc6O3U06IAS1pPjFIXds7FDuBufT2b8Ainv9FqQpbT
         c8bxAjh7l1GjbTP5G6jcow11GlXUAw6EnsYj9/yAlDFcGaOv143tmq2CP1KZ/fPxr/gm
         XGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGv2VZFTPO8KjXG6uEJQMGP0+jq5fPssIdseb/TM2ao=;
        b=YAcFaBKseKCBz6UGo0q7Jayl6NXN3JlUcWbJ0tcthYbs75uiVV47NcGrqTaG4RGv07
         o/Q+WXlK9Sw0ESNEyFw+3APpN3lRMvgWFx9eRCCsZ5prSDnrZa/rmExxs/k+Z7AA1S3a
         5m0tgxx7L/7EnMev9jf6kCPaSeWOIKPZRvtd+zssRBdZQ8WrtFFjQcQd9l5Whs7HwVjI
         cqnn0FDS0PzCvffzxi57jvqjpf3OFQ2vcKg+Ict//v72CRq4U1pqryQrvDRSyijdaRQX
         qJ/RHhg9T4RFkVQlMe/4yALmFeKttawhqv6aysVnpT0cwUCJSx1lrLWz7p78Xmy7qSVr
         eaTw==
X-Gm-Message-State: AOAM530BvUAJGf85/n1YOJwKx/c8kIrM7C4y1s502BvLCXe2dIxclgRn
        CXZbluaBcglToueL9z2seoSIiumm55TMEA==
X-Google-Smtp-Source: ABdhPJwJdOF4Azpm3mEMmH+C74e7dpbdohrHblt84Dc1NqBrJXiom+2sE9hz5x7f1TiGzKcu1i9/fg==
X-Received: by 2002:a17:90b:1bc7:b0:1c6:c3ac:894a with SMTP id oa7-20020a17090b1bc700b001c6c3ac894amr9831653pjb.125.1649252496745;
        Wed, 06 Apr 2022 06:41:36 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a66c600b001ca7dbe1bc2sm5971548pjl.46.2022.04.06.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:41:35 -0700 (PDT)
Date:   Wed, 6 Apr 2022 22:41:29 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 1/2] virtio-blk: support polling I/O
Message-ID: <Yk2YiSIB2OZv1FEb@localhost.localdomain>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-2-suwan.kim027@gmail.com>
 <Yk0ebS3cl95XtOuj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk0ebS3cl95XtOuj@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 05, 2022 at 10:00:29PM -0700, Christoph Hellwig wrote:
> On Wed, Apr 06, 2022 at 12:09:23AM +0900, Suwan Kim wrote:
> > +        for (i = 0; i < num_vqs - num_poll_vqs; i++) {
> > +                callbacks[i] = virtblk_done;
> > +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> > +                names[i] = vblk->vqs[i].name;
> > +        }
> > +
> > +        for (; i < num_vqs; i++) {
> > +                callbacks[i] = NULL;
> > +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> > +                names[i] = vblk->vqs[i].name;
> > +        }
> 
> This uses spaces for indentation.

Oh my mistake. I will fix it.

> > +		/*
> > +		 * Regular queues have interrupts and hence CPU affinity is
> > +		 * defined by the core virtio code, but polling queues have
> > +		 * no interrupts so we let the block layer assign CPU affinity.
> > +		 */
> > +		if (i != HCTX_TYPE_POLL)
> > +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> > +		else
> > +			blk_mq_map_queues(&set->map[i]);
> 
> Nit, but I would have just done a "positive" check here as that is ab it
> easier to read:
> 
> 		if (i == HCTX_TYPE_POLL)
> 			blk_mq_map_queues(&set->map[i]);
> 		else
> 			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);

I agree. I will fix it.
Thanks for the feedback!

Regards,
Suwan Kim

>
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
