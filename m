Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599283;
	b=i9HqLdHGUm9M2w4yZ52KGqtTGCjKE/er0OJUCb5Jw3ttk1xKEicxi60qrve+66KW+d7B
	 kGPZzldEbH0y6AIn9gIFL9TUQGLd9RS35nar6gOOkF3M7gT09VCNTuQuvw58CiMIO/wqN
	 MT+xNXQIkWMBGybbc3Tu8OrHbbPm4dgQ6xVcdsp4qN1SF+F1s7IeSW0Oe7+t4iB4yz5Yp
	 cAgFSAN9cyHmPX5YZFmAMwf+sJnsyuw8nhprPpfJq0sygCxK7TFPeKTyea5WrIKzV9Nhk
	 Af7gUUFWt9GRMs+lKUOdKSpIPyvSigXjcUq7cY4VhtiM16KxEBinjo0mcdKDr2D2npA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KPVgxbMcaQt+PxgzMn7lDpFwudV/imA9OGBWE3yEdS4=;
	b=XgHYC6b2DI4TsLRqDRYIS3zYtcVKDkbn2GjzuEM7WYImGAJk3UUcINR38ljOHKLjQdn9
	 t1+Nq+eX5Z4400vkKfo048+hWPXPVv1WNRtH4CmDIs9DmWvw2D2wXTr6TYq9Bccg38Ol3
	 0UmjFZn2h9cDb+RrA0jELTg+1/qvb/3OcofT83n9Ffl6cKV+xbaq2y50eav3uaY9fX5bx
	 u0REdxaOEeFV5OV+rumLSg89tbTkDWruHYdz7ydX0X3cHGybhfDoOrqLnDd8bFGPnwjNA
	 kh72A5nTnzBj4ZZLd/QOs3flrlTDKU2xoo2XQq4uWdiBQuuDZ/IY8/5yWj3UeJVjaNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5pWTRhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AB606A323;
	Fri, 13 Nov 2026 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5pWTRhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B1A1F000C4;
	Fri, 13 Nov 2026 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599282;
	bh=KPVgxbMcaQt+PxgzMn7lDpFwudV/imA9OGBWE3yEdS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=h5pWTRhJEjQTLAprJHZOSC5NCgwHLbPaK02HqqrXWW3c95280FCOYgOE35TKVEFeQ
	 hZ/dOceFvH6/Bb+F/nKQhKtPE3qn1ZlE9HC55FXE/2i0lNIOfZ6uEUfgckmeMzjhb8
	 tofzngjW7MIXc4YQwn8ue1kqKMXA+wluy5Jz75fhtEw+DXg/+9Xk6uvhZtr4RTBSYf
	 UN6qbFKxUNQWR9Wl0QKtRoe/X8nBc/FquCGQPstpndCwJJDWh7kphbxSP/HcgcK8JM
	 NfOXb73jn9c8Lsb8z8JFxNybrcBD4VYw2ICbvdb5B5PbZd9Uo2qbjNJxyoauA22dyK
	 Gnq/XVVO3akXA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: =?utf-8?B?5pyd5YCJ5rC05biM?= <mizuk1@mzk1.dev>, "Liam R. Howlett"
 <liam@infradead.org>, Alice
 Ryhl <aliceryhl@google.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Benno Lossin <lossin@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Gary Guo <gary@garyguo.net>, Jens Axboe <axboe@kernel.dk>, John
 Stultz <jstultz@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Lyude
 Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Trevor Gross
 <tmgross@umich.edu>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 83/83] block: rnull: add zone offline and readonly
 configfs files
In-Reply-To: <3246e50d-2489-4a79-8a72-550bd90fbd90@mzk1.dev>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
 <20260609-rnull-v6-19-rc5-send-v2-83-82c7404542e2@kernel.org>
 <xQnB2LuMsjEqP6I_00brV-s6btUZeSUsphCHwn_VvMlpxQiBhyrwDmHAKc-Av6sQbqdw0h8HassEoWDSbVQxxw==@protonmail.internalid>
 <3246e50d-2489-4a79-8a72-550bd90fbd90@mzk1.dev>
Date: Fri, 13 Nov 2026 20:47:48 +0100
Message-ID: <87qzgov7h7.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E6=9C=9D=E5=80=89=E6=B0=B4=E5=B8=8C <mizuk1@mzk1.dev> writes:

> On 2026/6/10 03:09, Andreas Hindborg wrote:
>> +        let mut cache_guard =3D tree_guard.cache_tree.lock();
>> +        let mut disk_guard =3D tree_guard.cache_tree.lock();
>
> This takes cache_tree twice; the second one should be disk_tree.

Thanks! I think I need better testing for the discard feature...

Best regards,
Andreas Hindborg


