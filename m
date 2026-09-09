Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA25563FD3
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967752; cv=pass; b=D8IlgI/LDXzFA+gSV9eFmF9FhjGEeaHiiC2QQqLiansH+gi1ipQhrOhjSJjxD16gQKou8Jv4W50Xc6uMJ5rfuq+CG8Umom8Q1NgebPfcSFvKZFdqLxMGEIrp9TqjU4iXTtHOvnu+d48BAN4lKrbCCfGVOF0GdpFIwnAPqbCHLsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967752; c=relaxed/simple;
	bh=xw814y87t87quBntQJcxdp2+tqIAOOAp3DWlfXczkJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNYV5IMMLlKZUbBIqPejDRxnu0fkyr1Pe84T58Ayl4PutlA18TETwhbBLu6vyn+TSrorsf7TJYQ2ntU17SI4ww6lyxNTd1HxaBvEFwz8hxW8LnM3+vhraozzqefDVdGhgtj8dIKDRj0HKiW9y5qg2TesTLCHSIvbFvffYwfxw8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MesJ4WCX; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MesJ4WCX"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46a231d69a0so226184fac.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 08:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788967748; cv=none;
        d=google.com; s=arc-20260327;
        b=cJLn7moHrrrPgDWNifQN7ZrJDwb22MolApHQD6ECeBNLX62G8qMt7qfOo3INCQNj9G
         pgrxkBAG751fL/r0IJCo/oFnEbQRdSBiLlFS20edyHkYi1WaBFOZd949lKdNsTg4THdt
         eT1DQnSBWp7G0TONfqbEvk6w5fqsiZjQyt8B1oVIv7CFKa5Q0qQdyBTRIgZGQsPGP/oi
         bV+uw/ScpBx5bpoxt6yTYLjwRN7HKWnhICLswkmxNjoEQKLHgA6VRTMFdI4l4jMO+srq
         HThrPvjf6YJzWhFmFIsvNwMGY3Eh9QAisrvereVMUlmE1xyhk/vy95MYGcVLERNf0zwK
         Q11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VF0OQubi00GE96JsDJZGKD+Lng8NQh8xjco2BGsiNA4=;
        fh=f9JtM/m3VV0jLk2u21LWHSp50nZmr3dwL99903FdXfQ=;
        b=FKHPURcRGpYewolddT1wPUtFXjUBaiUqKm52GOmolIpcS8p4rJCBKvZIYaPtzatBdP
         +ZolSf0MV2zjl6Opx/xmRGJLxyKG6O98T8Ak9xpqFuyI8oMwYCWIw4K4DVd2Gjz8UpZA
         NO9D8+GH6Ey530DDxE6shpX1+Gkxrk6UnFWVS+jN8Pz5aWMQO7sVnG/D0FLsxnGx54bl
         GapwtTGFyYlSpfd/OqpEEdf4uLaD260/5ZDETjdbmnk14RwuDNM60fX5RLTizKr2Jmtw
         lB7TQra09ETp0ftcyKyjVlBUMf0TDR0ftk6QkJ0YNPE1UzZ5OUUfVePdGctXLCWsttkM
         tyBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788967748; x=1789572548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VF0OQubi00GE96JsDJZGKD+Lng8NQh8xjco2BGsiNA4=;
        b=MesJ4WCXa2NT4ezY0jTvkShOcaZ9Ppjb6I9FdvfcXOHJaI340qM0TgKvslkPsvzetG
         1LFYRTCsnxFliHIA8vTibp74KSDKq/PB5QjXsxKTUjHi4C/ZJ7mDOfVW2iQT1IDDF8YY
         M4n8HRFkOL3ULfyNvzv3bt52aG9ZQWYhBXSxWID/MGKQ0dFBHJfdXLv0Wh/JZdynjEHb
         9WZ6MYct32b19IZpBcSrqG+lS++xuFc9vo7PSIB2qkkZ9jO099MNkgsnbThfTVOXQ3x3
         vk5q8Pf9csSt/1YE7RJHStqpnqFGzQNCrg6YsOnwg+G+IsBvjkE5DLYCVAkf206A32I+
         3Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967748; x=1789572548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF0OQubi00GE96JsDJZGKD+Lng8NQh8xjco2BGsiNA4=;
        b=r/pYHFb/13EXZ2F58AujE0lBogALVBPV+YOTT7i/n2DeJALri/Y/q8FIwOG0M+gVTD
         lBUBBQ5dRtaosiNYUDzC8LwwuJmYwMjvW34cMmbI+kI7K7dlxnWXIj2meS1a8IoU2VLi
         qDTEniBEvkVN1Sc+rY3Jdw96ZOB4oW6rL6T+Ff6wkgTnbYZFtPC4QhV8ZWs8dMtPRxZE
         Xa0emwo7EuRo4ROO+f5yEeCD4hxDeFgqjqkfKPL9tqXdSb+Xl9qTa2RDWLsqckD+lZ8k
         G9rx3ywGyd3MMoKSWHFJKlbYInKHqhxROC+Burnjz4iNbAdwT8La5jQqsUIQcHD6HQQe
         v8kg==
X-Forwarded-Encrypted: i=1; AKwUvBxJ0JWO5Ahk4vRznT+3LcqeS36yUIOrEAJkPZT7AFZFC2OwZDtBL3JMxuXfFR56LM1+hO48qbacCS+Juw==@vger.kernel.org
X-Gm-Message-State: AFuF++kQJDhIz0p/B2TrxHl21u4cQTpOOH5x+R1DGBdBYMXNyHCGLVtt
	uee08rJOEoypO5Y5kSUY6btEP1y4nfbLm1IBDwZDk2mVO9GeE9xuZ93EGIBXNCuYKEmBvHzb9u4
	Gbpxpag2Off1KaW7h0oN0U5ezrtL2/DmA3qbDvpmIFA==
X-Gm-Gg: AYBFou2JCcPRrg25ikVchqeE5ykR/ID9Ma9d/PIkisXKDCOedCqgNQ+fcW/neKevAul
	Gn1ol8Y1qAjtAmzpimKExxknorFz77X3tTn3+z6atmko10Plz8Re2mDO8/fP0zGqOxDWrnmOz/r
	YNzKlEnNn/flmXDhYnHzT566WbgQznGPpy4MnQ1kSfq0bGxWf8czf7a32VLVLpGsVXRYdEF7LSF
	BjIlneE6nrg0lyGcntKUDLmC3j/+cg8bQYROTIggTDNmdqD5Y/MU45fq41k7OpWXY9OkE3nZKeu
	7PZTXsDw7rWy1t/m2e8j9Ck3L1/wNvqRhtU6gLzW+aYdnFufHZ/ytRw=
X-Received: by 2002:a05:6870:56a9:b0:448:70ac:44aa with SMTP id
 586e51a60fabf-47694bce4d1mr16666049fac.2.1788967747907; Wed, 09 Sep 2026
 08:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132412.8965-1-ruben@scstudios.tech>
In-Reply-To: <20260909132412.8965-1-ruben@scstudios.tech>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 9 Sep 2026 08:28:56 -0700
X-Gm-Features: AcwNN1XeVWtY4QT4IUSZDerLCC2KE5DhMESR2cfJmiq1YwTKtThhqVs4_2s5bgY
Message-ID: <CADUfDZqb+Tcxqd2GxX+0baFSsEv=+GH-adYQomcwPLzwABv4=Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: Reject excess backing files
To: Ruben Sutton <ruben@scstudios.tech>
Cc: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:17=E2=80=AFAM Ruben Sutton <ruben@scstudios.tech> =
wrote:
>
> kublk stores at most MAX_BACK_FILES backing file arguments. The
> argument parser currently stops collecting paths when that limit is
> reached and silently ignores any remaining paths.
>
> Reject the command instead so that a test cannot accidentally run with
> fewer backing files than requested. Add a regression test that exercises
> the error without requiring a ublk device.

There are already plenty of ways to break kublk (try kublk add
--unrecognized_long_opt). It's a test helper, not a hardened
production-ready ublk server.

>
> Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")

Definitely don't think a Fixes tag is warranted.

Best,
Caleb

> Assisted-by: LLM
> Signed-off-by: Ruben Sutton <ruben@scstudios.tech>
> ---
>  tools/testing/selftests/ublk/Makefile       |  4 +++-
>  tools/testing/selftests/ublk/kublk.c        |  5 +++++
>  tools/testing/selftests/ublk/test_cli_01.sh | 15 +++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/ublk/test_cli_01.sh
>
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selfte=
sts/ublk/Makefile
> index 5daf36c6c3..28ce542d4e 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -7,7 +7,9 @@ endif
>
>  LDLIBS +=3D -lpthread -lm -luring
>
> -TEST_PROGS :=3D test_generic_02.sh
> +TEST_PROGS :=3D test_cli_01.sh
> +
> +TEST_PROGS +=3D test_generic_02.sh
>  TEST_PROGS +=3D test_generic_03.sh
>  TEST_PROGS +=3D test_generic_06.sh
>  TEST_PROGS +=3D test_generic_07.sh
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index 2400b46157..3af2f10ca8 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -2525,6 +2525,11 @@ int main(int argc, char *argv[])
>         while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
>                 ctx.files[ctx.nr_files++] =3D argv[i++];
>         }
> +       if (i < argc) {
> +               fprintf(stderr, "too many backing files (maximum is %d)\n=
",
> +                       MAX_BACK_FILES);
> +               return -EINVAL;
> +       }
>
>         ops =3D ublk_find_tgt(ctx.tgt_type);
>         if (ops && ops->parse_cmd_line) {
> diff --git a/tools/testing/selftests/ublk/test_cli_01.sh b/tools/testing/=
selftests/ublk/test_cli_01.sh
> new file mode 100755
> index 0000000000..e937b8e20b
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_cli_01.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +UBLK_PROG=3D"$(dirname "$0")/kublk"
> +expected=3D"too many backing files (maximum is 4)"
> +
> +if output=3D$("${UBLK_PROG}" add -t stripe a b c d e 2>&1); then
> +       echo "kublk accepted more than four backing files"
> +       exit 1
> +fi
> +
> +if [ "${output}" !=3D "${expected}" ]; then
> +       echo "unexpected error: ${output}"
> +       exit 1
> +fi
>
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> --
> 2.54.0 (Apple Git-157)
>
>
