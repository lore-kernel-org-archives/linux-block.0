Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CD2192EA
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826679; cv=none; b=ssfZ2AkDdxFgdLb4B3V62jXIB7eI/GgF1SkTUvBakAzwzI9FxgRmdEdDObCAtLRtr1jdxP0fZmjg1CujUyj2ifEzHnHf97+eXGzmTEOL/NrDpwK1lIEKiKZaol5WEqjQ1TUrXslR7VRqAh3DaUOv6MKU1vzlJtS1WTEdEkORY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826679; c=relaxed/simple;
	bh=AsIy8tLaxOo7ZH3jREf0QxYd+b8Jo9YqTIA8z58Eptg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtVxdrbY+0GbseRPs+sy9udWzxDfI7yyG0PujYH9FseKZU5I+n0eBFeSyQ2SmAbGB6hPzm8/66gdFzmjNZeXrv+6hLM5orHwB1c7e1/9faX0rLcI9TYSpaw+AD4ppK1mBfA7c2JrGB9C11iW5YJhp5bSAabQaSZ2y7oc5en93JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2F5C227A87; Fri, 18 Jul 2025 10:17:52 +0200 (CEST)
Date: Fri, 18 Jul 2025 10:17:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250718081752.GA22830@lst.de>
References: <20250715201057.1176740-1-bvanassche@acm.org> <20250715214456.GA765749@google.com> <20250717044342.GA26995@lst.de> <4bc3f4ab-ddc4-48aa-902c-8a24c1189dfc@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc3f4ab-ddc4-48aa-902c-8a24c1189dfc@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 17, 2025 at 10:58:09AM -0700, Bart Van Assche wrote:
> Is there agreement that this work falls outside the scope of my patch
> series that fixes the write errors encountered with the combination of
> inline encryption and zoned storage?

I think it fits exaxctly in the "scope" as a fscrypt maintainer and
author of the blk-crypto brought up issues with the current approach.

