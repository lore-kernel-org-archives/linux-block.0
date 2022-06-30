Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 00:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiF3A6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiF3A6n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 20:58:43 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A31EC40
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 17:58:43 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u14so24843814qvv.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0uppB9ii0pBd7MXi+uA0KCh+Kd0vDpxw6l/NwutkF0s=;
        b=Jrw+5T1eBpL9wW1ZHAJ6HZhMC93ajz0dD8ij5k06lT2TYiCRkOzKVIXNVztMuydzSN
         M2arN+q30Vw+2kjV7IvlAwoL3gWJYaaTZy2JFVJudk8tzANcL/S0a8x12XGriNvgAfd7
         qQdk2rGHaWmKJ09iDiX+Ph8gWznfXaJQz+NvlPuK4tg8hUKLQzjRA2Kc8cSipZb01NY7
         eAWoS3uWXXnRJ439fpKiUeJsmVB3H+pkGarQ1YHMSZKC3tU22f4qH/hgbZAy/zErQ7W8
         NzjzGFH/18BVnUeW7ePzs9bSCp0LauBQagUnkbTUe+LfXZhMZkABP6RUVE7RyMLhIMdi
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0uppB9ii0pBd7MXi+uA0KCh+Kd0vDpxw6l/NwutkF0s=;
        b=rhC3IcQZpzJRKlzk/YIyx8KO/DfHFhDdARKXh610/HfiIVPp3uU1tzqBfh+Lz7DKdo
         vKodCs04WEM2o4yylaMzlxN58Rk6djlQ1n4gQ7Y+0vA14bz4yggqkus5of/aISzPCCft
         OzZ/ovPUZcp2yPIQr5E9mzaDjuPPv9OgVib9VmEDR2CrlD4T+pTqHOVjFSruhuAGy68g
         Mzcymnhkhc5GRQkRcyfZVliAzoIKTM2Pb6IrE2BARluTbzTOyIJKgq0YaYJsfQPJMis/
         CWvziQOqvmKOLy6X/uvLtAhspWLaew9NN8kxDtFdC93j8jBtWE9dz49CWjkbcKHZ/Csn
         lRsA==
X-Gm-Message-State: AJIora+qPQ7mlUOtTPAbkLyRSePJHW/PWh78Ej++bTv3VAE7NXQ5cwNF
        aXJmjabM0f+gb13LwpoB/Q==
X-Google-Smtp-Source: AGRyM1t88mNCQuFnccSlpGOSCk9jgtxhHZcG6Sh8zLF13Wlmgeyxvv/qTSUsifWO8aJvXQitrAdhGg==
X-Received: by 2002:ad4:5e8b:0:b0:470:2e7f:ac1e with SMTP id jl11-20020ad45e8b000000b004702e7fac1emr9098439qvb.3.1656550722148;
        Wed, 29 Jun 2022 17:58:42 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id ca12-20020a05622a1f0c00b00307c87b8239sm11545690qtb.46.2022.06.29.17.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:58:41 -0700 (PDT)
Date:   Wed, 29 Jun 2022 20:58:40 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220630005840.s65j5vab6j2dsyq2@moria.home.lan>
References: <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042610.wuittagsycyl4uwa@moria.home.lan>
 <YrqyiCcnvPCqsn8F@T590>
 <20220628163617.h3bmq3opd7yuiaop@moria.home.lan>
 <Yrs9OLNZ8xUs98OB@redhat.com>
 <20220628175253.s2ghizfucumpot5l@moria.home.lan>
 <YrvsDNltq+h6mphN@redhat.com>
 <20220629181154.eejrlfhj5n4la446@moria.home.lan>
 <YrzykX0jTWpq5DYQ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzykX0jTWpq5DYQ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 30, 2022 at 08:47:13AM +0800, Ming Lei wrote:
> What is the difference between bio_set_pos and bio_rewind()? Both have
> to restore bio->bi_iter(the sector part and the bvec part).
> 
> Also how to update ->bi_done which 'counts bytes advanced'? You meant doing it in
> very bio_advance()? then no, why do we have to pay the cost for very unusual
> bio_rewind()?

Yeah, we'll have to add a u32 to bvec_iter, and increment it in bio_advance().

This would us everything we want - you'll be able to restore a bio to an initial
state and you just have to save 8 bytes, not a whole bvec_iter, and unlike
bio_rewind it'll be safe to use after calling submit_bio(), _and_ it solves the
problem that stashing a copy of bvec_iter doesn't save state in integrity or
crypt context.

> Or if I misunderstood your point, please cook a patch and I am happy to
> take a close look, and posting one very raw idea with random data
> structure looks not helpful much for this discussion technically.

I can do that...
