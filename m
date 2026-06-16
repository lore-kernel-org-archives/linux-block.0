Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9643C06B
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610632; cv=none; b=ZubfFeWB+i552si6+HQ3MLWWE/Kv0SWNWthDD1DMrcRAUAeeR/SZ9tpVLZpFcHYQDEyoauJ676FNdit2GCN+3V3fHiSZzZ9aHeNB04rxY/vC14ZD9zzcx/zIwgSOIFz10Xq1HCGsvtxPKd8TwdTyLVpLY9ImQDTNvXwg++ATFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610632; c=relaxed/simple;
	bh=TObrEHhKuPNM42P0oLKIGdOx5sA4x16gAm9/x6UBmOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSzP4vtn0LXY670dlhaGW7+oUc3zc88JU76ANViT6N+F84amiw/cs4fboveMP8L/V2eW6CdEZibc4s8Rl1bxv2HkfYgv4KgDo+9dBZxkqbnyUZmwJ9/HihVqLm8uuZrJezIi2WEB1Au/ZFCGutf86Q3u1rWmE7SqjMFvUCy0Rmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuZOhfcZ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuZOhfcZ"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-beefe797002so283421766b.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781610629; x=1782215429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcH8wbzZOm8yn4lLoAkAwb8V6hZltU+bJ+2UV9XpA9s=;
        b=NuZOhfcZrHteFgg+qVuJKf/u2zYwxMNt7M/+3Kh2WGKDHOK0XbwQU4TtUudSmIqfHp
         3d512sWF3YSKCtWQ4TZV5MeKudggeHCDoqM2kGKSS/6vct350HmOXUvKVfl2WpMkekLC
         zToUW0w6iHcPVj0SumIP+N2aMhFr8Fc4DCVBRZeUMJce0W0vsLnNpyaNYZOpNvfxOGkR
         n/gnavsNlF7llBohUYrKUQmn4UGZBkm4RxyM+ZAD8yOKsL03u8u2+w0jF76KFxxuDvGe
         vfBu/tdAI/YA/CfT/0uP87PxyZVwq1No+5SIzDm1wxIn8DsB15iFz9+PGgfao4J+51Qz
         gdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610629; x=1782215429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcH8wbzZOm8yn4lLoAkAwb8V6hZltU+bJ+2UV9XpA9s=;
        b=HeiA5h2BpLNgXlbYZG4xiYT6hlgew+JEmSzT1cohJHJCt0JQ26Ez7uj3ooQpc8Ihs9
         dsXvCp72Xg77pNPZNkP4AE0/QHlNMUgBj2k3BpzBnP4IPeg6c23v5IHT4YZW0TPzaSro
         Z3LkQwLW9sQmqBFO/AXi256dO6hKkm7/1ugV+FryB8lBhAUxS5/Wp0S7fBUES2o1+7Pd
         nK6Tr7OawWfYnUJvfWChTskjytaFFJ+3qv4pFsq73z+9E+e1jHEzxUTn8U4jAc2eoD0A
         aB160yv4oktk9glQ8MUJOvBku20HBdYOGw5EQXVJcX/srqiEAxWZOjkZZgu3Bg4TfkFN
         BLLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9av1unBjDAQG4ntmRD653BIOO1TB0nkba1FOyHum7dQfr4xuUt5feBG8LYk2vvs/bY7ejN+Us0nhA27A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWl564SYwQ+VYHTZcoQUl3hxbeV9H53vz8C3Ems43WmwLAoNJB
	5vrjwMG24r5ON7gb4wVTaGobc9d/3FCpKwy/3ss3mo/LvVoLPKFv7zwUKuAPoaXaE95fEHHA2wS
	1LQWBBpB3zQ1yChigxw==
X-Received: from ejfp18.prod.google.com ([2002:a17:906:e92:b0:beb:c99:aa2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1dd6:b0:bed:9a7:5ed1 with SMTP id a640c23a62f3a-c043a477df5mr130254166b.5.1781610629337;
 Tue, 16 Jun 2026 04:50:29 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:50:27 +0000
In-Reply-To: <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
Message-ID: <ajE4g7JsM6bnpEOu@google.com>
Subject: Re: [PATCH v17 01/10] rust: alloc: add `KBox::into_non_null`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 04, 2026 at 10:11:13PM +0200, Andreas Hindborg wrote:
> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
