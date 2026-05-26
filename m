Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA742030A
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825107; cv=none; b=b8SPgbWQMkTkkEgG9/lJStS/Wtwk2hOFe2Gj050BiCUNoaCi6kJmNhbJogXXOw3wkfBmAOGui+MOutZr/mT5Pbdj8liLzoe9zsPQrrOSPST3KseNSPKZAXgddfjlqoyQHHG+4khbbmLmXKCUAL8o00xBU3NMrzQQtgyAqjfp7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825107; c=relaxed/simple;
	bh=WFUswkoBa+zIhUw9qbOjqNqqoE5+b5W+xxa47lsvp3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXdKl/di3/46MmtBOMHoLMUh5vqobkEFFBMGoknTCkQLM4ypujm1mo+UDbuOUrysXF5Wt0wKMVo5TYqFHp6qqTsLc4ScJ5AIDqE8UYHlQCj6FABZE08IHYKra3OXXDpi/+/Mr06F7L36nAfdJiIIBsTnZ1jmqPnUX95s+Rj+Wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5SHUL4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5SHUL4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BE91F000E9;
	Tue, 26 May 2026 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779825106;
	bh=62wfmmufMD4Zrd4hUAZrV6c823IdxFxwW4MaqzNPxZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5SHUL4bJ9UzkgOqWX1ug956YHefp0+pNQEUOoTKeEUA49rBX2O8YAEXdWEwsnZzQ
	 1K1w9C3icUh7FXW94fyc+R03M2bw7P6SIdqS+s4x/vAGWvc5BQKb+AlNmnH7vdjamM
	 8rq1Frqzm3S+q3qqhRC5qn2H5Z3V2FDyxpG5aPhbdG/LyXDaGuu9jJr8eusdIi7ISP
	 DiJbVZp2hH7+fCoT5BCK53iEsmKkeqFEMXCamorYUdhoZ6P18inUKhdGtq0N2jFJ1S
	 2agnD+S7e20jJje7OHUXHscsbqSIopTZ95fHBeZyjAYmIy4NLJHqXAy7uIXclp6RL7
	 01d3GjUFykPhw==
Date: Tue, 26 May 2026 13:51:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] bvec: make the bvec_iter helpers inline functions
Message-ID: <ahX50HKkPtN7rNEq@kbusch-mbp>
References: <20260526070042.1817997-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526070042.1817997-1-hch@lst.de>

On Tue, May 26, 2026 at 09:00:27AM +0200, Christoph Hellwig wrote:
> -#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
> +static __always_inline const struct bio_vec *
> +__bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
> +{
> +	return bvecs + iter.bi_idx;
> +}

There's a couple drivers, nvme-tcp and loop, that call this without the
const qualifier, so this will produce new warnings. The nvme-tcp one is
simpler to fix by just adding the 'const', where loop looks like it
needs a little more consideration to get there, but still doable.
