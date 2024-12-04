Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2E1B0F29;
	Wed,  4 Dec 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311436; cv=none; b=UB4qG6uGuh+Yv6419kWqgHiuTz5Cy5AajlFuYitNdkjxidoNV2x66QO/DRDxBTKm+xc0HyeUhir0NXYXmHoVmEHDsco+HDLBg9b/6rM4LdOh1ZPghuGIgzF3g0YNaLhFlj6JCKRZonzR51XFZvOtkTR37gOT4hpBDslO5yP8rCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311436; c=relaxed/simple;
	bh=/blkFvAPE4y7AxysmsikoAFMjOhJ04M0iaoZSxkIbkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FaeCN4qPuFwI7VfLnma6r4QcC4OQOjSaRQMCznwOTuAOTmvLMp4RJcxWWoxBOJtg23lxy5zhyllTn9W9ARthRJjG6O3SmfjPjr+EDjQl24neMRSwfCQiVuz9st5SJh4F/k2FjoBGKw8xmS1Kve20RLCXBmPUCFHKzw3lqjcxgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkLlYc3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkLlYc3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFD9C4CED1;
	Wed,  4 Dec 2024 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733311435;
	bh=/blkFvAPE4y7AxysmsikoAFMjOhJ04M0iaoZSxkIbkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qkLlYc3fQ4YNtcoKZzuxJ4Es3jp4p/gpQyvId8VLiOLOiAI7in617EKb6AtcOhqPO
	 1LnWeKSbPYKOJxXRmfUWc+o9L37QJ6eJNYMrw8CZeq1znv8UmhCNtZhN/WlJ40krs3
	 LTZxUW5TPtxBZwkXDinaUdifMFbm2joKIUNV/c9nFRkRU0fQOnaO54aR9LaNWw/cK7
	 UXyMPpsIZZ83s8S9vnFyBwXX9ojgrwsxzJjc9CDIo4qst2C9QeyRBYW5Slnisob/YM
	 m26c8V12yzVVtYSAQJ6GjOZj+fZ64DOybVgTGlQz5pWP6WasAEIKaxCg+FmkJH0rSL
	 SvPP/BtUJKo7w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= du Garreau <benoit@dugarreau.fr>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Jens Axboe" <axboe@kernel.dk>,
  <linux-block@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: rnull: Initialize the module in place
In-Reply-To: <20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
 (=?utf-8?Q?=22Beno=C3=AEt?=
	du Garreau"'s message of "Wed, 04 Dec 2024 09:38:39 +0100")
References: <KDOrOz0f1qbGhNBKxiESVrGZaUhIbkfe1DgOqgX3pd7N7hiaJpbrvaLUklCHjUrGgHOVsYl3M-crnKTUa_WMjA==@protonmail.internalid>
	<20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
Date: Wed, 04 Dec 2024 12:23:30 +0100
Message-ID: <87cyi7g099.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Beno=C3=AEt du Garreau <benoit@dugarreau.fr> writes:

> Using `InPlaceModule` avoids an allocation and an indirection.
>
> Signed-off-by: Beno=C3=AEt du Garreau <benoit@dugarreau.fr>

Looks good to me. Thanks!


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


