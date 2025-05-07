Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1C29A0
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644616; cv=none; b=QIyF9XTYlci3+Pjqo05ux6GmjITMUX/Mk1Kj1JiTzcj01C5IVEoaEHeGth29Bc9zJm+e6/ur9Fw3E3mEcXC53OSofjCcUv0DAD5ej4qdWmoZKV85AO+z0wBqyR2bUzVXmGlOzMAFMGbFtvFubkHGmkUo1zqzFQClY/xQUMK/5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644616; c=relaxed/simple;
	bh=60ZvJgBlzuqhPVKO7oJJDJaqUW98+Gbt7VLuZ0uJ2Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BliRIM6YGGnLhXQuMMRUcaraGZ9EQBrDLukbdeAW94PDKJcjvn5G7LcOG9LT89ZL63fkrTOp6qhynvdo/s4OsTbIGmkzNAqPMcTxS8n2hkibykxakf6tD0Es1kZv0nmHCD2ymYzK9bZQNMipWQOIhfHWb7AFh1orlE6Rt4MK6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdO2RmQA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdO2RmQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F963C4CEE2;
	Wed,  7 May 2025 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746644616;
	bh=60ZvJgBlzuqhPVKO7oJJDJaqUW98+Gbt7VLuZ0uJ2Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdO2RmQAA1sXDsFxysShaJt+nqUdq5HSxGS7d5nxvSRJE2rpdKWsFQN0ZfCndh4hY
	 aEU+PlzoAFFICy8axNiVUwXaK17+r32tG/gYd67w5zHVZL/3ZHBzMhZyaA/U3Mn/jD
	 CAhWFZvaseSr4b4qQucA2qX+rz9SjnihG1scBhsrAj/4wAxasxZxI9A/rFvg53DZna
	 7PoSHCrcbY+RU7fOzicKN40qs+EjlobaHIycKE0ZgwWd9ERfMg0uclfjriUErIPYVq
	 o5vBlLF4Pt7yO2f2PLQ9YoA3nFavrfhHDsjQU2UQN9X6gK6DH66M53kP6ULznugiOt
	 1IYlTbN4juaYQ==
Date: Wed, 7 May 2025 13:03:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, hch@lst.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: always allocate integrity buffer
Message-ID: <aBuuhRBR8qieVW28@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507153759.1199895-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507153759.1199895-1-kbusch@meta.com>

On Wed, May 07, 2025 at 08:37:59AM -0700, Keith Busch wrote:
> @@ -412,6 +415,8 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
>  	struct bvec_iter bviter;
>  	struct bio_vec bv;
>  
> +	if (bi->flags & BLK_INTEGRITY_NOVERIFY)
> +		return;
>  	/*
>  	 * At the moment verify is called bi_iter has been advanced during split
>  	 * and completion, so use the copy created during submission here.

I think this may not be the best place to check this flags. This
function is called from a workqueue that defers completing the bio until
after the verification. But since verify is disabled, the deferred
completion isn't necessary and just adds latency, so I'll a send a v2
real quick to short cut that completion handling.
