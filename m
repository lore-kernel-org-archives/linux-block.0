Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD01C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 18:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiF1SdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiF1Scv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 14:32:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3921E1E
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 11:32:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c1so21278263qvi.11
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9MO8TEEfnuBc61++YqvTNJiEplsc1bJUer/EJhWfW8g=;
        b=UXvk70XwazaXgp0EEp547P3hzrNW/bv1TTIDEssIP811Qne+bqbk7I1PQtHrCl6LQs
         eJoBjcVeUZMGoigyNz77/0EWgE2zYCaQr+Wn4+XO+OykXp5JgYqvwW/jmDCUgIn3VYy2
         JeS3nJ9lbFvHrk821vJ2npGCDoWK691neIQNfroOjoLNa+mHcRXbLRUHsbeqAwe29Jql
         xFCvoxaTHsAameaeM3xxaALZa1ZQSfjJdQesuqnC54JTbpP8MSUWixZ3ZZSPRaA8LrU5
         tuxVQE1SXFBfaaDlObBJIqf4CDBgjzARmht+xtPus6Ar0iMeKLnVu9meuTdIZ0E5z2ZX
         D8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MO8TEEfnuBc61++YqvTNJiEplsc1bJUer/EJhWfW8g=;
        b=53VYIhz3TgXPC/2BRv9OnxfXafMhe1YLN1pC00q1P1bDRLKyZUvMs3XsNDUXKFQaxy
         d5mmu3k5g7dSI8hWjvJAAurNbv10fjxN7UTQAsZL8nxjGsWkvQk7jdkgaZ5Ss0tDvg0X
         cJTcMJT176N6TbWCRS57quX1/hjhnZeUI/scPCK+zhAguNvWy9vTCU+iwLVMUwPA3IpG
         BtwiODZpTDIDk2k5CJh2fIYystE1ZY8azRr3dYOPlP6kOrj1zkMHhHEHk4ZT+fL131Nr
         iyTqI4KKzaiWjbg8e5PSGaje9pL/d9VLbm/M3Ju3b0Jmg7y0rzjmwH+GmmE3NVa5bloS
         WR8Q==
X-Gm-Message-State: AJIora/19mnJto8IKiSNxUOvoeaCYXJEczzwadl1+BNdXp8IhLvUF7NG
        6P5G+uKO+s7Lgh6sVJzQ39HybCQtCJwZzwbPTw==
X-Google-Smtp-Source: AGRyM1t+qH5DVCkRhwfo5JxkCaB05+/Bj3qGcHKm7szHoMoFaCceNDjKXbyX8wBcoxiezW63J8SFvw==
X-Received: by 2002:a05:622a:14c8:b0:306:724c:811c with SMTP id u8-20020a05622a14c800b00306724c811cmr14597597qtx.394.1656441169418;
        Tue, 28 Jun 2022 11:32:49 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id h21-20020ac87155000000b0031903373904sm6453598qtp.43.2022.06.28.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:32:48 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:32:47 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 12:13:06PM -0600, Jens Axboe wrote:
> It's much less about using whatever amount of memory for inflight IO,
> and much more about not bloating fast path structures (of which the bio
> is certainly one). All of this gunk has to be initialized for each IO,
> and that's the real issue.
> 
> Just look at the recent work for iov_iter and why ITER_UBUF makes sense
> to do.
> 
> This is not a commentary on this patchset, just a general observation.
> Sizes of hot data structures DO matter, and quite a bit so.

Younger me would have definitely been in agreement; initializing these structs
definitely tends to show up in profiles.

These days I'm somewhat less inclined towards that view - profiles naturally
highlight where your cache misses are happening, and initializing a freshly
allocated data structure is always going to be a cache miss. But the difference
between touching 3 and 6 contiguous cachelines is practically nil...  assuming
we aren't doing anything stupid like using memset (despite what Linus wants from
the CPU vendors, rep stos _still_ sucks) and perhaps inserting prefetches where
appropriate.

And I see work going by that makes me really wonder if it was justified - in
particular I _really_ want to know if Christoph's bio initialization change was
justified by actual benchmarks and what those numbers were, vs. looking at
profiles. Wasn't anything in the commit log...
