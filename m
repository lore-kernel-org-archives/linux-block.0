Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40700389115
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534734; cv=none; b=cA42KVqmRB8MkBAAP8lbF+UFkIapmYIx0zZonnArNB7wOEQgqEy0HY6a6iipdrG7c8cX68R50UlDaFCz7VN8mY1aESJ6FG+fKAK2e5re5U0g3BOAHG24YduydkOtIKkyX4OC75+Ao/AjuajlejR9V2DI++6oOeL+OMaoVsIr4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534734; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3/ka4RyWtjn0l1jh80Y0OxeMqRkVVQqxv7wyfoAZHCVSfGHxUBGtESqUjez4cBXcQAM66umEtFpaSzuekHWvKkBb1+ir8glPxhG1nRlU+7c0DIX/bIv8BAxqlz3fgAWrG5ms5EnKIzcawoC7s7h2bJa+mXV2xct/86vsLCac/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FAD268AFE; Thu, 26 Mar 2026 15:18:47 +0100 (CET)
Date: Thu, 26 Mar 2026 15:18:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 18/26] mtip32: Enable lock context analysis
Message-ID: <20260326141847.GE16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-19-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-19-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

