Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0412E71
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252931; cv=none; b=o25v/usY1TOrKwWwpsCcdmDNzMznLIxDn50xpiMBRlmgqR/vf5oMUUhbjTkUaM8bBhHJ9OyA0aHXExQZC1ftWHFO3YgbSRl5ORYfnOapowTTjsv8RtXnQvtprL+nV3RHr99bzwUpTE0InJ8ZKYWQaSmrEXaaucne1xHlfpO4Mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252931; c=relaxed/simple;
	bh=yr97useGfIgb+XhS5yuBKRt9cZRi/7X62ugoXGGdTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbxWXR5O8kXPfKonrbeCHk+5+k0HAPz3/lNTVUChwamslpuayMXsZSBpeR0+HwT7PGEWuXxm8KCscFkQZxAEqs4/Lch80PahKaqxPifORbFcSMsDKejPCV4yD77+nHklXylLl/TN7wxqRjk519rTmFGB4NXSSEA35G2TBTdxV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2A5668AA6; Sat,  6 Jul 2024 10:02:06 +0200 (CEST)
Date: Sat, 6 Jul 2024 10:02:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v7 2/4] block: Added folio-lized version of
 bio_add_hw_page()
Message-ID: <20240706080206.GB15451@lst.de>
References: <20240704070357.1993-1-kundan.kumar@samsung.com> <CGME20240704071126epcas5p2572342c5d25c3292a9a39cb8c798a42c@epcas5p2.samsung.com> <20240704070357.1993-3-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704070357.1993-3-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Module the same comments as for the last patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>

