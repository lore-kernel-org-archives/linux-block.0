Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE93279DC2
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363991; cv=pass; b=mXxbI7g3nWu4a6RhjtRG+ieFHT4hWiyyJtgr6S/rDv9QIi7218hRGwP9zSLf4a1+4gze1mQckmuaLseUF8tIw/00v05s7m9EMBNswWasgJQ+HDpap3OXuuNETycE7W5Len4+LhLI14Ds/jYk/CZqdDyq2m7YufQDlYmIThWYlV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363991; c=relaxed/simple;
	bh=HmcEfutZMlDUqoFpQJtwDdhkxdCVIHmYf32fuuj+PYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpPfXlnHI1S01yPcoa2cP9LpbbyANx98xdlOJFcWcm3cV4436B6nCKyHq5OD3lTA8cEs5pSiNYezFddcUAxqKPkjG5HZKBS23BADyaI6s484KEL/0b0z3Ykz6uwYzUNOEhV/sni4R28hBjtRyvaV3LUix6+sG6k31HVROKYAp3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Zl1+CZ/M; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Zl1+CZ/M"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b05daf2e4eso122272eec.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 20:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768363989; cv=none;
        d=google.com; s=arc-20240605;
        b=P/suknxJldhrLznNmhWHeOjSWqL5yxsT8HxEDkHi6A4M5pJJmuAl3Uf9mkVh0S44OA
         LKUyrz9yzk51IsOoKrZrznMCmfpmvDWqUQQ412/vbp+x3UrlH9dTKXmFTFQ6d7vuVTDq
         syRi7hPLGiLdD08CA0HFOru8HMG0uBxtWQH8ZyZFy8/HaCLwuWD851FXDRGA1fMiQHKs
         PWMPZbN0aBszO5J3C1xFeQ5nGWFpuSgKcOdVh/+uq+VVcmm7BArnrUBWCz+YEHjGYGqc
         37LyBrXqSfMZjsWONAjBEV6xcQws4JzToBsC/GCpnSLuDwYXKTsw/hM4c+pYuxBQGk9m
         gDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E9EBtxN8/gi0Z4ABdIMfnRElb+vVPDDUGY/AOjCYXYE=;
        fh=RUfMUJ11Jc5mjlRxYY4TsZBTpAPrOfE85hmDtm2OkiY=;
        b=CYyrYBLAa2ij8ZKXhXGnO9f0XDgUnHOZ/vuNqpsuNGSzmO+jUfbe9+o8ZDL0Lc1Wu5
         /FkOl+M33bIQEXMAhcZ+KhpKLq6R9S/jAUdl/fSm//ydqKtrIBfaWZ2rhOvi9E3fMB60
         gvS8c0h9aCbH/vJkK2g8X6yNSSZqAh9+S38mTuOdXdao4iZ0DUZase0OrpQP5gLGZHi1
         rRDa8Kr08m6tGMslVpPb6E3NcFHuTK/uElqMun8H64wGLgy/CbxLSbkesnWLvPgmrLgq
         oJawWcH2WCTvvYxCuuHcNx7Nq9TBM77g9KIM2drVDrx25+Hfk5oErBTofuNyw76DSnkw
         qtJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768363989; x=1768968789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9EBtxN8/gi0Z4ABdIMfnRElb+vVPDDUGY/AOjCYXYE=;
        b=Zl1+CZ/MivxDXwiZ8BqBpUurccsOsjsKLCvhTg9o9Obd9bVu+uO6rn2NAnbi+aYP2x
         1Kd0E6HkdX7dJaSt6BGux5k3CKca2hk2C/OVNLLFZ+DyytFXi1QLUlWUfTrpkBPT+fF+
         6F47cN0OByQ8c7KtQVMrshak+pVgXyh8aGCcC49MwGwpKsA4xclsKjAfgHwGsJXXQCrp
         AoBtsANszwZtQQ0+e1kCZD1UPCwsH8qHDKytgwRPwjN4x5/gx1liTCsN8Wj6EycSzM3B
         BmPyivqtDV6ClIpqMNo44HSLVre0+nhHXjMJGbEkTRFc5bbuUNEbtYKxaaQNlBAnwAhi
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768363989; x=1768968789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9EBtxN8/gi0Z4ABdIMfnRElb+vVPDDUGY/AOjCYXYE=;
        b=kCvlI85sqdFxD1TO/KBNi0BaOYSASZQuy3VO8JjGdErVw1/BKGC0LWuXIEMw5HNRMG
         KelaJO2BUsutV4YAt/QVCHx2i7lV3wz9o4eKh88umF3MBLDPpQJBMDpG50tGWuypsm0I
         IefyZwDsQTUaMDOjD0J+Yzc/zaVzn6V68S7/FgMjoQ7e2/9rQm4veSSggVIgnSqstNyt
         5KzSTCXUyEJoDz9rdy6WAkDwBD6YbrrvcZFdP6WaOxHST4gGnjiu7eTGjZ9qO5g0SvLK
         ppwA8eSFiXDp7vlQqyw1aSyg9Qq2W5k+PMyEXxZPU+/IJERI2SYR3kbf/8ylr08Jup4v
         VhSw==
X-Forwarded-Encrypted: i=1; AJvYcCXBYojVx7zAokXoI/4d0q4EMQXqT8xczIrTHPC+LZ8cMGuO3cnZo7fZJcNMpOZ8auKtR24VYTNAqO5ycw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6V1JY5b2uxUEgMf/+d6rg4zoU927ORXvBKJtpNWRDyR6w9uBq
	Kgw+KyM+nYJbj9ZEhFHVvUtcswH3kURBw714tffraa8Xu+iHCZgBcF3nj1/sIl1plI0Rn/IgpfK
	FkCEuR9L/p/yBElPCwgo2TegMUj99YcYuoA5qat7kow==
X-Gm-Gg: AY/fxX70rgP9GbD/g93iov/hiKFOOGNNGnC7a/sJqO+re9M8799sldCmP4Zv4HkS/NK
	ubJJbwDQ8DEmqFKoOm3tY6ifFv7DBlCH6BMfgs0DAwkj2d0VeNEu5waXXwCdL+gx4p86DW34Auy
	OYYMvlIEwoXo6Pn+zbPXIMpeYosKZvYTeXoGvndvBfTa9bnGKkeEeDlHjEUwqTXM1S1aQTkj1Su
	c3XbVwxZqlp7TDUGFuxHMgVp/TYtoMBgtY8IaxgFKrKC23Gd2AmyPrvjYf4aYA+5/W2vatb
X-Received: by 2002:a05:7022:670e:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-12336a3df12mr950974c88.2.1768363989020; Tue, 13 Jan 2026
 20:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113085805.233214-1-ming.lei@redhat.com> <20260113085805.233214-3-ming.lei@redhat.com>
In-Reply-To: <20260113085805.233214-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 Jan 2026 20:12:57 -0800
X-Gm-Features: AZwV_QiN9iMgjhoh_riX0KJ084JVlwfXsh3yefSq1wQ6q38bkuRHIhF0J3-9YtU
Message-ID: <CADUfDZogtBa8f9e0QUj=2jWKYPe5g7wpc3zu9bYQ5X1UYVSuHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/ublk: fix error handling for starting device
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Seamus Connor <sconnor@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:58=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Fix error handling in ublk_start_daemon() when start_dev fails:
>
> 1. Call ublk_ctrl_stop_dev() to cancel inflight uring_cmd before
>    cleanup. Without this, the device deletion may hang waiting for
>    I/O completion that will never happen.
>
> 2. Add fail_start label so that pthread_join() is called on the
>    error path. This ensures proper thread cleanup when startup fails.
>
> Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  tools/testing/selftests/ublk/kublk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index f52431fe9b6c..65f59e7b6972 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1054,7 +1054,9 @@ static int ublk_start_daemon(const struct dev_ctx *=
ctx, struct ublk_dev *dev)
>         }
>         if (ret < 0) {
>                 ublk_err("%s: ublk_ctrl_start_dev failed: %d\n", __func__=
, ret);
> -               goto fail;
> +               /* stop device so that inflight uring_cmd can be cancelle=
d */
> +               ublk_ctrl_stop_dev(dev);
> +               goto fail_start;
>         }
>
>         ublk_ctrl_get_info(dev);
> @@ -1062,7 +1064,7 @@ static int ublk_start_daemon(const struct dev_ctx *=
ctx, struct ublk_dev *dev)
>                 ublk_ctrl_dump(dev);
>         else
>                 ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
> -
> +fail_start:
>         /* wait until we are terminated */
>         for (i =3D 0; i < dev->nthreads; i++)
>                 pthread_join(tinfo[i].thread, &thread_ret);
> --
> 2.47.0
>
