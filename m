Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876641E5B63
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769662012; cv=pass; b=cMJkISgTxKRUoJua9n50LQcPMRG9oTeEgA9E7QFGmpeKC6djVWYay8j5JInoHGX2umRQ4NPLhmHYkaKXTWVLrRmAbcGx4jfMUq7udavuma1okihp4g5f/NRNYcJ6LQRrz+7dBEk1CyaTOFnE3UhiGJ0RYSUXV0RFUm0PXHSIEHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769662012; c=relaxed/simple;
	bh=PJ3R7lt07RRgEU8a6So0mO9JduOq3PuYgPhvdD6V2EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbE19NxFZ6LXE3NlV5kskRx2qPDwMf4r5e1JOo75DKyqWc+MdUrNX3Qq2FBdG6s9s2HR+a9c/IsPFsZbnD5+w8+BOLfZL6F1JG6Q4ObkKTDMZEqOmzZ/rCIY1rL2RnMgP51IzHkC/a6t7KNj//YOoDUrm1gRm7X9Jfkmc+Tm30E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cQo89nBH; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cQo89nBH"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8864618c99so9252866b.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 20:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769662008; cv=none;
        d=google.com; s=arc-20240605;
        b=EbUYM6HI/QjwBbTm+xiLy2beKgZ0MhJJiMzyfd6lrbhExtFQCI3sCUhH1MVXPyqMUx
         p1SFChVcr0NyoaARMU3CQih0tD0b37NwV5v+f9YUEBa6Jx+Ss4OWQNkMrMXD4YDoDq1k
         NrCPCG2ieoVotTlual7aPV5WQozRtBqh0ARG+PiBTdumjQuTCRxPSzb1FNVMyWX9fZFc
         s4uPaGceT7LPw94RISSnA3/fMdPcamnAmuS1lgz5VYuLEOXsILZZxEhH9TLzxmIGWoxC
         O9MUfpWmHyoHIp+F15jc67YmsjGJqvBxi7sIcQXpXLxZK7lFmoNnUxKR9CmhE7Wn9CI5
         RAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZReyMDgbm0QUbNZWEgilgUbpMHWyxjBd4DDD0BAJT8=;
        fh=eO/Sbd8HYK8eCu3D9c/vyetJ0yxpgIrwhpeKVXhzkrM=;
        b=dWXEUzSSVfVy5/kTMvKEqCNwPMhcIJ8KnCHJIT1w+PFVTSpgVXuk06/xXqHXVlQsbd
         RRcVroVE8b/PGkfkoVr+/S9iwGcz8UUjCZUzq5q992uvJiss6PFrE9GqhYTNTRRPiMi8
         tjwyCR/etqxFemlP/KgrRt2K9y/Qd6ZYZe7F8UaZ71199g126ZfcFf7QPmnfY7zEZJdg
         L2srxIJ6hTnHABqZrtcR7R8zuMNacHz5IaBGCqTJBgB0g9jq/JVZPlsDlHa5WNyRJJWf
         dqq1UFH0pLTyFlv2GcHZEN28upCQKLl3YmYUK5LqV24z+zQ/qDGjI5qA+1VpAtLor0Fv
         c15w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769662008; x=1770266808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZReyMDgbm0QUbNZWEgilgUbpMHWyxjBd4DDD0BAJT8=;
        b=cQo89nBHW0Ye+XYqjsWwqrNvzaD4wPVJG4rLFpeMdoixeFN0/uxxUifkxFvLoZo0lr
         I7oSa9wOD2i6KWK1YjSmAxpJ+l5LzYdNiIGNV+5A2Gr3XF+020T5p6TNNNJtrZiHVVrr
         G17rbjXo+mzCgWJaoiW8q2c/ObF/2Dilu14Gja03tP9CcK1kuZtOFkBmocAg/JgDumId
         M2SDMT9h6X5/+2uKjWYwuF2dIZiVx9fxOS0pB0LZ1P98AjAFCTyIocrpThrEFQvXJ0Rk
         GaJpBa4bOmqeW6M6WCBT3cD9rRZK2usijK3faIHlWT1CKkn51386Wd/89/hNLJW7YPYW
         AJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769662008; x=1770266808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZReyMDgbm0QUbNZWEgilgUbpMHWyxjBd4DDD0BAJT8=;
        b=Fl84+3MJgtheVr0rv8xJvavWI818z74yuKnby1ZvbDvIncOCbExENQ60ljHhW8b4Xv
         lJgRhvj2iW+W4bb4gs3xZ9wY29fC6KauGHj1LAzVxsjamY+WS8nr/ajfK2vBVOjWFgyL
         kXce2urkz1eiwWx+pSOYrwiY741mujmzf8GvM5Du3rhDadVojSrKv/prUYdlw0XSvGLO
         2K90KlNcgG4emhEiLetqmJKi0V/j+FsRQDx06JgeAt7OvuJVtsd6WQefpJax0SXNNYuK
         lduM2wEdBG3yViFWUQ4SQnz3ZtQ9sVVR394vBhrgjjWXmiy5YusuBDo5DZGESQnbf3ad
         KAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoy3sdrKVFyYRwmfgcTpzNX6DOXWt2T78Bkc2BTtcxyiRlTAy3V5SsY94P7qSh15BLZR6GpBkJeSkgwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKWXhmtdM8+rBVOGyfeBLP0ZnSX8kbXJJe+QVf2RZ9AIfBTKU8
	Wt7XA38pRMm+GmaFt7CeZ/QTKKFtyAEnbMKVyI06eybDNRVbcfeQGK+YiGPwfo+W+lncvu0mrii
	n7xV5e8HSc5l++J9tq/AEqM8XsHMNrBOecfvyVM/L6Q==
X-Gm-Gg: AZuq6aIQirH904yLI+TdwiEYJMW12Su8Ww0FfK2eNXXW+9XMAMe2Yu6/7LDBj+ZlVA1
	479gS9qWlXI1OFVrTnALMn4vhrPZjGeqe23LdJHHIEiiWLZwcBVN0mfW0eO66Xgl1VnvNe0cYVS
	4ErAZ8VH4djPh8GbLlsT4DlaXYVfQKZiWjqp911RIkYrYejGTFZ/rV9O2N3DnL9nHmd+bQx01LU
	FD3n8Z/XIe3zAGuM6HPW4vdQtGmaxmev1BtNxQz3StVA2xDrzhzXrtybG97+X025ULRAaZ2
X-Received: by 2002:a05:6402:268c:b0:64d:4149:4923 with SMTP id
 4fb4d7f45d1cf-658c28e1692mr798430a12.1.1769662007700; Wed, 28 Jan 2026
 20:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129031501.3403688-1-ming.lei@redhat.com> <20260129031501.3403688-4-ming.lei@redhat.com>
In-Reply-To: <20260129031501.3403688-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 Jan 2026 20:46:34 -0800
X-Gm-Features: AZwV_Qhb_GBNyCBH-K7GhsCBP-N-gFVxhXqxFWMqSvI-D-lBe02ock2XQQSJ3tI
Message-ID: <CADUfDZoSrKxKUPEROT3Y8WKw2Dj8qFkGUF-mAT3x6s4FM9oTxQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] selftests: ublk: derive TID automatically from script name
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Alexander Atanasov <alex@zazolabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 7:15=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add automatic TID derivation in test_common.sh based on the script
> filename. The TID is extracted by stripping the "test_" prefix and
> ".sh" suffix from the script name (e.g., test_loop_01.sh -> loop_01).
>
> This removes the need for each test script to manually define TID,
> reducing boilerplate and preventing potential mismatches between
> the script name and TID. Scripts can still override TID after
> sourcing test_common.sh if needed.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  tools/testing/selftests/ublk/test_batch_01.sh   | 1 -
>  tools/testing/selftests/ublk/test_batch_02.sh   | 1 -
>  tools/testing/selftests/ublk/test_batch_03.sh   | 1 -
>  tools/testing/selftests/ublk/test_common.sh     | 4 ++++
>  tools/testing/selftests/ublk/test_generic_01.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_02.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_03.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_04.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_05.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_06.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_07.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_08.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_09.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_10.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_11.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_12.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_13.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_14.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_15.sh | 1 -
>  tools/testing/selftests/ublk/test_generic_16.sh | 1 -
>  tools/testing/selftests/ublk/test_loop_01.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_02.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_03.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_04.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_05.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_06.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_07.sh    | 1 -
>  tools/testing/selftests/ublk/test_loop_08.sh    | 1 -
>  tools/testing/selftests/ublk/test_null_01.sh    | 1 -
>  tools/testing/selftests/ublk/test_null_02.sh    | 1 -
>  tools/testing/selftests/ublk/test_null_03.sh    | 1 -
>  tools/testing/selftests/ublk/test_null_04.sh    | 1 -
>  tools/testing/selftests/ublk/test_stress_01.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_02.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_03.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_04.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_05.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_06.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_07.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_08.sh  | 1 -
>  tools/testing/selftests/ublk/test_stress_09.sh  | 1 -
>  tools/testing/selftests/ublk/test_stripe_01.sh  | 1 -
>  tools/testing/selftests/ublk/test_stripe_02.sh  | 1 -
>  tools/testing/selftests/ublk/test_stripe_03.sh  | 1 -
>  tools/testing/selftests/ublk/test_stripe_04.sh  | 1 -
>  tools/testing/selftests/ublk/test_stripe_05.sh  | 1 -
>  tools/testing/selftests/ublk/test_stripe_06.sh  | 1 -
>  47 files changed, 4 insertions(+), 46 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/test_batch_01.sh b/tools/testin=
g/selftests/ublk/test_batch_01.sh
> index 9fa9fff5c62f..a18fb39af8be 100755
> --- a/tools/testing/selftests/ublk/test_batch_01.sh
> +++ b/tools/testing/selftests/ublk/test_batch_01.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"batch_01"
>  ERR_CODE=3D0
>
>  if ! _have_feature "BATCH_IO"; then
> diff --git a/tools/testing/selftests/ublk/test_batch_02.sh b/tools/testin=
g/selftests/ublk/test_batch_02.sh
> index b477f91359e1..7ca384d11987 100755
> --- a/tools/testing/selftests/ublk/test_batch_02.sh
> +++ b/tools/testing/selftests/ublk/test_batch_02.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"batch_02"
>  ERR_CODE=3D0
>
>  if ! _have_feature "BATCH_IO"; then
> diff --git a/tools/testing/selftests/ublk/test_batch_03.sh b/tools/testin=
g/selftests/ublk/test_batch_03.sh
> index 13a2b3d3a1b9..aca9cf144b55 100755
> --- a/tools/testing/selftests/ublk/test_batch_03.sh
> +++ b/tools/testing/selftests/ublk/test_batch_03.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"batch_03"
>  ERR_CODE=3D0
>
>  if ! _have_feature "BATCH_IO"; then
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/=
selftests/ublk/test_common.sh
> index 7ff6ce79d62c..687884cbaec1 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -1,6 +1,10 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>
> +# Derive TID from script name: test_<type>_<num>.sh -> <type>_<num>
> +# Can be overridden in test script after sourcing this file
> +TID=3D$(basename "$0" .sh | sed 's/^test_//')
> +
>  UBLK_SKIP_CODE=3D4
>
>  _have_program() {
> diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/test=
ing/selftests/ublk/test_generic_01.sh
> index 21a31cd5491a..26cf3c7ceeb5 100755
> --- a/tools/testing/selftests/ublk/test_generic_01.sh
> +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_01"
>  ERR_CODE=3D0
>
>  if ! _have_program bpftrace; then
> diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/test=
ing/selftests/ublk/test_generic_02.sh
> index 12920768b1a0..1d4b1d6e059c 100755
> --- a/tools/testing/selftests/ublk/test_generic_02.sh
> +++ b/tools/testing/selftests/ublk/test_generic_02.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_02"
>  ERR_CODE=3D0
>
>  if ! _have_program bpftrace; then
> diff --git a/tools/testing/selftests/ublk/test_generic_03.sh b/tools/test=
ing/selftests/ublk/test_generic_03.sh
> index b551aa76cb0d..8934ea926762 100755
> --- a/tools/testing/selftests/ublk/test_generic_03.sh
> +++ b/tools/testing/selftests/ublk/test_generic_03.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_03"
>  ERR_CODE=3D0
>
>  _prep_test "null" "check dma & segment limits for zero copy"
> diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/test=
ing/selftests/ublk/test_generic_04.sh
> index be2292822bbe..2672f9c40fa8 100755
> --- a/tools/testing/selftests/ublk/test_generic_04.sh
> +++ b/tools/testing/selftests/ublk/test_generic_04.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_04"
>  ERR_CODE=3D0
>
>  ublk_run_recover_test()
> diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/test=
ing/selftests/ublk/test_generic_05.sh
> index 9b7f71c16d82..bda5064bc31f 100755
> --- a/tools/testing/selftests/ublk/test_generic_05.sh
> +++ b/tools/testing/selftests/ublk/test_generic_05.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_05"
>  ERR_CODE=3D0
>
>  ublk_run_recover_test()
> diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/test=
ing/selftests/ublk/test_generic_06.sh
> index fd42062b7b76..14a05054fcd8 100755
> --- a/tools/testing/selftests/ublk/test_generic_06.sh
> +++ b/tools/testing/selftests/ublk/test_generic_06.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_06"
>  ERR_CODE=3D0
>
>  _prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in=
 server"
> diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/test=
ing/selftests/ublk/test_generic_07.sh
> index cba86451fa5e..8dcfd8978f50 100755
> --- a/tools/testing/selftests/ublk/test_generic_07.sh
> +++ b/tools/testing/selftests/ublk/test_generic_07.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_07"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_generic_08.sh b/tools/test=
ing/selftests/ublk/test_generic_08.sh
> index b222f3a77e12..ce88c31d6b9c 100755
> --- a/tools/testing/selftests/ublk/test_generic_08.sh
> +++ b/tools/testing/selftests/ublk/test_generic_08.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_08"
>  ERR_CODE=3D0
>
>  if ! _have_feature "AUTO_BUF_REG"; then
> diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/test=
ing/selftests/ublk/test_generic_09.sh
> index bb6f77ca5522..744d0cdaa242 100755
> --- a/tools/testing/selftests/ublk/test_generic_09.sh
> +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_09"
>  ERR_CODE=3D0
>
>  if ! _have_feature "AUTO_BUF_REG"; then
> diff --git a/tools/testing/selftests/ublk/test_generic_10.sh b/tools/test=
ing/selftests/ublk/test_generic_10.sh
> index abc11c3d416b..4b4293b9081f 100755
> --- a/tools/testing/selftests/ublk/test_generic_10.sh
> +++ b/tools/testing/selftests/ublk/test_generic_10.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_10"
>  ERR_CODE=3D0
>
>  if ! _have_feature "UPDATE_SIZE"; then
> diff --git a/tools/testing/selftests/ublk/test_generic_11.sh b/tools/test=
ing/selftests/ublk/test_generic_11.sh
> index d1f973c8c645..e0dc0b8fe5d6 100755
> --- a/tools/testing/selftests/ublk/test_generic_11.sh
> +++ b/tools/testing/selftests/ublk/test_generic_11.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_11"
>  ERR_CODE=3D0
>
>  ublk_run_quiesce_recover()
> diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/test=
ing/selftests/ublk/test_generic_12.sh
> index b4046201b4d9..54b81ddfe9f9 100755
> --- a/tools/testing/selftests/ublk/test_generic_12.sh
> +++ b/tools/testing/selftests/ublk/test_generic_12.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_12"
>  ERR_CODE=3D0
>
>  if ! _have_program bpftrace; then
> diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/test=
ing/selftests/ublk/test_generic_13.sh
> index b7aa90b1cb74..922115aa14f4 100755
> --- a/tools/testing/selftests/ublk/test_generic_13.sh
> +++ b/tools/testing/selftests/ublk/test_generic_13.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_13"
>  ERR_CODE=3D0
>
>  _prep_test "null" "check that feature list is complete"
> diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/test=
ing/selftests/ublk/test_generic_14.sh
> index cd9b44b97c24..178443394ca5 100755
> --- a/tools/testing/selftests/ublk/test_generic_14.sh
> +++ b/tools/testing/selftests/ublk/test_generic_14.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_14"
>  ERR_CODE=3D0
>
>  ublk_run_recover_test()
> diff --git a/tools/testing/selftests/ublk/test_generic_15.sh b/tools/test=
ing/selftests/ublk/test_generic_15.sh
> index 76379362e0a2..727d0f4610d6 100755
> --- a/tools/testing/selftests/ublk/test_generic_15.sh
> +++ b/tools/testing/selftests/ublk/test_generic_15.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_15"
>  ERR_CODE=3D0
>
>  _test_partition_scan_no_hang()
> diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/test=
ing/selftests/ublk/test_generic_16.sh
> index e08af7b685c9..42e8d2e16ec9 100755
> --- a/tools/testing/selftests/ublk/test_generic_16.sh
> +++ b/tools/testing/selftests/ublk/test_generic_16.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"generic_16"
>  ERR_CODE=3D0
>
>  _prep_test "null" "stop --safe command"
> diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing=
/selftests/ublk/test_loop_01.sh
> index 833fa0dbc700..338a235fd82a 100755
> --- a/tools/testing/selftests/ublk/test_loop_01.sh
> +++ b/tools/testing/selftests/ublk/test_loop_01.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_01"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing=
/selftests/ublk/test_loop_02.sh
> index 874568b3646b..04c52454e2ec 100755
> --- a/tools/testing/selftests/ublk/test_loop_02.sh
> +++ b/tools/testing/selftests/ublk/test_loop_02.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_02"
>  ERR_CODE=3D0
>
>  _prep_test "loop" "mkfs & mount & umount"
> diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing=
/selftests/ublk/test_loop_03.sh
> index c30f797c6429..6e8f649fe93d 100755
> --- a/tools/testing/selftests/ublk/test_loop_03.sh
> +++ b/tools/testing/selftests/ublk/test_loop_03.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_03"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing=
/selftests/ublk/test_loop_04.sh
> index b01d75b3214d..9f6774ec0de6 100755
> --- a/tools/testing/selftests/ublk/test_loop_04.sh
> +++ b/tools/testing/selftests/ublk/test_loop_04.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_04"
>  ERR_CODE=3D0
>
>  _prep_test "loop" "mkfs & mount & umount with zero copy"
> diff --git a/tools/testing/selftests/ublk/test_loop_05.sh b/tools/testing=
/selftests/ublk/test_loop_05.sh
> index de2141533074..2b8d99e007be 100755
> --- a/tools/testing/selftests/ublk/test_loop_05.sh
> +++ b/tools/testing/selftests/ublk/test_loop_05.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_05"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testing=
/selftests/ublk/test_loop_06.sh
> index 1d1a8a725502..e73f6f4844db 100755
> --- a/tools/testing/selftests/ublk/test_loop_06.sh
> +++ b/tools/testing/selftests/ublk/test_loop_06.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_06"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testing=
/selftests/ublk/test_loop_07.sh
> index 493f3fb611a5..264d20e7c530 100755
> --- a/tools/testing/selftests/ublk/test_loop_07.sh
> +++ b/tools/testing/selftests/ublk/test_loop_07.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"loop_07"
>  ERR_CODE=3D0
>
>  _prep_test "loop" "mkfs & mount & umount with user copy"
> diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing=
/selftests/ublk/test_loop_08.sh
> index ca289cfb2ad4..2caa7ba748fb 100755
> --- a/tools/testing/selftests/ublk/test_loop_08.sh
> +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> @@ -13,7 +13,6 @@ if [[ "$fio_version" =3D~ fio-[0-9]+\.[0-9]+$ ]]; then
>         exit $UBLK_SKIP_CODE
>  fi
>
> -TID=3Dloop_08
>
>  _prep_test "loop" "end-to-end integrity"
>
> diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing=
/selftests/ublk/test_null_01.sh
> index c2cb8f7a09fe..eebce8076530 100755
> --- a/tools/testing/selftests/ublk/test_null_01.sh
> +++ b/tools/testing/selftests/ublk/test_null_01.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"null_01"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing=
/selftests/ublk/test_null_02.sh
> index 8accd35beb55..654bdff39664 100755
> --- a/tools/testing/selftests/ublk/test_null_02.sh
> +++ b/tools/testing/selftests/ublk/test_null_02.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"null_02"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing=
/selftests/ublk/test_null_03.sh
> index 0051067b4686..29cd09f06672 100755
> --- a/tools/testing/selftests/ublk/test_null_03.sh
> +++ b/tools/testing/selftests/ublk/test_null_03.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"null_03"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing=
/selftests/ublk/test_null_04.sh
> index 0b0719ea33a3..7491b8c17f00 100755
> --- a/tools/testing/selftests/ublk/test_null_04.sh
> +++ b/tools/testing/selftests/ublk/test_null_04.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3Dnull_04
>
>  _prep_test "null" "integrity params"
>
> diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testi=
ng/selftests/ublk/test_stress_01.sh
> index 7d3150f057d4..a9322ce496e9 100755
> --- a/tools/testing/selftests/ublk/test_stress_01.sh
> +++ b/tools/testing/selftests/ublk/test_stress_01.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_01"
>  ERR_CODE=3D0
>
>  ublk_io_and_remove()
> diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testi=
ng/selftests/ublk/test_stress_02.sh
> index 4bdd921081e5..6c114194f9c9 100755
> --- a/tools/testing/selftests/ublk/test_stress_02.sh
> +++ b/tools/testing/selftests/ublk/test_stress_02.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_02"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testi=
ng/selftests/ublk/test_stress_03.sh
> index 3ed4c9b2d8c0..4e81ca0db758 100755
> --- a/tools/testing/selftests/ublk/test_stress_03.sh
> +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_03"
>  ERR_CODE=3D0
>
>  ublk_io_and_remove()
> diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testi=
ng/selftests/ublk/test_stress_04.sh
> index efa8dc33234b..6c6f44b172bc 100755
> --- a/tools/testing/selftests/ublk/test_stress_04.sh
> +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_04"
>  ERR_CODE=3D0
>
>  ublk_io_and_kill_daemon()
> diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testi=
ng/selftests/ublk/test_stress_05.sh
> index 68a194144302..7e9324de2030 100755
> --- a/tools/testing/selftests/ublk/test_stress_05.sh
> +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_05"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testi=
ng/selftests/ublk/test_stress_06.sh
> index 37188ec2e1f7..c72e5d0b14be 100755
> --- a/tools/testing/selftests/ublk/test_stress_06.sh
> +++ b/tools/testing/selftests/ublk/test_stress_06.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_06"
>  ERR_CODE=3D0
>
>  ublk_io_and_remove()
> diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testi=
ng/selftests/ublk/test_stress_07.sh
> index fb061fc26d36..04c2764d5238 100755
> --- a/tools/testing/selftests/ublk/test_stress_07.sh
> +++ b/tools/testing/selftests/ublk/test_stress_07.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_07"
>  ERR_CODE=3D0
>
>  ublk_io_and_kill_daemon()
> diff --git a/tools/testing/selftests/ublk/test_stress_08.sh b/tools/testi=
ng/selftests/ublk/test_stress_08.sh
> index 9abb50ee3d00..37f7d204879a 100755
> --- a/tools/testing/selftests/ublk/test_stress_08.sh
> +++ b/tools/testing/selftests/ublk/test_stress_08.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_08"
>  ERR_CODE=3D0
>
>  ublk_io_and_remove()
> diff --git a/tools/testing/selftests/ublk/test_stress_09.sh b/tools/testi=
ng/selftests/ublk/test_stress_09.sh
> index 87b92b0a2410..53c1e3b2ab30 100755
> --- a/tools/testing/selftests/ublk/test_stress_09.sh
> +++ b/tools/testing/selftests/ublk/test_stress_09.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> -TID=3D"stress_09"
>  ERR_CODE=3D0
>
>  ublk_io_and_kill_daemon()
> diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testi=
ng/selftests/ublk/test_stripe_01.sh
> index 4e4f0fdf3c9b..3bc821aadad8 100755
> --- a/tools/testing/selftests/ublk/test_stripe_01.sh
> +++ b/tools/testing/selftests/ublk/test_stripe_01.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"stripe_01"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_stripe_02.sh b/tools/testi=
ng/selftests/ublk/test_stripe_02.sh
> index 5820ab2efba4..4a7d2b21a6bf 100755
> --- a/tools/testing/selftests/ublk/test_stripe_02.sh
> +++ b/tools/testing/selftests/ublk/test_stripe_02.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"stripe_02"
>  ERR_CODE=3D0
>
>  _prep_test "stripe" "mkfs & mount & umount"
> diff --git a/tools/testing/selftests/ublk/test_stripe_03.sh b/tools/testi=
ng/selftests/ublk/test_stripe_03.sh
> index 20b977e27814..a1c159d54e53 100755
> --- a/tools/testing/selftests/ublk/test_stripe_03.sh
> +++ b/tools/testing/selftests/ublk/test_stripe_03.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"stripe_03"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testi=
ng/selftests/ublk/test_stripe_04.sh
> index 1b51ed2f1d84..0c30bd6c2b3b 100755
> --- a/tools/testing/selftests/ublk/test_stripe_04.sh
> +++ b/tools/testing/selftests/ublk/test_stripe_04.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"stripe_04"
>  ERR_CODE=3D0
>
>  _prep_test "stripe" "mkfs & mount & umount on zero copy"
> diff --git a/tools/testing/selftests/ublk/test_stripe_05.sh b/tools/testi=
ng/selftests/ublk/test_stripe_05.sh
> index 05d71951d710..6ddfa88ad226 100755
> --- a/tools/testing/selftests/ublk/test_stripe_05.sh
> +++ b/tools/testing/selftests/ublk/test_stripe_05.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"stripe_05"
>  ERR_CODE=3D0
>
>  if ! _have_program fio; then
> diff --git a/tools/testing/selftests/ublk/test_stripe_06.sh b/tools/testi=
ng/selftests/ublk/test_stripe_06.sh
> index d06cac7626e2..a2c7bf4cc613 100755
> --- a/tools/testing/selftests/ublk/test_stripe_06.sh
> +++ b/tools/testing/selftests/ublk/test_stripe_06.sh
> @@ -3,7 +3,6 @@
>
>  . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> -TID=3D"stripe_06"
>  ERR_CODE=3D0
>
>  _prep_test "stripe" "mkfs & mount & umount on user copy"
> --
> 2.47.0
>
