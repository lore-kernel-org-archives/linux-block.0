Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508633;
	b=mZ2QyvWV/Kt7iAdq9ZzYfSQQtV1vYZeizj52oxlJ5VkLIZ/RwOk+RxwMPSKVhmMN6rbu
	 YEX7zdbjmUcpq75c5ChnJ+fLdAQe6bxNbCM3edmS/DLPyX+Aw4N7tdJAl4R1/uds6cbA+
	 VPQb4kxxQwD7fxMzv08/C171hqSo1dDClHav3ZsfTsnqXbZvR16gc1XkObgdmuH+9jLKo
	 Y3if1pBNf0A4kPJ7QuSRTAiPf+AxBYTCj6rRqBjvt5i/0nYeYrFio+2qJv/RHRbducj2n
	 qI8X/uLWeBd2yoaEhcSxNb9PKZ/wn8nSf869pNVkvxbcNBwdY1CSlgg16fj2I3iEx+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=io6UnxiFIVGXadZcnac0DS25TGFmR3HB3EppIhoubHs=;
	b=Ti0gj+4VfaYx+6KvMmuRR+yT85mt5+KSvr1cn0i0rRFMq5zDQZsCDzgzcx2ImGgHKg9e
	 KISRbyEwUB8OHZKw7zdQEe9GqEO6ULrKW+c4cc6eX3gQQGFkdbOiWikWU2zie8OQZuSb+
	 PXNRVgzl1G2sT98QF6qaRFi8Ga8i24BouKkskpt5dATLvCYQycZacd2QgSdfEgswkm3Io
	 RKBPZu7cCZt5W9m53qycALT6ktMytFoxcOQ2Pea8NLtLOCoN+RxMWWpCD7TGAiwxuANlK
	 +GVuPzIAj2VL0rmtN9hG4KnpA2F4fbr12YF6G3XkBzah5DxSgBO60ZUy8qMnUa/RFMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDMRlrGX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B233606A31B;
	Tue, 20 Oct 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDMRlrGX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D01F000C4;
	Tue, 20 Oct 2026 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792508632;
	bh=io6UnxiFIVGXadZcnac0DS25TGFmR3HB3EppIhoubHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nDMRlrGXYv1vS20QL17JojGeEtDuhTZRdybtNsohG7RtYtssAiO39sDuhSQC4uxg3
	 mnFn9/TJ7nyS778zQ4s4glL6bnRlLstNISybgyapTKKjt+Sa3fAswi+8T/rGhwjwvp
	 +Wh4ArFLLErmvpPHp0YoAe/iRwFVCmfILMbr+eTCWMgpLHXNeBnMGyC9+nKwkplruf
	 zCZi0eQ+W25PKM2H4wSxtIC8AjGvY+RrwouQemRw/5TvuvKsiyq82eNR7edBtyNQ6Y
	 ARQKHjIyudvF3IZxZ4Exm3e6BwkPHUl53cyXHddjgRVQjPTzZblWwHcj4yVmol+utd
	 iSzu03nVZmbWQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Jiale Yao <yaojiale02@163.com>, Boqun Feng <boqun@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiale Yao <jiale.yao@example.com>, Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH] rnull: serialize configfs updates with power changes
In-Reply-To: <20261019095807.1906316-1-yaojiale02@163.com>
References: <uGK5kP3Fr_s7fJcoFfMqR0HjR2qR0Eb1RCi3tOPqNOsRa1xuQPbjmLt2WXfcTWXV9pO0_tKKFz8ciXC_W8ObyQ==@protonmail.internalid>
 <20261019095807.1906316-1-yaojiale02@163.com>
Date: Tue, 20 Oct 2026 17:03:44 +0200
Message-ID: <87cxt4za5r.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Jiale Yao" <yaojiale02@163.com> writes:

> From: Jiale Yao <jiale.yao@example.com>
>
> The configuration stores check whether the device is powered before
> parsing the new value, then take the mutex again to update the field.
> A concurrent power-on can complete between these lock acquisitions,
> allowing a live device configuration to be changed.
>
> Parse the input before taking the mutex, then check powered and update
> the configuration while holding the same lock.
>
> Fixes: d969d504bc13 ("rnull: enable configuration via `configfs`")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

I think all of these were fixed last cycle [1].

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/20260908200845.405112-1-qingxiao@tamu.edu/


