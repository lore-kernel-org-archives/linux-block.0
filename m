Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95801C433EF
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 01:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiCEBbm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiCEBbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 20:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3438D254A81
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646443851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4W8ElG6mZSwqXHqNnnksVWh+tmZbEVnR0mSgqWcpZ0=;
        b=ia4f/Uo4NSm+AL3dniooorkeX9PFQl6nm+XJtGduwAmTx8FimmkB+EnqCCbzDAdUJpjngK
        LVWvDMyhGKBBxsEx4VQzwMrxm4HVh/sJTU8seK3R43uPlbdpV0PqJVs2bs51IZsRvaFD6G
        DQsihWXzKLJpbjgeh0FbuqN8b86qcUA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-oM7D0RU-O8m1OcWS1qtOjw-1; Fri, 04 Mar 2022 20:30:48 -0500
X-MC-Unique: oM7D0RU-O8m1OcWS1qtOjw-1
Received: by mail-qk1-f199.google.com with SMTP id 7-20020a05620a048700b00648b76040f6so6969845qkr.9
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 17:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f4W8ElG6mZSwqXHqNnnksVWh+tmZbEVnR0mSgqWcpZ0=;
        b=VD1fwksOLaiOHkyidzZenyNVCr7QC+XplFvG1rS2HIskDEgy4MHEq44AsRpW3Nq/TH
         dpqx7v4B9gHLqXmdXOxdk5jq4SA3JhuYQ39Ohrehhf5/8h6LwTSxZeG+6CV/ELWyXYgh
         LMpu+1slPKA174geGo5Wn+q8zfDKRuDzL0gx/Y/uI+NJKpAat7hgBzOvdL6YUjT80RHx
         tcYlTEiee3MKy5MsrrY2/qlricVGlCOrpU3D5HXqWty1eUjHGPIG20jLAk/3QSQU2w02
         NUr6SlPzb+aYAlOMxQ3f8pwqvBrdpM66MEUDMU//djEgAT1r8a5MKrAXwUF51oRCD52F
         YYSA==
X-Gm-Message-State: AOAM533L+iGshJTadS7Ow6omJLPtxvldSZaMhZK5s1scM/CKanHv7svV
        IuxUr1OO06Co6wiyoaYvVTRn/TNg+MShPdu0ejZUpZ85jhZEUqphnapKLugqWrNnJ+06w3WwmHj
        D+u3VnNEEnk+8qEXiABKTuQ==
X-Received: by 2002:a05:6214:c4d:b0:432:923d:17ae with SMTP id r13-20020a0562140c4d00b00432923d17aemr1003994qvj.18.1646443847882;
        Fri, 04 Mar 2022 17:30:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0ZfdGLhXz1qz87zG4hDSJWdc7ym3JCEtuN3XDxEZNrkSgeSmockEsKIFOYmh6d+2StzLyfg==
X-Received: by 2002:a05:6214:c4d:b0:432:923d:17ae with SMTP id r13-20020a0562140c4d00b00432923d17aemr1003988qvj.18.1646443847636;
        Fri, 04 Mar 2022 17:30:47 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g2-20020a37e202000000b00607e264a208sm3125054qki.40.2022.03.04.17.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:30:47 -0800 (PST)
Date:   Fri, 4 Mar 2022 20:30:46 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] block: add ->poll_bio to block_device_operations
Message-ID: <YiK9Rgvx0Z3aOGNQ@redhat.com>
References: <20220304212623.34016-1-snitzer@redhat.com>
 <20220304212623.34016-2-snitzer@redhat.com>
 <68dc8fb0-86df-effe-4ef2-8ed9c350d836@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dc8fb0-86df-effe-4ef2-8ed9c350d836@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 04 2022 at  4:39P -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 3/4/22 2:26 PM, Mike Snitzer wrote:
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 94bf37f8e61d..e739c6264331 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -985,10 +985,16 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
> >  
> >  	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
> >  		return 0;
> > -	if (WARN_ON_ONCE(!queue_is_mq(q)))
> > -		ret = 0;	/* not yet implemented, should not happen */
> > -	else
> > +	if (queue_is_mq(q)) {
> >  		ret = blk_mq_poll(q, cookie, iob, flags);
> > +	} else {
> > +		struct gendisk *disk = q->disk;
> > +
> > +		if (disk && disk->fops->poll_bio)
> > +			ret = disk->fops->poll_bio(bio, iob, flags);
> > +		else
> > +			ret = !WARN_ON_ONCE(1);
> 
> This is an odd way to do it, would be a lot more readable as
> 
> 	ret = 0;
> 	WARN_ON_ONCE(1);
> 
> if we even need that WARN_ON?

Would be a pretty glaring oversight for a bio-based driver developer
to forget to define ->poll_bio but remember to clear BLK_QC_T_NONE in
bio->bi_cookie and set QUEUE_FLAG_POLL in queue flags.

Silent failure it is! ;)

> > diff --git a/block/genhd.c b/block/genhd.c
> > index e351fac41bf2..eb43fa63ba47 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -410,6 +410,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
> >  	struct device *ddev = disk_to_dev(disk);
> >  	int ret;
> >  
> > +	WARN_ON_ONCE(queue_is_mq(disk->queue) && disk->fops->poll_bio);
> 
> Also seems kind of useless, maybe at least combine it with failing to
> add the disk. This is a "I'm developing some new driver or feature"
> failure, and would be more visible that way. And if you do that, then
> the WARN_ON_ONCE() seems pointless anyway, and I'd just do:
> 
> 	if (queue_is_mq(disk->queue) && disk->fops->poll_bio)
> 		return -EINVAL;
> 
> or something like that, with a comment saying why that doesn't make any
> sense.

Absolutely. The thought did cross my mind that it seemed WARN_ON heavy.

Will fix it up and send v5.

