Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C723B638;
	Wed,  6 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485658; cv=pass; b=QQgOk/0n/dslnnXq3tClzr/3XTvQR3S1+8qzMzPEXtwGRabKPWEH1Naqp/JL0TcyS977NM5Tf5nVbeoUf191qqSLBH7Ije2O2Ma3A+5RRnmFnQCtGeXK5YDcSfApFvUJXIo8Yy04pDDk8lrLiwqsG2/flDtALBzukjOiVYASl4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485658; c=relaxed/simple;
	bh=SwG+ZVELBRGqKBHGBySLmlrsPEBcL1iffb3s5ksR+lA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OAOdY2nkxvdmoaf4IKJugX0ElcdBfvJcxASfCI5oN24EsDWHOCn5A8kV0BVjZoJZIo4N2QihsoreyuCt4GHBWgzW1N11aQp/xWskwck/a7vx8tjqGl8If117tENRxjikPgxhgx+FEwLpj2dxk64e2gj6HtApW9suV9i0b08Uk7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QgoghX5P; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QgoghX5P"
ARC-Seal: i=1; a=rsa-sha256; t=1754485639; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R+oEOsORHKjed6jJJ7hmijPge5CnIkYUdrcEaMOZ8QyIWK279naTrfqatm4rklSiPEZugzqci3+Pl+uCi+Em2MPhC6IgS+0w/yfV1LE7/PPLck5IZv/5ANLhFkuotrqoZi6PS6dOJ3UzjiYPtEwDLuQemdw+b0xHygj96eqrPY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754485639; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X43jSMPb6fbCg7gqMVz1bHgLfMd3TFcRt/CDIdLMe4Q=; 
	b=f8IfgPJkKlvX8FG33pHAXMHeZ32qwMf51urOlsM2R2pb5wbsElfToLhKqfm39ppcUpkiwI+adXY1VGfs/wsbZ0GLCTB2dj23tMn7gtHXEPapvYkUYybY8SRUg48YTCZk8lXjtts2wpOaBYLebJZ73/dSaWxxEyWS4VBAJ5wnQiU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754485639;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=X43jSMPb6fbCg7gqMVz1bHgLfMd3TFcRt/CDIdLMe4Q=;
	b=QgoghX5PNM8sov8bFJYaOQN/Xbk7lZJh03uncPC4LCupf/2+UElLFAK+abxRBVoF
	+ZcViSWdBKCGBwM9rjKbUUpQ4wgZAoJWeQiG+kbIkLiuMDu54xK9ghx7o+AxjIMfahX
	dEZzA19wGiF2T11XbQ5n+bRxj+UKXw2lnG78jg0c=
Received: by mx.zohomail.com with SMTPS id 1754485637583385.9083889664603;
	Wed, 6 Aug 2025 06:07:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 04/16] rust: str: make `RawFormatter::bytes_written`
 public.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-4-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 10:07:04 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <710426EE-665B-4700-9940-B628F54A0D9C@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-4-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> rnull is going to make use of `kernel::str::RawFormatter::bytes_written`,
> so make the visibility public.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 28a6179385fc..b1bc584803b0 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -761,7 +761,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
>     }
> 
>     /// Returns the number of bytes written to the formatter.
> -    pub(crate) fn bytes_written(&self) -> usize {
> +    pub fn bytes_written(&self) -> usize {
>         self.pos - self.beg
>     }
> }
> 
> -- 
> 2.47.2
> 
> 
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
