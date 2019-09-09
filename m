Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D8FC4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B14218AF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIyQMR9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfIITTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:19:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34534 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfIITTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 15:19:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so5622792wrx.1;
        Mon, 09 Sep 2019 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r66d4BYEgHUxOR3huNv8G+gUhZfgwceZJlB7X7E2Auw=;
        b=IIyQMR9Z3PNc7WMmpLhX14tESPk15ABwQuTI15q0vFFQgM4JmzoAi/RLhycSkEyQKW
         +c3keZ+xqURPEQGloh0jzRTozvYGj94eFfgsL51dtm+GY5y2s+r3dr78k/hPopa1lF0H
         MU17MYNzkLRBIda57peHvR3hH6wgN9KxyfVWlD89tuPPHFsxXEDi/JQ1PXU2VeR531X7
         gBQoYa2FqowVyd86rfxGpgcPs5FMlopHalmWz4B9KqAelY/1CxslNNPhg1nDGcW8w7xl
         LWMxwPHxHnzmgwaYGy+Q3G4dfq7kNKmpB4J6ssytL91K9oPnCnNflWcJxSXGgahLzypG
         o70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r66d4BYEgHUxOR3huNv8G+gUhZfgwceZJlB7X7E2Auw=;
        b=Rc6HpKt1Mb/j36T+aMvNJR1xX+EGHh5ruQyOqOgS9qScBDukPDUDczOPAHeQ/4tdzE
         wdfc98++wC7AbruMWojm7QnzOFh4uk19UOvCeGlFBAH58ednEojEBPCEEPZaFSetJLu/
         /mLNk/Oifs0LyuHtl8sm8t0XFsGWcU/IDgWBB1Om6E3W+Gpq7plqQ9IVG7Mvt3RhTXYI
         gdHr4SwIwmqgm6VVIR0L5y/dAYCMqGkDPA90AdRVWUYQ6k0s+dREj+JH1foKEj7RFU95
         uFAsOOxm3VGaWaYHFjzhchPO/Zz9l1uSsMFhxaAmdFlxdv8scw4gELMk/E9z/UKsifLf
         /jfA==
X-Gm-Message-State: APjAAAWZ6SLB+kbDECfcqVcVtdLzEAYHxyAOGiS6Ki6yDhC7FaVyJsKt
        WAwqrVODeXOnbyYO9RAYVodnyMWt
X-Google-Smtp-Source: APXvYqxzb5qbwmdG9sJb6tMns3ACZ8bACZQPb/aD3Wgpte3mQ5QZNm7HEjrNYRG9ihan4YFQ48Bv7w==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr19476713wrq.238.1568056753698;
        Mon, 09 Sep 2019 12:19:13 -0700 (PDT)
Received: from localhost (p200300E41F12DF00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f12:df00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id 74sm497052wma.15.2019.09.09.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 12:19:12 -0700 (PDT)
Date:   Mon, 9 Sep 2019 21:19:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190909191911.GC23804@mithrandir>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
 <20190909125658.30559-2-thierry.reding@gmail.com>
 <20190909161331.GA19650@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20190909161331.GA19650@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2019 at 06:13:31PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 09, 2019 at 02:56:56PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > When enabling the DMA map merging capability for a queue, ensure that
> > the maximum segment size does not exceed the device's limit.
>=20
> We can't do that unfortunately.  If we use the virt_boundary setting
> we do aggressive merges that there is no accounting for.  So we can't
> limit the segment size.

But that's kind of the point here. My understanding is that the maximum
segment size in the device's DMA parameters defines the maximum size of
the segment that the device can handle.

In the particular case that I'm trying to fix, according to the SDHCI
specification, these devices can handle segments that are a maximum of
64 KiB in size. If we allow that segment size to be exceeded, the device
will no longer be able to handle them.

> And at least for the case how devices usually do the addressing
> (page based on not sgl based) that needs the virt_boundary there isn't
> really any concept like a segment anyway.

I do understand that aspect of it. However, devices that do the
addressing this way, wouldn't they want to set the maximum segment size
to something large (like UINT_MAX, which many users that don't have the
concept of a segment already do)?

If you disagree, do you have any alternative proposals other than
reverting the offending patch? linux-next is currently broken on all
systems where the SDHCI controller is behind an IOMMU.

Thierry

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl12pa8ACgkQ3SOs138+
s6HrWg//aN5PxrCWIsl0Y2QXlqhiL+PeVvdDm9nf8/CdONMVuGetb/xY/jQ7JMRx
I3RYYhHauxPMMLUxVloENIXnfjv005SaAE2TFhQ1oLxNomS/75KC+26920kSGwHg
zV8QHyu3uFiqdgkQLunbPs5PVQky7YTVqT/HTTl5XHkLnrsQyj+x00kayTmVjtPy
QmqqRJZsJ0G77ewpGXJT3edhMLqkmWF5s3ql0vB+8d+KObr4msjn7bl3nvp09sNN
n7ilt0f/qRZDWQKrVAMKMkOs9Ip8nZXPhkCVzTxST6cDrefMhDyED644IETl+HiI
1bRB+d1nJXg4gjsAFCrGCz4WdUcYOtVQ8CQJnkX9Wt5N2Zq/Mc9/VWU++C+Fb0sU
xkPPBOZaI9fKYe0pe9QR75iKD/bKEf8+p9gxjZV04QHW7zrsUhmEWyFmtuDwHsTa
Hkx8LNEp8sK96ly7nG8oYVGG7kvtpXWZCxk1WRrVw6MZdKb3rmF7AlTMlO3zntTQ
nsWYgX/SE2b17ckXWQQAlKjXeHFj2ax/E9bOzChAcsh/5DtQQXHOkKIQO6dmGNCQ
koleIlK0eAS0xY3cH5Bt5OlrmWMwCpb8pQ5t/gudb6Gs56aMGUOnXBg5SoVmnNvD
EJdRvM6EszKzeuQ6MNmsvwBw7+drIAHS1cmNITKBmiKWmnd+eHQ=
=Gpqn
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
