Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79A3B71AE
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747260; cv=none; b=da5KLpSZOmE00uUnDW/hGpfDpBM1Tt1HH6GamLI3P1t0bT8seN6m6gNRkjavE/dKAxky2S+9EJj95SmrAuN7+X/YCzhseOo5BAImkVnEj8bNuFZsANkIgwWvsaHNzqq+47Yfj3QbvVb7WTiEMpgIhh/uWc3UOz0WP4oPtLr6HKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747260; c=relaxed/simple;
	bh=HDh0tHN7Imku5gQvjhAPRn/aa/QQQichvxD3Lw2UsfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4/vxIVqU4808qJ0ygfCkQTTpgg9ziQGKUNItBuIbzx5elSLoUQ8FeERLU6lXS7iWoJgPnLc9wH9Y6e1Fi6/jyrQNfB3ljlzveTq5B1/mqPM7Q0ZJ3oPaKpx/q7ibA8zvAdsI3XlBkAk09xAvhjxbhvd/mGepVFk40iWTdTbgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BsOisRd5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BsOisRd5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495635a85d2so17040355e9.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785747256; x=1786352056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EPO+ED0ot3Taa08GbV6IzKrIjqgkBaW3P1eEmTzgiUE=;
        b=BsOisRd58kAESsSRFp3xd0/AlYeUGZGNyJ3QDgmNGW/quyXl3TtqKyTrMQoBd1Hpzv
         tPV2ujGuk0h3bcLDx04/5Nn7aV3coBIlHhyCy+DmYl+ruPQ208TL+mZOgj4WLZnJh4+Z
         RY4Hxve8o8UNrjlEJcAc4h+DUkUboDw9XZyjbw3jQecr/tR1VezNXDoeXyWA2HV5tgXv
         HtiAzDmiIBBLuRo79OVFnPHgWp1st9nQIwr5HiI3P6hRm6kV0r566ZAWVVrSHPNkuQsG
         it1PH/AZQfdjg+5R8zgtA3coeCAJ+MeXTVYFTxPZEa5TmeFu9JUmWTxqedk0Fn+LMfzr
         7NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747256; x=1786352056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPO+ED0ot3Taa08GbV6IzKrIjqgkBaW3P1eEmTzgiUE=;
        b=b+LdGLyyyUDAMC2Vk2KBbzoo+6fiuve2Q8f8QVbk02pi+ZYHYy0GawLt8pa4BpCb/o
         4zZz5EtIxTRzYYhmHu/YAiPO+FNSM75kYzKoUBUC9GLxHOofYv9VzLrpOOi1nxiq0R3M
         sDSsoMqxMIWjY+xXEU5QT3yJZTRMqdZ2f8jS++XZo/TTgEpcZfBegGw1BbJwfd3ovGrz
         FvuaQ9lhkmkP6qRjPyfF/LgcQojO2s5IThiNyNbcFVvjsCpR0LpMB+20ULxZ8rVpmy3e
         yowanMesXmNQ7BrMuf+3B0Lvra8m1iRUXsoq+hWGB0vlOJU4XbxHy9OqyViN2D763lYC
         EM2g==
X-Forwarded-Encrypted: i=1; AHgh+RpQFDZu6tGIq6/X417aJZp8Mj3kvwP4LhQTSNVrsnIUQQvDFDNAOZPua/sO+VSgkSleaA5g8t2tfoTmfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZb6UX6z55yFtIAr3Q2tser5xtGvanTJI5bEjo8YP3DGL1IhSr
	iw+Q99mTb2ZljtujC4A0BR/bYO9W+z02jCzuOZMH7RD1fYTSDzHDDIXysa48aGqHHHI=
X-Gm-Gg: AR+sD125Wj+F1Z/wyuq45hYE/v1M+RQ78l3VCG6OJIXdNxvaJcOwatkQCu31KBMpgzC
	zEitid0pbFY1E9Er/gzIvBDbN4gKN+oZwghjiHbpWQpWsylXNvJWXzHWVVChZN/l5vjVHHFflmj
	Lw0QHk+ylz+WMV6taxbyoyMNPqk1dVCf81MmnWWtQVwimeprnpMUwwy5jsj1vq6Ry60clBGbQwH
	B3+y1ck6V+vLX3hj/J1t1LeB4xdIdi5ujRlB0dT/prne8lwAB26+G2PYjywGuFCzU4IMsvfm2UW
	VtRI0uYtPiCELIvhdO/cpU6Cwq36ZzJ9OgJtDpORV8xYNFGjCeCfNOUsOS3jgPLYaCiNHe3axb4
	OJ6jDoekgyJWvpxQITUHe3+eDx4e6DBZ6S8C5UCflJxQ9k3QAd9MIKfG+XnwZEBNQWt59YhvSXA
	bvsD/ZjS5gcVEPism9g+futjj6DDyUR4woBv/ZLJGUWIa8zIubACgL14gOBeWeiRNssn47TQ6Zk
	t8zmP11VnLnS707/PoQqVHKeH4s5WJPD+k9VlgTFkSVdVAUyTp4PmXd6S0wmujfo/ua/stHWeOH
	VV58Tj0Hdb0GeN2is/M20Fc2Bm7HjhJA+ofYmBRy0Q==
X-Received: by 2002:a05:600c:5914:b0:495:5cda:52ec with SMTP id 5b1f17b1804b1-4980c662d03mr170527905e9.16.1785747255995;
        Mon, 03 Aug 2026 01:54:15 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b7afe6sm200011075e9.0.2026.08.03.01.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:54:15 -0700 (PDT)
Message-ID: <a6a83aae-2f51-428e-8e38-e6a36f095f13@suse.com>
Date: Mon, 3 Aug 2026 10:54:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/10] rust: module: update MAINTAINERS to cover
 module.rs
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <20260723-fix-fops-owner-v9-10-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-10-c1c3af7f7bcb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 4:10 AM, Alvin Sun wrote:
> Module types now live in `rust/kernel/module.rs` alongside
> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> files are covered.
> 
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Assisted-by: opencode:glm-5.2
> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7d21c5a1a1b8@suse.com
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c4..74733de3e41ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17984,7 +17984,7 @@ F:	include/linux/module*.h
>  F:	kernel/module/
>  F:	lib/test_kmod.c
>  F:	lib/tests/module/
> -F:	rust/kernel/module_param.rs
> +F:	rust/kernel/module*.rs
>  F:	rust/macros/module.rs
>  F:	scripts/module*
>  F:	tools/testing/selftests/kmod/
> 
