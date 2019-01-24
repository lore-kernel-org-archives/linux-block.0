Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B5BC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC456218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="VBAqxown"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfAXOqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:46:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43650 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfAXOqV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 09:46:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so4758163eds.10
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gEm+WvrDa3DSTuCS+gpzJsDAEzonQSYyupTatHkCWe0=;
        b=VBAqxownnhlzwWl75M0ufUH326Mvpm0n1IiE02W8x3bKJ8gbdgztNgjiu8F/xffz3L
         jrj0uBHvC2WxfDbOfvPk7dQnYRRxAETjmiy2yzz4rF/mDP7KsCFt+IyREZXxhNh2Wj5U
         w7/euDZgjbsvnmmysSi3x+DKzId1OjezVcwk8VG/ftGWgiPkCpOldAw4hpsSSaGk8JII
         g/sQ3JRNiYWkx8EpEoPLags7xGQhKrDLejexj5ckvAEpmE+PJf6pMliqfNFhIVDS1Qkf
         pou4tlw7LkYY850uDrNYy4gikJB0veEXkABPEAoQCQEZIVFcNs2R+9f/qQwyra0qWfjt
         z8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gEm+WvrDa3DSTuCS+gpzJsDAEzonQSYyupTatHkCWe0=;
        b=qGS4KEhCrhvX55fq4Uk6PeSPVRwlOrdiIClMh+pZtW76VARJP+KTs7TfFR10o9rOqb
         CJv279c+4B5eD6EacwnAUEOjZm/MgyaOQi5l0mml4jYip6RWPy3bkwj+tb9dNS5IyLzf
         IrG4C0AqkbIwOeakVfX/2P+bsRrXf+xVLRRW9/3yrX5gUPvL/tHP2CgjXDn8OVvrBpOW
         u0jnOhXPlQ/Vyy8cIvZ1KfWPJty/OROOOH+5Y5Z2uk17Tnni/MaccDFJQ+/S2Eh0bL5B
         5RkfaW/28sD4x29omVtVa+kRVup9nR+ivcpqfG1V9BSYOXTRc38RTMsWDgbqvIQkjXCB
         YoFQ==
X-Gm-Message-State: AJcUukfAbkW8imGXCpFxWMtqlKx4LZ/MD2CPMc7ivTAb/IGIqAnhSjrf
        DUxMdfKkqbKfbLM1uVBZTcpmGg==
X-Google-Smtp-Source: ALg8bN7SCJE+9hbADxsRw2n8lsp3OIX3ims/q58YYEe9q+PRhmNW/2EFE7VteIGocYJNXENiA7n93Q==
X-Received: by 2002:a17:906:20c2:: with SMTP id c2-v6mr6254873ejc.241.1548341178601;
        Thu, 24 Jan 2019 06:46:18 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id x38sm11372650edx.24.2019.01.24.06.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:46:18 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <7B226DC6-D3D0-4014-B110-26D35F6F85DA@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_89066189-14C6-4A13-B98E-3C34811C5AF4";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1] lightnvm: Use u64 instead of __le64 for CPU visible
 side
Date:   Thu, 24 Jan 2019 15:46:16 +0100
In-Reply-To: <20190124142207.9060-1-andriy.shevchenko@linux.intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190124142207.9060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_89066189-14C6-4A13-B98E-3C34811C5AF4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Jan 2019, at 15.22, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>=20
> Sparse complains about using strict data types:
>=20
> drivers/lightnvm/pblk-read.c:254:43: warning: incorrect type in =
assignment (different base types)
> drivers/lightnvm/pblk-read.c:254:43:    expected restricted __le64 =
<noident>
> drivers/lightnvm/pblk-read.c:254:43:    got unsigned long long =
[unsigned] [usertype] <noident>
> drivers/lightnvm/pblk-read.c:255:29: warning: cast from restricted =
__le64
> drivers/lightnvm/pblk-read.c:268:29: warning: cast from restricted =
__le64
> drivers/lightnvm/pblk-read.c:328:41: warning: incorrect type in =
assignment (different base types)
> drivers/lightnvm/pblk-read.c:328:41:    expected restricted __le64 =
<noident>
> drivers/lightnvm/pblk-read.c:328:41:    got unsigned long long =
[unsigned] [usertype] <noident>
>=20
> In the code it seems explicit that lba_list_mem and lba_list_media =
members of
> struct pblk_pr_ctx are used on CPU side, which means they should not =
be of
> strict types.
>=20
> Change types of lba_list_mem and lba_list_media members to be u64.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/lightnvm/pblk.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 12bf02df4204..72ae8755764e 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -131,8 +131,8 @@ struct pblk_pr_ctx {
> 	unsigned int bio_init_idx;
> 	void *ppa_ptr;
> 	dma_addr_t dma_ppa_list;
> -	__le64 lba_list_mem[NVM_MAX_VLBA];
> -	__le64 lba_list_media[NVM_MAX_VLBA];
> +	u64 lba_list_mem[NVM_MAX_VLBA];
> +	u64 lba_list_media[NVM_MAX_VLBA];
> };
>=20
> /* Pad context */
> --
> 2.20.1

Looks good to me. At some point these mapped directly to the metadata
stored in the device and the type remained when we change it.


Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>



--Apple-Mail=_89066189-14C6-4A13-B98E-3C34811C5AF4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJz7gACgkQPEYBfS0l
eODQoQ/9Hfg+Bm8OBNtmiiG0ZvuR8ZJ8Kosul1kCsyA3o12VlSrPnfjKsTdLz2y6
nw4DTohla7q4m46VIIBaCKz2wTtFaVOj1l29Adn7V2dBFadSfwBQJi5Hb1rrHYGw
4NMacqpd/JhfLVnwFpiqsTgnOq73DRix0EU2OBRWHILIGdygj9BJRUUe+2Jx2DWM
M3H+mKXWemISStkcbNdZ0fI6CRzSqKHD6UdQdRThTfpBFrhYUM/C4+sjnh00fbyO
UzaK+IJIHARBzDc5RQinxPgGLJ3bK1eebTvmasv3EyqZgPnyXGg3Jgk0CBm5mAdh
J8NnJbFGAYa1YrcyzITy6fS1C/PwKBvAlRAm9CylzQf6XeY/WSDvPgR+7G+jLQmL
CWeSf9N+Yldpy66egNjGjG8h/i0fs76ihQGF6wamyzfFbqZR1qs17sM9cSfEQQ7/
MawDh6lqDmAWVj3ZhqZ5W45/Vx/K8qm7Xj3nnAFHd3NTz/u63p2lxxsokCtvBuLW
LUGSksA8Yj85r249goOzJ0JF6y1sC3q1Li98yoRxGYOiJ+IbX2ZUz8or4tq2rVjR
QRc6GNkC8H4UWvZ9E20OcQSFOGHybI/rClmd6bN/GQrdOIsh8xV4bhzZX1JjzHpq
gNjoTcvZfA55GZveP7z5j4FUetzs3sLAAGHhJXwXXGHiltNpo7o=
=u2Jq
-----END PGP SIGNATURE-----

--Apple-Mail=_89066189-14C6-4A13-B98E-3C34811C5AF4--
