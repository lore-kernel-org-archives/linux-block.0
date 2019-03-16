Return-Path: <SRS0=01oL=RT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5A0C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F762186A
	for <linux-block@archiver.kernel.org>; Sat, 16 Mar 2019 23:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="gqt4cXd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfCPXtl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Mar 2019 19:49:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39246 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPXtl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Mar 2019 19:49:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id i20so8784949pfo.6
        for <linux-block@vger.kernel.org>; Sat, 16 Mar 2019 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=V5Oeo5bXWddAHdRELc7R7kLq0WclYZDIJ9YAyw1K4o4=;
        b=gqt4cXd5gyHinFiIz/mV3uhHn+hrTBHPLwrZcoZX+DOzJf7/UHsapjR/jysGfX/Yxm
         Firlz/o23phgmvdzFVCqV9B83e0gr0hVJwXwSfXiwVvreWixaHiaQfCXc5xhwjelvb/n
         V8QA4LXGbWZjzGxZhuVuKnKrKvmWJhg8IV+/8Zr9cl3E31sS9DNlH/l5WCrDXyFocjvq
         5nlpDSjaCunKsJ+YOnR2rTHEvpRglf56fuJQXTvGUFSgn+o5xVQ19Aph5rrpUzRk37ce
         rlt+0Ht6fWR60WJpMXjW5W6GYxrEaeZLh0jhres+XSW1LwYnKuifVMz6AW6/CerydoCh
         eJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=V5Oeo5bXWddAHdRELc7R7kLq0WclYZDIJ9YAyw1K4o4=;
        b=YeCE+AvcGzqxthAGuLqMYgO+9ZqOPXiXVDTrfR3pSAlL4MZOOWOCkAqGVz5BNzwqkh
         HjE+CP2CAuQTF9IRPyPUOwMinKvmJcktXSIYgQ+oSQR7jqvXT55PyB2pCddb3IG1iZt3
         qFzLiy5SdgF6XNATzEHvs8d7yrkHWF0+dblC2uMPufyIymXl0ZqYenc+MEtC881aN/OJ
         j2afAgghCqxb0FC/CQ/DzpAGzUM9M4Qy0gqh0QTpE805hnCMFb7pSZoZ0bUDRTu1JYEv
         VYthkBLHZJ4HmkaMuy80LBS2Y6KreKbZs+fpNmlfw6OJm7WMsRjUJEaOk6XMvteLzxBa
         uYtw==
X-Gm-Message-State: APjAAAWSEGfzg3wnWmWsbfbngfqOQGoMb2ExBVJL6mkH8gxuX3wLEE+1
        YEsR3PAoraLxHaWQD4H0LzVubw==
X-Google-Smtp-Source: APXvYqwaVV7PoGdWgaA36zIy64A+6//QWNYo9qv/aMUa54Z+DXNdNeIJd8IsbpuooGpR+peUDZt1Kg==
X-Received: by 2002:a63:fd10:: with SMTP id d16mr10555240pgh.306.1552780180366;
        Sat, 16 Mar 2019 16:49:40 -0700 (PDT)
Received: from [172.26.35.188] ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id u14sm8186403pfm.66.2019.03.16.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 16:49:39 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <39E4DA4B-AED7-4732-9664-AE44AA2C8800@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5F3E7218-AFDC-4729-ABA9-80456BB22F67";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/18] lightnvm: pblk: fix spin_unlock order
Date:   Sat, 16 Mar 2019 16:49:38 -0700
In-Reply-To: <20190314160428.3559-9-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-9-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_5F3E7218-AFDC-4729-ABA9-80456BB22F67
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> In pblk_rb_tear_down_check() spin_unlock() functions are not
> called in proper order. This patch fixes that.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-rb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 03c241b..3555014 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -799,8 +799,8 @@ int pblk_rb_tear_down_check(struct pblk_rb *rb)
> 	}
>=20
> out:
> -	spin_unlock(&rb->w_lock);
> 	spin_unlock_irq(&rb->s_lock);
> +	spin_unlock(&rb->w_lock);
>=20
> 	return ret;
> }
> --
> 2.9.5

Ups. Thanks for fixing this...

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_5F3E7218-AFDC-4729-ABA9-80456BB22F67
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyNi5IACgkQPEYBfS0l
eOAmPg//RTa2H9ii2qk72pGd1+Hc+rsPYIIz1bs1QGZFRptxYcuJhRZmCntUW+rx
h7UFAuYjjlkbdGIIixOi42bOpjI5A9s0i6rbcoC28VztN8wCpO0Bs9j/Y0vnTq1v
PposmTdBvu28ISA3UBC9/vnj+yK4kva1m6iaP21LH48DJTYlPXU9IZj2sakKAKiu
XIcoOn5Dbb8Ufvtpah2WyT6UCJjOJiNQCeUKAZCZmsQsfGVKMM6pkxs5L4QqSEfz
6sSsQs+ZP7qIlFJT97WdGmRLykHiZ8YUbkpzVHFsEGnRbm0zmHYxiN2LpeXWWz6g
DvhudYciulIwagnRc/Q+VgnqKSd7REtKuZytmSTF4rQyW77jBzTlDLHM4hJMsJ4s
2JuIGAKesPgvy3vTqGckhtMk9aS6H/XzaAguRygw8EYaNk8alsdyOICDZV0Rm3T5
QC6l4pNxt6CcIDfc+AamaylmZB0pb473w0Z0rqe9nopiAVGc2KIk/WnwZwzfWSNf
zkmTswJ7UomvLVDAnMWGXepuer0hmORNc3QjOm0RtyE1h1DnKDaAtITaGrt8X05k
deT1ZpsU1D90W6ouNZWwh6hTdGUZcdmkSbtaQJw6E6OEiMAOMXnL/6IU+HMEzr2F
l1p5ylgLQQqAAueTfpwX7+DV6l0tPf8eQyCeziz73KCIHAUmHrA=
=Tfn1
-----END PGP SIGNATURE-----

--Apple-Mail=_5F3E7218-AFDC-4729-ABA9-80456BB22F67--
