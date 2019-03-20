Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D344C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 11:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3575921850
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553080266;
	bh=utnSK1YGtlXxBOlfNo1gl5k7CXh91euMW7lupGNC72E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rKoY8wfi2qAKwuSEW3Dh2DtHWcrrEPT36zI8tFmh5dYOPry7eqLzsUuAOI+ObSdWP
	 sGJd3mqwemqx4Mh3Ub+zxMC7uVmlzpMYwFFTkMNZhFGFnjBNzKgkFYa1cpq7qVQPBm
	 2TVNSc8g+vfSHdw2WlRkmzjn9R9bGRR8KD2HNpzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCTLLF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbfCTLLF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 07:11:05 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1FF2184E;
        Wed, 20 Mar 2019 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553080264;
        bh=utnSK1YGtlXxBOlfNo1gl5k7CXh91euMW7lupGNC72E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYBTXzqEU5nol2C18dIg5bo9/aJiwwzoPhctaKIwBHbSWeU+pqrNisvE4B/yoUwbX
         JeKwljvqIY7rTQqeugx8xhrmXDsNj5tXqINssCV1c1F8mHZzBncKmxImnOW7p4zVt/
         O531ZHVz9I8KByT1M4lyjF61jfgQxV9zITJXpz9E=
Date:   Wed, 20 Mar 2019 13:10:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
Message-ID: <20190320111058.GU4823@mtr-leonro.mtl.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
 <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
 <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline
In-Reply-To: <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2019 at 11:17:36AM +0200, Max Gurtovoy wrote:
>
> On 3/18/2019 11:34 PM, Sagi Grimberg wrote:
> >
> > > As we discussed, let's check with RDMA maintainers if it's better to
> > > extend alloc_cq API or create alloc_cq_dim API function.
> > >
> > > Sagi/Christoph,
> > >
> > > how about adding a module param per ULP ? as we use register_always
> > > today, create a use_dimm module param for iSER/NVMe-RDMA ?
> >
> > I would say that its better (and simpler) to do a global sysctl knob for
> > it. No need for a per-ULP param for a starting point.
>
> for sure it's simpler, but in this case all should agree that in case we run
> more than 1 ULP in a server, all of them will have the same configuration
> (no QoS).
>
> are you suggesting something like:
>
> /proc/sys/rdma/mlx5_0/dim
>
> Jason/Leon/Doug,
>
> thoughts about the best way to configure this feature from your perspective
> ?

It doesn't sound reasonable that we have per-ULP feature (DIM is
per-ULP) to be configured globally. Especially given the fact that
users can find themselves running different workloads with different
requirements on the same system.

Currently each ULP has some sort of tool to configure itself and I think
that once ULP is converted to use DIM, it should have on/off knob in the
tool used by their users.

Thanks

>

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJckh/CAAoJEORje4g2clinkS0QAKlEqQCLfoDF80V462o1KEd8
SCWC9V8JE5r6htV8LkqiIONkc0ZpHGcFhF1cgpk5SHde64MqYuP1vU3o1ZUQi4Oq
82crvGlRi0ux6jtnDiUuKbNFzVE+DruQneNy60McDCPWdVjQxG1xOaY4c7S+Hz0b
2cvT/Bm0Jeg1Ztno3427hMpZ7BHGfCHSytxydIQ0viQaZVi13Wr2D4bsKRmlkPwc
E9fXdhPkgtvqFaxv1ghkMCgapEQ7mQVRpIo5sBUmgqpjaEMzap/40b3Z1wBSbfFY
Mx/i2Hz7+AZF0NKq1GYbuYyN5Z67dhcQnhcBYhuzLt+gbU4VoWU1tW+ZfyFq3I52
SRWW3cFXzmnWTVXwVeQ3TwILgk09G2QtOflo47Q1ttdQTH3VnhVJcI/qDYnBvvw6
DBQAh3Q20Ln5oKoa3g+b6OBAKOK1lyd/Ed2K/BvcYVIb53OXbXuUX3asjcscd5DF
l33kGNBN6ssnoOLGjgOQZfkSKaRu8BXHlrpgQiHPB32o/kFS4KNX7xIoqEjgBJb7
9Nj8xu4Kqx4OjqckC0xa/xxPonOoneYRiIFWbqfEmf3kJbFLBXeYOgeW91/jC621
pzuq21+jE0yW6MOR+x44PWReGeGXdEIvO1Uq6WkG5474h6CUGl3qiyExH9d8NbJD
HaDF8mocLkuO6Pnq6PHQ
=ouQx
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--
