Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F185C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 03:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C8B20C56
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 03:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgLBDB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 22:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgLBDB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 22:01:27 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0AC0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 19:00:47 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r20so171548pjp.1
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 19:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/5Lv3JwIVKjzrJbbwScz5WzG676sOc/sz1xTytGy+Yw=;
        b=Mj2JWY0MFovy7h5MgRizMg6MKfB8srtPZE230QpQnYQfYfQFnPFTOew3tmadbP0oAL
         zdYdAbiNTZ15sXGZc5rglJXlONQOO1bmzE+syceJWc29Qg7dWP/tBUJj8pSUyDb61M6k
         dzvVrxzdwfQt6abY+zcHTR38u+8+bqYcfOxSgPJH70XLFgNn2zKr72A+3M6MMhIlLkNG
         Fz4n29Jr2VAC2D46DaijbPbb5L0yyAvFrAO2HnF5rhW4RkXHik/0Qzax4tMT3+Ia0WiY
         /T7TKM9NOlcGAjNXnbCh1YMT53zWtjMiYJVHGgAAXOTs4WbC+/DKJLYMXlU7F/b5ABFb
         UzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/5Lv3JwIVKjzrJbbwScz5WzG676sOc/sz1xTytGy+Yw=;
        b=sN1K4Fzjvx/T5wdLwCOnQHz5SKeNU70U+J9b2S6/DlvEy2FOho8KCpcHjEonWNeNJT
         cIRkHLyYK4kXtu84ypeOIuvlsEbYmnkBtVQJMTmWAKemktNm0QwavhxuOsu+Mu4p4LMK
         P7EzhqVTVbfa/C1HvyhlRTfOkD0xTs5zLsSfqvsJpgHOIZx4hJbUuUJuELLLsJmBwzg+
         DzFXjVVH2IJKBk9F0Kw82gm4WDyYRIcON5JkArRm3UHPhh0uXm877EXj38LTE80bi+uy
         boFW7V9Jh9Z7WgMc6X0G85W6DxYHAyOSPok/WulsSBM/fhzq0lvDKF7XI3UAzYR7k4eO
         udog==
X-Gm-Message-State: AOAM530zUDj080/VtMV1ada085OvZzXEvBVqOpoPSGwBo5FIcna8qpq3
        TmmKnYPmXuVEMaAXakIz+Ny5ll8xdPdV/g==
X-Google-Smtp-Source: ABdhPJynql1L8+QnTkG/5pZk0rfQUmeQ+x72YzKhV5F10/wiR7nwx+Wzhtg4g6ac7G+BMgMpKDBbUQ==
X-Received: by 2002:a17:902:758c:b029:da:a6e1:e06 with SMTP id j12-20020a170902758cb02900daa6e10e06mr552623pll.67.1606878046242;
        Tue, 01 Dec 2020 19:00:46 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id w2sm286265pfb.104.2020.12.01.19.00.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 19:00:45 -0800 (PST)
Date:   Wed, 2 Dec 2020 12:00:43 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201202030043.GA21178@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
 <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20-12-02 04:30:02, Keith Busch wrote:
> On Tue, Dec 01, 2020 at 07:57:32PM +0100, Javier González wrote:
> > On 01.12.2020 23:03, Minwoo Im wrote:
> > > > +
> > > > +	device_initialize(&ns->cdev_device);
> > > > +	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
> > > > +				     ns->head->instance);
> > > > +	ns->cdev_device.class = nvme_ns_class;
> > > > +	ns->cdev_device.parent = ctrl->device;
> > > > +	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
> > > > +	dev_set_drvdata(&ns->cdev_device, ns);
> > > > +
> > > > +	sprintf(cdisk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> > > > +			ctrl->instance, ns->head->instance);
> > > 
> > > In multi-path, private namespaces for a head are not in /dev, so I don't
> > > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
> > > like it will make a little bit confusions between chardev and hidden blkdev.
> > > 
> > > I don't against to update nvme-cli things also even naming conventions are
> > > going to become different than nvmeXcYnZ.
> > 
> > Agree. But as I understand it, Keith had a good argument to keep names
> > aligned with the hidden bdev. 
> 
> My suggested naming makes it as obvious as possible that the character
> device in /dev/ and the hidden block device in /sys/ are referring to
> the same thing. What is confusing about that?

I meant that someone might misunderstand tht /dev/nvmeXcYnZ is also a
blkdev just like /dev/nvmeXnY.  I'm just saying it might be, but I'm
fine with suggested naming as those two are indicating a single
concept (namespace).
