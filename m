Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786BEEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 22:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFVWUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFVWUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 18:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADB21987
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687472397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8RTbUEcsXVxJGVp1cgZcgX/JYsR6GHDNvHugZoGaQ8=;
        b=f5els/K1GPNSTObvrQgKXZXV8Kslr+dA+dP+x/dJdcwSRnY2m6wUVxop7+AnYmBR9ojbIF
        +wO2JixVd8uL2aEhj+YFiqEL8CMakJ1uBnUMTZapICf/jy1ntllnWSBSM0orX3XTCQh0el
        eYWfo/gXllrf99I6Ce6Jx418FzW82TM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-79dwWUSdNZSaE3rqSIrWgw-1; Thu, 22 Jun 2023 18:19:56 -0400
X-MC-Unique: 79dwWUSdNZSaE3rqSIrWgw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3112808cd0cso1658f8f.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 15:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472395; x=1690064395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8RTbUEcsXVxJGVp1cgZcgX/JYsR6GHDNvHugZoGaQ8=;
        b=cNmXWF/B+VDgiALqKx4qoBneeNXfkzw5XstqWJyJ9+TeO/AdBiaX5RdXtdJ7c3EWVc
         iG6ss7RGbhioAYKOTIZSBYF0cxg2jLnEp0a38IZj98wF6XhNftLQOuSofU1PhN9S9KC6
         kDgHiaCcRzd3i/+pkvb1y/kH4WaaTX6yfzGJL08JHDDWo49uOX7pP6zMy/UFb3UrP3m6
         rTwpUP+V6c7pbIjgOWcxZmyo4g8LX2PwWI3tY7s0+5D0Asl8SMe3gt3nBfwyidQ807Kt
         2Wgk7JHSs3HRhb+fsJ3rcWN9cQubyx7OfFjsEG90yC0SNAb8KYN5zihf9klhXuwlpZvb
         M1yg==
X-Gm-Message-State: AC+VfDzeaP+wxxH737rugQPMBU6J7SsTRqXxAE8jCdq8mbs4LrGHZ5zu
        vhLuRaBqQHOdfj3i/Hp+CX6yE+C5pTmZ/NR4lRo43pxtgzTPtRUDdHJeVZWakuw3V3cc2OaCaFN
        Elq7vj45aP8Ri4MEb/WM0KPxFryIIi3U=
X-Received: by 2002:a5d:6884:0:b0:30f:bb0c:d19d with SMTP id h4-20020a5d6884000000b0030fbb0cd19dmr15604592wru.64.1687472395003;
        Thu, 22 Jun 2023 15:19:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tGVFhj88K9vXN9dEIt7gC+lJIK47dxUwDE9o4afC0zIAZHaBYJ2sfg+xB/WDyPkaGjaGs7w==
X-Received: by 2002:a5d:6884:0:b0:30f:bb0c:d19d with SMTP id h4-20020a5d6884000000b0030fbb0cd19dmr15604584wru.64.1687472394712;
        Thu, 22 Jun 2023 15:19:54 -0700 (PDT)
Received: from redhat.com ([2.52.149.110])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d55cf000000b0030633152664sm7923108wrw.87.2023.06.22.15.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 15:19:53 -0700 (PDT)
Date:   Thu, 22 Jun 2023 18:19:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Suwan Kim <suwan.kim027@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sam Li <faithilikerun@gmail.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] block: virtio-blk: Fix handling of zone append command
 completion
Message-ID: <20230622181558-mutt-send-email-mst@kernel.org>
References: <20230620083857.611153-1-dlemoal@kernel.org>
 <CAFNWusY41eprBrH-95vp2uZFkxMpLh0iF7NZ8H6FznjQYSv31g@mail.gmail.com>
 <def64cdb-d36a-04c8-77cf-1ed0daa1ef0b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <def64cdb-d36a-04c8-77cf-1ed0daa1ef0b@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 23, 2023 at 06:55:24AM +0900, Damien Le Moal wrote:
> On 6/22/23 23:32, Suwan Kim wrote:
> > On Tue, Jun 20, 2023 at 5:39 PM Damien Le Moal <dlemoal@kernel.org> wrote:
> >>
> >> The introduction of completion batching with commit 07b679f70d73
> >> ("virtio-blk: support completion batching for the IRQ path") overlloked
> >> handling correctly the completion of zone append operations, which
> >> require an update of the request __sector field, as is done in
> >> virtblk_request_done(): the function virtblk_complete_batch() only
> >> executes virtblk_unmap_data() and virtblk_cleanup_cmd() without doing
> >> this update. This causes problems with zone append operations, e.g.
> >> zonefs complains about invalid zone append locations.
> >>
> > 
> > Hi Damien Le Moal,
> > 
> > Unfortunately, this commit was reverted due to io hang.
> > (afd384f0dbea2229fd11159efb86a5b41051c4a9)
> > You can see the mail thread at the block layer mailing list.
> 
> There is no commit afd384f0dbea2229fd11159efb86a5b41051c4a9 in Linus tree. What
> patch are you talking about ? Where is it ?

Either you didn't check recently enough, or  there's some
breakage and your CDN's not updating. If the later try
poking kernel.org admins.

This is the commit:

commit afd384f0dbea2229fd11159efb86a5b41051c4a9
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Thu Jun 8 17:42:53 2023 -0400

    Revert "virtio-blk: support completion batching for the IRQ path"

you can get the patch from lore too:
    Message-Id: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>


> 
> > We don't have a solution about io hang yet..
> > So I have one question.
> > Is there any possibility of virtblk-driver io hang on zoned devices
> > without this patch?
> 
> If you are talking about the batch completion support being reverted, then my
> fix patch is not necessary. The issue I fixed is not about IO hang but the fact
> that completion processing was not identical for batch case vs non batch. That
> led to breakage of the zone append command completion. The original support for
> zone append without batch completion is fine.

Yes that's great! I expect we'll reapply the batch completion
down the road and then your patch would help!

> > 
> > Regards,
> > Suwan Kim
> 
> -- 
> Damien Le Moal
> Western Digital Research

