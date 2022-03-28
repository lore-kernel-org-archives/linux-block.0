Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07636C433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 14:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbiC1Omk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiC1Omk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 10:42:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D468329B5
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 07:41:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso1525445pjh.3
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmDWLhKjMiOZDsjfpXH0BkZsPUSF04JPahhR2P+pdhI=;
        b=L8c6V20Idfnpug41/smYwGJzj7w5Xc8oRHsq0uO3JuYqR6rV0Go0JBvH8Us79Fr3Yq
         9VEvN/U6kERBVzwKvs8REngxIK8xuJjVYNhgdVnkKGNAfi5j83tTGpXM6+K/hwpXT9WF
         Yi0FbskVQngDWR1VzEK74GQUuhbVSTQnfpAcUTUn+1di2ReFw/jXM4YMuxffoSN+Wty4
         1AlmE6Pd1d463uYRW9R8Qyk74PmLMJoOOstr7NhAb5YvMsjV1Ko7WZ2WOsxP0Oq1jvW5
         mkExy/97i5+GYRsf8hai/dDQlVu5QolfChTwKqb55idHn+qSjjgrCj9b5LQ6nrm9SjGt
         sUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmDWLhKjMiOZDsjfpXH0BkZsPUSF04JPahhR2P+pdhI=;
        b=0JiSHsvYEXryM2/risgEgRda0pXLmgkunlN3F7sKXQi0xvVCFEdPcnxVzQQv0w9MbF
         zpbIh38D513cZhnfCpxLQRmtELng4frqVjjKUFs55wDhunkYQ0Y5c4tuUer5tUbPIZpI
         0hku/nlEAjTZ5bH7XVsw84ZBNmuVQUGoEcDkFZR5Gf2mDqGZJgk4MeSKstRy8V3drDv1
         mEMd/z9VlN5GiyZD6PkkJ8Do6k6BQ7V+9p5lPCzRrvW8zwOALn5qzITTfn4dLWNa4f6T
         mAZin8qvV1UnOjUolHX9Ntm7oJadRGg/SXWYqVRepAIKXkA6oDLknya+y1qkZD0VB8+/
         d7AA==
X-Gm-Message-State: AOAM530dOOJgUGnFhqjhgqkx2vsC5mtLs7/YBaZYL+YPXUh2CHM6xiAI
        Ci2rLI680gQ6TcrzmeZNVsA=
X-Google-Smtp-Source: ABdhPJzXMEHMAEAhCTfAOuiUJSuk36Dxur964/n24luNu7bspdAt0bbv54jsM96if7oi36h2X37yag==
X-Received: by 2002:a17:90b:4c12:b0:1c6:f450:729d with SMTP id na18-20020a17090b4c1200b001c6f450729dmr41640132pjb.190.1648478459525;
        Mon, 28 Mar 2022 07:40:59 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id q22-20020a056a00085600b004fb308e393csm8608362pfk.178.2022.03.28.07.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:40:58 -0700 (PDT)
Date:   Mon, 28 Mar 2022 23:40:52 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <YkHI9Ke8VSE0Wv/W@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
 <YkGv2nr6m1MRSYxp@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGv2nr6m1MRSYxp@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 28, 2022 at 01:53:46PM +0100, Stefan Hajnoczi wrote:
> On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> > +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > +{
> > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > +	struct virtblk_req *vbr;
> > +	unsigned long flags;
> > +	unsigned int len;
> > +	int found = 0;
> > +
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +
> > +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> > +		struct request *req = blk_mq_rq_from_pdu(vbr);
> > +
> > +		found++;
> > +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> > +						virtblk_complete_batch))
> > +			blk_mq_complete_request(req);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> 
> virtblk_done() does:
> 
>   /* In case queue is stopped waiting for more buffers. */
>   if (req_done)
>           blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> 
> Is the same thing needed here in virtblk_poll() so that stopped queues
> are restarted when requests complete?

I think you are right. I missed that.

I just added blk_mq_start_stopped_hw_queues() to virtblk_poll as
you commented and did performance test again.

It showed higher peak performance than virtblk_poll without
blk_mq_start_stopped_hw_queues().

I will add it in next version.
Thanks for the comment!

Regards,
Suwan Kim
