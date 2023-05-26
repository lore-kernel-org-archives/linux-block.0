Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30160C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 00:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjEZAgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 20:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbjEZAgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 20:36:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E261AC
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 17:36:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so150094a12.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685061367; x=1687653367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ9LyPTo053T3fijbdEEeajXM5b0nc+MBS0L4hj1F/Y=;
        b=TDAx+dt6pUfaSHJbf2NrRNpfsbscdpyE5E6JoZa4h0wMlat3WMbVhXEVYxqXvIp4Zn
         L/ZBdVhL4QzPQv2jjXt8wN5XNqHmUFaTb11tEOuzMiAEG/1IDCVoWbTQpGMwPMcaueNA
         vPVPOhjA71jC4smZBdAUDi9GcD9+MBWOLfpKX+2KH6wZwt3Ox8zXjLhJZl0aCXBjRLV7
         +1l5X6FhTRJmRgnmpLGr6XxF0d063vavFNvcrtoXsJt+uyXUooiUl4Ro2iGW+9UF3IQn
         JmcWT/NDBMtg9GGqV/PiUmXYkvwGfMgammbN0RNn5tBb+i9p2JitRx2i/1E2zO8ct7vE
         FC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685061367; x=1687653367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ9LyPTo053T3fijbdEEeajXM5b0nc+MBS0L4hj1F/Y=;
        b=WmwBluOXA1F36EZG6cPdm14ftxJ9IAILwXhfusnpi6dVRPqVqv4ZgKWrPyTc/fptBx
         lBQPurnpPtroThUm+MLoenmLJkd8Vnf96zqrxtQCOmYmuuaGp4rEQWXh1D9SJBMlj/Ry
         MuxqAhyqcPBrsmpvEW17B3CtdGz04+ID62c+Q+1atDUFA5g1tvgcDDe3/n6XmtOCrdsb
         RJs82/tPk9bHPyRVeMvaju1LgsVgZFylQjsrSlxMa37PPmy+LqLhxMPNQ4/Ze6A8TrxF
         u22I3EQ2Thmkb7UYRM/B6pJGpKo9y9btTYS4U6GBzZtHbmDsll8eYpa4V8sed1Ri9Cb1
         d4wg==
X-Gm-Message-State: AC+VfDydBszDAgQP+3i/BSDOp0i+FrMq9h98zx1llJoGnUK21JJwGl4A
        SBT0L0yHSwNaxvFedCRKHXeZwg==
X-Google-Smtp-Source: ACHHUZ45T530Np/DKkM/YX0mFC5+v2YjaZ7Ka9v14tyOEH74llzKzA6gQNPz0SE1MkCc9RKZ+f8wxQ==
X-Received: by 2002:a17:902:d511:b0:1af:cbb6:61ff with SMTP id b17-20020a170902d51100b001afcbb661ffmr589592plg.64.1685061367017;
        Thu, 25 May 2023 17:36:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b00194caf3e975sm1979063pli.208.2023.05.25.17.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 17:36:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q2LR5-003vd3-20;
        Fri, 26 May 2023 10:36:03 +1000
Date:   Fri, 26 May 2023 10:36:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/7] block: Rework bio_for_each_folio_all()
Message-ID: <ZG/+88/G+hX5DyCX@dread.disaster.area>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <20230525214822.2725616-6-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525214822.2725616-6-kent.overstreet@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 05:48:20PM -0400, Kent Overstreet wrote:
> This reimplements bio_for_each_folio_all() on top of the newly-reworked
> bvec_iter_all, and since it's now trivial we also provide
> bio_for_each_folio.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-block@vger.kernel.org
> ---
>  fs/crypto/bio.c        |  9 +++--
>  fs/iomap/buffered-io.c | 14 ++++---
>  fs/verity/verify.c     |  9 +++--
>  include/linux/bio.h    | 91 +++++++++++++++++++++---------------------
>  include/linux/bvec.h   | 15 +++++--
>  5 files changed, 75 insertions(+), 63 deletions(-)
....
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f86c7190c3..7ced281734 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -169,6 +169,42 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
>  #define bio_for_each_segment(bvl, bio, iter)				\
>  	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
>  
> +struct folio_vec {
> +	struct folio	*fv_folio;
> +	size_t		fv_offset;
> +	size_t		fv_len;
> +};

Can we drop the "fv_" variable prefix here? It's just unnecessary
verbosity when we know we have a folio_vec structure. i.e fv->folio
is easier to read and type than fv->fv_folio...

Hmmm, this is probably not a good name considering "struct pagevec" is
something completely different - the equivalent is "struct
folio_batch" but I can see this being confusing for people who
largely expect some symmetry between page<->folio naming
conventions...

Also, why is this in bio.h and not in a mm/folio related header
file?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
