Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF74466AE6;
	Tue, 15 Sep 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463514; cv=none; b=TwyCp0z0QmLv8NNz0YFA0U8zFG9jltEdMzNg7PB3HWx4gkDUDvGVM868NxDbMSo3mJ7lk/0UiX0gGSnfspu93ChZgiHYkUTMKnxAjml2k/BTP61GvVAFSQm2/VNRE67JqZaxy/nP/bSWb3PU/l6LRuAN9lSpTy+NuBWoREDXWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463514; c=relaxed/simple;
	bh=J6KfTbZZsfezM0agr1fPfH3MsGi/UPS3jgcNYXWsm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG9cnLlFUCz0QodH8N6Jtvs/C36jTvYUWBLEQvFJDHDlsY97Q/7X5Bglw06SLfkfBrWugJErFQrgskK+y33RX9DVfIedOP8hdht1K4gibr2w7Zq0IYzziclgEohJRCncGM9zNY2VFkWd4Cowb2VJu1du/E6/7NWeymNGuqfGAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40A2E68C4E; Tue, 15 Sep 2026 11:11:47 +0200 (CEST)
Date: Tue, 15 Sep 2026 11:11:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v2 for-next 2/3] block: allow error injection rules to delay
 bios
Message-ID: <20260915091146.GC15715@lst.de>
References: <20260830012002.80275-1-haris.iqbal@linux.dev> <20260830012002.80275-3-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830012002.80275-3-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

The delay does look fine, but I'd really like to not use up one of the
scare bio flags for it.  Can we insist on the delay only working for
an error, so that we never have to reinsert?

