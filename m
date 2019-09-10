Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41057C3A5A2
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 07:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0829A2171F
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 07:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuYbJB1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfIJHai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:30:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46176 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIJHai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 03:30:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so5171633wrq.13;
        Tue, 10 Sep 2019 00:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YjQ9pEO5IN3psZ2ABHVrfgt0hOFSNKUPtL3mbQytPvg=;
        b=KuYbJB1rRCIA5kqatd7Bcdqgl7wRYk/4rIiK5aNj2OkYMZgQSubklvivbEQk6fJpAD
         IdDfvJuaFVILZVnYFeF2SjHd/KEOO+JH8R+D8PtkXllVzKmn8heNaBjfR8px7ylhH5sj
         SpFJc1ZqGu6deSdkR2BBFQerhDsnTIdRHtFSS5k+0B8GGHeZYo59m+f9JxrAuio59zoA
         +vXQEtgsAHatITxpJi0Khit5jrRO90dvwK27Yzw9KdBI4Gmr3u58LmOmX5srSMVZ21gv
         15dXFxt3MkO2hF1koiFjFKm0fd9nABOqa5UV/n99BGgGEglOaD8RFYbPtvoHAKDzfogz
         tehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjQ9pEO5IN3psZ2ABHVrfgt0hOFSNKUPtL3mbQytPvg=;
        b=Ucgn/8kWhRV2Li2id5o5MGCUM+sfdsOAxVZ/0xQoGF//pURZsIwLV41hBIY3qQJUBt
         g1Qn7oxKuu7gsG3FcCEeSNN5kuZ0+pTk7mY2mfWxeMr7hEN/2zGoyIbT3L3VnMS7X78O
         AZrwF5oGNlWOyXnwnSm6Ee9xT8HrWm3BR8FFJEC6Vr2qXxnzY18vQxCq9iyAymLc5O1t
         RYORmoHQ5CJwqo4bEZztqG+tF1OEZePYZV9xSsPr7beQTGCnxMPnSLa7UbcrbDJw+uTb
         99H2si53OrUvl1HJ5v+SHP6zfZfqBuPY6AlezzxqYw7M2kQ+6rZP0eBZbW2HCUanFQSz
         +2Zg==
X-Gm-Message-State: APjAAAUEczDDLeEX/UkMO+PLAIeBWkCRKOjlHJSEq/IOlnf5hNlCncmZ
        jJCIdS+8Y/624aoD4lJBvDk=
X-Google-Smtp-Source: APXvYqyk9WCBITkuK7q1y6ZyAuQkn4A2Dh2xPHBmgR6dmrrJ/VU3uzRjkezzlrJG7V3Ez5tYScj8jw==
X-Received: by 2002:adf:84c6:: with SMTP id 64mr23817863wrg.287.1568100634650;
        Tue, 10 Sep 2019 00:30:34 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id m17sm18275651wrs.9.2019.09.10.00.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:30:33 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:30:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190910073032.GA12537@ulmo>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
 <20190909125658.30559-2-thierry.reding@gmail.com>
 <20190909161331.GA19650@lst.de>
 <20190909191911.GC23804@mithrandir>
 <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 02:03:17AM +0000, Yoshihiro Shimoda wrote:
> Hi Thierry,
>=20
> > From: Thierry Reding, Sent: Tuesday, September 10, 2019 4:19 AM
> >=20
> > On Mon, Sep 09, 2019 at 06:13:31PM +0200, Christoph Hellwig wrote:
> > > On Mon, Sep 09, 2019 at 02:56:56PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > When enabling the DMA map merging capability for a queue, ensure th=
at
> > > > the maximum segment size does not exceed the device's limit.
> > >
> > > We can't do that unfortunately.  If we use the virt_boundary setting
> > > we do aggressive merges that there is no accounting for.  So we can't
> > > limit the segment size.
> >=20
> > But that's kind of the point here. My understanding is that the maximum
> > segment size in the device's DMA parameters defines the maximum size of
> > the segment that the device can handle.
> >=20
> > In the particular case that I'm trying to fix, according to the SDHCI
> > specification, these devices can handle segments that are a maximum of
> > 64 KiB in size. If we allow that segment size to be exceeded, the device
> > will no longer be able to handle them.
> >=20
> > > And at least for the case how devices usually do the addressing
> > > (page based on not sgl based) that needs the virt_boundary there isn't
> > > really any concept like a segment anyway.
> >=20
> > I do understand that aspect of it. However, devices that do the
> > addressing this way, wouldn't they want to set the maximum segment size
> > to something large (like UINT_MAX, which many users that don't have the
> > concept of a segment already do)?
> >=20
> > If you disagree, do you have any alternative proposals other than
> > reverting the offending patch? linux-next is currently broken on all
> > systems where the SDHCI controller is behind an IOMMU.
>=20
> I'm sorry for causing this trouble on your environment. I have a proposal=
 to
> resolve this issue. The mmc_host struct will have a new caps2 flag
> like MMC_CAP2_MERGE_CAPABLE and add a condition into the queue.c like bel=
ow.
>=20
> +	if (host->caps2 & MMC_CAP2_MERGE_CAPABLE &&
> +	    host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
> 	    dma_get_merge_boundary(mmc_dev(host)))
> 		host->can_dma_map_merge =3D 1;
> 	else
> 		host->can_dma_map_merge =3D 0;
>=20
> After that, all mmc controllers disable the feature as default, and if a =
mmc
> controller has such capable, the host driver should set the flag.
> Ulf, is such a patch acceptable for v5.4-rcN? Anyway, I'll submit such a =
patch later.

I'm sure that would work, but I think that's missing the point. It's not
that the setup isn't capable of merging at all. It just can't deal with
segments that are too large.

While I was debugging this, I was frequently seeing cases where the SG
was on the order of 40 entries initially and after dma_map_sg() it was
reduced to just 4 or 5.

So I think merging is still really useful if a setup supports it via an
IOMMU. I'm just not sure I see why we can't make the code respect what-
ever the maximum segment size that the driver may have configured. That
seems like it should allow us to get the best of both worlds.

Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl13URUACgkQ3SOs138+
s6H5Ww//Q/9nSoIbiNJ3CXE5uk6Cp0mfgbhCntnfmxbLgPLT5rkqWbdHY8QOEpQF
Wo/6z7NY9rag/1WKnqSGWBkx51NANm9VRDGvd8ZCSlkoXeF+T2ijgrDp/8MG01Er
IEBIDs2Fq0GOWJw5DOf/bgKGMJBbQj+0l7Akw6Yt4npJgAZoLW6c3JQsJLFH5WNo
mRIa48vQmi0vHj1Q3EjvWXJUT6ZSRrH6QLbxET7SK5ZR7VcQARjLSm2rOHxWm/xp
l1jJDSwMNt0PALj2jEWIt8k3ECwhdj5TpBD3ZyWN5pI86+1TAZkcA8gK8mmLYrmE
VUE8z2JQoot7h3zU5yQCFp2j+XkYe+l2vRlA8l1O5+spwz4K7KnOOAlREENVMwB7
l8P4wxehftBJw0B1jnDivK3jYu2haTXWa5vF/sWsJNOi+0/RQcPAiUglJeMNARKY
PwAMZNsqdFD8UivFb2UqWP+k9iSzDIzBEp8NLjT5Yn4w+neI9KHXb3xzTCVURnla
O6LsP4zYJXtNgaQmPvvHRJy0z1SEBpee00cVO7sSskNdidEBiJ1SUqIqTtCHkV86
WNVcL3OcARFVMs5m8FuBr0jAvqPVKdDoXzdqV2oNGSoq1wpy3CRMTHC9R9a5h9jx
mVzCmY9QJkpZtXBIKwQrPNE2XFa44Dj6gFujG5JbyzEyQwgtpHg=
=VhVB
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
