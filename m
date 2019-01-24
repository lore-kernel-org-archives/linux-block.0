Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE6C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409A3218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwdQRNeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfAXQik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:38:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43560 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAXQik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 11:38:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3236021pfk.10;
        Thu, 24 Jan 2019 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TWnz2BebD+itGPPRJAiL79afMiIId7AbrdNVBzKwVKU=;
        b=rwdQRNehLJrUB6NzEvStL38UMdLW4QUfr3LPC/4texP7c6g/ufGtRr7Eq5L4xGavYk
         XkuZ87ACPed+dxOhWqrrGiPQDwvNEysv40Cb7fISnhnmG6QUrtf9zr1vOySC7KcrISVq
         43iJfekVkhCj2gRrdaHi1FfU14EGcLi0eRmJa1wr1uAtQOVioOaKKxM+1ag2pG1KE6Lu
         DxXYLh0SutkprLqxSL4PWkJQh0wBp0onBDwJacvIuMXXrwZ+uKDV4v2Lpp1M87HxH22D
         yIanzDpBPtLy6p8kEvbZau/alvjdTwcEEksbdxyx1dE9ANVP52YUyuG1zpFMT7QNTYyi
         KYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TWnz2BebD+itGPPRJAiL79afMiIId7AbrdNVBzKwVKU=;
        b=o6u1z7z+Qus+8B1lXALzxBYcKiJRGBgyXvLLKoUHwCrdVXtZdrAB7kzeMV0vMI0P4c
         0sIDu2Eyed/atfCVM7zR2+8cf5a7yySEi4rDM1jSOe7PkOMxE27Zno721zUIgTAX5PTa
         uWFO5wZZ/hyOyG57uW73EDXiJw/r2IAJ/M31vpnaVJApUJNbUim83RR2fIGaXXrg7QG/
         jcfpfpV8p1oTdOuU1X/yTbpkpDf4piYFu0M/5dXq7ilZDvP/VjosALdrdM+szuoc7EEB
         LYPlZkhBW5k3dimKF5Da/s0esGWHt9AKBguc0OlKF1Q7GSjb4I0Iyg0q6PGNKw+PQNg5
         4Vcw==
X-Gm-Message-State: AJcUukekBj5Lt8aDfPlQ0Q0ksRZPkq/xu7fct+Q1WiUNwBF8lxtw+2wy
        AsSsCz9wERxv0Qi9aA0q6MoPU/zoTdz4ll0JVBU=
X-Google-Smtp-Source: ALg8bN5YgUtMMS5NwPaSd6ZiN/0oQTTo/U/o3XC7Og4DkFDSZq3nnRpidfDMZT+tsy3C/VCJzhM4Be0p8MUO33PenYw=
X-Received: by 2002:a63:3287:: with SMTP id y129mr6555650pgy.337.1548347919934;
 Thu, 24 Jan 2019 08:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20190110143051.52305-1-andriy.shevchenko@linux.intel.com>
 <20190121084732.GE18680@lst.de> <20190124121659.GH9224@smile.fi.intel.com>
 <6D748F08-F9F9-4DFB-84DF-63E97C691013@javigon.com> <CAHp75Vf4ndBaS6BjAM==7csYB9EYDvjV9jT9C6kioDryzb_HnQ@mail.gmail.com>
 <9E0FD459-75F2-4EF1-9310-8FCDF6F87604@javigon.com> <CAHp75Vfd=B-AP=7KNFiDU-qER9BjB0Qw9Lyp+hb8x94NfQiZyA@mail.gmail.com>
 <5FF168CC-9372-4DE5-BF62-DD3A2EE08384@javigon.com>
In-Reply-To: <5FF168CC-9372-4DE5-BF62-DD3A2EE08384@javigon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 18:38:00 +0200
Message-ID: <CAHp75Ve1BUr1hHWhhHfr0nLCzj0ERbocrn27K_r=mpePYppjtw@mail.gmail.com>
Subject: Re: [PATCH v1] : Switch to use new generic UUID API
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 4:36 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:

> It is not pushed anywhere yet, but I have been working on a tool to make
> a pblk recovery tool to enable FTL repairs if something fails in the
> kernel recovery path. Here, I use this uuid to identify the
> instance - is there a way to reconcile guid_t with user space, which
> currently uses the __u8?

For Linux there is util-linux which contains libuuid. There is uuid_t type.
Unfortunately there is no so called LE (little endian) variant.
Perhaps someone would need to extend the support for that.

--=20
With Best Regards,
Andy Shevchenko
