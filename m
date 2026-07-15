Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65838944D;
	Wed, 15 Jul 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127618; cv=none; b=KycTtG8wR84WgMHGcn0KbpR9zLIhItLCq9hqygxBegi8ApXRLzJZ+QcCUSZpJ4Om/NjQcOsCBX51Q0ITgyQgsco4coEJ5GJDtfGaeu2xxSESTnhP8NoUcRWPid88sYfHe1f4CNenw9byQAlnIgF0kpbvtvckyGNJIs+7muhWhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127618; c=relaxed/simple;
	bh=1pzGaTvf72z5X3259E8ivsaQcRh5GltHmZyB8tD/0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTEabE5cZiUHaDnXNhWLngv+a4juXEdApcV2qC99APLJG4/H9XkT1XcY5WTDaCAuUUTs01LoOBi/cREqPS+1lgG5zCdHq6vEDBuTQzo146JjbosTHfn29St+b1WOQ6TODnBX26bL5TQOsFb62l5t2hf7OPyrK5xF9KTCl40UBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyNj9JRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyNj9JRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313B81F000E9;
	Wed, 15 Jul 2026 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784127617;
	bh=IOaKmdfiiDrqAjMrZJnSAwAKxpQDI3Cn4h4ccunFMUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DyNj9JRK1pHUTGl1S63juU8GsDZTFP38co68sU3oAYvmQDsdt+wYiDmp6+EVrhN9U
	 B7+xLfH2L8/jlMq5HYTerQ+J3ZWbp9naEO604BZnfvrp/SUyewAi0RZRKt3QsxDYt3
	 ql8uVjAVk6xC3yj7tn1smGRUlvGI9MOsWYYWs+yzKOJS4ioh/HjxnEAJRza/1x5tDO
	 rUcZEDhb81UNktiQphGpgGhhWEgDl+aFkcr74rJqnsBXlGPf6cNeYHjOCmlef7hQ5E
	 wKVdOIY3HYxIwI0cLIQ+0+CBZEgE4z+sGibRHXw6qe0OeSgPQiLapxh2U0pV0FDGaF
	 kktPN9tcpg+WA==
Date: Wed, 15 Jul 2026 09:00:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] block,iov_iter: move bio_iov_iter_align_down into
 iov_iter_extract_bvecs
Message-ID: <alegfwkrEpy75dAZ@kbusch-mbp>
References: <20260714131318.2670042-1-hch@lst.de>
 <20260714131318.2670042-4-hch@lst.de>
 <alZHF1wZY58JSU7N@kbusch-mbp>
 <20260714145026.GA2213@lst.de>
 <alZniKpsda_UJtj1@kbusch-mbp>
 <20260715043417.GA15746@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715043417.GA15746@lst.de>

On Wed, Jul 15, 2026 at 06:34:17AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 14, 2026 at 10:44:56AM -0600, Keith Busch wrote:
> > On Tue, Jul 14, 2026 at 04:50:26PM +0200, Christoph Hellwig wrote:
> > > Yeah, we need to support that.  Kinda interesting that xfstests did
> > > not hit it, though.  So back to the previous version.
> > 
> > Here's a simple test for this case if you want to try. This should work
> > for any file or raw disk with nvme backing storage.
> > 
> > It prints "Success" before this series, and "Bad Address" after.
> 
> Yes, assuming the NVMe doesn't support SGLs and has a 512 byte

The same test should be applicable to 4k LBS and SGL capable too!

> block size..  I guess this is going into blktessts/xfstests
> once the query API lands?

It's a simplfied version of this one:

  https://github.com/linux-blktests/blktests/blob/master/src/dio-offsets.c#L269

Though that is incorrectly expecting failure since older kernels didn't
support sub-sector io vectors. If only we exported the necessary
attributes to tell user space what's allowed... :)
