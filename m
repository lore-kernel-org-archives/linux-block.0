Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D31E2838;
	Tue,  3 Dec 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223229; cv=none; b=qvgJ0HdiwWqSU+9W+FaGeFO+hqqx6ByAsqb+UryMNepSOOITRnDgB+ct/DUJB5lqhnhM0iZ45ss1NRGTwFnwpPaWXVwaNQlGq8IKXiV1hK1TUl4Eu40xpuAoolMf4WO42K81zLuuIFw1Smr2y41FSPavVN/Q0TksAtZMoEdBJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223229; c=relaxed/simple;
	bh=/b1aKx+WEPJ+dI6W1lEXAcaiwdrP/tzAlbitMbr5im4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fxjvkPl+Bss3gIn780PzApd8zfwQy2cltu/seAB+IlcNVwrWL9DymnuMqlzkVj/BV7ktQXJNj41KL/1tjaCLOILQaLILFImc3KLikfly1mH8pp32WXt70cDpbxvmKWXzDgH8NGtYP9EIwWKVz4Y+IfoTvqrxAx1rh8VH/ouzbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oox60Rmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oox60Rmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1057BC4CECF;
	Tue,  3 Dec 2024 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733223229;
	bh=/b1aKx+WEPJ+dI6W1lEXAcaiwdrP/tzAlbitMbr5im4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Oox60RmkDob8qQSoii1sk0k/Q+mj/a+r/fG3RlLI3wcl+tRummlhQc46/rl2FXYPM
	 vtIB0vH5pFOmNVotVt2U89iAtjVdb0MHuSvBSNtPGm1SGQwp73Y240bgoy7xt66Dfb
	 lJgFTdBdT72b0f8rQD7Iz1wt0WY4KwWgzYEiCamBYKWgX30yCrYvigbS/Rra/tpmmh
	 x4dC6/CVHX0tb/DlFnj0qTN513ehJe+6NfXBOhGQvxyaniIuCOkh/Uv/38+KnSUsJs
	 GaEbxhXaD+EE+tFQVS5sRr9oDdildbitWSTueFdLKaWfeFQ9ddD6OKdE6t+8C5Yuu6
	 hQa6s+yBr/G4Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <linux-block@vger.kernel.org>,  <boqun.feng@gmail.com>,
  <axboe@kernel.dk>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] block: rnull: add missing MODULE_DESCRIPTION
In-Reply-To: <20241130094521.193924-1-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Sat, 30 Nov 2024 18:45:21 +0900")
References: <nxIB6ABobvhiDA2z5gk5pNpCwflPD7Faqf6s4WWaJseb8VIkFsYa2Vl3aeMLZyC0G2HecJ0D1_GPf3FczGjCww==@protonmail.internalid>
	<20241130094521.193924-1-fujita.tomonori@gmail.com>
Date: Tue, 03 Dec 2024 11:53:41 +0100
Message-ID: <87plm9f362.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Add the missing description to fix the following warning:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/rnull_mod.o
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

Thanks for adding the description string. I am curious about the
warning, since I don't get it. Do I need to enable anything special to
get this warning?


Best regards,
Andreas Hindborg



