Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC4FC433E6
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AC9229C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbhAKOnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbhAKOnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 09:43:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BDC0617A4
        for <linux-block@vger.kernel.org>; Mon, 11 Jan 2021 06:43:09 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q137so18065298iod.9
        for <linux-block@vger.kernel.org>; Mon, 11 Jan 2021 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Uy4dmSh1YXfPmAlEsVIKk8C/onNwMc2Qs5bzKzONEY=;
        b=IEBc0YK6atXTkF/0ep40Msod91NjmTr9cLAHeYx9ZEwhH9/ioU/Ke/2QaOxLtPTflQ
         h5+BFBVQYdQNlmztL63yL9yF/DkIS7V2iwlKHqyZ57yiGKFKpE8Z4DHqNwECA+THTqfg
         KK39n68NS76uYp4WCHPSKGCW/gZCXz8UFs/Nh+z8uxLeMskRR5ScoHWZvxzqV5kAcR7b
         kNx2p48bUJZM0tuIXW6mjHt+XYdfvQwyHKmb3zBhoNRGX6b2B3g13TphzPcLudJwyQqQ
         6kgxwhtTkNyxPxSA/XRHBsFC2o9+3zYifBIBE4/wKNhZRjV/bFn2BjQtWPS0J19LWhAh
         E8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Uy4dmSh1YXfPmAlEsVIKk8C/onNwMc2Qs5bzKzONEY=;
        b=jKv2eyG9JSFE6MD7jXl0705y3RrZzf517v/NgylrFJwFk+So8/mY02R6pdJHbYHlWS
         8RfR60H+wPYHLYFcJ4lazIFqw5fHPW5SywXUY6Y3JYXFblIxVu6TrFG5JJ2KSr6+4LVi
         VUa6f9oLjocNHhzSytvQvIB+M1G7oj0Hswnj2ibjXrkYmekhwYQ+KtUop+H6KCuBuujX
         5XdbEDhCZCp74q36ZC5zKMAL58Gp/vxxS41EjS87Nzid2Ga96Xx3JGxXg1QEowy++edM
         arS4fCB/P3m9mheSzf9vScJ7CZ4zzEgCfQvVFb+CPBIq2el40cqdyWmj2FFNRpqZQuXz
         HnQg==
X-Gm-Message-State: AOAM5331P+3duB2LRI3z1IBQ0rihiMIDk6m5o/U/rjHOrfDebwBypxTP
        /i1sAeJe77EtCqeJMU262JVLLg==
X-Google-Smtp-Source: ABdhPJyZ4N4cjirnjDbebnDeZG+f7StyYJS43ntMtcIQPUiYPQbNQdhEnL7AFHNuclaajx6Qc8gFDA==
X-Received: by 2002:a05:6602:1cb:: with SMTP id w11mr14752467iot.45.1610376188168;
        Mon, 11 Jan 2021 06:43:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id a7sm15427506iln.0.2021.01.11.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:43:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyyPS-005WSa-NT; Mon, 11 Jan 2021 10:43:06 -0400
Date:   Mon, 11 Jan 2021 10:43:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        ddiss@suse.de
Subject: Re: [PATCH v5 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210111144306.GK504133@ziepe.ca>
References: <20201228234955.190858-1-dgilbert@interlog.com>
 <20201228234955.190858-2-dgilbert@interlog.com>
 <20210107174410.GB504133@ziepe.ca>
 <76827f07-9484-d2c6-346b-0bdccfdf4a7a@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76827f07-9484-d2c6-346b-0bdccfdf4a7a@interlog.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 09, 2021 at 05:58:50PM -0500, Douglas Gilbert wrote:
> On 2021-01-07 12:44 p.m., Jason Gunthorpe wrote:
> > On Mon, Dec 28, 2020 at 06:49:52PM -0500, Douglas Gilbert wrote:
> > > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > > index a59778946404..4986545beef9 100644
> > > +++ b/lib/scatterlist.c
> > > @@ -554,13 +554,15 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
> > >   #ifdef CONFIG_SGL_ALLOC
> > >   /**
> > > - * sgl_alloc_order - allocate a scatterlist and its pages
> > > + * sgl_alloc_order - allocate a scatterlist with equally sized elements
> > >    * @length: Length in bytes of the scatterlist. Must be at least one
> > > - * @order: Second argument for alloc_pages()
> > > + * @order: Second argument for alloc_pages(). Each sgl element size will
> > > + *	   be (PAGE_SIZE*2^order) bytes
> > >    * @chainable: Whether or not to allocate an extra element in the scatterlist
> > > - *	for scatterlist chaining purposes
> > > + *	       for scatterlist chaining purposes
> > >    * @gfp: Memory allocation flags
> > > - * @nent_p: [out] Number of entries in the scatterlist that have pages
> > > + * @nent_p: [out] Number of entries in the scatterlist that have pages.
> > > + *		  Ignored if NULL is given.
> > >    *
> > >    * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
> > >    */
> > > @@ -574,8 +576,8 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
> > >   	u32 elem_len;
> > >   	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> > > -	/* Check for integer overflow */
> > > -	if (length > (nent << (PAGE_SHIFT + order)))
> > > +	/* Integer overflow if:  length > nent*2^(PAGE_SHIFT+order) */
> > > +	if (ilog2(length) > ilog2(nent) + PAGE_SHIFT + order)
> > >   		return NULL;
> > >   	nalloc = nent;
> > >   	if (chainable) {
> > 
> > This is a little bit too tortured now, how about this:
> > 
> > 	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
> > 		return NULL;
> > 	nent = length >> (PAGE_SHIFT + order);
> > 	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
> > 		nent++;
> > 
> > 	if (chainable) {
> > 		if (check_add_overflow(nent, 1, &nalloc))
> > 			return NULL;
> > 	}
> > 	else
> > 		nalloc = nent;
> > 
> 
> And your proposal is less <<tortured>> ?

Yes, obviously checking something fits in a variable is less tortured
than checking the result of math is correct.

> I'm looking at performance, not elegance and I'm betting that two
> ilog2() calls [which boil down to ffs()] are faster than two
> right-shift-by-n_s and one left-shift-by-n . Perhaps an extra comment
> could help my code by noting that mathematically:
>   /* if n > m for positive n and m then: log(n) > log(m) */

One instruction difference seems completely irrelavent here.

If you care about micro-optimizing this then please add a
check_shr_overflow() just like we have for check_shl_overflow() that
has all the right tricks.

Probably:

input_type x = arg >> shift;
if (x != (output_type)x)
   fail
return (output_type)x

Is fastest.

Jason
