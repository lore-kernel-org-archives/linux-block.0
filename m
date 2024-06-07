Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F11C696
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 04:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736197; cv=none; b=rzGAatDnSsSlI3S/eq01mZua/gxuDOpBQyh908P0nJjOHNh5bVbbZYfKuXwPfRLIimhmcvdFq7SodZl+t4YxPnlEvfGLSlnHQhPF9wB6yapd5jEZa+BALdsFe4bE7k2VxJJLl9Ech7SRFX88azA0VAfDRTBpqxCsaUtMW9C5RK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736197; c=relaxed/simple;
	bh=/vRtXN4fKK6+TMQFmCcAfmcLD+JzkgKkfie+Npl141w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbDrwXvy0RL8cHOptp79+lX+wwhsTDgQmzwVNw82OqwVP1JV58nChh9S5sDYTj84EYpxESTyKFag15BMK3S8Wuj+kHoFKUv4tAnXFpQa/mtsRz4kl0F+v/rMQsiLMKaV+sGpw/cRtjJORMkzQ5LKiqMLXj8ofqurH/9qk8kmG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2C6D68BEB; Fri,  7 Jun 2024 06:56:32 +0200 (CEST)
Date: Fri, 7 Jun 2024 06:56:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] check: confirm dependent commands
Message-ID: <20240607045632.GC2857@lst.de>
References: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 07, 2024 at 01:52:46PM +0900, Shin'ichiro Kawasaki wrote:
> As described in README, blktests requires some commands to run tests.
> Check them and warn if they are not available. Also confirm that the
> bash version is 4.2 or larger.

Loks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

