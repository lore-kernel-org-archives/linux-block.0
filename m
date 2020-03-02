Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9135FC3F2D4
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 08:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6568E246B6
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="L4hx1DGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgCBIkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:40:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43600 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgCBIkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 03:40:05 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so10560450ioo.10
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jze/FNhRDKWjQlWtmwCDYRnX1I7Prg2i7AZY5w7Cpnc=;
        b=L4hx1DGIp97F0xxeWLytLuL4nJiy+neZad2J/X/6mysuwRtntVOGCZ2Z8ePsY8+2LG
         rLHYtJKJK0K+vAZPGyGiB8sSUPeybyNDaLppd6wJUqMuXS9KiTrwLqPUCfJbV+hOTtpS
         lGZpF2q/BAEDhXtBG00f0LOlfd74B18n6EXVCJ/3hA8MVmju1WIfYzG8Vw6El2w3pss+
         kYpd+jUw/qEw24KZkssrZ3iwlq0kQo7QikDqKzA5y+AATKqj3/6S+jyyRzUttVhJwKsd
         ykVpohjBaF2bh147oajPIbD53I4wxK6IyRuYi3PrcuU9Xei3nCVDRYtLwINnKKEwnfhw
         O4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jze/FNhRDKWjQlWtmwCDYRnX1I7Prg2i7AZY5w7Cpnc=;
        b=Ff7F7MXi3dopoOYonYmvvOojaWE3qTFBCep4bqA3ckb9v5xsawtQP5vEtPC2exPHm/
         fkAX2ddaa3pyvoe0EsTKuI7S2X+9nkGdp09OTjY3CB6rx1eoTFzdqY+z44G00K55mytV
         banJEoCeEKSNcSn/zYulVep3xDbkQGwwTF1asYE++pOmweyQm7cCOSvyAhEthhP9vK4l
         1IgON7/gBJ26Ai5EZvGHzYreJ9GNjSBgY0HjujgM71r2DU2HjxURejIVUBeZxzQ8DKT8
         cS62o9xVpiPUQO6Z4dD3Xvg3txJh36TNgrOtMo4+K1Axdl5AUrvzHCosrtdgoeHCcVxb
         uoqA==
X-Gm-Message-State: APjAAAVuKA/7lXohBSOsljhA6P/Buci21kd6mQi+WNmK0idIGNOogad6
        c2s8/pd51l9aGmeArck0g0cc9o2jJEWEO2FSUuunjQ==
X-Google-Smtp-Source: APXvYqwkAZnv7X7wfECu0vOH3IDGQx0c6Y1SH7wYI0ImzAr2Ut9SF0aBLXkSTjk245yZEeo6zHkpzb77qe6NwX/9Yz4=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr12431680ioh.22.1583138404966;
 Mon, 02 Mar 2020 00:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-3-jinpuwang@gmail.com>
 <e1d8d2ca-78cf-f3ee-2286-1c96e5cfefc7@acm.org>
In-Reply-To: <e1d8d2ca-78cf-f3ee-2286-1c96e5cfefc7@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 09:39:56 +0100
Message-ID: <CAMGffE=X6s0DSKL2c-AmBa6_shvJggNJ0aqCx0C9SbLh-fR3nw@mail.gmail.com>
Subject: Re: [PATCH v9 02/25] RDMA/rtrs: public interface header to establish
 RDMA connections
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 1:31 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > +/**
> > + * enum rtrs_clt_con_type() type of ib connection to use with a given
> > + * rtrs_permit
> > + * @USR_CON - use connection reserved vor "service" messages
> > + * @IO_CON - use a connection reserved for IO
> > + */
>
> vor -> for?

right, will fix. German version -.-
>
>
> > +enum rtrs_clt_con_type {
> > +     RTRS_USR_CON,
> > +     RTRS_IO_CON
> > +};
>
> The name "USR" is confusing. How about changing this into "ADMIN"?

Sounds good.
>
>
> > +/*
> > + * Here goes RTRS server API
> > + */
>
> How about splitting this header file into one header file for the client
> API and another header file for the server API? I expect that most users
> will only include one of these header files but not both.
The initial RFC, we did have 2 separate headers, one for the client
and one for the server, due to the fact most users
will only include one of the headers.
https://lore.kernel.org/linux-block/1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com/

Later we've made rtrs can be more flexible, in a way user can load
client and server on the same server at the same time, and both
headers are merged to one.

I appreciate your feedback, thanks Bart!

Regards!
