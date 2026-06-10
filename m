Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A43F888F
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099737; cv=none; b=gO4pkhrOyQbuq2NRatY200EijkHUwdNJF2KI7uo0a9rQFOFCn7hjWYAJ7fyd+KJEMIc5B0ZkAkDdS1Wj5l41nlILLYwvrJfgK2qxlc4Td5ylQraeXXkcs59TCjzq3DCWTbaTzesloiKRAdNlHMUEHbNctVGl4/XzbqZN+J8YWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099737; c=relaxed/simple;
	bh=nt244tUHpxINImQJOka9hSreeGR91MwZI5IU3d4SKrI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fpsf0UgZBs7JTd1TiaX7MWQBh75EbYaMAiwe+E4K4/AyPI61JOtCgLQuIHkWoarC57D4CfPhEs5rzh9ZNqispIiFlPN54Wa5890AP/W5GhgkPlhnZ6brLJ6UfOyviA/3N2a5i6DibiZuzsgDCsaNaQTtaPnFUG/psPOLobvGG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOnR3NXn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOnR3NXn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so5308204f8f.2
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099735; x=1781704535; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrfD1plP1bimcA7C6IrsDX2w89PrVAfDKwGHaQaTOpA=;
        b=BOnR3NXnRVlBYnrqoRI/u4Kfp4NwJRhTug1nif8Kmm5r1FmvFCmbzKck1a2zmdsf2H
         X1aRCIfLtK3cYtbtXWKvtqlR+a1vuyLqPIs1174aCV4Z2AvI6rSEZFebZKsB1sWoRJ3v
         AHcL5PsnK6jDzy9gBfbN/XU1S6VEoeGWTSp6vytNkPFNiQ6/DaYF07JKdZv/cDtoQgRY
         TbT/ywT5emwxOId8+i/h08utyOuH3FEbyJ4C1PZzMn4Yl/m61UZHYfMflK3WBtwOPcan
         RkfJXGP2d3rRSy/h1JuvLxIRq9kWYcW3/ufiVG/t8KWx0KJVng+HyvTWteTRNn9ToCje
         8mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099735; x=1781704535;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrfD1plP1bimcA7C6IrsDX2w89PrVAfDKwGHaQaTOpA=;
        b=IOcLoeTH1kiJvXjXncX7ew/+93WOy9WQlkh3A1HcEZLcMcpNn9ks+TsCpYqP4uW9vx
         FFJ2sSbuMSju8tCp3os66etNHAGeaBtOl8wqG1TYf0+IEeIob989Kcn/d3lTF6aT8uRl
         Zfw3MH7i/8lAoquNtUSvJNZYCd0wbr6TG+q09vVWQUmC5qc6gZTHB9QfUAjwPYra2t9V
         wEUdYEQBPbISl1JHr4cD1WpFmcWeZwwh3svSvW/XN7eY2ixKIUdX72T+SszSPlLPylmD
         bMlvzmk3ijUQx8WJFZzo5r01+8jZPaLp/pFUpdI3SERalhwaKWt2h0RG6hBrAp57C1m0
         Vppw==
X-Gm-Message-State: AOJu0YzSOIx1EIeWcm3M6hWQs/jdm2Fvou+k4kI7oew/d79GRefr90lZ
	8JNQ7/o4/93xUgnJqoXMtdLioM7vXLHoGcVPJbo61dMcEUbdu3sp6iTa
X-Gm-Gg: Acq92OG1xbO09sdUsb1hPdRC5mlUL5MgjjU7IMOP18zCd7sZFBUQAlrxYvPOu30kHa9
	W4h5kijLl4z5biPE4ZUY1IvwPsiw0e9OjTsNFVboe+vucM3D44A14ulkqEVcaLhxF1mKXLXSn7a
	CskpbU679ChIcJeWMfDVA/v5t78Bm6tseAwSBgfOsSyaQNJ/zQrken1dybqbExigpjx+4CzkxB9
	5NU/B99mPPfi8M3vxmzVID6GPgwgJc+kx1EWsszVUYIyd0OsDMyEOSH0l9CkYS7gg670+saPSc7
	s4k95poqgcOz6ean4HlQYrYSJ13GXztaDDjvbOk89yv5hIhKWdgGGWT27e8dozshYfXmiz3386u
	aJDrn5iQ+TtibEIT4gxs6WrDj1vTso8moIBfEJ9rax3T7h9+B5WYWPuaKY3K3fjln41rFuOZcOj
	400fsQLwT3aLFXcm2jGAcYjukhFT3osLZYi3pg1D7bjTp+yra+gyDgA/3X9DMxWJUty14=
X-Received: by 2002:adf:e014:0:20b0:45e:f29d:d438 with SMTP id ffacd0b85a97d-46030618a38mr27777125f8f.28.1781099734405;
        Wed, 10 Jun 2026 06:55:34 -0700 (PDT)
Received: from localhost ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm73903398f8f.1.2026.06.10.06.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 15:55:32 +0200
Message-Id: <DJ5F5T5UIXRF.IVVHFP62M2Z8@gmail.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 23/83] block: rnull: add discard support
From: "Malte Wechter" <maltewechter@gmail.com>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Alice Ryhl" <aliceryhl@google.com>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, "Benno Lossin" <lossin@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Boqun Feng"
 <boqun@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Jens Axboe" <axboe@kernel.dk>, "John
 Stultz" <jstultz@google.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Lyude
 Paul" <lyude@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Stephen Boyd"
 <sboyd@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>
X-Mailer: aerc 0.21.0
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
 <20260609-rnull-v6-19-rc5-send-v2-23-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-23-82c7404542e2@kernel.org>

On Tue Jun 9, 2026 at 9:08 PM CEST, Andreas Hindborg wrote:
> Add support for discard operations to the rnull block driver:
> - Add discard module parameter and configfs attribute.
> - Set max_hw_discard_sectors when discard is enabled.
> - Add sector occupancy tracking.
> - Add discard handling that frees sectors and removes empty pages.
> - Discard operations require memory backing to function.
>
> The discard feature uses a bitmap to track which sectors in each page are
> occupied, allowing cleanup of pages when they are empty.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  drivers/block/rnull/configfs.rs |  15 +++++
>  drivers/block/rnull/rnull.rs    | 120 ++++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 121 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/config=
fs.rs
> index 2f3fa81ea121..e47399cd45a4 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
...
>          }
>      })
>  );
> +
> +configfs_attribute!(DeviceConfig, 10,
> +    show: |this, page| show_field(this.data.lock().discard, page),
> +    store: |this, page| store_with_power_check(this, page, |data, page| =
{
> +        if !data.memory_backed {
> +            return Err(EINVAL);
> +        }
> +        data.discard =3D kstrtobool_bytes(page)?;
> +        Ok(())
> +    })
> +);
Should it be ok to set 'discard' to 0 if 'emory_backed' is not set?
In the C null_blk driver, 'discard' defaults to 0 if 'memory_backed' is not=
 set,
it is also ignored (and defaulted to 0) if 'zoned' is enabled.

Best regards,
Malte
