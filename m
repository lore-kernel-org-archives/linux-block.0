Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419FCC4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0994421741
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601054281;
	bh=lqS7SUCdRoDTnZFkqVOLRhge2UmBv+3A4poXFNxyUWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p4aOU3ckCTlytEl8CA1LBzGfSgebJwL7R771SfImEBnBhezJ6qpnemIZMFbtpTmyK
	 UdS/4UAq503omwqnEtNHv1IKB/j6hKzJIvHXrQLYCCrVO0sMG/W8yEeeI9fe4iEakp
	 bdDw7CaFBC0EVQaOjyP1cNmb1wUANOwIrbd0A7fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIYRSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYRSA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 13:18:00 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E0C0613CE
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 10:17:59 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so3623882lfp.9
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+ANB8ObSSZ0LIy221HtUSCjieyuyM53ewN5x3+3DVE=;
        b=ViM6tNtjnjXKy+aig7vGCrWABYQxrnX2HtkZcN4CBEWw59xq/lePN1F/rj4bBZKD9U
         Ciyu/pPnZh+e6dHKrJngZsreQbcFBMQz0XY6cDFZ6Hru4Bqj/AL8F4fhKruS2mt+CqNQ
         pTRiIMYwAshLcNOYleRDc/4QZ26uCT/Hm942Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+ANB8ObSSZ0LIy221HtUSCjieyuyM53ewN5x3+3DVE=;
        b=Xph1aIldASPJqscjrueHqoDGvdWSp8Qt2nVSwafLAPV8a+HvuxkSa2aPD9oCkWRA48
         NCzCZ8cReARXaCrLgR+nMybIsbB9itiv3jvFR0vzBQlm7JCLFc1+3KDaIDP8hKEvp4M9
         GJzGQitYhBBTLnJ5VVAiCEIbLPyyqEmEYr6JzyoHs2EP225lz85RZb1rIgGOW1PQ3gdj
         mNJmDcogp7cx38X+0G57Q3THPSY7V6XCkE603G5zvyHAQFECA980UZXRVgwMVIFqyPgZ
         uoCIRR3F2v55rueoph87MJgO+wtV7nj6V8yUlXBvBqtyOOYgtxcfBRGJ8hKMx7+wJAKu
         +Drg==
X-Gm-Message-State: AOAM531lXI8c6YsxH36CEXq/qK9+fdw7+Adnc2jErDMr7G7q3a5Uzq21
        ryqcUnvHKweLuRt2eacmVGkFuvRzPY+Hkg==
X-Google-Smtp-Source: ABdhPJx1MV2FuYMA2N3CjaavkfmgDwsQyppFs56q7bY7TuaNehc7PK/Z9LybdJdYgux2hhx5PaWheA==
X-Received: by 2002:a19:e602:: with SMTP id d2mr1857077lfh.514.1601054277807;
        Fri, 25 Sep 2020 10:17:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 186sm2709807lfi.205.2020.09.25.10.17.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:17:53 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u8so3670130lff.1
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 10:17:52 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1832306lfg.344.1601054272350;
 Fri, 25 Sep 2020 10:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200915073303.GA754106@T590> <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590> <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590> <20200925161918.GD2388140@T590>
In-Reply-To: <20200925161918.GD2388140@T590>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 10:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
Message-ID: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> git bisect shows the first bad commit:
>
>         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
>                 kmem_caches for all allocations
>
> And I have double checked that the above commit is really the first bad
> commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> is LIST_POISON1 (dead000000000100)',

Thet commit doesn't revert cleanly, but I think that's purely because
we'd also need to revert

  849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
  74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
(un)account_slab_page()")

too.

Can you verify that a

    git revert 74d555bed5d0 849504809f86 10befea91b61

on top of current -git makes things work for you again?

I'm going to do an rc8 this release simply because we have another VM
issue that I hope to get fixed - but there we know what the problem
and the fix _is_, it just needs some care.

So if Roman (or somebody else) can see what's wrong and we can fix
this quickly, we don't need to go down the revert path, but ..

                  Linus
