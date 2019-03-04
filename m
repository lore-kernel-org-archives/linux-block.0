Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D76DC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495EC20863
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 07:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="qATzsFro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCDHSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:18:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34884 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCDHSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 02:18:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so3361367edp.2
        for <linux-block@vger.kernel.org>; Sun, 03 Mar 2019 23:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=W/d3fWvr7Bc912w3bE0qqVvNHCIEG2jUO8/eh2oVyBY=;
        b=qATzsFrouXPArku+tvUYtFZJpLKh7NbvL1pK5GjYrym8zd59rzdOlxAqgB5yPOy2JL
         jGZZwuK5aIul1NE8d6CWHQq5bJfCovImIRDqPJdlWxlcFN+PKR1TqKGetPRk8FF79J/f
         UYFwt7fr156z6zHIr6aBWhiyqQ/eABm4k95E3Yx90TQkTc9OCFMce+0OvHKtcgGNA2le
         ooYuTBkGgEBUnlr8e0rAfPuYkxU+bXryjWY/lLI88HwbiCJR/z5llXPlIlc8ad3Fcx9e
         /93+vR4XuR4SWuyzlksN9A6rO+6y2eyskI3dtyJQ26URdc+RdQ5NZk02PpGiHFYUfcUx
         rwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=W/d3fWvr7Bc912w3bE0qqVvNHCIEG2jUO8/eh2oVyBY=;
        b=gRpiyTQcAkKHnGEAra/z3dcqez8A8XcxOOzVHLCN58VxhjQz4zzD6h4Drg8Fb/NXE3
         gFREoJeKZrnFV/trJHu8xOfn1B+HK5I0eJNvXEXaen1PV62umvTyQYgEpQsIHwdy3hzT
         thmW80BlzHev0S9b/rPNTXfImSFR2VyidjGj5hZyHzBTycC6GuvtkLuq3ZvIRmLypK4M
         pgh0EdmnrN/s5oxkFqHfwShivfGUXNSx/7xgsessoEiSxAA3LujgCMQIHR5qC0Aog2nn
         hl0xX1VkfMH/qvo47fRR+yTyRLZsifojuwZikAqM30pF5Pkl9EYEOOj9qj8W4ixj4Hw4
         SqXw==
X-Gm-Message-State: APjAAAVUpUu/DNZ5dd228t8Yj54UQMQp99gurZDJ0JPNvbhFZkRqjc3D
        m3i0tN8r35w/Wbcb1XqvAm57rw==
X-Google-Smtp-Source: APXvYqzczleVDccKUs6l6Kn41vScIwIqZFjUBjWYJ/1Qkw0KkNXyvVFdRcsXfFaJLnblnlIdg+256w==
X-Received: by 2002:a17:906:512:: with SMTP id j18mr11581044eja.12.1551683914022;
        Sun, 03 Mar 2019 23:18:34 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id c42sm1855799eda.63.2019.03.03.23.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 23:18:33 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <A2244D44-B6C9-4208-86F4-D440A1B6EFB7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6BDC8CCA-124C-4717-B1F3-20A9CD0BCE4A";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 01/13] lightnvm: pblk: Line reference fix in GC
Date:   Mon, 4 Mar 2019 08:18:32 +0100
In-Reply-To: <20190227171442.11853-2-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-2-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_6BDC8CCA-124C-4717-B1F3-20A9CD0BCE4A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch fixes the error case in GC when
> we both moves line back to closed state and
> release additional reference, what cause illegal
> transition from closed to free on pblk_line_put
> when only gc to free line state transition is
> allowed using that path.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-gc.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 2fa118c8eb71..3feadfd9418d 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -290,8 +290,11 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> fail_free_ws:
> 	kfree(line_ws);
>=20
> +	/* Line goes back to closed state, so we cannot release =
additional
> +	 * reference for line, since we do that only when we want to do
> +	 * gc to free line state transition.
> +	 */
> 	pblk_put_line_back(pblk, line);
> -	kref_put(&line->ref, pblk_line_put);
> 	atomic_dec(&gc->read_inflight_gc);
>=20
> 	pblk_err(pblk, "failed to GC line %d\n", line->id);
> --
> 2.17.1

Looks good to me

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_6BDC8CCA-124C-4717-B1F3-20A9CD0BCE4A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx80UgACgkQPEYBfS0l
eOBvKxAAxQlbRgSE9riGO1RuloSREDgMSzcbOuuPL9ZUG6eSvBurOEw8kvZ2+nQE
iNHdin7rc1xNEAPpHHgwHYd7AvabwTH/dLN9sNA4+CZHKyXfraqNMVX1iMawoBqw
2CryRI2ogOVqs9RL569BeqLmrc+VpeJIccic99SG4yYsRbXOZ5dQO6rdRhaefoKo
TVwZ3eozUHttFc3suae8s4GPZaPQQwrb8L0ZZj+IRvtjWP2Ks7JzcJq7X2r4d+lC
ifPLPgskQTgP27dWrjLkgk6WEEehDLdwuYPCAltUVLz85hb9ljM0m/3cqAe4eOL1
pKYQFDfm7Etc/k5XpTSSbh18MZFcY8F5hcms6kO0Ip0P2hQO+Md9udRk/SJtZeKh
Npgp1KpYL5Qr5zKkf+fd4ZJMVDJgGy/2Z6QFWkFHeiw+P+PFaAeviE1wkbhSamDD
U3RwlHmD0nRwtdD+8MS+isIXAWhAfonaZTZldrQo1VcVxX85gOeLxFEWffXcNmh/
Navclhbc+H0HrhepZSMDdYAf7YiMk0it9oxb1ND6pCSAeif1bKVdPJb1YPPRAvUt
bNYEd3Y8ElNGXMrjuIF0scnINshZ4TqBNj7Ne8NBY1XpdPFyHqvdZ0nqX+LjgqZS
CG7RL2nrHmM8YYtEQoaSABXOlyIGd7W27afkQquiul/1FN8D+us=
=FtVN
-----END PGP SIGNATURE-----

--Apple-Mail=_6BDC8CCA-124C-4717-B1F3-20A9CD0BCE4A--
