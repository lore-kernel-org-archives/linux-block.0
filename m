Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C2E2D0602;
	Sat, 11 Apr 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903388; cv=none; b=c/EzLTjBpK2da2RGTVouZL4irFL7c4iOKZbfZEmS2Bo1hSzM5sXicBjaFeggYQHAh8H3C+BZWe5W3Lg/B8PggEuwnV9fpWwNP9mBZKRS0zPvEoG5tiDolGuElPLgGh8fBnVxCww8YjB2F7rysZun6/iZaKdm/q8GGV8eJfjg/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903388; c=relaxed/simple;
	bh=wZNIGOWoXeu1uFgjqextzz9GxLpwlqcnsLJYOpzU7DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZbZYqrBSc35miLs0yDJJiByVqGSNnpteo+YpPR/4jYJCX4Ik5MfSk/2sc6b9urPWQwGj953/9V5SCUMWsQfzyGyGbVfBGRbI4tGyhqKaUebkVPFwzjafXObtC16xlh++c5J4Lq29WYtRZpET7OX5uMUZaQFoutL9DQDP5dd7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufifa+go; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufifa+go"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE3DC4CEF7;
	Sat, 11 Apr 2026 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775903387;
	bh=wZNIGOWoXeu1uFgjqextzz9GxLpwlqcnsLJYOpzU7DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ufifa+gonpzvYXmJLcptAuBwuvMTCiJh0z/WqfU7VIyc8xsb10vV2yA5BEl8VbW/q
	 VtH8G5dYvHR9P6jl4cbn2d2xVuXFoU0pioEKqmVijkNxtM3x9Thb5sbimTrkbEUefF
	 1wn+Bn9SmXarXZX3IFuKevs2Ba3HM3y+pYXf3Bw1lT3CpHHlZkFDanQZZKoLZYAIrz
	 9ZaRXvql1DsE9FcXu2Ze2taYkdkBVhzf4lZUJykhcxLpEZ7xMayAxte3TP8E5bG/zS
	 wWt//iedp3pphLr+I9LoIaiIj05etZYxAQTBzJJoygvmD1+XecPQwAA9RA+D/FoU6r
	 TwY4f/eR5hkNg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>, Jens Axboe <axboe@kernel.dk>,
 Miguel Ojeda <ojeda@kernel.org>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] rust: block: add a borrowed blk-mq timeout
 callback
In-Reply-To: <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
References: <YpOxb7raN9ztoDEyfT5M8S4KZA74Ua0I9VLcImKPi_lJ6K5xWugbgbzKmQcl0rz2XdRw0cXOYrDpOYjz9q62Dw==@protonmail.internalid>
 <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
Date: Sat, 11 Apr 2026 12:29:34 +0200
Message-ID: <87ldetx01d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Wenzhao,

"Wenzhao Liao" <wenzhaoliao@ruc.edu.cn> writes:

> This small RFC series fills a missing blk-mq callback in the Rust block
> layer. Today, Rust block drivers cannot participate in request timeout
> handling because the Rust blk-mq vtable hardcodes `timeout: None`.

I already pointed you to [1] multiple times. Please make sure to read
that patch series. The functionality you are submitting is already
covered by that series.

If you really want to use your tokens to improve the kernel, I would
suggest adding boolean parameter support to the Rust module parameter
parser code.

Be sure to credit your LLM according to [2]. And please do instruct your
agents to find related discussion on the mailing list, so we avoid
solving the same problem over and over.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/rust-for-linux/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org/
[2] https://docs.kernel.org/process/coding-assistants.html

