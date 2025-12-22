Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0D2BE048;
	Mon, 22 Dec 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413234; cv=pass; b=crdVoRxdOnwgIHQrjhFpqxCg+mMFU3DWHPD4/sqYQGUZPF4ZAYQbvMQWFMNghMJzlW1BnHmSt4B0/LjzFVaE3LMnXJtVZbF16VsBeVmCzYztU4mE4LHHvO/tg/4EnOqiiu7hAwKlclZChTdDI0PCkDrJlhL/rTTBkLhjQlXc1o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413234; c=relaxed/simple;
	bh=/7AkD5MoGLoJ9E0uIl0cXggdSAyflF5Z3k/pqlk9AHk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jfsEbo1UE37xU9hTwWN2YoMp/JkbwGxRiFBuXajd8DwFoCCb1lLatPSx0R3wQVbNwmHLtL18nWvLyVdiRDOM6/yRBmmNLgTYBiv2CRKk5+A2gXX2YuLexiNLZjmIzq02l90rPuA87Yo33NsuevztByBiY/MHf+s8ZKK4Lj0ubB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hHm2zh8i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hHm2zh8i"
ARC-Seal: i=1; a=rsa-sha256; t=1766413216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mKHOwEpsdpTYqSsOlM9PPJY66nGbqiIPGyY3SXyrt4qL5fRzjN4fYVZVBniYRbj9Om5mpkEPQ2OVAJN9o1EhKy1z9bBv6jJeju+GbAUTBj5nGlOHZ30PXthRty/hIyxf0MVqaBuEhDJGhg0xm2hciWwvo/QYbBLN9Dy6tXisimI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766413216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1Ko8sRL3XFUTsdfrXmGabUt+wzKpzjrULj5gkrSJQns=; 
	b=mrQh5LnBRPZqvt/yhHrLXkJtkP5RbyrWIDYre8WPDAkGwRVh9c4B/V7ykl4phbVMvdXYZuM4tUqZ3GsAQDHv81+Jh/Xuf9vWfAVJbfWRAjiRyj398yy1LZAn5UzkIV/5qdoRO9sXrgE/WI5YHbdhl1ICO8bjhCYhbqiMTqYjvZY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766413216;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=1Ko8sRL3XFUTsdfrXmGabUt+wzKpzjrULj5gkrSJQns=;
	b=hHm2zh8icw2bvPkWEWNqu+JT9W72T4LkgWp98iWWmFui/7SLyoDvZwUmvfQE6fgi
	uUKdVXyS5sp9FEs1THf5B7p8Xp+oAOqsqtaVKkOiVCEYgBZDTHaVqXPEiihbk1g5q/B
	qNKs5QOL1yXLEdpMZCi2aiIKoHqYtmFsXJZcEDL4=
Received: by mx.zohomail.com with SMTPS id 176641321412580.97702557807827;
	Mon, 22 Dec 2025 06:20:14 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rnull: replace `kernel::c_str!` with C-Strings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251222-cstr-block-v1-1-fdab28bb7367@gmail.com>
Date: Mon, 22 Dec 2025 11:19:58 -0300
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tamir Duberstein <tamird@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4015C791-D9C1-49D3-893E-79FD1167AD50@collabora.com>
References: <20251222-cstr-block-v1-1-fdab28bb7367@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Dec 2025, at 09:26, Tamir Duberstein <tamird@kernel.org> wrote:
>=20
> From: Tamir Duberstein <tamird@gmail.com>
>=20
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> drivers/block/rnull/configfs.rs | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/rnull/configfs.rs =
b/drivers/block/rnull/configfs.rs
> index 6713a6d92391..2f5a7da03af5 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -25,7 +25,7 @@ pub(crate) fn subsystem() -> impl =
PinInit<kernel::configfs::Subsystem<Config>, E
>         ],
>     };
>=20
> -    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, =
try_pin_init!(Config {}))
> +    kernel::configfs::Subsystem::new(c"rnull", item_type, =
try_pin_init!(Config {}))
> }
>=20
> #[pin_data]
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-block-0611c0c035e3
>=20
> Best regards,
> -- =20
> Tamir Duberstein <tamird@gmail.com>
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
