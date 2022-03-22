Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B778C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 00:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiCVASb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCVASb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 20:18:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717CC63AD
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 17:15:49 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s25so22020965lji.5
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csvJ0QvkeDX9zhaH3ynhXpLSXNMu2MD5+Co07Dq20kM=;
        b=WrI+JXUpOR6988UTRR43/d/5SpiOnCk94apAlrMoAxFTcVfdSTgZRTsfAQlZ3vATU0
         /iqRtxTQemfTxCIIXXEOeHbGVLbqiPApRQWzyLoJMGDA7hXy75BKh1IVDDLAT2/SWlPb
         egjcZygj11BpczvpnzvbN58n7B8Jd7lkgSvNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csvJ0QvkeDX9zhaH3ynhXpLSXNMu2MD5+Co07Dq20kM=;
        b=TMcoct2knOJQ1TUKz6LupX3hz1YqzCrClb9atYWqIIOh+081SPHd6BHaLdB/dJqmtx
         6YLMdy+2HjX+kRtUOloeqVMR2ZxZp326uPkiiUYTHD59LwOB19gMPzxP1Bq7oL46fCqS
         /PYvh7YeL39kb/VISZVTfM8Q2Ohb/0Mbx6/HXFgWcFVMSQC62ZDQZ4cBNl8BwWLaaimI
         OQQJ3H3/FtEFGTcaesj+r6A4k37DiDv3bcwhWqnJkSiJ3TvUVUxQYcgloMmbaTQfBlQc
         aFW2iK4GCYYFHAEMZBVqLBN6zXKj/Z6UCXkvKEULBNiN4Rfc4wQI4DCAptWrv7xYTF0i
         NZMg==
X-Gm-Message-State: AOAM533kn+5/IvqdLdFdBKRegR2noCYLR/0SV6lreOYFeC9Ha+ZaOPTU
        UZVukaOyFQuIRosQ8I1KmCHCnqC3Xn0JzNcLDsg=
X-Google-Smtp-Source: ABdhPJzRUGuNqTv3hx/rvhDqNTjsTiSjqujeu2UgvPYcwLCOfUTo33/+Zt9BECAyUA6+Y9kZJwvHww==
X-Received: by 2002:a2e:8853:0:b0:246:179d:7638 with SMTP id z19-20020a2e8853000000b00246179d7638mr10787351ljj.186.1647908043544;
        Mon, 21 Mar 2022 17:14:03 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t5-20020ac25485000000b0044833ffc127sm1960243lfk.185.2022.03.21.17.14.02
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 17:14:03 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id w7so27196937lfd.6
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 17:14:02 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr16058452lfs.27.1647908042714; Mon, 21
 Mar 2022 17:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
In-Reply-To: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 17:13:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXy_WR5=z+tWFY8NiuXtwfnOC5cOZeFN41MjBGcG4tsg@mail.gmail.com>
Message-ID: <CAHk-=wiXy_WR5=z+tWFY8NiuXtwfnOC5cOZeFN41MjBGcG4tsg@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver updates for 5.18-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 18, 2022 at 2:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> This will throw a merge conflict in drivers/nvme/target/configfs.c,
> resolution is just to delete the two discovery helpers and the configfs
> attribute, basically everything in the conflict section. This is due to
> conflicting with a last minute revert in 5.17.

Only because I looked at this conflict did I notice that some of the
changes are kind of pointless..

I mean, this is well-meaning, but I'm really not convinced it's
actually *useful*:

  -   return sprintf(page, "\n");
  +   return snprintf(page, PAGE_SIZE, "\n");

It's not like a two-byte copy can ever overflow PAGE_SIZE.

Sometimes 'sprintf() -> snprintf()' conversions don't really buy you anything.

                Linus
