Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEEC64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B98A207FF
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omjzs4OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgLANXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387439AbgLANXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 08:23:24 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3CC0613CF;
        Tue,  1 Dec 2020 05:22:43 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so4069712ejb.3;
        Tue, 01 Dec 2020 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uADe8pIjhPSuCRhZ6wL+nTegabcP2vd7po21w3/KsKc=;
        b=omjzs4OIh0H0sHYUNmwiXYUGGpzCAAS6J/sItDiufcNI3jka57fonKBcXPHYZ7EC3w
         AqLZcIzbTeNVW0c2I3+JFfvc8LbaA+N3OSA5kU5bLEsXHk7ey8xXeITb4y8BDGmkSuEX
         hnhkY9dSxfZLgLIQnczOR5S5HMKm+X7Jv0afzHvs4nlyr69ybrpO7EVWh6s6RZgB6Mkn
         lYmSW2uOOaAeRQOm0KA1q31X9cNYK3/WEn63GNDPTPmca1DLBuO2Blex+UBkVzSy+0K6
         4Qu2amZVXcEhnwiECDLa3n03Q3H8ZM/P0xJKQl1pedcKaAHTPsyAzDhlUOPYREoTmZhq
         HEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uADe8pIjhPSuCRhZ6wL+nTegabcP2vd7po21w3/KsKc=;
        b=He2rSKGBQeFPu0KqEoMcq2WddMQV9p2cfLqkjK8DzIkwPpadwUhXRsPyHKAdVAwKAB
         plkcwt2NuixdrpLmgCqMvUvcTU+GNehHaVzUZDL3ktF2ztHAl8Gud063KvVmpZyOdZjq
         yOXAYnTyKAh6RiL1OTt/fcl9ztjm6nvEX7p4Fl0k6LD2R5A7Lnn7FlgVB1BXfia7Wmmy
         BeGtEfMWUVce2K5dNL6rPj0Ll0W1/qqGfi7Kfe3+7ekHHWsYkC+RmUGpZBnf6akb0g8L
         Wefo9e7xDBQorurw7Q3E73ASbAYO0fnFKtTWD7Sl5WbutgNHEzvO3krcEkPw3lNbStPC
         6Frw==
X-Gm-Message-State: AOAM533vzThRWXU0145afIoblfXijkrlesvBCKzQnRvVVZqrNXjaD1rD
        oGy4+ILG0lRlRHPcBl6dYEJwuyAKOm2MLMIkTPU=
X-Google-Smtp-Source: ABdhPJz0oX8n58WEDpkBVOtEEmsqhZFkHTca/aDr4LQ7oluH4avRguTL/Swrpq6KXGmBFui3PPL0bTwu0E0hx+11DBY=
X-Received: by 2002:a17:906:68d1:: with SMTP id y17mr2997597ejr.447.1606828962469;
 Tue, 01 Dec 2020 05:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
 <20201201053949.143175-2-selvakuma.s1@samsung.com> <942255077c7caf5a2b1983570e30c3bf06410f62.camel@mail.ru>
In-Reply-To: <942255077c7caf5a2b1983570e30c3bf06410f62.camel@mail.ru>
From:   Selva Jove <selvajove@gmail.com>
Date:   Tue, 1 Dec 2020 18:52:28 +0530
Message-ID: <CAHqX9vantopwsTYLNh92uaVaP_vOsbB0O-XgMSEjdKUsRk=gFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] block: add simple copy support
To:     Aleksei Marov <alekseymmm@mail.ru>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        Damien Le Moal <damien.lemoal@wdc.com>, hch@lst.de,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
        joshi.k@samsung.com, javier.gonz@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for reporting the memory leak. Will add a fix.

On Tue, Dec 1, 2020 at 3:58 PM Aleksei Marov <alekseymmm@mail.ru> wrote:
>
> On Tue, 2020-12-01 at 11:09 +0530, SelvaKumar S wrote:
> > +     ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
> > +                     &bio);
> > +     if (!ret && bio) {
> > +             ret = submit_bio_wait(bio);
> > +             if (ret == -EOPNOTSUPP)
> > +                     ret = 0;
> > +
> > +             kfree(page_address(bio_first_bvec_all(bio)->bv_page) +
> > +                             bio_first_bvec_all(bio)->bv_offset);
> > +             bio_put(bio);
> > +     }
> > +
> > +     return ret;
> > +}
> I think  there is an issue here that if bio_add_page  returns error in
> __blkdev_issue_copy then ret is -ENOMEM and we never do bio_put for bio
> allocated in  __blkdev_issue_copy so it is small memory leak.
>
>
