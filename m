Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000B18C03F
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183152; cv=none; b=h+NszAQiJnL71mrRMCSiIlzjRRCZJ6puycP9r1BdI5OYIkc+6tLUuN97WBAoYzHNtKcZTcQ19JoON3+5fv0K9CBYKvXAkGAtpWlVPv7/KJE3hwiO3hVj1tpnpqBL+4/w+KKPbFgFxpGVx+HOktOpc8zsD60QeWUb93mkqgHGXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183152; c=relaxed/simple;
	bh=fV7qJD6yhgwuJlKH1+42Z45MafhWPUSlgX3fL8yBa7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6OvzLTBTH6ziB6urlbgfu25cI/dm3/Bak8qLNP715/FZ/Tdj2fIqZ3QOg4FyKF+BFthK7gw9Z7aGPsWRqnzPTmqnztMJV2UeIKnDmHKdwFVTcX/xOS8j73VyG9sYaHuPlVuYoCa7YycrCPXUk4BPpmFx/AX63vjLW6BycaTslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZIGC+r6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZIGC+r6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C7C4CEE7;
	Thu, 23 Oct 2025 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761183152;
	bh=fV7qJD6yhgwuJlKH1+42Z45MafhWPUSlgX3fL8yBa7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZIGC+r6jVLTAf3Sy1p3fqOs0HkIs7kNmVojm+Ul/ViiXDbNB0xbvRaResMQtRNOq
	 32NK0IXOqZVgrT6in6lDEfwujWNjq7UudbstmWebpnPvaVJOwOlOeJnNHFDJqy8nSK
	 yDrrWTJKRK8RYi4FKy93hkyJg8tN/0SwXm04slUntJst2hmDTeixQLLPuZVvhkj5oF
	 s4aVxlxpRSMZHve19wZyqd3+iarfaJoYZ49r/PtdwY8IPeSdhRfeQRZ9bEfcRszc7t
	 XlIaS34pPVbyZNzc1hiFThIRufqgPknFm/tp8UfMIk/O7l9VMoENa8wE1RGSAgd4+b
	 x6k89QOOL2ysw==
Date: Wed, 22 Oct 2025 19:32:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@devbig197.nha3.facebook.com
Subject: Re: [PATCH] blk-integrity: support bvec straddling block data
Message-ID: <aPmFroUdJkJCIjdo@kbusch-mbp>
References: <20251022235231.1334134-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022235231.1334134-1-kbusch@meta.com>

On Wed, Oct 22, 2025 at 04:52:31PM -0700, Keith Busch wrote:
> @@ -65,48 +79,61 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
>  		struct blk_integrity *bi)
>  {
>  	u8 offset = bi->pi_offset;
> -	unsigned int i;
> +	unsigned int len, i;
> +	bool skip = false;
>  
>  	for (i = 0 ; i < iter->data_size ; i += iter->interval) {

Ooo, this should have been "i += len". I wrote some test cases to hit
that a bit after I sent this, so will need a v2. :(
