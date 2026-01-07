Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C45322B75;
	Wed,  7 Jan 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783214; cv=none; b=EaxqYEKTeevgRwB7/Ikx5XYvbyzSO+tOSS9Q8Om1BYVgkYRFawlpmJ14U/jUaTJMgzsQzuPeA7Z9a7QQh60he1ME0t99CmQWKXWoMbv+quah0gO5xQjU/7wvxoOqrCNZQJbfwqJtLNGxQSoT+a/4le5+RBOylU3kGKA8OdCNYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783214; c=relaxed/simple;
	bh=QJsbowrMVBHMeB0/fXtS33caxShTnPi8PYmz1nYQWLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BfWG0J/LEPBQUhfp7afCXA2/S3vTvz/8w/+J353cxzT3z9N6dYuEb2JIcunEZjPwHqG/Lc8Qg/LT2cgRlFPNnPOgHDoHgBvIXmzqVo4q4HuJldhxUcVooAN7dJy9ZucqtXAUQWiWzY5bchtafvPH/2dsNO8YYMlY4kWdoAEYCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppNUcWiD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppNUcWiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA891C4CEF7;
	Wed,  7 Jan 2026 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767783213;
	bh=QJsbowrMVBHMeB0/fXtS33caxShTnPi8PYmz1nYQWLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ppNUcWiDRpscSt1cD93OuJbjERgw/prcp3SXpjkGvKp8n/CTJGi8iwGLz81oNb3Qp
	 xy8LxOgMfFuGN+89ox6ipjRdNEDkRJLCF96Yq1nfY+NYiPUR7ivfKEcVCm37+TpbAS
	 jrIX6S7PeP600w9YVpB8JSntUiwRRh+2givGm8qJT0pqoYDzZlyYTwHycohNIFMMMJ
	 wgZlY/LNrDjA/rcVzgHicWDuG1Xr1tdgEaCJPFY0TFZ0jwzCgtug46YiHIMx70AC71
	 VhWtjxH8T7QSI4tYF1uhKu/D7Qw2u3WZ4GVRsfKxk6GOaZ9xS4ds55tbEoP7ogwEHJ
	 NzZbW/j/A8IXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/27] rust: blk: add __rust_helper to helpers
In-Reply-To: <20260105-define-rust-helper-v2-2-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
 <20260105-define-rust-helper-v2-2-51da5f454a67@google.com>
Date: Wed, 07 Jan 2026 11:53:24 +0100
Message-ID: <87a4ypiti3.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> This is needed to inline these helpers into Rust code.
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


