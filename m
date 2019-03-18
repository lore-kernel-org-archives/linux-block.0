Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F8C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406A0205F4
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="fjuHDh2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCRHjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:39:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37001 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfCRHjP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:39:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id m12so12608107edv.4
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=A4MDMqaYkZFR61feb/+G0MMD4x4ovzeYG/g4JgxCZkU=;
        b=fjuHDh2BvqBV0dFdN7ATlYyVxMe8NDcO1J5r0pk29Zn+VGt6YM5ClXSG613gCjFgIy
         /m4pjJ/RUgGOPU5k8aAWR6E9utDbqmIvF8/lthYhFWDHQWOF6aJ6nM5f30FDihwA7gJw
         fuyykOesYJBLoY7rN2BFx+gCFI9VU5cAP+4qf/Oj33moR0DUwzSbBU7MrheVv3eI0yCr
         StRRKwVKfC6GnVMNrap20QfcutcrBy1FO4rX1yAiOkrhu2LIwAjeGOtapS19eb0OJjJk
         Molf50NvlgwjUquSq8srP/nPc/KaTeZfvmMsotNMQjy6zVkYEA4KLj0NwPF1iX3n0bw9
         fdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=A4MDMqaYkZFR61feb/+G0MMD4x4ovzeYG/g4JgxCZkU=;
        b=DlBzN5cSXsVWeaVYxdvWa6zAuIOR2h1xqIe5xlTPhuKv+BY0VBHLdv4euu4xYsGx6k
         ePKXIW4qm6BKILJl66pmARLv80CXUQEExIVc5bCqC1KVnkLmJtmU7HE1PbnFG3ILJ7jL
         8KR/qiCMX6yOkP6Cw65fPexoq2bZ8GMhyLV24LKqUypeh+pi/mNlg+FW/5EknnzXSnaH
         y51IXRwytNs93e3gkwgvyGb2JWTpPnh56qACPvUEEDyk0f+spCHRXQazopT82Bw0keWo
         6OdbfHSGI5XxxLp3i73uAoCkhls5oDnfyhuq2ndW9v6Z2W7YM++DUrekTw8ssrZ6evxf
         j7dQ==
X-Gm-Message-State: APjAAAVgPqHHroL4Wh5uEACRlZJ8MgpvZqmQECTbyO26M6gHSDmPf2pe
        Ww+3J1/BGGUUatI8fhZQOLlLfA==
X-Google-Smtp-Source: APXvYqxpcIsuXuk7KMcPmfMVU7H7a8Kj+RelcLNUGARPA8o1394hwEoMyN+GglsSQ/YPmoB1fOE0/w==
X-Received: by 2002:a17:906:55cc:: with SMTP id z12mr10298105ejp.213.1552894753228;
        Mon, 18 Mar 2019 00:39:13 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id 35sm35880edh.43.2019.03.18.00.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 00:39:12 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <8BBA55C4-054F-4E33-BA46-62AC54BC7CE7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_75B1914C-0DDF-4A69-8F65-69862B89852F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 14/18] lightnvm: pblk: GC error handling
Date:   Mon, 18 Mar 2019 08:39:11 +0100
In-Reply-To: <20190314160428.3559-15-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-15-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_75B1914C-0DDF-4A69-8F65-69862B89852F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently when there is an IO error (or similar) on GC read path, pblk
> still moves this line to free state, what leads to data mismatch =
issue.
>=20
> This patch adds a handling for such an error - after that changes this
> line will be returned to closed state so it can be still in use
> for reading - at least we will be able to return error status to user
> when user tries to read such a data.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c | 8 ++++++++
> drivers/lightnvm/pblk-gc.c   | 5 ++---
> drivers/lightnvm/pblk-read.c | 1 -
> drivers/lightnvm/pblk.h      | 2 ++
> 4 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 4d5cd99..6817f8f 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1786,6 +1786,14 @@ static void __pblk_line_put(struct pblk *pblk, =
struct pblk_line *line)
>=20
> 	spin_lock(&line->lock);
> 	WARN_ON(line->state !=3D PBLK_LINESTATE_GC);
> +	if (line->w_err_gc->has_gc_err) {
> +		spin_unlock(&line->lock);
> +		pblk_err(pblk, "line %d had errors during GC\n", =
line->id);
> +		pblk_put_line_back(pblk, line);
> +		line->w_err_gc->has_gc_err =3D 0;
> +		return;
> +	}
> +
> 	line->state =3D PBLK_LINESTATE_FREE;
> 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
> 					line->state);
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index e23b192..63ee205 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
> 	wake_up_process(gc->gc_writer_ts);
> }
>=20
> -static void pblk_put_line_back(struct pblk *pblk, struct pblk_line =
*line)
> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
> {
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct list_head *move_list;
> @@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct =
*work)
> 	/* Read from GC victim block */
> 	ret =3D pblk_submit_read_gc(pblk, gc_rq);
> 	if (ret) {
> -		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
> -								=
line->id, ret);
> +		line->w_err_gc->has_gc_err =3D 1;
> 		goto out;
> 	}
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 54422a2..6a77c24 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -475,7 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct =
pblk_gc_rq *gc_rq)
>=20
> 	if (pblk_submit_io_sync(pblk, &rqd)) {
> 		ret =3D -EIO;
> -		pblk_err(pblk, "GC read request failed\n");
> 		goto err_free_bio;
> 	}
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 5d1040a..52002f5 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -427,6 +427,7 @@ struct pblk_smeta {
>=20
> struct pblk_w_err_gc {
> 	int has_write_err;
> +	int has_gc_err;
> 	__le64 *lba_list;
> };
>=20
> @@ -909,6 +910,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
> void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
> 			      int *gc_active);
> int pblk_gc_sysfs_force(struct pblk *pblk, int force);
> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
>=20
> /*
>  * pblk rate limiter
> --
> 2.9.5

Looks good to me.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_75B1914C-0DDF-4A69-8F65-69862B89852F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyPSx8ACgkQPEYBfS0l
eOB6KA//Y8AXcLEGo7FivoLhZDYMYF6D+qKTYuWWAC21ILIw/WBkXp/G9RE1NZ0w
M/4uIcmYlLrzDNG3v95kwx3FBlM7AyIH3e66Qbdrakc0GJamHV4/4IItLCBZUEbD
EU79vWlMTbTmqb5mRIfoICBORy5t/oA78upUMYdSqDZHk+ZlL0hSW0MgikYtV2lm
qFJxgvqmy52KiPAnQquHbH/BRPvTDho7CiiuRn8vQ5psx6YXceDkFcpJsLo+lTCY
MD0+kcqf6FYbtjWV21GeI6gqpUhe3oYJTDSrpFVHxRHdmmnkI69syDbp3dZlHy2J
OQuW0cLKO4CchKhToAIXu+pvNNCaiVQ6jgKTU4WAxl2MhXFiI5c4xFNb7Zuwu3N8
stZxj1/jSCf2RVu18qZC3iFjf/PO65W1foUfuNTL4n+mpdLcIJtEH0i4ziNZvN54
J9/6ouIJ+OWcjbdZBBvIEkEuGKK8to8fEkpz+4SWYMF2WPUJAWoeW3eHu1UQY951
+ok3SYGW46PvGprLJXD2QvEznueFofRBzLQLHgw3biukigFB1ULLqnJMGZYPHZAr
5oR1izXDStFkAbnc5wAEoJ9R69krSlGKaNw/OyhrrsTBbeCxJuZyvmmSXC9ylFCN
96KC+RySMAYXsZdu/TxBUPmY8oJ6egcGoiAF0UiGDCWeNzWB1TE=
=d8Ds
-----END PGP SIGNATURE-----

--Apple-Mail=_75B1914C-0DDF-4A69-8F65-69862B89852F--
