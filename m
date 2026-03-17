Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E23E277B
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756469; cv=none; b=iHH9a714TRAg1fOXUuGyt7MhqXGeCXEO+JkDIclB7TKUDn1GOIdtmHoPmvC6jQVhA+79IZAqbmCT8OhVVTSEG1rjr4ybPaBcrmR2wROoXsQIrpGqVak3N9h2r/LQ4kL0njvDkbrgZRK0U9KXbne3+AJ9hIaCLssPcxGqu6A+9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756469; c=relaxed/simple;
	bh=I12e5wHS3jU0R2MHDWYT/B35wdrNYsWDQ9SWQ2/AwaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVHFdOtgWxmfy29/yE2DLoX2PsiXMmWrlypq4EfEmxyFVLILj+uIMyCRdGzsXt1zlheIMtMbmC+h4C3scqZh6WamhS+ZTS/Cd2Kx/k67X5Df6cTL+4XTtAFJFFULjIhs0zAA9aAzmNdL/jvP1MP9LHeuVFAh/1xdnhrnePiZmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A17768BEB; Tue, 17 Mar 2026 15:07:45 +0100 (CET)
Date: Tue, 17 Mar 2026 15:07:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 10/12] zloop: Add a lock context annotations
Message-ID: <20260317140745.GD2670@lst.de>
References: <20260316200901.4111651-1-bvanassche@acm.org> <20260316200901.4111651-12-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316200901.4111651-12-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 16, 2026 at 01:08:47PM -0700, Bart Van Assche wrote:
> Prepare for enabling lock context analysis by adding a lock context
> annotation that is required for Clang.

No, it's not required.  You just disable warnings.  Anyway, the
conditional locking is fixed by a patch I have in my pipeline.

