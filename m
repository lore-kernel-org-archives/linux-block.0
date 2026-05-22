Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF73947A4;
	Fri, 22 May 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454923; cv=none; b=F2gybSmbG5l0RqzZurVQrSwqQ1yI6hucMzy1Gzn5ctkg7lwMf4KzKdEZmt3GW7iAR1x09wKW1SESXirdRKIHrozY5L2y/qxmLSsgWKTVitSPUegvdCHSm86iKttBEYYxO0lgy/Dc9JVPEd18g8nBUAD9fheHBLdpkHpwWI6DxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454923; c=relaxed/simple;
	bh=uF4OGkHlj344yFcM1V9Q4dUficuXS4ObZFLa3j+sOb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXDKo/NE2evlWvcxPOzBVsuXP5WA9SvvYfKI0F2I0fOZ3Va1rAkdseFeUAU6MhVOy5tQlvpkvOMdQju/ptjf4dnM18x9xC2uQzZnFAszIiWvOUcdFN2oleHnsZmvfAD8+5a5g7piBlmrL4bcjR6piDeEACIdp2ddlR9v9OVkAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD67268C7B; Fri, 22 May 2026 15:01:57 +0200 (CEST)
Date: Fri, 22 May 2026 15:01:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, yukuai@fnnas.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: Re: [PATCH v2] block: propagate in_flight to whole disk on
 partition I/O
Message-ID: <20260522130157.GA25237@lst.de>
References: <20260522123437.214058-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522123437.214058-1-yizhou.tang@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks unchanged from v1, did you just resend that?

