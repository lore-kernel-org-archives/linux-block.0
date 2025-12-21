Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C82505A5
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766359041; cv=none; b=nqqejwds810rutNmOSzke/KsE4VUTwHU0B3DgQtqBtpvkz3GB5XkNaILiV3CQpID2XUftKIQivrUv0K9rfIkrKOLiglFjAi6A0+1YMZXbTzZzCRMS061CyTVzCPPPTKoZzH+RpMf8kF3sIcKDI1CfDN6YRSI5+g9WGPQtQcVIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766359041; c=relaxed/simple;
	bh=iyLpVsiA8ORSOe0sQppKrZn+L7O20ZMfPMTxTtlpZKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCccZZK6X2rhHJW1DboEpyR2GDFd7QiNGhEj1TK6Y8jfoz5IDBTd1nqafO54prsmQndFx0oVOICrMYoCJCF9vOjRKmFFHcJpzZon7Op6kfRAaTjYrRgcySFPp9T3GTCHtRnCaOj9VOgIbKMbxA+NGm3zJAUpy1PS/JJ5xnrDwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1gvv86k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1gvv86k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8794DC4CEFB;
	Sun, 21 Dec 2025 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766359041;
	bh=iyLpVsiA8ORSOe0sQppKrZn+L7O20ZMfPMTxTtlpZKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1gvv86ktTBvn942fUjwHDB3KbNVedHydJlz6r+8aCGit7JP20j2FnCmEw6DpohFH
	 iMqrURAKlPP/A+QeD+k4P/UsSVr4onBr9SvYNC9nkkB6x3nssfDQiOo3w1uPhC5dag
	 2jNnZyMRnXQ6Dq4c7Xl4FAmLSgQwJ9v/Np/OHPWrB26c/xauGiW4uZu+5bXxFd4DYv
	 JxPsgWq7yXh/jlr88o2FW3Vgsl4fdHHYKYf+oAy1h17XpTYMftUTjz/yIqCHEnCNzF
	 SI/v6pb929TSk9CeTSZFRVb/nvXJ5b2ZUsUZnc2YwIzilAMp9adVdJ9AxslibaTXOX
	 RR+fwMQEKEARA==
Date: Mon, 22 Dec 2025 07:17:15 +0800
From: Keith Busch <kbusch@kernel.org>
To: Vitaliy Filippov <vitalifster@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
Message-ID: <aUh_--eKRKYOHzLz@kbusch-mbp>
References: <20251221132402.27293-1-vitalifster@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221132402.27293-1-vitalifster@gmail.com>

On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> It contradicts NVMe specification where alignment is only required when atomic
> write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes

Commit header is missing the "fs:" prefix, and the commit log should
wrap at 72 characters.

On the techincal side, this is a generic function used by multiple
protocols, so you can't just appeal to NVMe to justify removing the
checks.

NVMe still has atomic boundaries where straddling it fails to be an
atomic operation. Instead of removing the checks, you'd have to replace
it with a more costly operation if you really want to support more
arbitrary write lengths and offsets. And if you do manage to remove the
power of two requirement, then the queue limit for nvme's
atomic_write_hw_unit_max isn't correct anymore.
