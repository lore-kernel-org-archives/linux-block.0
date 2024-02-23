Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F79179A8
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716723; cv=none; b=uRh3POaUTVL3xVlh+EKhP+319cErJpkB2hW8oQKYBWY7VAG05ySZiMbrfsPVJs4TDnZSlekmRDdPnj6t7Qb1ZaRft2EY/UhuytACSO5l4qMdiwoIxrvTA5kz6wf8qW54ZiaH1fN6EjaE4P4GIMd5jPIy4D0Jeiuy3UfR8psEZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716723; c=relaxed/simple;
	bh=iNuAbsejRr50TqSupnntWNJNUtUNgOgz9Lm/O+Ecqv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k11aZpRvRfPvb2luHKO44WS0p5a9XkSSjfCF9MqZwCoIEGI/4NnE1qFBp8c6mwYkNV9L0q3xZ2aM3DGDX5yKqOsNhZfT0w0dDQ4nNLwg7W0TWcc5qQMFLkH22T6Kal6DBtC52qCNm77zbAL6CKHzzaa578jzJkVFRemQphDHZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MthDhzNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MthDhzNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A645C433C7;
	Fri, 23 Feb 2024 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708716722;
	bh=iNuAbsejRr50TqSupnntWNJNUtUNgOgz9Lm/O+Ecqv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MthDhzNcyIQXxaYO0A+XNgskkqby1RyKtQ6X8IH7iGfh2vlcOX+XJu6iSod0Kd50h
	 1cimj6o5QfErd7o8sKMtfsZ4OjuMO0D7u69G+nYp/T3JuRZTOoN9WOGmLKveHnmqtB
	 g8E8HHGdJSkq+6yKtA7XaUaxPjiHTpe7OJWyJwwiafiHpbz33TZE0+Qi/8lqBJF8Up
	 tEp7BfJ0KnWLBkv4H5sABKEA4iYbkJLXh3xTIXE096hfjsFVWR51AFipfkaqZc6b/p
	 O2H2dGxnUBP6nMjkxWfrh/f4QFSz9iXF1bobD6ceiY/tK9nDgn9ze8JXIB2Zr9USyb
	 sirTu7bUFq8Qw==
Date: Fri, 23 Feb 2024 12:31:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.org" <axboe@kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"nilay@linux.ibm.com" <nilay@linux.ibm.com>
Subject: Re: [PATCHv4 0/4] block: make long running operations killable
Message-ID: <Zdjyrvfy7aELykoS@kbusch-mbp>
References: <20240223155910.3622666-1-kbusch@meta.com>
 <1a81ef8d-023b-4a87-a71d-a31dddf3106c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a81ef8d-023b-4a87-a71d-a31dddf3106c@nvidia.com>

On Fri, Feb 23, 2024 at 07:16:30PM +0000, Chaitanya Kulkarni wrote:
> On 2/23/24 07:59, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > Changes from v3:
> >
> >   Added reviewed and tested by tags
> >
> >   More formatting cleanups in patch 2 (Christoph)
> >
> >   A more descriptive name for the bio chain wait helper (Christoph)
> >
> >   Don't fallback to the zero page on fatal signal error (Nilay)
> >
> 
> we need a blktests for this, for whole series :-

How would you know know if the device completed the operation before the
fatal signal or not? This is a quick test script off the top of my head,
but whether or not it shows a difference with this patch series depends
on your device.

  # time sh -c "blkdiscard -z /dev/nvme0n1 & sleep 1 && kill %1 && wait"
