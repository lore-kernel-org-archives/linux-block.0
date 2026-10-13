Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3796511217;
	Tue, 13 Oct 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903989; cv=none; b=G79lsfFhU3wdPHR0/YRNrEzjui9H6cBlBH9QruP60vQAKnfGiXUo2jHu7th0y9ywWKVyjrLmXSxaXyuIFmW1il6LmI6ZRfORAYxZ0nlMZZ7FP3XHUtW0yIuSZZ3F6KGl9mzwKuL8DCWSnNNB3O1Vy4ubQNP1bg4qeU54R783nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903989; c=relaxed/simple;
	bh=tKGJnPqPnuoMHUmoNXrpk33GgsTEYsrnTRJjd259cbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnXvTJBt08z6h5U+tXkueK31v8iNuKvkL8yPIxOGKUOd22+jGp43kNC7NXqwOzFgV5+4BJ7oHJj8XuGD1JwP2mdFgeEtdGF5GuWigpd7VUPHsf5lL98SVKJ+rhftkgZoz0liOj0s6R1ExQ5g3mv76vNOndSEIkZS5un1V/M88Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiGZYO8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiGZYO8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C181F0089E;
	Tue, 13 Oct 2026 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903988;
	bh=oeDVFxI7KzpHQq0vn8qs5iujeSPpRMCAp16GZFUVdk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LiGZYO8vTNNss7ES6TN2wxRjUrwF9wXpBbz7SAGBglXP5/MrM5OZbvTGHDJMIRy4T
	 v6qcgVb2+LYbPQvTO+uUasDldR/MpAIEvB98CoaPwRMGeh9vRsHUCZ5D7Pimhwv9g2
	 haVHznXFlgAJPljp+RM22Oq8d6WrVvchmkUIjWnPKJ/nR3AY66f0lWRYrbwV1HQAYi
	 ki1QSOVOc7U0uN+t3Rub6ORKl29UBeKV3+PEoFJhJoXyi8OS9FBPIqV+dEWTGQVjOn
	 OKeT+JTi4h+JaLZYAZyWhWwx4QBk03y9ul++2vxAgHVGCtmKegRrzB/3PEgiRczZya
	 X3ExhJOQSfZyQ==
Date: Tue, 13 Oct 2026 09:06:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: dinguyen@kernel.org, schuster.simon@siemens-energy.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lftan@altera.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nios2: fix __wsum type degradation in csum_fold()
Message-ID: <as5I8gmaWXr5OUgb@kbusch-mbp>
References: <20260922153416.730513-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922153416.730513-1-kbusch@meta.com>

On Tue, Sep 22, 2026 at 08:34:16AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> csum_fold() shifts a bitwise __wsum type, which sparse reports as
> "restricted __wsum degrades to integer". Sparse only checks the body of
> a static inline once something instantiates it, so this went unnoticed
> until a recent block layer change added the first csum_fold() caller to
> a file built on this architecture.
> 
> Force cast to a __u32 for the shift, as the other architectures do.

Ping on this one?
