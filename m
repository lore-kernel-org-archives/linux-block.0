Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805D48F84E
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050342; cv=pass; b=DUdRFlk5ZW0DOQqXaSAPYYxgkYRTXgM305JA2EfVhLCO8krEc1c67LHS6Ce2OlG9xOu+yvH4n77CF9+gHKaXRPuuleZ+2hz1cWw1a0TEfleI/jHDxhpTUDsiNmbXRHL+A7OCb4OBTTsH3LfXmA3TCp2RFO+9IkzRwL14mkmQ/MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050342; c=relaxed/simple;
	bh=iexBxeT1r80QFrStcwB2/AMqN63Tsm+wJYHNQeJSdVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSpdWUcdcFllDOlVjVv1Mx+f0u218uHNBj9OSLrVIr3Wc67+dVMXpswPi+IQlQ8yxz9jjlNhcx4ryjoP8B+fBrsAMAVHlIh97gZK2Gon9kdJ8nK7Afc+MX5VTpppDaTrtX3E/pH8I5Ti3++x+XKpnXfhHL2Ye9R/4yvyIzkLWDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJp4vwvC; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJp4vwvC"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c13f2685f2so1102405b6e.1
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 07:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789050339; cv=none;
        d=google.com; s=arc-20260327;
        b=op79n7WvOTdykmAw1MOxp2fLgYqiwLEPi5GUdVq9p3zm7I892pTcAtuODuNU2hQftJ
         B96bsN/q73Or8UV8iBEPMcIJPqhk3EvLhj/zaXSdio0YYzPX5JwB5ZTrVgwyKkR0Pk/P
         PxuWepIckDR+fSNyANV6Q8kO9uTPizTl++LJEClgBM4nkH2EbSiaByIa/gkGqb/Yq+HM
         XsLmJrcOwk2GRSd3U19bxzQ0+U+Gd3YthIgVc8UXlJzEmObUl53PYoK7ujzHS4ZGe4ul
         5PDGSpVLB3tt27GXpG9lCKpkQOpj2VayRT/cNlhz+veVtZLzpA9fy4ftRMPbkKffjxME
         D3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=haTWqSj8+sulXARcSdY+bPVghCT1LWLKYiL7Y87SzJw=;
        fh=3A9V9bpbGj+pUnu+dxxLVzFB8DCgU7ggFbaUoLDEk0U=;
        b=LO4nNpKeMlZApc6p1bVfYBH8HNy7smf44qBz1PgZ8MUr9SeXEI+pLzPEMDF/68G9b7
         W8QgyB5hA8C9escZLT2plqmRr2ylrWt//E/d4otwDnDgSQ5YqtpeNlDRWE/oYoN8gAk/
         UcuXva3Dyf5u7J9EB07i5I1Wq0KIwEFMDGkXBa8GHHvhK1LavtpxbIgEckiAaiHPIN2Q
         6B+OJnqPnT1EBtymV16FDOddB4BVjxOC0UhJP+UIMNNXroEAzwwqz4sP8nIE8+UxP/tM
         lUCW5/yB5AFsdEXHUpxWcCBC6mbZVrLTGBlMHPzvBPM04t1j/GXn0H0gwe0XArE0uDpe
         PIRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789050339; x=1789655139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=haTWqSj8+sulXARcSdY+bPVghCT1LWLKYiL7Y87SzJw=;
        b=FJp4vwvCiR0x6tmzF+PcmZUx009lRz8h32k3K3kUFuuTRyj6aojucLDolDzlQz7TuP
         h4Qwi8oqxvxbEx1Qbc77NKmkd9pSc02yDxBqFrTNd7d/gqAj8rPVKyyh77hFuI1OkpQT
         R/bdwydN4x/Lt/8Nlb4XlPRIZezfOYw58Jzgbztd27rvzE5uLT2zFc/odd9vmQ3ZeLYR
         VL4NY3l38El3Mc+PhHQkmBsOdRcM+BjqBIOIAOHvhp1gBWzBKKMRmWA80FOBBPZvHDTx
         i6P0EA/TnFF1lidh3h1cRigRDPMyt4aVCBSK9k9KEMXJYNaFOG51bgcV3PM46gwokp1O
         fUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050339; x=1789655139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=haTWqSj8+sulXARcSdY+bPVghCT1LWLKYiL7Y87SzJw=;
        b=oquZoDp4xIQWvpHUGQ+vWoHoxb3LytbC+/LjEkfuLhxFbgfNh06/v7i/YBegpmH2mY
         0xXw5ZGmTyNqwsN+9TQ81A5Bs0CqKDRv8sXsJ03v3BjpPr8fmQFGbSdlTBPWsD6BCMvC
         IvsWS1Q2CJGawNyUAZr77AqWpnDApqAcj3x59W35s6EitUxlx5ZRp4VjntbBM23FzJnh
         Ma/n/5ivogCuLzUyMyuLI6OX2WM3U4aRTFZGs5G3vewQ3xmvW1DSblaC/GXFPT1Lur2w
         hcctnti0HamqF90wK0jSaecCmIbdT00x2/uWLKT0K2LVrX0sedvxshaJl6vScxV3BdO7
         P33Q==
X-Forwarded-Encrypted: i=1; AKwUvByR9ERkpE551qaoWni6g5If/BdLrPUSykD6xjpsghCvUdvXTqIr5fh4wn7IyBc8w/Ic9xmyK1cWzyo3kQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n+aux2cadbzr4FWP/Gl0Ta3VsO2G5ob7yDkzg9SNJOqXekS9C8
	lcSfMsZ9Fi/UXW/wIc+tyZykoM0/GiJf6THMWd3gnbiDpnPLZGgzaPraDgJk+ZGiyeVVsoJhnS0
	WH83ioGVVilOjCOvZm9xyQa81DXvobf0=
X-Gm-Gg: AYBFou2XOIr3qJ9l93X6kGPGmoYr7v2l4DzcIbck854pOBuCUrq4/giZ1FCJwEPhOxK
	jTNHPhqfjZ8on6loTzP/LkWiIZILk1288HgHa/i9lSl8C02NgTQwdJzcrfKnNgtPmRRChagFl3Y
	UZLK07pUqICFbp7Pkzrf1FbQhY6WEVmU2B5J2ByZHj5mil7VnPDYKgZSWr6OCgOEz+946zXQ64j
	SHOgs0Pq1CGj1grVgsoLm1P1U4pr6neEi5iRkJqHrF41sdMAuCU8wxOdlxV912Ej5aMpfsk6rpA
	QehHILjl/V/vns/W9ZKesE8uIZ1ZAFVqpO1DxXBk+e7dwNk96+2gUAeWKwYzYJKIN1KG0F907lt
	m46Ha5wZZbIxK5wEhziHHnkWVz1P34fzFlv4TGJbiC6tPMY+UDrjg2MyyujJ7Pr5XHQ==
X-Received: by 2002:a05:6808:4f0c:b0:4b2:8d91:ef6a with SMTP id
 5614622812f47-4c13fa8795emr5586961b6e.8.1789050339246; Thu, 10 Sep 2026
 07:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132602.68852-2-mngyadam@amazon.de>
In-Reply-To: <20260909132602.68852-2-mngyadam@amazon.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 10 Sep 2026 09:25:27 -0500
X-Gm-Features: AcwNN1Uu_GuAXXJ2Be9f6O__zza3jhEo9v5mLmL2JzR85KZC_M254gRqoHjxODg
Message-ID: <CACVXFVO7YD4ckMPgZJh7=oxLMjka2UG_vkNcfECCBpkSQ7SHPQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: install test_common.sh and trace/ scripts
To: Mahmoud Nagy Adam <mngyadam@amazon.de>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:26=E2=80=AFAM Mahmoud Nagy Adam <mngyadam@amazon.d=
e> wrote:
>
> Every ublk test script sources test_common.sh from its own directory:
>
>     . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> and test_generic_02/12 additionally run bpftrace against the scripts in
> trace/. Neither test_common.sh nor trace/ is listed in TEST_FILES, so
> "make install" does not copy them into the install directory and every
> ublk test fails when run from there:
>
>   ./test_generic_02.sh: line 4: .../kselftest_install/ublk/test_common.sh=
: No such file or directory
>   ./test_generic_02.sh: line 8: _have_program: command not found
>
> The bpftrace tests are affected even when bpftrace is installed: the
> missing trace/*.bt makes bpftrace exit immediately, and the tests then
> report a skip rather than a failure, which hides the problem.
>
> Add both to TEST_FILES, matching how other selftests ship their sourced
> helpers (see kexec/kexec_common_lib.sh and zram/zram_lib.sh).
>
> Fixes: 6aecda00b7d1e1 ("selftests: ublk: add kernel selftests for ublk")
> Fixes: 723977cab4c0fd ("selftests: ublk: add generic_01 for verifying seq=
uential IO order")
> Cc: stable@vger.kernel.org # v6.15+
> Assisted-by: Kiro:claude-opus-5
> Signed-off-by: Mahmoud Nagy Adam <mngyadam@amazon.de>

On Wed, Sep 9, 2026 at 8:26=E2=80=AFAM Mahmoud Nagy Adam <mngyadam@amazon.d=
e> wrote:
>
> Every ublk test script sources test_common.sh from its own directory:
>
>     . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
>
> and test_generic_02/12 additionally run bpftrace against the scripts in
> trace/. Neither test_common.sh nor trace/ is listed in TEST_FILES, so
> "make install" does not copy them into the install directory and every
> ublk test fails when run from there:
>
>   ./test_generic_02.sh: line 4: .../kselftest_install/ublk/test_common.sh=
: No such file or directory
>   ./test_generic_02.sh: line 8: _have_program: command not found
>
> The bpftrace tests are affected even when bpftrace is installed: the
> missing trace/*.bt makes bpftrace exit immediately, and the tests then
> report a skip rather than a failure, which hides the problem.
>
> Add both to TEST_FILES, matching how other selftests ship their sourced
> helpers (see kexec/kexec_common_lib.sh and zram/zram_lib.sh).
>
> Fixes: 6aecda00b7d1e1 ("selftests: ublk: add kernel selftests for ublk")
> Fixes: 723977cab4c0fd ("selftests: ublk: add generic_01 for verifying seq=
uential IO order")
> Cc: stable@vger.kernel.org # v6.15+
> Assisted-by: Kiro:claude-opus-5
> Signed-off-by: Mahmoud Nagy Adam <mngyadam@amazon.de>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
