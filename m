Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC53C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiF2SkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2SkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 14:40:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426329810
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 11:40:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q4so26150320qvq.8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTPGx2N1jpuiUT68Zx+rA9I6AVj18IKzWfibl/qcoIc=;
        b=EBIbqSNvP2ruC35qvPv9h53Col+Ygkn0I5VAjNaaA8tJlPGTKJFknqiA80PAvB/bba
         Knl76j7bwvlybj7LtL/0noO76pjVJr4/ZqsL3SHVG6xybVP0KiDfzgrjp6VCTchCjavA
         Xfgz7YYGNCtGpezI3h+Bg0Fe6Xx3HS7GAbya04NQ4FnwAYHYHHlYxTvwUL19B1wBM3K1
         lw+e0dX7iCwGAi/Faf68bJHiZWuonJ0fTL7nr8sY2CUpTRP/kJqvTZLB0HIr9W9ZFT6B
         K1zsVF1G0NOlIxXTblUTyzl5fQIiZKpA43W7kvE8tG2qbIej6vqvV8KppahTH8FWrtd0
         Dbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTPGx2N1jpuiUT68Zx+rA9I6AVj18IKzWfibl/qcoIc=;
        b=GXgcdQSI0mczaVaS0ifnRgLaa5gYP9AojRJyqBLP3fwNpfK1NawXEjZJAchAiTcPXC
         E/iQcUxhPJuGQMnUb37Pc7b53efEC7x+YX7NtQDGdBwq6C0eRhetErNbjTQbhx5ErJ7e
         g+8GorHYY9hQ0Rv3xnEkOQxSdGbW+FkouB1R40PozGLY2FMT8GLGt7stUcA/LATosALu
         tDlvc1RsMQ7qqsMArWHpdGTtQ9CBC/zJEm+GxkcVjb6bSCLYvHoQH1GlX6xjI+XYTQDS
         m7znU0t2E4TFKD2vQOlNavwvYZLh5Ns/UVxRUdMpC/uhT/L4O9sr4g5ONrDLVdfuDBmV
         1Pqw==
X-Gm-Message-State: AJIora9p+ofDcyEgyunpxpKsJsEfYlWwRRHBhWpOOWfYPDnKk+ix/f7m
        WCzLYXxEReEP1eOjji6WUQ==
X-Google-Smtp-Source: AGRyM1t+k/LSavzJpNR9L3NcEUGUmQ3ZTiAl/yvrznRdJZcWrAFcC888FmZXs9k/HBhEyicxMrvcOw==
X-Received: by 2002:a05:622a:174e:b0:319:5b72:173b with SMTP id l14-20020a05622a174e00b003195b72173bmr3863832qtk.13.1656528002961;
        Wed, 29 Jun 2022 11:40:02 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a2a0100b006a6f68c8a87sm3941480qkp.126.2022.06.29.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:40:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:40:01 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220629184001.b66bt4jnppjquzia@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 11:16:10AM -0600, Jens Axboe wrote:
> Not sure what Christoph change you are referring to, but all the ones
> that I did to improve the init side were all backed by numbers I ran at
> that time (and most/all of the commit messages will have that data). So
> yes, it is indeed still very noticeable. Maybe not at 100K IOPS, but at
> 10M on a core it most certainly is.

I was referring to 609be1066731fea86436f5f91022f82e592ab456. You signed off on
it, you must remember it...?

> I'm all for having solid and maintainable code, obviously, but frivolous
> bloating of structures and more expensive setup cannot be hand waved
> away with "it doesn't matter if we touch 3 or 6 cachelines" because we
> obviously have a disagreement on that.

I wouldn't propose inflating struct _bio_ like that. But Jens, to be blunt - I
know we have different priorities in the way we write code. Your writeback
throttling code was buggy for _ages_ and I had users hitting deadlocks there
that I pinged you about, and I could not make heads or tails of how that code
was supposed to work and not for lack of time spent trying!

You should be well aware that I care about performance too - I was the one who
pushed through the patches to not separately allocate mempools and biosets, and
a lot of the work I did ages ago was specifically to work towards getting rif of
the counting segments pass (work I believe Ming completed); that was a _major_
chunk of cpu time in any block layer profile I've looked at. So sure, tell me I
don't care about performance enough.

*sigh*
