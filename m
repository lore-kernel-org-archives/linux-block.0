Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiDLV0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 17:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDLV0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 17:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D344018A3CF
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649797509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSGlSFmkV0dQpkxytbOFilmxcRdv/gtOoUcqeFDKH3U=;
        b=MlzMACl03MZB834aLxWt+8b+fIkiCwhQkaRUENj7HBYaqAf+hs70SLobIXcFnPe6ZXlHsI
        vYUb92jN2RVM980yOBawDFapz4Bq039XAHf2Frb7JKoCVRO/35lRHld7X2WnTW0I2P9dAN
        WNQ8NNm+kgfFGBa0PIVdPLrs5WemwXs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-9MTeKuy8Mo2JdyLaLJLU1A-1; Tue, 12 Apr 2022 16:52:42 -0400
X-MC-Unique: 9MTeKuy8Mo2JdyLaLJLU1A-1
Received: by mail-qt1-f198.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso15652664qtc.12
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 13:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oSGlSFmkV0dQpkxytbOFilmxcRdv/gtOoUcqeFDKH3U=;
        b=ofTDfVJtEl0OkZNeWvLhGGTlcSmagE6KnL2SBRMpXTPkrx1deUoOPgKZwksMwzDuRX
         onThyLcML7pe4wmQT2E+hHbPbKMi0GEh2JhYvGLX0cu+FLkazgUMoI4tqJWgKbDSKe6m
         llpJHRwHW0gqWZzT/oy1IT34ByIsH+OKvA/MgVbYvfn05eHFPjB45J1n5t3UcbNP/FJ0
         NwTe893qQJqO/RnhanR/CCbrOdJMHM+zj5pABvEP//yC2g3OUaOfzO3bPS2gL3JG5DnR
         NPFz95w7kdReWPupuecW0b2e3tTNDoK3wlxL3gUGYgWZHCDw1lZy7BZDHsmJti0tPjG5
         qyFg==
X-Gm-Message-State: AOAM530plAsTHOyJegYu/OI/gYGh06SlmQI/29/8K8Tr6OUkSpA9PBt/
        itAkOIlc2Wuw/L6DUprizI56V2RZx7JO8VkSFO7hJs/C35Gy6Er9NNTL8enwWoinWYdNH/gGHrT
        Ig0661s8A2iSVesOmALlrDQ==
X-Received: by 2002:a37:82c7:0:b0:69c:1612:53f9 with SMTP id e190-20020a3782c7000000b0069c161253f9mr4447736qkd.408.1649796762099;
        Tue, 12 Apr 2022 13:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbRAr69KUXZHA1hFRyE0EoPeOfDydesoZY9+W/e1MtrwpsCB2KNNv+dCQFRLorPvnzr6Oeog==
X-Received: by 2002:a37:82c7:0:b0:69c:1612:53f9 with SMTP id e190-20020a3782c7000000b0069c161253f9mr4447723qkd.408.1649796761847;
        Tue, 12 Apr 2022 13:52:41 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a064700b002e238d6db02sm28512669qtb.54.2022.04.12.13.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:52:41 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:52:40 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YlXmmB6IO7usz2c1@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412085616.1409626-6-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12 2022 at  4:56P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> The current DM codes setup ->orig_bio after __map_bio() returns,
> and not only cause kernel panic for dm zone, but also a bit ugly
> and tricky, especially the waiting until ->orig_bio is set in
> dm_submit_bio_remap().
> 
> The reason is that one new bio is cloned from original FS bio to
> represent the mapped part, which just serves io accounting.
> 
> Now we have switched to bdev based io accounting interface, and we
> can retrieve sectors/bio_op from both the real original bio and the
> added fields of .sector_offset & .sectors easily, so the new cloned
> bio isn't necessary any more.
> 
> Not only fixes dm-zone's kernel panic, but also cleans up dm io
> accounting & split a bit.

You're conflating quite a few things here.  DM zone really has no
business accessing io->orig_bio (dm-zone.c can just as easily inspect
the tio->clone, because it hasn't been remapped yet it reflects the
io->origin_bio, so there is no need to look at io->orig_bio) -- but
yes I clearly broke things during the 5.18 merge and it needs fixing
ASAP.

But I'm (ab)using io->orig_bio assignment to indicate to completion
that it may proceed.  See these dm-5.19 commits to see it imposed even
further:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19&id=311a8e6650601a79079000466db77386c5ec2abb
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19&id=56219ebb5f5c84785aa821f755d545eae41bdb1a

And then leveraged here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.19&id=4aa7a368370c2a172d5a0b8927c6332c4b6a3514

Could be all these dm-5.19 changes suck.. but I do know dm-zone.c is
too tightly coupled to DM core.  So I'll focus on that first, fix
5.18, and then circle back to "what's next?".

Mike

