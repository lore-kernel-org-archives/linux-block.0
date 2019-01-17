Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966D5C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 15:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6716120851
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 15:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngA7FnU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAQPlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:41:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37390 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfAQPlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 10:41:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so1540104wmd.2;
        Thu, 17 Jan 2019 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ylGOrw1kiKqI28CSL2w2XLVGVsRLas1Nz8eLY7WQDA=;
        b=ngA7FnU4iftwG2EsosFJXjz1jXMi5w0jl8HCOf5EuCHXCe78k4lQ/8NiFxSveYV0uz
         vSZdly7fJHNDfbnSv3fY7F1FrQaMIDMYucDYumNWAFMqx2EyRFLBAfLGSwT3X67nI+Bg
         3QmWxUIiPTmR9FhVsWx3ZnPlNw2vmFmrLHSh69Jfb3tatsOQfnLFHKuBC+/URLr79dQi
         UZBy3HAQm6hW7fk0vexFPdHHvdBAkrSl6X8+HfyheKh6ZcuiO6sTTje4KmAB+eRvuIGR
         U8uz/yuCoS4amGqAU2CHpkm4MuLjArHq8+Q7x7qXLBs1r7sifZJ7xFYyGvHqEt4KDC5Q
         5y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ylGOrw1kiKqI28CSL2w2XLVGVsRLas1Nz8eLY7WQDA=;
        b=k7nFVltUeeSZlyPznJI/PiESlhhyjXDC0B8scPn4m2lKolbXOZunbfd2OvEZPnIN9f
         l7Goiji2xYCjg2UaEfREhRN8sF66FN7lCZmG4UTldaF1m3GKJxm5bCuZ6pJsq7kbGdNP
         Mb+HZ2l6xy8OWtJLcAPmUGq/cXWCAIBdEK5W1lmT39hLzI1lmu89eboIdvoYy8XP6Z8e
         xnCHI1mZPkxfV3tjM6J/ZWFdlj09SK9xH/g+NDNlPqfnjjLCPfnf5aUmhN4f+Yeqzk9+
         OrsAfey8eI6nzoehRHG78xLCVrjKwSsgjFvcUt3Lx9/Mbw+uAcANwSvFuwjvNiDLZPSC
         etxw==
X-Gm-Message-State: AJcUukfwgmiSq7Zj6mw4UIBTENkJkBIUMRneaV+1JL4PUML36CXv2lnW
        duDZqxUM0rceBs0qcUlg7tx19dXSdd6XPg==
X-Google-Smtp-Source: ALg8bN4Srk1oTF8EfYc79WdhHLhDH1qwN8Ewd4XD6omG1S5iZNQQAZUomC5yQkJWz9owyBmdA09Ubw==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr12701156wmf.88.1547739667382;
        Thu, 17 Jan 2019 07:41:07 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r3sm69817303wrs.78.2019.01.17.07.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:41:06 -0800 (PST)
Date:   Thu, 17 Jan 2019 08:41:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [BUG bisect] kernel BUG at block/bio.c:1833 and fail to mount
 disk
Message-ID: <20190117154104.GA24272@flashbox>
References: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
 <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
 <20190117102657.GB20220@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117102657.GB20220@ming.t460p>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 06:26:58PM +0800, Ming Lei wrote:
> On Wed, Jan 16, 2019 at 09:54:05AM +0100, Krzysztof Kozlowski wrote:
> > On Wed, 16 Jan 2019 at 09:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On today's next-20190116 I see a bug during boot:
> > > [ 6.843308] kernel BUG at ../block/bio.c:1833!
> > > [ 6.847723] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > > ...
> > > [ 7.543824] [<c044c144>] (bio_split) from [<00000000>] ( (null))
> > > [ 7.549881] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)
> > >
> > > (not much in the calltrace)
> > > On all my boards. Also QEMU-arm fails.
> > >
> > 
> > I forgot the bisect commit:
> > 
> > 258cfdfaf7bd729e759a0a91fd00ac9794796ad3 is the first bad commit
> > commit 258cfdfaf7bd729e759a0a91fd00ac9794796ad3
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Fri Jan 11 19:01:15 2019 +0800
> > 
> >     block: use bio_for_each_bvec() to compute multi-page bvec count
> > 
> > :040000 040000 d79b2e71d308650df4764ff644f29d3a24dbab96
> > 0a5d624843b805ee0c9fd9a7e2d5163f5b15b167 M block
> 
> It should be one 32-bit arch specific issue, I guess.
> 
> The following patch should fix this issue:
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index dc4877eaf9f9..4dd7183de849 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -166,6 +166,9 @@ static unsigned get_max_segment_size(struct request_queue *q,
>  {
>  	unsigned long mask = queue_segment_boundary(q);
>  
> +	if (mask == BLK_SEG_BOUNDARY_MASK)
> +		return queue_max_segment_size(q);
> +
>  	return min_t(unsigned long, mask - (mask & offset) + 1,
>  		     queue_max_segment_size(q));
>  }
> 
> Thanks,
> Ming

Hi Ming,

We saw this issue on our CI as well: https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/170724607

I added your patch and tested locally, it boots fine now.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks,
Nathan
