Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF534C433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 21:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiCAVU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 16:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiCAVU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 16:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E1335AEE8
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646169585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zhGsISEne7ayegiBuC0VI77v51JSASEUVzAtdh+UqeM=;
        b=TWilmJOnfC4ne+Img1z+wb9bP3ype1/uCn+6yZdZ4v0XRK+hyf2gZvVjQURydYdDm8cq0k
        eCAtBMvHNo2z4NMUT7ZOWrGQqh+z1PcfGzJuQN5m5A0mm7yraX5FWHXExXArJhwUyAHaJY
        27z5tj4y0fTeKWop2jSD2rNo51qRPaY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-nDp-jSjVM5ONpOIf9DP07g-1; Tue, 01 Mar 2022 16:19:44 -0500
X-MC-Unique: nDp-jSjVM5ONpOIf9DP07g-1
Received: by mail-qt1-f197.google.com with SMTP id a6-20020a05622a02c600b002dd2d38f153so8201981qtx.17
        for <linux-block@vger.kernel.org>; Tue, 01 Mar 2022 13:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhGsISEne7ayegiBuC0VI77v51JSASEUVzAtdh+UqeM=;
        b=qoXB7Yj0xS1XkKNjDeKK/UPqBw78SxcQBBKPE3yrdUOSXF8hd58YIxEEU/RmisAi9u
         3GHOLembPt914C3fpGn+v2eXF14xw1BPgONSgbWwwBP/XOfRSetoRPQnDXBuEBbPqXXA
         eM9Laj1JoV8shM4NNh1HxBk00F846KP/C++v9FU9vJMjXAoR9i74xyonOhQ58XF0EOAM
         TaHmnK1UG+lVBkExz60taCzHwc0yZNOvIVnOEJkSpwNQEgkqxPPyWYuMiH39FjwZkpt7
         CA37yk51syUFD07D+zhzg0tJlcZ6LS5MZ684cGaRxc/LLKMpYG5PBVJhS1UyKD7wWvyQ
         MKsg==
X-Gm-Message-State: AOAM531lo2KjBJsoCWUg+7c7cXIqoGviKWSKeFBAqIKnfrpDFO3m35fn
        O2RU3KYxgD/KnhQWVEcL2o9Id+aMMoRzCqtkfPlUH39PD+5FXyylIl6aeCQsJyVtAGH/B3gTbl9
        eqHjVCFjKOzLzC2Ava/uakg==
X-Received: by 2002:a37:464c:0:b0:60b:6be8:29ae with SMTP id t73-20020a37464c000000b0060b6be829aemr14693624qka.126.1646169583744;
        Tue, 01 Mar 2022 13:19:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdhhv8FXLh+s6pIY25DENmaFxbVp4vb4H3/pCOuTKcqaohrWojF+hMg+3FnTB0/X5W7hjY7g==
X-Received: by 2002:a37:464c:0:b0:60b:6be8:29ae with SMTP id t73-20020a37464c000000b0060b6be829aemr14693615qka.126.1646169583532;
        Tue, 01 Mar 2022 13:19:43 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o200-20020a37a5d1000000b0064904a35862sm7092093qke.96.2022.03.01.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:19:43 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:19:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/3] block/dm: support bio polling
Message-ID: <Yh6N7msbMBcANFxg@redhat.com>
References: <20210623074032.1484665-1-ming.lei@redhat.com>
 <Yhz4AGXcn0DUeSwq@redhat.com>
 <Yh1vrWXlaTnEcrNd@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh1vrWXlaTnEcrNd@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 28 2022 at  7:58P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Mon, Feb 28, 2022 at 11:27:44AM -0500, Mike Snitzer wrote:
> > 
> > Hey Ming,
> > 
> > I'd like us to follow-through with adding bio-based polling support.
> > Kind of strange none of us that were sent this V3 ever responded,
> > sorry about that!
> > 
> > Do you have interest in rebasing this patchset (against linux-dm.git's
> > "dm-5.18" branch since there has been quite some churn)?  Or are you
> > OK with me doing the rebase?
> 
> Hi Mike,
> 
> Actually I have one local v5.17 rebase:
> 
> https://github.com/ming1/linux/tree/my_v5.17-dm-io-poll
> 
> Also one for-5.18/block rebase which is done just now:
> 
> https://github.com/ming1/linux/tree/my_v5.18-dm-bio-poll
> 
> In my previous test on v5.17 rebase, the IOPS improvement is a bit small,
> so I didn't post it out. Recently not get time to investigate
> the performance further, so please feel free to work on it.

OK, I've rebased it on dm-5.18.

Can you please share the exact test(s) you were running?  I assume you
were running directly against a request-based device and then
comparing polling perf through dm-linear to the same underlying
request-based device?

Thanks,
Mike

