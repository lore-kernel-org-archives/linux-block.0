Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B15C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 14:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382162145D
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 14:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tvw1uced"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEVOsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgEVOsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 10:48:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F6BC061A0E
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 07:48:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z80so10990829qka.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3w51OvGuo1KHhLeM7yFgelFdqmJRy1oB37C+DpHIeKU=;
        b=Tvw1ucedIP3sqfOTo40QuzKzcGdZ+N3DZVgR6fFa45SbTPiDIv07yyRGprYcSo8vMN
         pl6Ckae9iVFITmQJaKpk/IA+s+NZzl7LAW6H6sZ79UklbeV3zo3pFOHiVBKYIoMRDi29
         qMMuVIwS6rsUlEsNXYv/0LpItYKlgNhYIXzoc5SAPCVxqHSb+yAbC6MXlA0gGASOj+CN
         2c7I9h7kkenLAJixeaMkxwHZRnnke91WrQsnlya/7NHkVKNJgO5cM5O5BdWJVDqTv9EK
         P+RTbfB2BoVMXodN2Olw+E+v1Dv/3WSDDi7pm+YiXRn3BR0Y8mXspUYYb7WHFOGe02Aj
         6hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3w51OvGuo1KHhLeM7yFgelFdqmJRy1oB37C+DpHIeKU=;
        b=MHHFf9HmVv0XqovOL5vPs8KcncMbht9IFYQYNvJvuSfk4hEomaIIHUfr4kqd00axMy
         uOE/W1PCSpbRahnv/6RVl2jNCkJDlYd2YWTSKUz+MKWyViBPueQaFMPTcvYfPrD4ampF
         h0mDLL3dr8mrIjZ4AayguErwWAB0sJMy41ZAfEX6IzP4oxSsWk0MTUIsN2I4OfcWfHXf
         mO/qe2J5ISbs02CWa/4629o5Gxp9K47iMNug2BNzvevG6rFOPP0eTQ0F9q4N88qsc86b
         Y0tFueS4qJPFwD2RLM/SacO6dQmcbgo9u7AzvDn00CgMBHAQXpTl6v423XgV5en5FCfe
         OHPg==
X-Gm-Message-State: AOAM530wwgqGRG+fyIeYEhtKz3orGY1EosVINFobi1ZMmeu5splk3bom
        kR15k+rPuzFVSuiGYCzSUSf+0ODx2wc=
X-Google-Smtp-Source: ABdhPJwQVp2Xt0p1QXcBq+r65J1vD2fl8hbMV/jpPpahXkLWYOPThtrPHx7nM5zzTwcHCiSKaQ5RnQ==
X-Received: by 2002:ac8:4e8d:: with SMTP id 13mr8288900qtp.169.1590158912275;
        Fri, 22 May 2020 07:48:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c63sm7108459qkf.131.2020.05.22.07.48.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 07:48:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jc8yN-0003KD-9I; Fri, 22 May 2020 11:48:31 -0300
Date:   Fri, 22 May 2020 11:48:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] block/rnbd: Fix an IS_ERR() vs NULL check in
 find_or_create_sess()
Message-ID: <20200522144831.GH17583@ziepe.ca>
References: <20200519120347.GD42765@mwanda>
 <CAMGffEnuk2WfWmwjKy_Sqcuf_xKwzrPpE_o8j3nHM30ADr8HVw@mail.gmail.com>
 <CAMGffEmC215iOmtT_iZizey=jnbgWneE5f5zapYvdJi5WYDM1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmC215iOmtT_iZizey=jnbgWneE5f5zapYvdJi5WYDM1w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 07:13:08AM +0200, Jinpu Wang wrote:
> On Tue, May 19, 2020 at 2:52 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >
> > On Tue, May 19, 2020 at 2:04 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > The alloc_sess() function returns error pointers, it never returns NULL.
> > >
> > > Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Thanks Dan,
> > Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Hi Jason,
> 
> Could you also queue this fix for for-next?

Uhh.. Yes OK, but if it doesn't get cc'd to linux-rdma I won't see it..

Please let me know if there are others

Thanks,
Jason
