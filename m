Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0161DFE25;
	Tue, 18 Feb 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910614; cv=none; b=K1FlHjdZM+PvXCbhHR4lGUFFpesHfj7+P3mcqx44c3DyRncLzxje3Ib6Ps1uTRAyzAoOhjwsmMCUlaLykDILiFVj8ZHX0+tp8+ucoqpaPfp1Y4iTLk6OuNBJqLkDsKPIargtFQ6QDQ7UAEMmdMKlJmPmiz7+CjCfhKtFgVm8838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910614; c=relaxed/simple;
	bh=OQQ7m8L1BMzudoAvLK5XOS0A2jo3zwHZiCn7d0G8ezI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pV6ASyOVuM0gX1sjwMWEDmPgXo+hXwYIv/h3EUvMQ3/8m6Zv+5fwUsMgbvwTB4jp0N3peQYLqJ27jDaRdR9Dh3lFo4mUR0U7ucijN3VFTgpzm8Jvpb+RctSWiMIRStnzxVtIyOI/Bb0elNSOvrvJcQ9OuA90cXzo1EbnwBTiBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=L5fmSxEx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="L5fmSxEx"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B6923411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739910611; bh=kFYOYn1MtAEZtgRUc69ZbYn9hJuiwHY+YySaTGJ78RE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L5fmSxExEYbxUUno45IHgf97DZSNzRAvQkWSZhGw0fgSGkjxTMMHffRfuqIuUXsDh
	 t8WoD/OPn78iqiNTz1J3JwoCs5Gh1QxrofxjGRk+eE2wgeV8aM7DPB/h1/WXejy6OM
	 ZMqW/eJ1DsmWZWq93ClvikSknHXh3X+CkH53hoLrTe4kvQKz+eeB3fmc2C0m5v1oVv
	 s1/h8/Ftjlfr+1o4diYWudXlCqnzBAWDpNyKiH/i+tiqHgUJVjIxbFpe46zKBy7yRP
	 fJf3wd5gPOycn7cCGQnNyR6q3JC6/DYQFtoATRF4sYvXiZKNaRzKpy1TR+ZRC3otp7
	 c5lieeHnXpX6w==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B6923411AF;
	Tue, 18 Feb 2025 20:30:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Reaver <me@davidreaver.com>
Cc: David Reaver <me@davidreaver.com>, Randy Dunlap <rdunlap@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: iostats: Rewrite intro, remove outdated formats
In-Reply-To: <20250215180114.157948-1-me@davidreaver.com>
References: <20250215180114.157948-1-me@davidreaver.com>
Date: Tue, 18 Feb 2025 13:30:10 -0700
Message-ID: <87ldu3ngh9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Reaver <me@davidreaver.com> writes:

> The introduction discussed stat file formats for very old kernel versions,
> which obscured key information that readers may find useful. Additionally,
> the example file contents and the reference to "15 fields" did not account
> for the flush fields added in b6866318657 ("block: add iostat counters for
> flush requests") [1].
>
> Rewrite the introduction to focus only on the current kernel's disk I/O stat
> file formats. Also, clean up wording for conciseness.
>
> Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.stgit@buzz/T/ [1]
>
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>
> Lore links to previous versions:
> V1: https://lore.kernel.org/linux-doc/20250214013905.60526-1-me@davidreaver.com/
> V2: https://lore.kernel.org/linux-doc/20250214051432.207630-1-me@davidreaver.com/
>
> Changes:
> V1 -> V2: Rewrite entire introduction instead of just changing 15 -> 17.
> V2 -> V3: Reword counter reset paragraph for accuracy and clarity.
>
>  Documentation/admin-guide/iostats.rst | 89 ++++++++++-----------------
>  1 file changed, 33 insertions(+), 56 deletions(-)

This seems like a definite improvement at this point.  Applied, thanks.

jn
