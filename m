Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A1C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 12:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0A9215A4
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 12:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqZ5RFtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbgE1L76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbgE1L75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 07:59:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD2C08C5C5
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 04:59:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so32995821ljo.5
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmUDbRdWnFX3Rob4B0QvCGfA3VJF+c7F7awpUudj+ms=;
        b=IqZ5RFtIvBjwnF1oMxfDsISc3/SF4HRrGWAVls6NFHl9jYWj5LhLFY+T+P/SLCDs/P
         Kj/LUDgERqB5366gEneqW0blH5AzlNjmQXcGhmp7spRhFlumHJ4m0Esqlgvq4at9sUcH
         eV92SEgJ7wyidXnCw9zbikM9VIDGIxDvAJDmqW+5ZTNxXDKrWBJ9NqeV1FhETBRDIiD5
         EzVI/QKFOk+c8HoZDbuWlftmetLHYNIIakPAkN9beIBq4x3CWhLW71Sx7oXtU4cTXl//
         JORy8FG5YOPaf3+0mhl9VRiQdUw/KITQNQvBpbziB03HaUtPlTJ8AvDecEgbfPc8uNuT
         JboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmUDbRdWnFX3Rob4B0QvCGfA3VJF+c7F7awpUudj+ms=;
        b=FXgLcIb0hZrC64W46RZQpaoAYe+A9RqLga8qvHqJCtN25gHmpJZJ/JUacO09RFzzz1
         emzcva/l20kwrXMN8En1uzTp81ym2jeSzI3wz+0Gjxv+mlk1tYkspKouOparmt4s4f2Y
         TZBSych8e4V3IY9qyIG+O8Umx1X5XkMa1fBqYJaDxMMqknoU5mzD6igregTSyQOFB1Yc
         tSWoREvtEbeD7c39/j++ehR/TJfODDH2RtPhCai5vJEGU68bApNl/fBrOOkuD7IzslFR
         9da9ks/herpRW7JCB2fxONr1m/rvDNK6Q1NKSDOIaRLOlEe1u643Etwh3K9q8Xui7QC6
         gEgQ==
X-Gm-Message-State: AOAM5317uP3j2aghVxiez1V+taN0jemlptfwSUpHBPImHYWNqwBCO0lz
        dCxctc/aTegM31QKh3lnYWBWyc4Ch9PbeXpwatcgGQ==
X-Google-Smtp-Source: ABdhPJw8GtTv+/sAxbto1YqqIvEBT46TYNkrZQQEeMUqRroN1vTaBL4E2sPM8eYDKji+VyijdekgVQK1D3k+XjeoHAA=
X-Received: by 2002:a2e:3818:: with SMTP id f24mr1244505lja.338.1590667195145;
 Thu, 28 May 2020 04:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200528081003.238804-1-linus.walleij@linaro.org> <SN4PR0401MB359826C471B9D331DC79E4EE9B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB359826C471B9D331DC79E4EE9B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 May 2020 13:59:43 +0200
Message-ID: <CACRpkdYXaq-JQ=buuSgFOT=DbqS7xsb0iXfc5aFYjg36hB2fTw@mail.gmail.com>
Subject: Re: [PATCH] block: Flag elevators suitable for single queue
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 10:26 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
> On 28/05/2020 10:12, Linus Walleij wrote:
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index b490f47fd553..324047add271 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -794,7 +794,8 @@ static struct elevator_type mq_deadline = {
> >       .elevator_attrs = deadline_attrs,
> >       .elevator_name = "mq-deadline",
> >       .elevator_alias = "deadline",
> > -     .elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE,
> > +     .elevator_features = ELEVATOR_F_ZBD_SEQ_WRITE |
> > +     ELEVATOR_F_SINGLE_HW_QUEUE,
>
> That indentation looks a bit odd to me but for the general concept

Yeah it's what the EMACS default "linux" indentation suggest if I
put the flag on a new line, but I can adjust to whatever the block
maintainers suggest.

> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks man!

Yours,
Linus Walleij
