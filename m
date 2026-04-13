Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5A3815CE;
	Mon, 13 Apr 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102591; cv=none; b=DRhWS7R2tYA2IT4cJIwQgS35zbaNmOuCqGYfkyd42D4knNdr5BmmzIuejYmd7RU8DeEVl4h30xOpugb75TtWZOK1bLJijvV2zvobPyGW8vRXyOhF9pvjONYYEuc5ur0nwc3ZDs8NsKyy2rnLCmdtjGS2HYGvtPTyYsYZz1RGojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102591; c=relaxed/simple;
	bh=RHlWpDhqE4IKOkFXV9Fh64KcGdDthPmi41dfkVaT7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTIw1IA/+oXLLULkPnCKMJaE6LjTaYWEQksRy0fDZTNIYAzb+awuXrf1YouLPnFJSGZ8DUGv2W+VdD/H/l6YfPCyYU9wOfFBlE12i94AV1qQVg572fDXKDhMDz9MdVpY1H+12Nw2VUcvVQ5pjrv65nNTa9tDWplsZRrsQovofdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd5m4oxg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd5m4oxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09482C2BCAF;
	Mon, 13 Apr 2026 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102591;
	bh=RHlWpDhqE4IKOkFXV9Fh64KcGdDthPmi41dfkVaT7Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pd5m4oxgxc1vqwjyEk7DN6TH2VpxTalo4RumGHaVVor1SNl1iMBx8h2Ag54LYKuru
	 b65KDkBBPKyPXs0q4YhzDqW6ghgjdWFXJIyDy/50knKXbLZkgdKdILK6WEXx+zt2tU
	 7rOj7gCfVGp+0TbEM5ufWQtO031CsBr/bKdocJe54Np+rrhF/Xc8QTPUb5WNnu/GfZ
	 zR54cG5qCcspBnMFrdiWjD3fA6BmIgSN3hQwi8ExomvmsE8+W2JQPHVOqh/1LEMKPT
	 mxWqhQKO35QRtKHhlQAqcG7AZw8rJj3sYXSL+lyXIEBDBFEQ8aAg8UYUdytK8dozoL
	 XqW4/3d5W6dLQ==
Date: Mon, 13 Apr 2026 10:49:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and
 helpers
Message-ID: <20260413104939.5ef4d9dc@kernel.org>
In-Reply-To: <adzVUdf74CVk2DwJ@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Apr 2026 13:48:32 +0200 Christoph B=C3=B6hmwalder wrote:
> >Can we just commit the code they output and leave the YNL itself be?
> >Every single legacy family has some weird quirks the point of YNL
> >is to get rid of them, not support them all.. =20
>=20
> Fair enough, we could also do that. Though the question then becomes
> whether we want to keep the YAML spec for the "drbd" family (patch 3 of
> this series) in Documentation/.
>=20
> I would argue it makes sense to keep it around somewhere so that the old
> family is somehow documented, but obviously that yaml file won't work
> with the unmodified generator.

To be clear (correct me if I misunderstood) it looked like we would be
missing out on "automating" things, so extra work would still need to
be done in the C code / manually written headers. But pure YNL (eg
Python or Rust) client _would_ work? They could generate correct
requests and parse responses, right?

If yes, keeping it makes sense. FWIW all the specs we have for "old"
networking families (routing etc) also don't replace any kernel code.
They are purely to enable user space libraries in various languages.
Whether having broad languages support for drbd or you just have one
well known user space stack - I dunno.=20

> Maybe keep it, but with a comment at the top that notes that
> - this family is deprecated and "frozen",
> - the spec is only for documentation purposes, and
> - the spec doesn't work with the upstream parser?

The past point needs a clarification, I guess..
