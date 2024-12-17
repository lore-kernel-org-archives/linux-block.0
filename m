Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77AF14AD3F
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408922; cv=none; b=kAumeLad/sv6NEQEK6VjdHxJLSOPYlwJ0bNUV8jsJnFRAjzS2L60bqXZ4NkqcJ5r/sfxLG4spN7Rs9o46nAMH87BPnnHZ6FVg6wZjfZeXaZ+8fKPqeSLrLM4hl3VhwAYFKL05/0DrO2Kc3eELoxlgCDlP5yeCfwyuCMVg74Bnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408922; c=relaxed/simple;
	bh=0SuXcgBtvXf4XUeRArgqREW2a++n+q8mlPAFybOxSWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIrI0YCkWXIX+xbgCZm0mOPGkyn1V8APpWGfIjkPkXaPcMqkYKr133zxG6Mb9m3EyrXH/XGX+89D9N2vdZUMxQwOCemKutHBfxpqQF/73kLqGjPuu7D729yxwscYa82G0seYVCZFguMvvgZxEdMwD8O3pXxn5HVkb5DB9a+FVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 708F768BEB; Tue, 17 Dec 2024 05:15:15 +0100 (CET)
Date: Tue, 17 Dec 2024 05:15:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: Zoned storage and BLK_STS_RESOURCE
Message-ID: <20241217041515.GA15100@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 11:24:24AM -0800, Bart Van Assche wrote:
>
> Hi Damien,
>
> If 'qd=1' is changed into 'qd=2' in tests/zbd/012 then this test fails
> against all kernel versions I tried, including kernel version 6.9. Do
> you agree that this test should pass?

That test case is not very well documented and you're not explaining
how it fails.

As far as I can tell the test uses fio to write to a SCSI debug device
using the zbd randwrite mode and the io_uring I/O engine of fio.

We've ever guaranteed ordering of multiple outstanding asynchronous user
writes on zoned block devices, so from that point of view a "failure" due
to write pointer violations when changing the test to use QD=2 is
entirely expected.

