Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69B3E95BD;
	Tue, 14 Apr 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180950; cv=none; b=B3UPc0t9HR4IkW0ST8UMzE92NJ1yKNEtWTe4tEGCsSD1o97emAGnQ9a3yiyXr0TAyFQDiYw08KKYjLVzi32DNF6teJdVEALdQm7lUwrCraBS844lcII734iqiStfwBeTst25Jy+UID87ssKlsRJa6lK8407nqGBCBZzOHXMJaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180950; c=relaxed/simple;
	bh=Zhi6g3yPEN2uxSDsN/A+28ZL8C5VnyvQTTqEpnhvRt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8j229a21Wb55WUZ5Hy4hCw2GSrHtKtaXL8GNSTsO5jmYUhVQ82dXS5LT5DRjhVqEJBegigpz4kdjYVpDDFfr3I5k1eFJnoUpOMrD6sKOlhzuBhvze71gDNXX62ID7pggb7wxf6AcEMrgnpX58zawTwZcpAgG1lA15AYHgjhX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfzn1n6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfzn1n6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8741AC19425;
	Tue, 14 Apr 2026 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776180949;
	bh=Zhi6g3yPEN2uxSDsN/A+28ZL8C5VnyvQTTqEpnhvRt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfzn1n6EpTRAHbECrupVQDjIyO5XV3ORmBRDv9vlk16b97BBjwTuMakAhbFBCCLtg
	 IkSqhUIv6HlzkTsjhZMglROyvsNSR81THgTs/RmzdGbrJSeMEGbf1hf5Kt3kUXBKLj
	 3O7sQq60IGLEViV0G/KNk89EpAnPZLeJxP9y1XvetJ0vR70JKTYMbciK0IxOQAiDvp
	 MgcSLFRwTF8XHGUgqE+6Qq4e4ZXWvp+6HPPNt0nVv/9lNm6Qo2w1mx4e5ayVA8PPHq
	 1qsW/kto0s0mY3MjD9Qls+58BgpZpuOvAOxk8Z7Kj75oCjqGSv1G5hGDEZDr/ogO0W
	 7fNeh5J64VZzw==
Date: Tue, 14 Apr 2026 08:35:48 -0700
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
Message-ID: <20260414083548.02f76970@kernel.org>
In-Reply-To: <ad4ox7ibZoiW-tje@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
	<20260413104939.5ef4d9dc@kernel.org>
	<ad4ox7ibZoiW-tje@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2026 14:08:58 +0200 Christoph B=C3=B6hmwalder wrote:
> But we still need to support the current family via a compat path, and
> I would much rather have two YNL-based families than one genl_magic and
> one YNL-based. Carrying both sounds like a nightmare.
>=20
> So the spec proposed in this series would never actually be used to
> generate a userspace client, if that's what you're asking. We would
> continue to use the current libgenl-based approach, with some userspace
> compat shims to make it work with YNL. Then, when "drbd2" comes along,
> we could "do things properly".

Let's jump to the drbd2 work.
