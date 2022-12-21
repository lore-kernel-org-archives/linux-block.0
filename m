Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96500C10F1B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 13:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiLUNqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLUNqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 08:46:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1D1AA04
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 05:46:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l4so4259083pld.13
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvt2/Z5MJ7SnBkYPD/foExtxln9olT95F4ry1fYwfcQ=;
        b=Dw8C+skutrP0zI1psFRZbaF946HGz2UQoP/LjfS0xXFI8olwBhZG4K2SajT88y4JB1
         5JNWodH8XxzWnET7y1x0HmT9Ro1yseZJ+nKqGJTtb/vQHfVNF2DBfwhJ20oz/GEtuSjy
         SwT+6+NBtmt39lLoYh0WIQq9l6tFQNMwpIlIEltqqzWAM7/s2DV6YwbOQiTPf5hwx63d
         95DNbWdbFJVKlvH4gIKtwsJhEQnBbZXhMdOvHei8xpq+2oeSluzz3Oh7MzOdOehRDz2B
         2xGWKRgLd67LpNt5tLxfQi1GZNEhkHRDozqghOxKkGO6K40EOM9KKSFymqHBgGIDwxFx
         Viug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvt2/Z5MJ7SnBkYPD/foExtxln9olT95F4ry1fYwfcQ=;
        b=B20yGE91saxL7DA35oXKl6ex/iqi2w9uWiDoRWJzU/8r4KQijJnKX7ky1LX5dOaj7n
         He1oULxRaXoiHQVTeR+lr+8HLSwrOWs0bjjAG3N7322BcJNpHDOteTAzYfcCCwJ3fANj
         3vGr8diKrCSTzmVJ9nle6e7MA64oazmrVdFj6Ea7PscArpRYPxW3M/cPk/gW38SgIUy6
         QYKdOFh0NFXCwuiQg14k1zlkLQaxeZmzKbmj5HG7fJcOfPYTWL07oSF0FB6WbtmFjJyH
         Uh2qFtmqxliNKnxMY49TULHKpxghsuR7GSKTGzFxI0Im+Xn1kB7kQkGoQX2wsOgYQtuD
         DkMw==
X-Gm-Message-State: AFqh2krbFGjkqwWqqyiLX/h6zyVI55gy7d44++HBs8mWuZXrdkzMK71r
        r/JmpC2jmY+bp6HvP8zJEt4=
X-Google-Smtp-Source: AMrXdXt0uuYNccjQMWknvIg4JSLjJZieDEHhMnHOdL4SDTQTm85foSm+MFhisZdg/GMwwMAr4j2whg==
X-Received: by 2002:a17:903:189:b0:189:ba1f:b178 with SMTP id z9-20020a170903018900b00189ba1fb178mr2333336plg.9.1671630370046;
        Wed, 21 Dec 2022 05:46:10 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001895b2c4cf6sm11453015plg.297.2022.12.21.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:46:09 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:45:59 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio-blk: support completion batching for the
 IRQ path
Message-ID: <Y6MOF7CMJ1AZEzoC@localhost.localdomain>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
 <20221220153613.21675-3-suwan.kim027@gmail.com>
 <Y6LkfrTVV/M2eye/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6LkfrTVV/M2eye/@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 21, 2022 at 02:48:30AM -0800, Christoph Hellwig wrote:
> > +		if (likely(!blk_should_fake_timeout(req->q)) &&
> > +			!blk_mq_complete_request_remote(req) &&
> > +			!blk_mq_add_to_batch(req, iob, vbr->status,
> > +						virtblk_complete_batch))
> 
> One tab indents for line continuations are really confusing.  Please
> make this:
> 
> 		if (likely(!blk_should_fake_timeout(req->q)) &&
> 		    !blk_mq_complete_request_remote(req) &&
> 		    !blk_mq_add_to_batch(req, iob, vbr->status,
> 					 virtblk_complete_batch))
> 
> > +	found = virtblk_handle_req(vq, iob);
> >  
> >  	if (found)
> 
> You can drop the found variable here now:
> 
> 	if (virtblk_handle_req(vq, iob))
>  		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> 

Hi Christoph,

Thanks for the comment!
I will send v3.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Regards,
Suwan Kim
