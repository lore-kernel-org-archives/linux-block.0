Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58E3EBF21
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185296; cv=pass; b=T4MQK9ucA0P6ek6ttPE2xtix5FWv86//P9wXkHo+W3OGyntSR5dQ057/IDxQSUQ129UdyKGJoN4QA+sUfs4A2ylFKPFvtk3l+Y5UsCxVx2e8m0zV1Lw6O2LY1PmxCAEpC1uULALMF26XPKDe/aFeIR8EjkO+ajPE8zf1zbIGmNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185296; c=relaxed/simple;
	bh=cJdkYRcxnUEL397UI1OS3MXqry0cR6kyDUerA84EGyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1hsHnpOmwxlij3hUGQeE30kXNRh5lEDn7HpaX2ZzBY8YhzRd7Ai1+CCL2F2it8IivDlmylSyWNmJR8tTGSUuNacLnSbFcKG9C4HmVTib7Qy8mvY7zg885gqleLQ85mULfAoXvWbG6lT1Tg5wowz5+HDLwZTdAoy0yiQr4p0GxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZBH1DMes; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZBH1DMes"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233bc11279so168180c88.1
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 08:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769185295; cv=none;
        d=google.com; s=arc-20240605;
        b=H+7BNZxv+jdsYbFUgWmfBb12RbBIKmIdNG642CphYxyypGTQ9995PBbaTYzOScgFCq
         q7OSpiRxE/mSD99ad1MkcmiuJTiplzg4Z7haitfZgObU7svSTMo1JG6lMA3Zcvsx01+U
         Yr2ihi6DKC4QEp22/goZEm87sHgdN6uIaMOMeReDZpqSlEUEcheFyCNJLr6A/OhjUm+t
         0HQGeXEpmezXf5345Q+vUwD2poE3fsqF+jcvyAwFrceYSaO7ML9uFD6Q88LWQdEGUfY6
         HgsZmT+MMxbcmEFGh6U1uOT2KshL3Md2bD/WhPdbtSgYlvyjqEZOmWXxIbfJoT4nWWUG
         iYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DxNTeWBn5w9lqozNLdO3vzm/ZdxHMZsH4CX0i7ouB0I=;
        fh=M/5BqOLrk/HHu94mg2Wygjoiz7d0rZU31WlBGTlhBWg=;
        b=BCAhtV6x5nvkdl3VSR490DFb18scQszQVptTM2eVbsGUtivbKXQwn4T3JtxaTjU4k9
         Nti5FWUhUTViot5XM49DgQlcU5Z+BDx4wtpoPjssXj8eXgbcTkJ8O0R4Cow1mhwFqcmS
         OUk5vZPwHUkXCQUFZUqQt/2kbGlAad3j4rhX5BtghUbumVghCdjsq5FBOtHFKmWzNyLv
         z4O3kz3T7K6MYPwwYkYAxRoW5Lv6lfCkTjEw7wV118IGRal1E0MvLXqzl1w3MS3V7LuD
         LbkQW3f215IHtPApjvLIHI3IX2QjO5MnY8NtVfkABKkp8Fj7IEXjqslMU3Ne9UMVE4La
         bkJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769185295; x=1769790095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxNTeWBn5w9lqozNLdO3vzm/ZdxHMZsH4CX0i7ouB0I=;
        b=ZBH1DMesoeN3x9rLf4Vg5hJ2zsEgC/W6Thlf/asg2KkZ3sqnnx9lmwJs78y2WCRo/h
         OAb8NDy1eXpc7oUciDIQD3gS4cFFeO+Y5uwNI/O01tye/BhIxlbe/HIKZnTILNfWUdlJ
         XoELepb9HozzEOjTXyhAOP9lmzRLKH7+kjIPiJWdf00rzb0HYXDtZpf9WBT5ytop/mrY
         yxtzScFv2Py0X7/lcDlf9pKvDg8WErXBwSQc/3yQhzNuoelHABdx/byfw8gh010wQh8g
         9RkJBpq9SvmayaD78lMz5svsG3PIU/IbNTkNqOryxZ7Lo4FzFQoIu4x7oulTlb4RLjEI
         OF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185295; x=1769790095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DxNTeWBn5w9lqozNLdO3vzm/ZdxHMZsH4CX0i7ouB0I=;
        b=v2Wmo4JgMC6wBLI3BijeivVKyi4IAqb9N3nS1k7HaiVynI8SWdkUE+IJcl7DAuXj9W
         8Cu2fHYdZz5Ezkwzsx4Pxrchw2ewpuOOOYHDU1YgKT1TeYW1CZeCyvJb2rx9LatDLpUU
         4IwacZCUZ3aAdJbn/bhAxbxtUMJLjZX4AcqnMU2kn2Gyii/ufJHcFTKjKrVZ2gFHDtR8
         Ukvg7816Q7UcBbcPHdwqWq+pPflxbi2ue+47bgpiC/qPC5qCotZKgM7txkQ6We9+g7h7
         w4uruYEsKY7ST8GfQOcjN+PWtyIcgeEDcHQxrjVAdD2RgwEB+RQOHVxmhfiwHiS+z3Fx
         g0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVRr40HZ0uF4NBxmBats7R8FVWwGseBvL1Pn/ZZ95lhmACmk1wVxg0fxgnd4bQ+eP2sgvncTScv2n4QEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2n2ab4b3GG/IXlBaUAI/vVIswX1MjtsOPP1lhbsgjk/xIt7T
	RfEfT5HhAWO0dpBACKgOJmJKc8+0zRXx+BZiVbDjo1j28YoXClGbVO364DTdwy7Pn/3Y4lkN+1I
	Dyz/x58VPmxlSqbtrlxX3qVpUiGtL5rxaG9J/tf8GFQ==
X-Gm-Gg: AZuq6aLm66vwmkQgJyTyzZSBdfYLhbb5CrMC6HaM/e0jkNNu2jCIZ7LH1D0rTQa94Aa
	Oad+7q8bwsgt9CcNs7PpxQFRvV7EGlHevIr0yWUjRetfc5D6aAXibIeQWdupOC/1Hg87RGiKd5G
	qAHtOXyWfsAoUnHVhX/YrZ4lip7K2/Hsi2EoGXQiA6VF3YQ7hQc216ODomfD3GKs6VWYhvFDFl+
	epnbaPztsVLjzgBkqnja5iy1kWCbNSJudnjfk2fz/ivy4rBs2wjvmiWdKo2C9E/dt7AdHlJ
X-Received: by 2002:a05:7022:258b:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-1247dbf83afmr822047c88.4.1769185294328; Fri, 23 Jan 2026
 08:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123112913.1371323-1-alex@zazolabs.com>
In-Reply-To: <20260123112913.1371323-1-alex@zazolabs.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 23 Jan 2026 08:21:22 -0800
X-Gm-Features: AZwV_Qh3_0A3z74JwuZQxyRjNGjleQd1M4K5VH1qZpvE0taKw_h1Ly7vckZSHC8
Message-ID: <CADUfDZrtJO8AhRh1WbMo8_xPvwE6NBOD9K8bUr6_B+=mhiSd4g@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: add missing gitignore for metadata_size binary
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 3:29=E2=80=AFAM Alexander Atanasov <alex@zazolabs.c=
om> wrote:
>
> A new utility metadata_size was added in commit:
> 261b67f4e347 ("selftests: ublk: add utility to get block device metadata =
size")
> but it was not added to .gitignore. Fix that by adding it there.
>
> Fixes: 261b67f4e347 ("selftests: ublk: add utility to get block device me=
tadata size")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/self=
tests/ublk/.gitignore
> index 8b2871ea7751..95052c32fa09 100644
> --- a/tools/testing/selftests/ublk/.gitignore
> +++ b/tools/testing/selftests/ublk/.gitignore
> @@ -1,3 +1,4 @@
>  kublk
>  /tools
>  *-verify.state
> +metadata_size

Maybe move it next to kublk (the other executable), which would also
keep these sorted alphabetically?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> --
> 2.43.0
>
