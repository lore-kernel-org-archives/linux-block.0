Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2870FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 00:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiAMA65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:58:57 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36549 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiAMA64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 19:58:56 -0500
Received: by mail-wr1-f47.google.com with SMTP id r28so7295387wrc.3
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 16:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=odbVD9g7tAIK8dQGcnu4Ggb+BPkjbdrd+1ieep80GTY=;
        b=paXKofIOwI28qG+rRj2s4v1ot9QDaSxuhlCJaC7Ho+FyQEZMeFutmTgrKLNLd3bF+l
         HHgE3CgmpaegEQPgm1vYCau7XPU5+zTNVVjLGoxuM4XUsqwn/28YRaOd/igzqae7X+Fe
         tpSdASjxAnFAH17xq713CFQEmCAVIdxTbaAnB0VH3M3BTJXxJJxqLms4Y+tu28tUOsJ9
         egehnufP9qt3acsQ08a67q2s0zRJS3+tVJiZ7fEGPx4J8t0kny+3Cx+ZlQa0qjJXMQhs
         8VCUS56++O80wdlX1uHKXysIuNb70dVdWr1y0SDm7xjwdtHuf9JS5W/Z4+bmynadbNm/
         a+Dg==
X-Gm-Message-State: AOAM531uDALBFESA49giR8KJoKerO6c8hNwtncm82NoGTWbMm6QaUmM9
        7sS9ma0lZoszXJTvH4RYTpa4lcuXk3w=
X-Google-Smtp-Source: ABdhPJxDUXYXBd3HFI/Y5s/Q3YdzzwPl3vIioEi9WC9yhgMMKXoQptPQKhaI4uekVURrvr8gfvh7+A==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr1818527wri.52.1642035535693;
        Wed, 12 Jan 2022 16:58:55 -0800 (PST)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id t5sm1121921wrw.12.2022.01.12.16.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:58:55 -0800 (PST)
Message-ID: <93f6c52690fb84fc79cc634f451a5c5d52df6c5f.camel@debian.org>
Subject: Re: [PATCH V2] block: sed-opal: Add ioctl to return device status
From:   Luca Boccassi <bluca@debian.org>
To:     dougmill@linux.vnet.ibm.com
Cc:     jonathan.derrick@intel.com, revanth.rajashekar@intel.com,
        linux-block@vger.kernel.org, hch@infradead.org,
        sbauer@plzdonthack.me
Date:   Thu, 13 Jan 2022 00:58:50 +0000
In-Reply-To: <612795b5.tj7FMS9wzchsMzrK%dougmill@linux.vnet.ibm.com>
References: <612795b5.tj7FMS9wzchsMzrK%dougmill@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-iu9Vq1xeG/SJnZ0bhA1R"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--=-iu9Vq1xeG/SJnZ0bhA1R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-08-26 at 08:23 -0500, dougmill@linux.vnet.ibm.com wrote:
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
>=20
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> ---
> =C2=A0kernel/block/opal_proto.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++
> =C2=A0kernel/block/sed-opal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 90 ++++++++++++++++++++++++--
> --
> =C2=A0kernel/include/linux/sed-opal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0kernel/include/uapi/linux/sed-opal.h | 12 ++++
> =C2=A04 files changed, 96 insertions(+), 12 deletions(-)

Hi,

Any update on this patch? It would be very useful, right now it's quite
difficult to check the status of a sed-opal device. Christoph's review
comments from v1 were addressed as far as I can see.

https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzch=
sMzrK%25dougmill@linux.vnet.ibm.com/

Thanks!

--=20
Kind regards,
Luca Boccassi

--=-iu9Vq1xeG/SJnZ0bhA1R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmHfeUsACgkQKGv37813
JB5Osg/+Of8hawEFQYPn77lsDWZUkRQnPnyTFAdBNGsT5OTHitHTJl8majiVldvM
8OZRcFukcrutXy5v65NBS4EWVpvj6uVYXds62TaTC4SuitSvo+dY5S6kSExRuLdY
6kdIVXKKtCWBh5dKfhNYkHqBp6ti3ka4Rlx5oDJ+eB5dqkj/J0oIu8OyMRaejjyO
u8Ka7HBhHW69eM0slhffLbnO5uLVSBzGCpd4aFAH5ekGPHPFvhm87xmRvTPLSJeO
kLKyJ1+agWYHrEBqVv4CPin8fkoo34kaYZxJkVU0kn4MZvywiC5tr4WjDxuTDvbt
uMG6EKylOH6SoLmUHwAcUs1QPX1via1L4pnFPRzO/hV++0V6oL/LSqXjTxGwtnOf
2u12/AgAmR5OIv6NXmi/lEEGuLAd2bYHPg22RljtakEw/N74ZeA19p4I1BDMVh3n
PeMQtZStqrzYiqGQrT4Ts2msXSODknfsPLv58w4Z0JViZ/kf7NsGl869weJNSKNE
O/MEKQ0MeSYPBaz9Fmblj1Dt6MBhDzd5QfQtkb7Fc9tBvzxewT9YhQmSNJr+Hc/R
go9JTfH8bn37Dv1Aj+//kc5r8abmLp1oQuojXbR62ugivELOidS6VQSkAYWWLLCS
Qme1gk67f51B8ewUhX/p3xvC4La6CXdvuySt5DvxMQ6/LfKXIWA=
=+FFs
-----END PGP SIGNATURE-----

--=-iu9Vq1xeG/SJnZ0bhA1R--
