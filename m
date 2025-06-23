Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2592BD030
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701313; cv=none; b=PM03+38ChoFVymNpN4X70rpaVEJiS3FH28zMlonuTClQkFGk35Z0TEGD5GZHjJpFQhdjJEEygYkGAYbsw6LYc9FqseKv5SrGsCkxqlrnd9WvagbUv+XgDleaeO7mGU7Nhw/YU3M32rAgSj6oOoRGerU6HjRpbGucT4V0hWOTPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701313; c=relaxed/simple;
	bh=TGBpV5oULML4Z1a+dy4g44Lzc6dMl0RK8w2iyF/3oeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoSdbIZoRZI1FA+kfsygaqnyvq7YSA313J1HtstsfmXLaZF5Q7Li4EYWfNLjg6XfidaGD0z7OqQrV5nxoAFHNPn8SEBymlyFZtLFmyj2L+Zmk4M4DKTVuAaSIDbdmSUZPp3cTaIPpIgypkjoR/g0cPkCC9IBnEon/I147lDy25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ejX7fFke; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ejX7fFke"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313336f8438so560862a91.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750701311; x=1751306111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96FPfMZWCGqLJ9ZyWXBqoa6PuTvXzBWkUXOsD/Ztgto=;
        b=ejX7fFkeQCr8FwY6wdWxLuFQRUX3jABt4/Bxvc6JZFVB+obSlLIQc84oojkaZos9aq
         2rg8IPfOLLd6yrkg0ki2ZCdKoEPXpxgwH2I0duhIdXCFzvuw+t0ErGdNqn6gVZQuPc8b
         kF0webXpPExlPr8prMUpeZ6etMoLVEiR+Q9ZMLP7QC4vnVPxoI4uI3dO6+w338fV2ftu
         TBzcededYGCkRFENbpHxZJq3UlCSxSuNYbSaiPvU1gZWGvoLm3tgwTQDjhteZOzylDOz
         puMjDCfaSvdu2RN8rKCny8uVE13XE2X2FUn48fpnicPYd2RndGRiXLQ0wUuWM+j8Sne4
         qQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701311; x=1751306111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96FPfMZWCGqLJ9ZyWXBqoa6PuTvXzBWkUXOsD/Ztgto=;
        b=ShuBobAK4M9BJpnVS1JKXE6zNsSM9YEStNckE2G8ZRY0RkMxeBUldPq+UtDs9ytQKg
         WtBCZOOFWeqo3cj8ivdT9QR/JBagrTkG9NQKBS643Bj8BQ1PGf3ZRXIfG0f8o7FRNmyz
         nEaGAI9HX/ed22gprEnRUKbectdYWH2CpVIwSg7MwrylOpBRJXZWRRO3anv0B1w5+YBh
         dtS11rQEuoDPwGZliPGpvz/H/HkgFUZzV2FQWU5rEp3X/lu5JnkVv0yMI3jPos5AnXA6
         iqYtqGLBknIg5fgTcqngAAoC8fAeKs9XxbqtmIxCjhiq5RoyQLFZ2LnxWuFuLTXYwlF8
         CRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN7bMjUmZ5OQcOwATtqmwCoxt/NPL1YwMJ+siqfW8AuBlczuJ5PvAZeLl8TwihOeDYtX04QxwEHGmSYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvbCC+Ku51DWmjGnnj1d99I809OLHpcgnKtZYkL4E77cNtAZc
	rVca6RyjYgh2rmEXxasRwK9ZACuGTyHP9AElBYlBsM6TpfoYrz4h9Hj0kK9E6a7rFNE5fRVi+eY
	xTalcdnPJfOfzuy1k5SxD4wNDBAEhghfwlhPcPAvDgA==
X-Gm-Gg: ASbGncvAbrPNdWBK+HbE3mtp/KT9k/xHZ2qJUuWnn8duWDg1CNxOyRrgN2PHP2ElL1X
	mfybQ/epnpxkJsQ+Y+cmWSWdgmnMCfO6aK/3IZYO2muesdGb2ylhdqNEiVacWrIP40tUfcKn78g
	dUKfl11yUJHJFYOAMnvd0sl9Fci4EYuTBhr5hijm8vmUt/EPZDnS0v
X-Google-Smtp-Source: AGHT+IGfyk0z44pdh1sFfJu14XhKV72gabAiQjUE4fc8prUgN08vVYNzJPCr3Wlchk5EMe1wFJizpQF14M7zR+uvR3o=
X-Received: by 2002:a17:90b:57ec:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-3159d9140e6mr6859482a91.7.1750701311132; Mon, 23 Jun 2025
 10:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623011934.741788-1-ming.lei@redhat.com> <20250623011934.741788-3-ming.lei@redhat.com>
In-Reply-To: <20250623011934.741788-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 23 Jun 2025 10:54:58 -0700
X-Gm-Features: AX0GCFs1ZkKiV-xos-674OJMpd0KRjKKbhZdTqkFeazZxgBQAKsVW2AcaPmFygA
Message-ID: <CADUfDZq4_463nageZgzH8hMtr_gTMhvMxHfVCSuzVoBCWbgsww@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: ublk: don't take same backing file for
 more than one ublk devices
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 6:19=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Don't use same backing file for more than one ublk devices, and avoid
> concurrent write on same file from more ublk disks.
>
> Fixes: 8ccebc19ee3d ("selftests: ublk: support UBLK_F_AUTO_BUF_REG")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/test_stress_03.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testi=
ng/selftests/ublk/test_stress_03.sh
> index 6eef282d569f..3ed4c9b2d8c0 100755
> --- a/tools/testing/selftests/ublk/test_stress_03.sh
> +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> @@ -32,22 +32,23 @@ _create_backfile 2 128M
>  ublk_io_and_remove 8G -t null -q 4 -z &
>  ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
>  ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK=
_BACKFILES[2]}" &
> +wait

Why is wait necessary here? It looks like __run_io_and_remove, which
is called from run_io_and_remove, already ends with a wait. Am I
missing something?

Best,
Caleb

>
>  if _have_feature "AUTO_BUF_REG"; then
>         ublk_io_and_remove 8G -t null -q 4 --auto_zc &
>         ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[=
0]}" &
>         ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILE=
S[1]}" "${UBLK_BACKFILES[2]}" &
>         ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallbac=
k &
> +       wait
>  fi
> -wait
>
>  if _have_feature "PER_IO_DAEMON"; then
>         ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_i=
o_tasks &
>         ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per=
_io_tasks "${UBLK_BACKFILES[0]}" &
>         ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --p=
er_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
>         ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallbac=
k --nthreads 8 --per_io_tasks &
> +       wait
>  fi
> -wait
>
>  _cleanup_test "stress"
>  _show_result $TID $ERR_CODE
> --
> 2.47.0
>
