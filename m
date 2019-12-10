Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCEC43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7E42073B
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTiCBLot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJKZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:25:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36277 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfLJKZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 05:25:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so13271986lfe.3;
        Tue, 10 Dec 2019 02:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lg4AhAvPA2MW169lce5BVlmxb20DdD9akZ2hhy6ig3k=;
        b=FTiCBLotYFjh03wZj4knhcl8BMXBmq0zAi457bVRqn+6sc7GAOVzCj32SSKhUowk39
         S2ANnGVWu8HiwFveq4v/GT0it5Jv4Sm4Cw6YEYYjHIIv8z7ODCH/ONDyFYw3xryCuAJx
         KZNz8eUOyKp6173vQJSbNSQBI9U/u21/q8DFVvBcwNBb12hms38D6VYBJCbD0jSNolt9
         jCXg1kUrfpkD6fKz2WZJx/jLc7gy95Q5tA6mzMa4JIjleJzOzbloLczSC9mpyBblRcqo
         Gi4UxaDIVKn3aCRl/AmTyYrihS+4IqTCcCKpw8yEikIu4P77/3qmXdEVvWfES4cf7SUP
         PR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lg4AhAvPA2MW169lce5BVlmxb20DdD9akZ2hhy6ig3k=;
        b=ZULYYPBDUSehEINErlwtnX/Ewz29xY5WAs1jcaXTHUxlxrLH/pD12zpV5k7Us3k4Np
         mzpPNJWv1p+h3QNPpL3UFRmSB3LY0oJ6M1dtfBaXQmcGJ0vmRkr2bgTu1Bja6zqfgGqh
         J7Il9HMYBNc9mr0Ds8p8sG/TNbVU/wTMECBuQjxjKet+Envh2UgjKCrN1vOv+95hkdyB
         hefV/m3JewQlTOIFb28Bqc6GTqe6qWT4uas9rYMPEYbEDKysbqFe3o+ZxM5nbEw4j2u/
         jQ/3hz7e3uYZbnawFOQXznAuP6pN8X9QmUQgvwJfGqgwWj4hl/FbzvAzvoG4tByF3QQy
         4CQQ==
X-Gm-Message-State: APjAAAU+ry7XEyUkVK+ARIroNrseW3G+m2+EI8KDBQPvsj/65/7VQvcw
        99QyOz7jg3n1BrqHPrGF8fQ0ZHGqTyO/VwBV5dw=
X-Google-Smtp-Source: APXvYqzJ1n85YcM5EF1ZvSd+1TmfnkyzXyHPP1Je/JBYVDcQHyXtbVJXSpCo0J5NP1ZNn5s9enJ5G9jr2beZsSr+XS8=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr14474371lfu.187.1575973503519;
 Tue, 10 Dec 2019 02:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20191210080628.5264-1-sjpark@amazon.de> <20191210080628.5264-2-sjpark@amazon.de>
 <20191210101635.GD980@Air-de-Roger> <20191210102023.GF980@Air-de-Roger>
In-Reply-To: <20191210102023.GF980@Air-de-Roger>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 10 Dec 2019 11:24:37 +0100
Message-ID: <CAEjAshqsdjANuZDJwUnTgh3FBnhN-fp6T7-oN0hZKq8uHMDWhA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v5 1/2] xenbus/backend: Add memory pressure
 handler callback
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, SeongJae Park <sjpark@amazon.com>,
        konrad.wilk@oracle.com, pdurrant@amazon.com,
        SeongJae Park <sjpark@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 11:21 AM Roger Pau Monn=C3=A9 <roger.pau@citrix.com=
> wrote:
>
> On Tue, Dec 10, 2019 at 11:16:35AM +0100, Roger Pau Monn=C3=A9 wrote:
> > On Tue, Dec 10, 2019 at 08:06:27AM +0000, SeongJae Park wrote:
> > > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > > index 869c816d5f8c..cdb075e4182f 100644
> > > --- a/include/xen/xenbus.h
> > > +++ b/include/xen/xenbus.h
> > > @@ -104,6 +104,7 @@ struct xenbus_driver {
> > >     struct device_driver driver;
> > >     int (*read_otherend_details)(struct xenbus_device *dev);
> > >     int (*is_ready)(struct xenbus_device *dev);
> > > +   unsigned (*reclaim)(struct xenbus_device *dev);
> >
> > ... hence I wonder why it's returning an unsigned when it's just
> > ignored.
> >
> > IMO it should return an int to signal errors, and the return should be
> > ignored.
>
> Meant to write 'shouldn't be ignored' sorry.

Thanks for good opinions and comments!  I will apply your comments in the n=
ext
version.


Thanks,
SeongJae Park

>
> Roger.
