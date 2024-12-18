Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCB14D439
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505153; cv=none; b=Eh12Vm0DEWTVyHhObTBUoUubaQolvfoAsa3kdst+ABWl20SRyKoYm6qtMOsOpH8G/prNhXlo9KhDEZvCjfW2qZCRik1pnXYvNRi1iubVV+vVqRgvf6G1NazyK54HF1k2u+EmBuyeMnF03EVbRll15ijE9lQTLP8YTSRlXWEWW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505153; c=relaxed/simple;
	bh=VFpqsxC00QkIBa5N7uCjRQHQvOPGVWHnu2oLj58UQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aeux2QZ0Jy5scSKnGztTUmNJz5/lX0YXdJdpvQIBfB/TVRnblPTWvm3TV8t5TjxhaeyghVSK18sSV0m1EW0V7YZHwYQa95mVeCKaYB6wy8CmWaLT2DBkMHt1I68TdrzQeqnBI1LPpXd12SdNJCRB3aaD5Bd6MaNGAS/3L5d/lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B50A968AA6; Wed, 18 Dec 2024 07:58:59 +0100 (CET)
Date: Wed, 18 Dec 2024 07:58:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Zoned storage and BLK_STS_RESOURCE
Message-ID: <20241218065859.GA25215@lst.de>
References: <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org> <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org> <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org> <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk> <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org> <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk> <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org> <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk> <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk> <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 12:59:00PM -0800, Damien Le Moal wrote:
> Thanks for the pointer. Will have a look. It may be as simple as always using
> the io-wq worker for zone writes and have these ordered (__WQ_ORDERED). Maybe.

No.  Don't force ordering on people for absolutely no reason.  Use the
new append writes that return the written offsets we've talked about.
Enforcing ordering on I/O submissions/commands/requests always ends up
badly.

