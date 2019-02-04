Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63CDC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CD1214DA
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cRvEnZy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfBDIOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:14:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36181 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfBDIOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 03:14:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so10480497edb.3
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5eyM7QfCDVFlJmGpD8M7Hj09aS6UMjXYaF9KvLang+0=;
        b=cRvEnZy1QBcNokBANV8JA5sNfoqUDRPwv0dm98urFhnIcRAo9Rqcem2Rdj8TrRztOx
         /OBF/qj87MZ6dr572TxDK+NFejf51JIYQ9NlgPWSSUgx0N087wAlJjQY71RUA/xuYb90
         As4pt88ZWhMc7vOrDaZ5d2GaTpu6o8KBvMuU3jh/IgzkZ4Cfz+EJaVLdE+JseXnjXorP
         vVW8iSwkJisp1pkAalmXYXpThQCgjjE71RIScZZo6TSudrLwUK5g7zlN0B8dqYqFW0k8
         01M+bMqfOMxYfvPaqg68M5Bh/E52rZ6JNm6R3+Hjk2/qU27ZVcBIGrzYRAliA6/ihZ8l
         nvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5eyM7QfCDVFlJmGpD8M7Hj09aS6UMjXYaF9KvLang+0=;
        b=jbe9dqRDPttwmBhbqt+d0w2TsCo6zIkUanhLOMb/RDpC0aWz2K4sRNCJRyuBdHyt9G
         qGoYWn3qCqbG90vr9oD/AX2vlxTyji6Uy4OQ5H0ew7eznDIzNp2ckZoAXGwBkAh9ogtj
         +DIAjYaWzIddCa8O1HQ5lrYQ3/bI3s0S+TNhjNrY6/fiSJEhW2/nEy9mv1lfg6K2MJg2
         k+vdAULQeaN85ZG/NZRsw8PBNsGWTjCfYQS//31HOjLBkzBrOfLZMhBIOl5/sDZkeJG8
         p7OM15XsJcl6shKsmoJLacE9YALaXXHVQXS8SpOhh72Z54sig6uE7s4tkcikk0uXU0YM
         iqZg==
X-Gm-Message-State: AJcUukdGtMkClXF0Sn3AoW6alhNOqBC0ThITY75EHwnJ07j7pghVwYGL
        VhoDRdy9EU3jI1d+vbKm9AWYWA==
X-Google-Smtp-Source: ALg8bN7K8A3+GBvKu3Zi80JhjtZu6kd0UhG/aFrCdLkjYPFWxROdZpBVrTKuEo7o+fZTHZIQHxnF1w==
X-Received: by 2002:a17:906:a4cd:: with SMTP id cc13mr28661493ejb.121.1549268052163;
        Mon, 04 Feb 2019 00:14:12 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id i46sm4062621eda.37.2019.02.04.00.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 00:14:11 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <3E3CC5BE-585A-4F0A-8EC7-7FE5F855E888@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3C636952-BFDB-4A27-8C39-EF94106AC829";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH V2] lightnvm: pblk: prevent stall due to wb threshold
Date:   Mon, 4 Feb 2019 09:14:10 +0100
In-Reply-To: <CANr-nt0FWrzsCmv=X8oqCSOBYTO7nZi5gtKJN13setFQ8MFjRg@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190130102604.14496-1-javier@javigon.com>
 <CANr-nt27moc9eLMgXkoXQGR7GA=uRpg2u+v7aJxzNB_AGbw5hQ@mail.gmail.com>
 <E4DF0FFC-5A45-405D-A942-DD8572CC1BD1@javigon.com>
 <CANr-nt0FWrzsCmv=X8oqCSOBYTO7nZi5gtKJN13setFQ8MFjRg@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_3C636952-BFDB-4A27-8C39-EF94106AC829
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 31 Jan 2019, at 21.10, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Thu, Jan 31, 2019 at 5:33 PM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 31 Jan 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
>>>=20
>>> Hi Javier!
>>>=20
>>> How did you test this? I'm trying to add a test case to our testing =
framework.
>>>=20
>>> This is what i ran in qemu, and I got a hang (with this version of =
the patch)
>>>=20
>>> nvme lnvm create -d nvme0n1 -t pblk -n pblk0 -f -b 0 -e 0
>>=20
>> I run several low configurations without problem. Can you share the =
qemu configuration and version?
>=20
> Of course!
>=20
> qemu remote: https://github.com/CNEX-Labs/qemu-nvme.git
> branch: master (cb200e3ccf9c1ff21f6275c6cb68b2801135a640)
>=20
> My geometry:
> parallel units: 8, secs per chk: 768, meta size 16, ws min 12, ws opt
> 24, cunits=3D0

You are right, lmw_cunits=3D0 gives the problem.

What about the following? If it goes through cijoe, I'll send a V3.

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index d4ca8c64ee0f..a6133b50ed9c 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
 /*
  * pblk_rb_calculate_size -- calculate the size of the write buffer
  */
-static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
+static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
+					   unsigned int threshold)
 {
-	/* Alloc a write buffer that can at least fit 128 entries */
-	return (1 << max(get_count_order(nr_entries), 7));
+	unsigned int thr_sz =3D 1 << (get_count_order(threshold + =
NVM_MAX_VLBA));
+	unsigned int max_sz =3D max(thr_sz, nr_entries);
+	unsigned int max_io;
+
+	/* Alloc a write buffer that can (i) fit at least two split bios
+	 * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee =
that the
+	 * threshold will be respected
+	 */
+	max_io =3D (1 << max((int)(get_count_order(max_sz)),
+				(int)(get_count_order(NVM_MAX_VLBA << =
1))));
+	if ((threshold + NVM_MAX_VLBA) >=3D max_io)
+		max_io <<=3D 1;
+
+	return max_io;
 }

 /*
@@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int =
size, unsigned int threshold,
 	unsigned int alloc_order, order, iter;
 	unsigned int nr_entries;

-	nr_entries =3D pblk_rb_calculate_size(size);
+	nr_entries =3D pblk_rb_calculate_size(size, threshold);
 	entries =3D vzalloc(array_size(nr_entries, sizeof(struct =
pblk_rb_entry)));
 	if (!entries)
 		return -ENOMEM;

-	power_size =3D get_count_order(size);
+	power_size =3D get_count_order(nr_entries);
 	power_seg_sz =3D get_count_order(seg_size);

 	down_write(&pblk_rb_lock);
@@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int =
size, unsigned int threshold,
 	 * Initialize rate-limiter, which controls access to the write =
buffer
 	 * by user and GC I/O
 	 */
-	pblk_rl_init(&pblk->rl, rb->nr_entries);
+	pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);

 	return 0;
 }
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 76116d5f78e4..b014957dde0b 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
 	del_timer(&rl->u_timer);
 }

-void pblk_rl_init(struct pblk_rl *rl, int budget)
+void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
 {
 	struct pblk *pblk =3D container_of(rl, struct pblk, rl);
 	struct nvm_tgt_dev *dev =3D pblk->dev;
@@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	int sec_meta, blk_meta;
 	unsigned int rb_windows;

-
 	/* Consider sectors used for metadata */
 	sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * =
l_mg->nr_free_lines;
 	blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
@@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	/* To start with, all buffer is available to user I/O writers */
 	rl->rb_budget =3D budget;
 	rl->rb_user_max =3D budget;
-	rl->rb_max_io =3D budget >> 1;
+	rl->rb_max_io =3D threshold ? (budget - threshold) : (budget - =
1);
 	rl->rb_gc_max =3D 0;
 	rl->rb_state =3D PBLK_RL_HIGH;

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 72ae8755764e..a6386d5acd73 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int =
force);
 /*
  * pblk rate limiter
  */
-void pblk_rl_init(struct pblk_rl *rl, int budget);
+void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
 void pblk_rl_free(struct pblk_rl *rl);
 void pblk_rl_update_rates(struct pblk_rl *rl);
 int pblk_rl_high_thrs(struct pblk_rl *rl);
--
2.17.1


--Apple-Mail=_3C636952-BFDB-4A27-8C39-EF94106AC829
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxX9FIACgkQPEYBfS0l
eOBo6BAAtCOpOkZMt5ie2vRW+w8MKCE3BKQXAQZXFR/6p5dFc5c6ztOkSKL553kg
lBW/VpIdtqA8ZuJHW5TajN2ICqL3Y/9/269YfMzq/vQrivnBt8LAesrMzKYbkWxi
L+quEopcuDMywfIIPq03QZmykz7CZdlQGnx31QC4B8rICSron5X758XjAhNrFP/w
OZfoJLmZ/JowDkiBFnzCEqXE0zzVEk4uUo09ZgWb554APUS2vlVlvFaPjZ2uxgAF
C6wAGhZAXEBjOb4YaAL+FUuEL9fx5AGew6qAGqU2CdPQKwWrh1ccW1wsVr5kAFJY
t2eCKabZ3pBLsu6p1uPlBcww7iXz1e7z2pZOJE0/7JW3mypJiySEZRFSOgMQrwjV
8z2HDOzhHn9aBIBf9BJZhbUhl4NqHqnMWh3gl1++CKnLJabkEwSFKpzgk4k8aVsV
StuGm/kPgdTT1Kb+yaLTgma8KQU0OOiO2ZcSzxUeNEhkZVt+R+pS8JeCEi1oZn0F
HppsfmLbdZmseUNqFsRch2rNKAJRaPLo5n+IDJXuKIjNE5oVX4yt+/rMy85SzCjU
2RJX+hzNW8I+Pqx4yH2DtQ8M9zqYbIo0ZtrMBVmfweQZiS0qsvKAi6/zk+8jZ+gO
BxkMXtDHmtQ1BzLiqDJeX6HoZf4W2KznT9j9fURkdLJIP7Jlbr0=
=RPX4
-----END PGP SIGNATURE-----

--Apple-Mail=_3C636952-BFDB-4A27-8C39-EF94106AC829--
