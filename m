Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E129898B
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368478; cv=none; b=BOT+yaZ+v1OCyXML+hJivbYXB+3S10HM78Bxsmn9/1oD/MS77oB8ljlqJZDyodDhJNDi+M7xpum69I50j09MJaODKPX42N0aVNPZf3a3vYVj9lPfq9294tbKCTcKmlynKZvqaNBClkW4FxUSht0ILKRo+bZi2BpCEuEPLplrGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368478; c=relaxed/simple;
	bh=+X2MVdmNrJF/V3nvcT+W9hT10XSoF3OUmkrYg9xLKXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFGSW7AnkGpLEjoLZ1r40zAi0FqWPzd67zT0krW3CgSTS5dO7cHwNFdg12Eb8ELaBEe7v2YN8sOrwt6tBCf905GCogJ9htuFW95zH/WO3wPFZBQwXDSS6LqfVFlARRmT+BOoICrsYFSKJzq175jZ/EI7IR9KO4TvbmSBrOJUtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKzQbKAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKzQbKAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3599C4CEF5;
	Wed,  5 Nov 2025 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762368478;
	bh=+X2MVdmNrJF/V3nvcT+W9hT10XSoF3OUmkrYg9xLKXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKzQbKAAAJv0izxIjAn+iCPsWg7+UlWa3dCcjyQhqKA4RYJX8uMEThkMuM0JPXjiw
	 biEjKRM4ee9ZLh96E9VfjOoZGEZQ5grF/jaZPwiQSso0Cv9+DNg6jfj7DeQyTb5yUa
	 /snPftnxvOmLnsZAOezDOnQCGkK0Og0gaPqNd9WgLCvHDtKmUbfhE42Ijz9/ecgHsE
	 PcXxfQGJI9ZhWlCTsttoxeVjISd5i1dtwl8VI7zGYKEXTM5EgHF6l7y9CSWwcfc+E1
	 4bga1LxCqK8UhI384vFyCGPt5M9j9B0bIuKF4oVwBjDwIGsr1SKHaUWJxsYe84Yo0+
	 i+u8q72gaGfnA==
Date: Wed, 5 Nov 2025 11:47:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	hch <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH] null_blk: allow byte aligned memory offsets
Message-ID: <aQub3Fnmr6zlMqE3@kbusch-mbp>
References: <20251103172854.746263-1-kbusch@meta.com>
 <3df2d429-7cd8-4186-a47e-2fbb4489ed6f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df2d429-7cd8-4186-a47e-2fbb4489ed6f@wdc.com>

On Tue, Nov 04, 2025 at 09:15:15AM +0000, Hans Holmberg wrote:
> I applied this on top of 6.18-rc4 and hit the following when attempting to create a zoned
> nullblk dev(see bash script for recreating below the crash): 

Thanks for checking. I spotted the mistake in the code, causing a
potential buffer overrun. Got it fixed up for the next version.
