Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE40C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 11:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiDELuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356534AbiDEKX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 06:23:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF2BD89E
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 03:08:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i10-20020a17090a2aca00b001ca56c9ab16so1564024pjg.1
        for <linux-block@vger.kernel.org>; Tue, 05 Apr 2022 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AFZlzhQRYQmWlcxY6uWkNd8Iq+nKCCpPlY/EOCThoMQ=;
        b=SxaS2wRPijdzWAjSRtnfxCsnSZYpeG2Ao0WEXpxGe4mIZD4qTwFi8fdGBlS6xFqLXF
         NJjclKg1eSpxDVmjnDMqN5aBaYzd+koEQJSCHGRSjNrALtc18lkyMMF06NLmrA2bE95S
         lKw7smML6PKadf6LBOgP9QHICn9CnaOADJRVffWy0FY+cK/jNyoQrVEZkTUu/plCXm44
         QLw69MWA60bAN+6bqV4mJaCw8q1wz3YzrgTsD99EEcpKLLLSLsCdc5qa2m4FxYlTX4C6
         y9IuZWySXpFyg9OyUSGDmZQQqQ0fLEwUgW5K74cfcG02jiSLmX2yyoM/AX+etNnGSbN1
         2PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFZlzhQRYQmWlcxY6uWkNd8Iq+nKCCpPlY/EOCThoMQ=;
        b=p1/TwEucPg6sPcM+UztDMNpSVkQQDYcl6Pe6JHYo1NV4mCi+wu+fdgdAq2+OUIWW38
         zYsl0j4G8WoKjHGrPM23bJmYUno8L3/72jxoyhgWpu3s+3UzcJxNgbFAllQ14QxxobBM
         mNsuHx78YH1IJIHqnPYp3Uqw1BQ70xAcD8gjYmN+QZraEXOisYzlEu14vDWgABA52/d2
         94jvaFpRRkRyLFSTPtS/SdUbFVnFV9l4owMs7A6ChE7/A0odRWbZvRekqQ5qlNAgHW2P
         qGkTiHYGtTDU84oS8CQuNQ/1By72LMBMxdD8mVBCz9lnlKLBW2tYqd4doUVfQM4Ekomo
         dLeQ==
X-Gm-Message-State: AOAM531qQTUq7LRdbU9tSdryVVU44awQ2KBOy3rUIoQhN2Pa7vZc3V3X
        /4umBKMGrLeFoBWVlRgO/sk=
X-Google-Smtp-Source: ABdhPJwVZ2O7lZLfPbbpY/nfeqiAWK8ZBuCgB9p0mU2eHUiT/wjI6HHJdlsImHbLjF+6XCRo1EvbXg==
X-Received: by 2002:a17:90b:3908:b0:1c7:7a14:2083 with SMTP id ob8-20020a17090b390800b001c77a142083mr3186635pjb.230.1649153311233;
        Tue, 05 Apr 2022 03:08:31 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id on12-20020a17090b1d0c00b001c7a548e4efsm1983962pjb.54.2022.04.05.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:08:30 -0700 (PDT)
Date:   Tue, 5 Apr 2022 19:08:23 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] virtio-blk: support polling I/O
Message-ID: <YkwVF3f2DsESU84x@localhost.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-2-suwan.kim027@gmail.com>
 <YkvvKr9nCfza5KRa@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkvvKr9nCfza5KRa@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 05, 2022 at 08:26:34AM +0100, Stefan Hajnoczi wrote:
> On Tue, Apr 05, 2022 at 02:31:21PM +0900, Suwan Kim wrote:
> > +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > +{
> > +	struct virtio_blk *vblk = hctx->queue->queuedata;
> > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > +	struct virtblk_req *vbr;
> > +	bool req_done = false;
> > +	unsigned long flags;
> > +	unsigned int len;
> > +	int found = 0;
> > +
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +
> > +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> > +		struct request *req = blk_mq_rq_from_pdu(vbr);
> >  
> > -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> > -					vblk->vdev, 0);
> > +		found++;
> > +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> > +						virtblk_complete_batch))
> > +			blk_mq_complete_request(req);
> > +		req_done = true;
> > +	}
> > +
> > +	if (req_done)
> 
> Minor nit: req_done can be replaced with found > 0.

It looks better. I will fix it.
Thanks for the feedback!

Regards,
Suwan Kim
