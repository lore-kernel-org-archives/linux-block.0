Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4253F0A98
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290346; cv=none; b=LD91g0aQjZbi5QJMZa6pmTFPaAIahces28eWMrl0iB/5hkwj+d5x/olM6daWyF2RWwD9iertxoeaNr9RDMj88gMgprw1e0rS1rdEUg7aFljWpTRQsIvdU+byGH2xx+jBMIzaXJg9HtYDuOhegLn7E9SjqBgE7oUKi8nGsnLvJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290346; c=relaxed/simple;
	bh=SaGndv1sZcIDwCrKV/IKg2C8VGTEybpPMLMIJMMZUoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzD7BzJwGTm49b9FPnO0bBxpjRKeJjuaZPrJlXb5dbUDgqikIiLjGWyZNaanR7AfDXz+TO2D5sHwvd1pMQjrmIsWdtRYrhqxMA0dqZRyPC6BJEU09UuZmz8pNbPJloVjRUT2fhC1dFpqKivJGW+2QRtqFaZWuQrpmi0kEswZaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJvU0lrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJvU0lrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD51F00893;
	Wed, 20 May 2026 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290345;
	bh=4oasd/yJa0K1TRSG+ZPHoS2lgQfXO6TXKwK7m/2VakY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bJvU0lrg3TUf6173gpDpGIGJGMQgML3JDhFJxP+0Hl4dYd7EjyewbFsMrE7Asfkzo
	 VhtnnXVavSXo9HqRxK60rZmBdMaqFQ4imiYwYvNNd5cvoJnobMTxWLpL9Qiex/b90R
	 ANP1fHonZym1o7ppMSqjSe3GI040XgeC8VJyiMSBBxfl8ni1MFmMrWyBs9cMb3h/RQ
	 8TDsxllnvNHFhAlHvzB4W5u7M5yjIGjx/n+CzDVgHsp25wdES+eYYmZsz6OUe6RAm+
	 r9nrkaiDSaG4ZQOBtO8xDpA0O5/gm7Ptr39Qgpvg/NHp34yKVBydBJjr8Ae+OWBmih
	 KrdpbccY5o62w==
Date: Wed, 20 May 2026 09:19:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	tom.leiming@gmail.com, coshi036@gmail.com, Igor.Achkinazi@dell.com,
	dlemoal@kernel.org
Subject: Re: [PATCH RFC 4/5] block: move bio validation into
 __bio_split_to_limits
Message-ID: <ag3Q5wdOBFNclfMe@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-5-kbusch@meta.com>
 <20260520072548.GC14937@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520072548.GC14937@lst.de>

On Wed, May 20, 2026 at 09:25:48AM +0200, Christoph Hellwig wrote:
> Moving the checking from submit_bio_noacct into __bio_split_to_limits
> means that we lose it for bio-based drivers except for the few that
> manuall call bio_split_to_limits.  So we'll still need a helper for
> them, which could be called just before calling into ->submit_bio.

Oh good point. It looks like many of them don't even want their bio's to
split, so probably would need to factor out a limits check from the
split so that both can call from an entered queue context. Thanks for
the feedback.
