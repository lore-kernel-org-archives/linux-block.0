Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874114FD7B9
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781981; cv=pass; b=FTWbHJ2T90ewdS5fXiulP3Sv2NqFGHqcrWDKtw+YLUhECeV2TbwZykcW33EWdUQj/jVQTkRZUl52PXNaQwdbtQrFw6mV/BGLC/UjPzMXoevutX8K/znGJL52VbO3fitx0Mq3oa18s/DIFq6U7hsploukxt2seMydbotgySs12Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781981; c=relaxed/simple;
	bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV+nmOKd0LslmbO5xtFDEi3RIZe/l5PglfVv9T5DxVIzTilyDHXFQFHkt0gcd8xSeBzXBfw1DsgktrT5tB65pWzSiMcnPcbsAWVIeTId2+tGm07QyOimNV1XUyNxGSzudJUvtn6UISaSqaCsCkK59zX+x2nkYbF6thAtRQ7rjmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2l7/XlY; arc=pass smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2l7/XlY"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bc6ff6cadso784766eec.0
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 08:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790781970; cv=none;
        d=google.com; s=arc-20260327;
        b=DCb1uN1ulYd9UzmjRX+KMudfo2+BTnOhWT//AhJb0RTrQyG7/2k7UnZTi2j6DntCjD
         ciudhFs9Gihn4rJItbzgIU5eaM82UuajTrJNPE6e2FcfL1vJxPT42nbUMUx650GXBln7
         VW21IFadWmQENg9pKYsOVt52AgN16LD5tKG7n2NCqH2uLrcR/+WAO2bx+NYNEIY3lXAE
         Z4tc1CbuYigC/4KTX/o5HyNAbvfEiE20W/RSUdCyi+m1rJrFlH4XmknvkGN6jUacZv3e
         kEBTGSziI4QD9nolilaXvYFqJfg9JZ5Yyrs3cvGvUG9y32ArvqYltY9Zy/9Wv6aXjYZu
         lV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
        fh=UHdaBCZtV6jfbKyPKHQQnMhnWWL/UcKLHx205SZsSiI=;
        b=rlmYAwohyLX/d1tgD5Ur1Xcz7yoILxdoIuXpxCC+k0e4tFVKwqvC4Icjq1ZYahVzd9
         pKhezJjjfDY80bym3FUcER9o995agnTr55pkZXY+mi8aE1RNZ7uym+OxUI0gvH+6lYmG
         cvKj5M9WYnDfb616yavuqoPOvdbPKgka4kKPeDxjHQgH34eeDl0RgTEj589bgIgBZIsU
         2UGJiVyBFgmJZCWB41Pe7uV52R9GqcYzatiAb1xQvX2C3IFP7PjvcWuRNdD/u0FtJyjL
         o1eLg02+08be0lWVdrjJdntgdT2lrLbUWGrCQCuhiwsRxpyfiRxATpUv6RALtanvsBzm
         hbNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781970; x=1791386770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
        b=G2l7/XlY3zQ6NT95T4GJIABV70dQH3YXfhm4enxJMeipuwl+3j1XoUkEd8u8oHldOK
         esuecKKwebCbmzlTH9xuDG4FzzeSEAX58acn2Sv6Miqp0XhSDE5nU4vxFdfpDOVZZFRc
         LwN+K2QUSnmzMioeswr6m+PTzU01zYe1ikW/ZbHMWFZtlbNdvpl5a0gl37FJqtb0bRX9
         5g52nlVMtKtu4x6GY2+fQcJiHz85/rlk573rk9oNCNmlG4aPmR/XFdDVLgpw6NBLOK6Y
         5SGhhvCUzM97hK80rknNUoW6UjGSqbJUARHn8XvaFHmRFork3u6xX2D8znP/ZC8nJfjg
         9CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781970; x=1791386770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LS3U6D3bE8RIAvF+h1U8Lgt7te2vLbKOufwxJeZh9A=;
        b=WH6nrG9wS0OJ0QAdq21TjC9PWb1YK3NznmU4qZlKcC3unNTyw7xVhyvR03tfVJfgw0
         Z+a6fd4vgr/j4/3PWQLCeZF4AQjJA55r+Au6LdC5T8ETqSq7stz6fHlOrACVZK2MhAzd
         JmNH+vNXKFChpB6IaYq+JZYwEPliVkdA2ECZxfp7c2jqC1SqQX8qFktmjqZy95qtkAql
         6bpTrz+HaPA3bhx7fOvn8hwFo9bJC3SSNLjNXl03t8iV+5O2xZToLDwi/4wqL1lP/Kqg
         fitrrvYZT4u7B/uPvNnPdxLH6+th3RuSBmy7C68yB1wFlAu3jCf42gWTmqKbw3D83PeX
         XCRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdKDXTBeQFFv9dX111VhthhowdPIEzdmfzYJo+07ecGFyXFdng6l2L+GUHUz9sd2tLhog392Y04Mrx5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKhk1M65ngHZtgP/MOpe0TUyi56JvTafKhWSTAXWaHIfg0tr9vp
	lI3vrRFFuyIXg09zRadTkUuHJHJuMAjl/4fiwXdLyCw8F5pwJmX7Q/rgx53kBdzNeq1ZXL1161B
	8hmOcLfRFBbyl0oz/Zk1quIe4xRNeUoc=
X-Gm-Gg: AYBFou3oSCrOd9p5WNw/9KA27gr7w3OS1k9+QwEqj0u+Lvh6sBZxrD4+9n2+7ytocuw
	IfMYhk6UeYDfNqaWkePBbiKlN4bj8tr1JIIdwGg+QiW6DJ4z4lLD4u4MstoE1+Fm9i4xTygpmh9
	oRkPjQMPp6yzYzRRUMSXXBDXONX+dw4TMiNEP1sTxfElzKdS0up81onockKyvuwdDFcO5Lraxhg
	MePTqj+UtDx7/S2FHyEE1S7mv2rNgbcL0tuhB1jLSVJ7qiL4FnutHOaHauvUqHFcM6xNBDSWO5M
	bgkUzvDCS/RDYAkSXbphNZDW7iZm+JD8s8FTlHaLne8EeRRYhcwHsy58oOgSmBhxGfZ8QzjwkOO
	yh4vY1KxdoNpaRqi5S30ShjsVIhvve46pe8dqZt3MoaVq0oNipO1Q+YXC6rfnDbe08/GOOlYvh/
	9BxXk75Yf4065TXdmNMW3HT7vprF8tV9gTyMRRVILBLEajW/bKqPI=
X-Received: by 2002:a05:7300:4fa9:b0:33e:8552:6e06 with SMTP id
 5a478bee46e88-34cd6003e42mr3012710eec.0.1790781969755; Wed, 30 Sep 2026
 08:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
 <179068244058.1205226.1765319338142659278.b4-ty@b4> <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
In-Reply-To: <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 17:25:56 +0200
X-Gm-Features: AclHuK_OBw9tG-s9O8MtvXyTH10ESbf_7IiKq4RprYC7l6RRjV0_TwsAnU0VqBg
Message-ID: <CANiq72nFiT0EoL8Z9iPT3xcPWynofUAs4F2gb6-NWmUQmtBHPw@mail.gmail.com>
Subject: Re: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>, stable@vger.kernel.org, 
	Priya Bala Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan <ytan089@ucr.edu>, 
	Sophon Z <aiqubits@hotmail.com>, Qingxiao Xu <qingxiao@tamu.edu>, 
	Malte Wechter <maltewechter@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:07=E2=80=AFPM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> This series showed up in next today and broke the build for me on
> various Fedora releases for aarch64 and x86_64; reverting this series
> fixed that from a quick build test limited to drivers/block/rnull/
>
> The full error msg is quote long, find the top of it below. Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-rawhide-aarch64/11055137-next-next-all/builder-live.log.gz

Confirmed, I see it e.g. in my arm32 build.

Cheers,
Miguel
