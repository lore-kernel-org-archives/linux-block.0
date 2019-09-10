Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA97DC3A5A2
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6FE216F4
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 07:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvJLHgCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfIJHho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:37:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfIJHho (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 03:37:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id k6so5819856wrn.11;
        Tue, 10 Sep 2019 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UuJyuSukBKIezQSCqyZoPJhxZe1EDnnm86HbRJg7Ku0=;
        b=gvJLHgCTA/Urti/ZBDt2Z5z4ZK2fOV17eLPIH3uHznM1dJgsX2Y3QDBMUKRJ2GVTPX
         aEKkJxoHtDSWxE9w4zDF5TJ7uH5ObnePm+2wdvkVhN9hIFDcLV13bLDkuOHlm/rjoXcK
         HZ9Okc7Pcz6ZXV4oSmolCfmet2uwUhhsC0swtcUSfhLFWWq0CP8eCDgl6K1zRCbHjDsj
         6lVxIpMDiSCpjLvjYKEznSwiChnYficcSRonr7v+B/pBp6SvJZGF0Q46e9FmsytWg8xC
         8ocizJ53iTp7vKKi4fDow2r/plXNQUQoT/oqoGoNit9/3N7s8SuCY7yP85kevxMYC51o
         0foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UuJyuSukBKIezQSCqyZoPJhxZe1EDnnm86HbRJg7Ku0=;
        b=ubazJ6lobes+s2jG9jdJEw+rybfVLC8eyF/fQSVOtj4mmbv3O4Lo7bjOQXRMYCtD8r
         DbZa0ytCdqnwhgpq9qU86pk6dnqBZ2pqM5pm0bmuHZSSJPU7SaE33JEo1JReS9fvfUBE
         qYM/VvZzfH/Npr+B7YdWK1fCUoMYbdS937Qj6HLH+mHH44Kg442+OVelQ+zys5GJiph3
         qEFmedAKm+ABN7iazEYc+2vNNcbxcZXWSpQVIunZlM8gxwQnSUl4uncl9w5+3JmammLt
         U4F7wchjvaPBwXQ+mC4C4NBXatB/VtuUjjFwjbTW+I5IuOq6hpQBlmBzDX4gqfLktC+h
         C6CA==
X-Gm-Message-State: APjAAAWhQ9V2aUC6TolBrty5UspFjY9zHo0OORpRdgnPlcSlJXqZte6q
        T9xcvh2Ly64/auHKn/vk8aE=
X-Google-Smtp-Source: APXvYqwze146x5fIGOG0Z78pU2BlX5iPfIiaGJ5N9fO3L3GOFdp4Jw2jIiHThLb8NCAv+0cHO1oEng==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr23745284wrq.129.1568101062115;
        Tue, 10 Sep 2019 00:37:42 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n7sm16060321wrx.42.2019.09.10.00.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:37:40 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:37:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190910073739.GB12537@ulmo>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
 <20190909125658.30559-2-thierry.reding@gmail.com>
 <20190909161331.GA19650@lst.de>
 <20190909191911.GC23804@mithrandir>
 <TYAPR01MB454470364B682B9BF708E557D8B60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20190910061348.GA30982@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20190910061348.GA30982@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 08:13:48AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 10, 2019 at 02:03:17AM +0000, Yoshihiro Shimoda wrote:
> > I'm sorry for causing this trouble on your environment. I have a propos=
al to
> > resolve this issue. The mmc_host struct will have a new caps2 flag
> > like MMC_CAP2_MERGE_CAPABLE and add a condition into the queue.c like b=
elow.
> >=20
> > +	if (host->caps2 & MMC_CAP2_MERGE_CAPABLE &&
> > +	    host->max_segs < MMC_DMA_MAP_MERGE_SEGMENTS &&
> > 	    dma_get_merge_boundary(mmc_dev(host)))
> > 		host->can_dma_map_merge =3D 1;
> > 	else
> > 		host->can_dma_map_merge =3D 0;
> >=20
> > After that, all mmc controllers disable the feature as default, and if =
a mmc
> > controller has such capable, the host driver should set the flag.
>=20
> That sounds sensible to me.  Alternatively we'd have to limit
> max_sectors to 16-bit values for sdhci if using an iommu that can
> merge.

Isn't that effectively what dma_set_max_seg_size() is supposed to be
doing? That tells the DMA API what the maximum size of a segment can
be for the given device, right? If we make sure never to exceed that
when compacting the SG, the SG that we get back should map just fine
into the descriptors that SDHCI supports.

Now, for devices that support larger segments (or in fact no concept
of segments at all), if we set the maximum segment size to something
really big, isn't that going to automatically allow the huge, merged
segments that the original patch intended?

To me this sounds simply like an issue of the queue code thinking it
knows better than the driver and just overriding the maximum segment
size. Isn't that the real bug here that needs to be fixed?

Thierry

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl13UsMACgkQ3SOs138+
s6Ezsw//RAOY5Dm7us0NPQqAc1P3ojIxfsFJyMeSumdiCqsjOJvlEbtkpc6lrAYC
8Uegwj/A2AUY/6s9wt2O83mT0YvyhYQDf2P0mAblVBjLbE4cu59e9iaNqlhogD+N
Csytgz7UD/1YQL7phsUFvHMEHRhiKuqN7tjzks3wdgBqB6tXgdQnDlY1m11RxlxA
a/FGYFX/Gs9nrYNO2g9E4ugg/MCmakNr4+QkJSwdRp8DjwLIlgQteu8IrZy2V8lE
YABZ/h614f8VS8soD+LjEB462+WHHFBinc1+JXCl4962+1CQVhqBliYlsOfpf9jR
j+DGbPVSiF/cpqEJXwbsYFxBwxNty+M4OGUVwDsGmR+8oUjkIJle8b8GA3F4K9Ct
4SynmdProuSgfbUj61kk92SyVf/gGyzwCj7uRUdnEdkVOCX4Kt4eAvAoT7Mgx31V
9uemmiPzu6Cofx9oQae/qUSmsztWrM2Qop6nT44oPV84JUgwgjjTAggJu/U6wNEN
bruBJbM7kFqU8V2wzUUU6VTg4n8QPXYQk+lWHMs2hj4m+D90up5Ww4LYhTpNuVPI
K+lBbIHe7VqyzzQna/3SQiqGaFIvxzhu2+Ndiq5sm4xNy3uPPm6i3R5I4Bt2Qob7
N6TKsHGcm/LfkhLDtLoAiLq9yQHbA7zkP2tywmeapbha8u9V2Jc=
=4O1z
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
