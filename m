Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F1138490;
	Sat,  9 May 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778285979; cv=none; b=TDth+afegmVue/f+p/9vf4MEA53bnXkV1+a5btlxE6h0xF2e8+yUfNIAdZmUWz/0DFWOHY9cr4+9dC3lFAeEW67JrAtlrTCVtpDvsuEcR8yDrjOe8h36bkFBiPbOmXFSOuJNDSbX2tJn+X0IeeWiYHifgIZ5xkH3nXW/jK1dTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778285979; c=relaxed/simple;
	bh=b5qA5vB1EXMLj/yB7RsAZzkcdF3PgoU+Nhq97+UCZz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncU2MvC4iwBFMtn86NtbQAhO5pDkjItRiMs1PtfCuyY9uGu1tcXf+oTl2qWboCpD1kMmI64XJf+OtmADgqeCBf4OSZMPGylCod81DLw/QbAoSPk4QGRi0oOXsQz/TmYCq7tKBGshYm3ohwIzcwHtS69DRK8kV9QJF6aOr/UZ0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE2HmQNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE2HmQNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A813C2BCB0;
	Sat,  9 May 2026 00:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778285979;
	bh=b5qA5vB1EXMLj/yB7RsAZzkcdF3PgoU+Nhq97+UCZz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oE2HmQNS/Q/ccBjA9xlyKCeceeVlStrUxgDk7xZf07bD36CuDtWE9LA8Qj/kZo3YH
	 w9C5wIMQfCt7wRAIK1rIZneK0hPUNsJalA1yPd5cfvSutk36ohP4yaxAiYxFpQDOdq
	 o4KuMVdT6hEJe1T4hk1684MiCu3GUK3THAJ6HJy3cL7CYAy/ufMr3rcYHJ+fagTMSa
	 7Dwh2plsFKfpzKDaDw4idoFymGhgqQJEGYUiKuB+OGS4pdtaaHjymqCUk6hkzGXdE2
	 C6dJqyjE4Wau8FC5HvnqZwLl7Ki+Rh0J9CbRFw06ebLHiT7GTirTUli+TZpM2z/9Cx
	 9fesukQdaSRig==
Date: Fri, 8 May 2026 17:19:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Message-ID: <20260508171937.1c9419f5@kernel.org>
In-Reply-To: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
References: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  6 May 2026 14:45:39 +0200 Christoph B=C3=B6hmwalder wrote:
> DRBD's genetlink interface was defined using a custom multi-include
> macro system, genl_magic_{func,struct}.h. This system generated struct
> definitions, netlink policies, serialization functions and more
> from a single "magic" header.
> It never really caught on; DRBD is its only user, its internal macro
> jungle is next to impossible to understand, and even harder to debug.
>=20
> This series replaces it with the standard solution, YNL.
> The *_gen.[ch] files were created with a modified YNL generator, but
> these modifications are not shipped because the current DRBD family is
> effectively frozen.
>=20
> Note: this family primarily aims for compatibility with existing
> userspace. The next planned step is a new (also YNL-based) family,
> "drbd2", which will implement all the actual modern recommendations for
> new netlink families.

FWIW:

Acked-by: Jakub Kicinski <kuba@kernel.org>
