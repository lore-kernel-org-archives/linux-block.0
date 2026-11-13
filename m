Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590735;
	b=f84icSHCH1VpZUW4Kvw4Gac4QmoOoA2/AZ+8QxKEKtko4Ji/yuSYPwaY4fJ7BRSwJPqn
	 MKt1OCliKnv7m1TuSoe8WwyiZ4Iz7Q9rFlAr6sVBI31tMeZEeFXAh9E3aRwCptnvL61CX
	 rrXSMv4vU/6LWbKwz459eL8JlrG0YoY1jGo+j0e9bX4DfkQH4kZesi3oypx3WEibRSg1A
	 xW65B0jKdDtQzpHt/sdMm5rGHR9Jw62St5VnIdEf2ibRd+kPKnTQRi7V5YXLu5cbb/TyS
	 +zaaaMI4TvVduwntu+j4cYzQXoYJGbjdsuWmIjGhRxFZZ9cUZn17N1IN8b+x8PFzdDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590735;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MIME-Autoconverted;
	bh=v5VCnw1Fvtd/Gip4papkzUmc4LWV8dOqyxkMmZU8NKA=;
	b=CtW0cINWT1hz50vjPmlrBSXxlHz7pvoLfYWY8qN66PXu75MGsdi3JI+slgd6nBOnm/BT
	 8ADHMvrezv4PMeNPAhS4cdFM/pcD8DATCNNH3SROe9Z/fdNERw7zklmV6ctiGVnHBGR4O
	 +tLrcWjOxPyU756bdWWZrKNjNAxsS33k98wo7hCoRcoHmnr4F1ox2Ht/Cp+apyhm2XXEF
	 dgvycFP8wX6QBNSUffIW9rrRxY1ATWu8OFVjLv+7EiJkJ6LAA3SbpmZDV39cKgSDjfdFn
	 mp5k1BgnSm5QQuc6Mxk9KL4T7FGXexLmZjevQ/kCbZvqa32ckAmJeP1mbHRLZ4Xh+ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mzk1.dev;
	spf=pass smtp.mailfrom=mzk1.dev;
	dkim=pass header.d=mzk1.dev header.i=@mzk1.dev header.a=rsa-sha256 header.s=purelymail1 header.b=V9KuuWcN;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=oBQ+mx6w;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B8607A5FC
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 17:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00B8607A5FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mzk1.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mzk1.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mzk1.dev header.i=@mzk1.dev header.a=rsa-sha256 header.s=purelymail1 header.b=V9KuuWcN;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=oBQ+mx6w
DKIM-Signature: a=rsa-sha256; b=V9KuuWcNuAVuhSLxrM/zeH0iiGGKN10vfTI0UZhwRvvAXLJHa//5AtkMwwsG3gCGAovoNsfB6hpYEgc8leoXQUGc3/8p26yo2AbMKr4N8FW/LOA31BXHMALHMZndryJ2bRblSLKlBru7/L/NZbQLm8yERMaTSjveV29YKeCTjzf+qjX7/x6JEcIHE9QwVm3ZDkAZS7rWi8D/Qznheaq0uy5AgjiKPmroDRTyP9YEz18ufg+fiHWGBH7IAOQ17MbVpb87Se1RL/+ZtlaB87gz6kg6Ds4oy7V6p30VvgaGUuylpVDc7+iuQMOhq16oi1WZpPlYZWcX3X7mn//U+cIbng==; s=purelymail1; d=mzk1.dev; v=1; bh=ynwczMvkRVmR6wZnOkUfy2B4rEh3V7zlSMQ4smUy/aE=; h=Received:Message-ID:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=oBQ+mx6wIpb4CdkjkexxCs/iwcIZEOxTo+I8V5tlwLba+APf1rElu5WKFdEKmnjGvdpqlSSej2wWvTauBnYzXLqM79/MZEufKvzA6xs0v2VZuhX2FXil5DWPzI50R7Q4u5YpNMBA/h6LC4P0SI8GTn0zm4nKzUZGXswVt1cLxlg+thzmy3PEVlJFZO3hbOq1K1U1ODu2dVfCz02GpjItX7O58AXnyF2ClmSKz3YSxMxXvMH5ARUVFy1NZztWH/HAPKhtjeu0PrnjzJXt2JyRVzidyuPZ+E5JjJIWM0tfmotnFkx1WINmVcIJWMovcO0H/GvvKj2+JeSXvK6QXkbvUw==; s=purelymail1; d=purelymail.com; v=1; bh=ynwczMvkRVmR6wZnOkUfy2B4rEh3V7zlSMQ4smUy/aE=; h=Feedback-ID:Received:Message-ID:Date:Subject:To:From;
Feedback-ID: 1682458:65466:null:purelymail
X-Pm-Original-To: linux-block@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2110463954;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 13 Nov 2026 17:24:17 +0000 (UTC)
Message-ID: <3246e50d-2489-4a79-8a72-550bd90fbd90@mzk1.dev>
Date: Sat, 14 Nov 2026 01:24:08 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 83/83] block: rnull: add zone offline and readonly
 configfs files
To: Andreas Hindborg <a.hindborg@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>,
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
 <20260609-rnull-v6-19-rc5-send-v2-83-82c7404542e2@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?5pyd5YCJ5rC05biM?= <mizuk1@mzk1.dev>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-83-82c7404542e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 2026/6/10 03:09, Andreas Hindborg wrote:
> +        let mut cache_guard =3D tree_guard.cache_tree.lock();
> +        let mut disk_guard =3D tree_guard.cache_tree.lock();

This takes cache_tree twice; the second one should be disk_tree.

Best regards,
=E6=9C=9D=E5=80=89=E6=B0=B4=E5=B8=8C
