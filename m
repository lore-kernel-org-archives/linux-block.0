Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284D2367CF
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422131; cv=none; b=KeTP1Pp9yjO6Z+gEYiKPiqWwLcTGBNQ6Qj0Wxo63jQH+7dAAvy92BNT90lXPZWsVWSdOfp4KFpxjtzNCPM2uWiicwfGJTv51Qu4PkgBRLm99ejmg3ItLoOGAg8c4nT1vz50kF2yyBaAuI02oN+X1jx11WM/8i+jM0R2MO8kZ224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422131; c=relaxed/simple;
	bh=CWOlpFD51h5k3j7I4SihrB/oShLDpfFZhAxD8saRkKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCISDh92BJQIzyGUY5rPDMAhdDwPBtIKNLN6TucRMOXEn6WhWEpnuxCfqHFAAKnKt338uNJKDkP/fLbaXm6obmLHEcR8Dp0VO+VUzIL778kpUCX3VbY324xIJGd6l51pBfA6CxaRUEdFDJIt2mQ0zS2afsjPkt9SEHf6spVVMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LClMz1TK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LClMz1TK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a3051bc432so6772715ad.3
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766422129; x=1767026929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGPYUbRxQZND4OH+MPO1PfdEV5r6bCBT5rsKeYeuL5A=;
        b=LClMz1TKvjGYeNrxDB2WN+QAeEzCBp3fMtaxfO3odCSRVvlqeKAp/48TeDg9rDvvc1
         VstKnezdMRW1ov8lZxtSdpQq4DcrIG1UCbn8s/FysDgeXc7trIddqqCmnVaCdOB1T6EB
         fmky2QsoXNYbFxnPIp8EPZq66rTP//hATMWqIF2Z7jJhemxPz8G2ESAEO9jSg7IjWvzw
         w3a37EEwBzfDMYgUfNeNRd3yydQJ34corXsgcSp1H6ngyweED3oVzOro/Cnyf0AjJd24
         mXHQrkM8v8S/r5aavWunLW+fs+RpvEFRlg8QBL9+wPGaA13Iqh472NWWHGiKs/BzTwLN
         A1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422129; x=1767026929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGPYUbRxQZND4OH+MPO1PfdEV5r6bCBT5rsKeYeuL5A=;
        b=vU57rWsQNY/wBV6qACiYKaWQqBGVD1o/bInU/C7axO5kOIlkQJjxg2wLSPCzmE+ilw
         Sj/I113KvpTxPvVvP6bx937zwRMCTPb8D9g23pqEnUregM6xO4GbCl30hHSn9bFB5Pj/
         humI0MFjdC8e2dosbD7mU27SELShKoMkEXvJpjI9eMrwstun74KVOPIc6u735fBXVvZZ
         pOuesS0k6GUma3I99BBN72PWbbM23jiXZSzvvsLmKkhf0KQHwuGhRp6fC9DRjaHsRAjl
         UEskVtGcnX7v4WnvCqO7cILK1nSJndlHKjObHNQ4PIGPCUUR5BDuwKV3AH9gYSVEfcRt
         tE2w==
X-Forwarded-Encrypted: i=1; AJvYcCV2tpnW1AgudFBNgyiS28jCo9z7+k9xri89M4RWWJ41a7EgjwXufmhsMg+MohV9N5lQ+PTjwBd1yqIgGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Jb6fsQk8ZFMwiazVxy1g/KcZIc6EE4zuy/zFa9TwKdj+PZjP
	koMcjYXPB5hUZp/kPYp5I/k458rXc4hWvGwsgq80ick3q3qaLS9gS3EkP4YsFbvvBdyJaZDQ6U5
	xg5ylaqbwPz/jOwqot8KtfpFkyVp63nAT4iU4YVzpJA==
X-Gm-Gg: AY/fxX480H5VAXspR+LY8EjrALleePR0SyJ6cY81944t3qT+APsgcCUasmE482DQuMm
	DSBS5cK1myFzsmoh8+ZrJngofQDbWM1AgUHnSwm8ct2K4DwGQ4zxAMVsVJzDsELkOOB7eI9i52+
	2g9BIa1jlBfxMMitPw73fhgy45qzj/JKAivQypL2qhgXp3GqaFsrkFYjeHPkY3xoPl+FwMngXLM
	QV4mEaAsS1QjH7pbnr3BD9uAIeZV2QRdn9O+AktkD659vr3DzH36DH0dC6hGUMsKNeilPI=
X-Google-Smtp-Source: AGHT+IF78uIOXoIxFlUWbMz1QQO7V18q4EHlVxzqYmr92MWzPuw/XTAKNvkbDPyDW7aUWMR6GeSlUqWzYz4Mi7sjgfo=
X-Received: by 2002:a05:7022:4298:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121723088c9mr7099905c88.6.1766422128719; Mon, 22 Dec 2025
 08:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221164145.1703448-1-ming.lei@redhat.com> <20251221164145.1703448-4-ming.lei@redhat.com>
In-Reply-To: <20251221164145.1703448-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 11:48:37 -0500
X-Gm-Features: AQt7F2q1Eo6qmb-jnnw7mrplVaz4EGNZ7U26pHDoFH6L07zvaVqK3xH_KLKjCng
Message-ID: <CADUfDZq8eMgJWbwD9uFomjmv14PtDf8npsk3_uCUY8=OHuh-mQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/ublk: fix Makefile to rebuild on header changes
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 11:42=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Add header dependencies to kublk build rule so that changes to
> kublk.h, ublk_dep.h, or utils.h trigger a rebuild.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selfte=
sts/ublk/Makefile
> index eb0e6cfb00ad..fb7b2273e563 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -53,8 +53,10 @@ TEST_GEN_PROGS_EXTENDED =3D kublk
>
>  include ../lib.mk
>
> -$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe=
.c \
> -       fault_inject.c
> +LOCAL_HDRS +=3D kublk.h ublk_dep.h utils.h
> +
> +$(TEST_GEN_PROGS_EXTENDED): $(LOCAL_HDRS) \
> +       kublk.c null.c file_backed.c common.c stripe.c fault_inject.c

I'm not really familiar with the selftests Makefile magic, but will
this end up passing the header files as source files to the cc command
too? That seems a bit wasteful, but probably won't cause any
compilation failures. Maybe it would be better to explicitly list the
.c files to pass to the cc command, which seems to be what most of the
other selftests do.

Best,
Caleb
