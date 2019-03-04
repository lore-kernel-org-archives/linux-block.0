Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A1C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F29D206B8
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="tmuY64oB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfCDHiW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:38:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37341 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDHiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 02:38:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so3393457edv.4
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 23:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kRVQi7wSeU3kDhDvg7bs4h+7GF7Uuyi2TK915YxVu0M=;
        b=tmuY64oBXmOJWZa5Tofqz3jIA9cB9jTsYr7LF0wKL7WAIAycVNk0sCPWcGc7f/qRtr
         wkqhjZvnSNnhXR3i4uXEAXmjsC1IMEw/0Qh3mbOEkS9ES4DkdlNU+FRl3lh5/1mv7H6V
         KX+DTLvYLOaRIRYYrFEwKsz8hUMi8NYg6UJexV1r2ggt4MuKQl1O7vbXF4tNYgiXP69b
         D3pyEFxyaLLPyCXsOzu191G6jrz1tOwc4IIhDLfPaJAbUzt550r3RgVmOFWOq3QbfbgO
         Sd2BfLHVJt8dtcqggtOEvN+d8dsON6kysfKUm+4HELfNhDoHUuC7GK0VHg42DkZ8QMua
         kn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kRVQi7wSeU3kDhDvg7bs4h+7GF7Uuyi2TK915YxVu0M=;
        b=SSE9GKJ1BM24QlhC0nXDQYe4+877LdMFcDcaMTZF/sHfkwZ83/KEEURmFB+jnMudni
         9HnREz96yaRb1u0n5nlN2qR48uNYs0jLl9xljcW0wWvWbxkMJMlb/fixHID9/s+3yo7C
         +a6xU3DA8KYVWtZaNchFNWqM+qbfzEWC9Z6mvB6RIKmeiC2UpSxFJc+gdcV9EUyHVIz7
         PvffhPQklVhJJTf53rNZ2pZ9c8jbLTXo1m0y4gco1Hcdk7Ba19EXhY/6/lb+ZEgHlWqK
         nznPQ07f7JBZZWPQ2bRbersWd1Ms/cM18s6UEHP54OhSZxk4lPXfR83EVTkNmUXiHMSf
         ImDg==
X-Gm-Message-State: APjAAAXivQsp2mzneCUmPr2SwBGR0byx/FjztovQxpe2nmExx/OsBG4b
        /0qehKLJBjM/CBYIPiR2q/4MfQ==
X-Google-Smtp-Source: APXvYqwkl6LdaqFuFuEjd6cR3SZTDixsQ8DnwWLgzjkNnL2Cq1NTAH0txMJXkKCbKIPocgBhD+u8dw==
X-Received: by 2002:a50:a2a6:: with SMTP id 35mr13771100edm.227.1551685100312;
        Sun, 03 Mar 2019 23:38:20 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id b5sm1034027eju.74.2019.03.03.23.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 23:38:19 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <2DABC388-6D60-4253-9DD0-5FD2FDEED619@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9914778C-342F-46FB-97D1-DD3E44D17150";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 04/13] lightnvm: pblk: Rollback in gc read
Date:   Mon, 4 Mar 2019 08:38:18 +0100
In-Reply-To: <20190227171442.11853-5-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-5-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_9914778C-342F-46FB-97D1-DD3E44D17150
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently in case of error returned by pblk_gc_line
> to pblk_gc_read we leave current line unassigned
> from all the lists. This patch fixes that issue.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-gc.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 511ed0d5333c..533da6ea3e15 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -361,8 +361,13 @@ static int pblk_gc_read(struct pblk *pblk)
>=20
> 	pblk_gc_kick(pblk);
>=20
> -	if (pblk_gc_line(pblk, line))
> +	if (pblk_gc_line(pblk, line)) {
> 		pblk_err(pblk, "failed to GC line %d\n", line->id);
> +		/* rollback */
> +		spin_lock(&gc->r_lock);
> +		list_add_tail(&line->list, &gc->r_list);
> +		spin_unlock(&gc->r_lock);
> +	}
>=20
> 	return 0;
> }
> --
> 2.17.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_9914778C-342F-46FB-97D1-DD3E44D17150
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx81eoACgkQPEYBfS0l
eODmJg//ctBoYha3zYnq+neRlvMfpyDGMyNhqLAk2QpzDjqQbq2KuQi7l/gSzZ5d
ic0eE8OnjA3bBKGlNNOMnTKl7mfv5VaMbB6FJXkMGR84ZBhUUfa0JVPYv6FJmfvi
B6CodM3O0oleJJBA72kAJnLESoiFnUBNfc6KQM8JAhZrzwUZN67w1hjQPMHvIvGv
rxNLaJd/hQcpR50/hE/G+V4KdyJlektQ9dKKjLOJOpXGrtvCiNdDK0X56ijpGXJY
c1V6a4WP8WmGsZCvNPeo5sxay0fYfpessxRB3I2pCaCLZ2qL/Bd+1GegVkDAaAqB
5cg9paQBlO05Au+Hy8kg81g1HdTOkWiTnaE16Xq5hRZZ0Xy4KPP2V5j3L1fR4q45
3/A3Ih8TD1JtCNxTMIe39t227737UPnZgbAdWuZweigSZI26Ychfaq/Na5fPl1c9
7H6RSZSVOHVIBqtlWyu88D3qyI4bzmHKsV/ITx57QxPedjbxDTp5jPrtV8IbhzdZ
HMrxuKGVwsmzB673sNW1kZN+U9usVFMv0VUHWuC0nIAHYxf1/vRqe+G044cpts5d
DQfYXshVikZjfXfVrayr003e1o7AeNfFV1TkijBKx4GCcm6DkFJ48G41dhL/lyeW
aZhftv5A04z0mCgtxlCRabw0yBS6mO8g55MOQKkGf1hH9cXillo=
=LW6A
-----END PGP SIGNATURE-----

--Apple-Mail=_9914778C-342F-46FB-97D1-DD3E44D17150--
