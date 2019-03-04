Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5D7C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A920863
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ci16aR7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCDHmo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:42:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36176 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCDHmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 02:42:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so3402440eds.3
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 23:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pjSD2FZPGkufifazvlxHHQPmVAP8CEDnvdkWfP/tPUw=;
        b=ci16aR7NW9TAvU1jKeb1DRKNJIFsp2dGJHyXFDzt+TSziBWtgJqtVegs5gqh+aNFWj
         X2ler91mpOnhpScIhyAJQaexF7guRGJfSNQzi6/Y/nLnkzszG9fYjflkO9LR+/CkCf2z
         EuSdnddvn8Im3WroPFfEEJg33HNnCUoH2lL7mG9cvX0hPZXJud7mTJ2N2ub5mhMWh7SZ
         JDJgh2M5q/0Kd/VJWwCK6o76+ipVulpUb4boynLig73OnXf4JxZ2YIa1nSqQlbfTWYy0
         pvrmReHhTuwGnJP7X9aHlyMLex2LrOVTyuhuMwpJeaEWwXrLL1on06NE1vGAeAjufyqL
         yAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pjSD2FZPGkufifazvlxHHQPmVAP8CEDnvdkWfP/tPUw=;
        b=oGESxzlDNcAe7BMa3AJ2/QK56mdaW8A/m0JX2iBTGmUvPxUP5IgWsnHP++NZxytGZZ
         MN33D29kzgHMsDjqUUzmBEt38VHw1jWns808ZfxxliV1O00ab0Tsm4pBMGcpJz6lOeRo
         kSDhEYfz3Xu6tbTHWHlLlPyE62HAS2XFzWcj9gNqbu0zOMXLYcWoeUXJEf2E9VaLkuQO
         wa9YLdNKUXT59dGW5G07N4I4cTTZtd4sdm+mR1OE80bjB/ENHlZMnZNmOv8Chpfh6Uon
         JhZDozGl164k47g52a9OpKiGGJS3I8iJITwxjCuLcRjjESdyBDLIgkXTgiBE2iTkpM8A
         Z2jg==
X-Gm-Message-State: APjAAAWmVYrdY5Sit/R24oABT5Knxc3WixOsksun3JoAF597HyQj9c6P
        HG5/hIj/+f7ddHvlAz5yDeSRug==
X-Google-Smtp-Source: APXvYqxMluPQMUQ2Mfv+i2XsNP3yZ2QM6dRTCFiROwV42QHRJJoyXKMKJHthxmN3YyNi66bPA4GMcg==
X-Received: by 2002:a17:906:90c6:: with SMTP id v6mr11771571ejw.241.1551685362088;
        Sun, 03 Mar 2019 23:42:42 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id g48sm1854798edg.41.2019.03.03.23.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 23:42:41 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EEE28D51-7D8F-4299-99C3-08E3E69F7156";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
Date:   Mon, 4 Mar 2019 08:42:40 +0100
In-Reply-To: <20190227171442.11853-6-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_EEE28D51-7D8F-4299-99C3-08E3E69F7156
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently when unknown error occurs on read path
> there is only dmesg information about it, but it
> is not counted in sysfs statistics. Since this is
> still an error we should also count it there.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index eabcbc119681..a98b2255f963 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct =
nvm_rq *rqd)
> 		atomic_long_inc(&pblk->read_failed);
> 		break;
> 	default:
> +		atomic_long_inc(&pblk->read_failed);
> 		pblk_err(pblk, "unknown read error:%d\n", rqd->error);
> 	}
> #ifdef CONFIG_NVM_PBLK_DEBUG
> --
> 2.17.1

I left this out intentionally  so that we could correlate the logs from
the controller and the errors in the read path. Since we do not have an
standard way to correlate this on SMART yet, let=E2=80=99s add this now =
(I
assume that you are using it for something?) and we can separate the
error stats in the future.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_EEE28D51-7D8F-4299-99C3-08E3E69F7156
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx81vAACgkQPEYBfS0l
eOBdcw//SrRRy2vpZLhK+40kzV0rT3lfLNCW5ljvBK/oMPAjrl00N5dTSquGEjB4
/MMSkEnGnddFZpHCBzSKqEMhJkVmDJGognea/dM+ZvRJotT2QdK4Zmv0jWhd1e2Z
dzgRf0xMwmIRpbfZmSl9eGaCoYbTUZeqTCFcQRFeNngO585dt3APPAodorKZzl1P
6rzzmtzM8TpyTGU+m0haB5JaiylFq3y8LEn3guko9JbIt65jCXS373Pa7sEVslFJ
9aq/itxDZrYwhVJkEJPmIaD/rtyZRSuHIdYSkDteDTeXkO9n/ISHCT1E7aT09Z9V
/JYRTe8mcjBUdxM7VrvAHpqdSjxLK9aJ5div8a7/qHqX5KzheaR743w8jKE6Z+Fy
jdwPDe2vsh3M8ePYWuFmjIyQsQigsHzEwIS2bqZiNt4NiIEDKBY1z9YRZi5Kq2Xt
RpQWauZvzuZvtCjWpr9nRbnGLKAo9d+K58CqjHe1DtoCfMGKWykr5977IbZ2MOu0
uy6Uey4uXlhkZFJ4TS2w6AwEYGSS3gCSl2vd6lXUoqOp/nn/IOdl1946gjcBLoRH
0h1pNIaI0YkquuNvS/qs9bpFnm6grv02kMQgn2Bmgiep00bLHS8IM1SOgWlilJkv
Mujm7XbCQ0ewTAC/zEkW6aLsEB6lbIPBWllW5RRooPTjYxd/OAw=
=n7cP
-----END PGP SIGNATURE-----

--Apple-Mail=_EEE28D51-7D8F-4299-99C3-08E3E69F7156--
