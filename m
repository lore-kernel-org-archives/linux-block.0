Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B3370D5A
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598912; cv=pass; b=R8r72evu/v+OhwaLt+Bx0jnldneKpiHNMpNGDxFTDSJMaRFqoMgk5mwwDaflUth0N+UPW0OGokE6CkdN1loqkURL5eGOomU+29Ps/IY4tiiIFcHvfmM9eRDurJJHxVk/6o1gzVc2KbTJQAjkXzNzl5iubVnb4N0v4wX7Z3qyFbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598912; c=relaxed/simple;
	bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkq7SEyiqkERp1ej9LHL0gBmpjkFcLwlSUGlxuGViQzZMsGWPb9qIZV6fNQz2R9IE8vT4q+wL0Cw70od/uN3bsi3GNQkVqAaAQDaOBTQHJR1WKfCdJup5oZgm96QTcpGTs7kWKEM5L8/mj25Eq782m22FaSuupWCLHaxe5Qjer8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzAlJRqp; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzAlJRqp"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c0c4194b2bso12315eec.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 11:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773598910; cv=none;
        d=google.com; s=arc-20240605;
        b=cWv5vkjs+w75Ww/n/ApCeQGq8BV/gO25cBZfFWxgx71pp9y9sH2Qsyvy1kvbB17tXc
         ozpsv5lHOCwVwAuK0cI+ByZv5W85FPrXc/jrhu7kRqUAArb1p3TFEoVj9XiPKyQl+tOr
         GAj12WbRrTteFaUuOO44p597LmEff4Yu0izLNmmskLHnt0xqCHYWb8vKzBDIiClef2/2
         NkKcgK5fc38HMY5ofoIab/BFUqZikIOM4qGGoCstZs+TrQHG2EyRmEsnzwlwuJ4wnOMG
         HJEPLVVDlhlfPUx9upLmcQM+xSKe9nCdYvHWFOVAOAFSS9kcbUCdrjQwLGj4AXDDP1Ta
         vZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        fh=2x+3709cBlc4BRsBS6JhP2jwNWijkYwg8g1MxXW+94Y=;
        b=cC/q8lIfWb1GB0S5xRPw7n0ceVCvEqpsjNWegZj3JaOXif9ttMpnY7QSdF5+c4tMlC
         D+bqjaKcVP2N1VDaG8oel3LFOq5cZy7QVsUjIvZoPh7hIis3MqPxIN62YP8lLVZTY1p8
         96yedAKVe26WaW6h+IRc3yO8DH7L6abxt26E3ZPjB9RSQHswH4cFaQQZXOSjtrkN0GN8
         +EnMFpkc22RIrE+Z291YT/V7FQUO0iyqWitx5ctS4msl3xI0MrXKgP4LyetuYPrV15wl
         VIiOEHVsGQ2RNXRBEu3L+njQNugm4PmPF3iXTI3dNIXmAbidDyRyTrLoKxP4hW7qfQml
         Jr7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598910; x=1774203710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        b=HzAlJRqpf00I5iuQt5ArG5L+zYSPg/yyi6fxZTlxjCp8CMRwrePyDzCKJL+Mh7EWTn
         4IJglDFQ2a/LlW0rB1AT2104r0NadyvffSV9BwRcGBMC5X8zdcvieSw6xmPf1J2w19CT
         MiZMlT1z7h5XQ1mjNI/XDQ3MWb9++Auq54bv+AQf90hLD1mZlQTgnWhbO+pjApY/+N8o
         7FxCHbVJDUTvRLiTdSjS8PEkoERw2lAkJFP4qHcP8JRq19iBMPtUVSy2U5oTHJ3cVLDE
         4zGE3LJSoWMPICo7qW7d6FcrHBxrUtnFzvbbGNGdtQdEN/vPrGdifYVq3oEgGc4FF4kQ
         zoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598910; x=1774203710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        b=TLw9J1joh4qKktNkkn512jVto/5lakUR+ZqrEU7aHAs+uwHUWMBbveDNkBwwQO222B
         O2gWscS/Q9QcEoKLuryP6czF2WNN1NjWTlG17ikdy4mlpdlrSRvErKQcC5nSQw3yV/Kr
         nAPM9ECtNdsWDnLjuwv3xDPzi1rfVmRs/eAa+a3+qFDevID2/qJQaKXONqjTSkqAUEQJ
         PxInGL7HUvb8WYKni+a2RNtCrjOlTPL2F/ZLGEaCnIByd/QVBANywmbbCieypph512GR
         x9jDHOTYbqjXI6Zz3KQys5iuRVNPD6R45HxLdbz8tq1mLnx75AXwl/aWdvZvN/Lz+yVJ
         ycCA==
X-Forwarded-Encrypted: i=1; AJvYcCXM2oskolCCb0gbGs+bFkaPlwXaRt7EM2i/LAgxMMc5LIxjPWFLeaNuIG2VouYYbWCNnfpfz/dSkOBHuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfgeYenZbAMr7avpPrN/Vx/j40nEz288GJwYLHprnyuldSex8
	KMNspVhHJtBbrQA3tm9srdUK85Z7RTzMgSobmSxfHU2cEPDZ2kh5eih+Btut50l0Y/N0+xSmQ4p
	1+5aUrdB+c0l1hQ4VnUiqszDlEzSRex8=
X-Gm-Gg: ATEYQzwQaa1fdVsmZ9RECC39c+Jy44peF/24jQvaTmXloHTbskdsQDVhsECdvTzxX60
	8ZDFOPzfwNGZd8B3s4JApTpItOsw8sylchBlq5dHwgP51Ubu2QIfqImsaJ3kqCVTETDmSIrVWEY
	5ozYbbkCjPkx62lptNMQoMr0bVkToIvbda9KZL188fMN6eaj2Qey0wHr7rK5G224vH/8IYO+R48
	123XDZWBY0l3EoBdqjJ0Cc3W/aeTabTO6MUOBwctLDf/LHLBT5mWslUqRIrE5ehCypkhh9j7Cfx
	9c3eLHWFwJbjTIn6GdlQL38tsMnElZ5Cl8F2B1VrrV9RPs759aQH6q4ztBaRwkrluz61FPI03pK
	btpOFmJmkImnUtNmk59HM3qI=
X-Received: by 2002:a05:7300:4313:b0:2c0:bcca:e9ae with SMTP id
 5a478bee46e88-2c0bccaed2cmr503104eec.7.1773598909944; Sun, 15 Mar 2026
 11:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 19:21:37 +0100
X-Gm-Features: AaiRm504huR_jEPQjv25PhnCGlqvxnPL_8XhiojOoKqXdkJjPbWUaTm98aG9g50
Message-ID: <CANiq72kdfYLmhojMo=vOAc5tULjjB9V4bM=iUmm5cLGpF-zj=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boqun Feng <boqun@kernel.org>, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 6:27=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
> These changes were previously submitted as a single monolithic patch
> but have now been split into logical, atomic commits as requested.
> The code style has been verified against checkpatch.pl.

Thanks for splitting it and fixing the diff, this is way better.

However, it seems you sent v2 three times. Was that intentional?

In addition, it seems the patches here are independent from each
other, right? Patches that go together in the same series are supposed
to be related in some way and/or they need to be applied together, so
I would suggest sending them separately.

Splitting them into separate patches also means you will have a
smaller list of maintainers to Cc, since here everyone is Cc'd for
things that are unrelated to them.

By the way, I would suggest using the `--base-commit` Git option when
generating the patches (optional, but useful) and also Cc'ing
reviewers as well since that will increase the chances people will see
your patches (you may want to use `scripts/get_maintainer.pl`).

I hope that helps!

Cheers,
Miguel
