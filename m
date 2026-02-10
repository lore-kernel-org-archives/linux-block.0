Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138F6FC3;
	Tue, 10 Feb 2026 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739277; cv=none; b=bCywXJdF9OwfOLXyh1+NS10MGb6erhbg2c+Bh+Au9mvVRUUqwuKUg0Kf3zhVW+0YsKFfc3A5+acXbAhcyjQR8SIOCAag1A0/ye1JqJQbGJXPzbHgMZ0pl8joNrzO90losZ7y0N1w1z4KutHHIo78UilfuOpezvE9p4qmsE8vSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739277; c=relaxed/simple;
	bh=K3DXxvJ6FVQs/z6PXfq5PjWLrYk64mlcmilSRWH8Gu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgr+h4+0r98JFvjiHyP1F1HMCKlmOZSsvU+O/1uraCIFYmk/cTla/TCbZiPL+QwOtZI2TKT6r8GKHqQ178nZhay6ejhDqs1dZRwG6f/WjfCbL0sKW1IVUETf0tbeKDUy5ETb/MARaUl67PIuu+bifR5TT2+f2shdkTlt3bbt668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSIqE/py; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSIqE/py"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F983C19421;
	Tue, 10 Feb 2026 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770739277;
	bh=K3DXxvJ6FVQs/z6PXfq5PjWLrYk64mlcmilSRWH8Gu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSIqE/py5qSrzsPCv9NZ7D+h2TqKee2r1uwzqr8SGBAsPOR1LNl7i1WAWZFUznuh/
	 JsADInzYEHPuzgK2IYzDXF/lGjtM6mQWOIOGC9XLlsoWvtABRGd6cqFiO7/E0ED2wj
	 Xf2fQxLLWyO5mvtbNVMgp0LDP+dcFrscctWr1y+rhydyw6ZVu6RNcc6NJ7jM5Z4Ez/
	 5SotcOGMA8of/XN/+gPWNZh/3EI9MkvAD52KAk0hyAuhTuYVWKwdVKtwYK+IIkly4U
	 0RZ4dSJCZn6VWxsTeIE9RtlsHVVCBbTVJUGH2OPZsn2jxYPOqm5xZAgS3hkvHxOgGT
	 zlF/BMg69MLXg==
Date: Tue, 10 Feb 2026 09:01:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYtWSscg6L9xxlzc@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
 <aYtKFNm-wRKn6l66@kbusch-mbp>
 <20260210154108.GB2484@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210154108.GB2484@lst.de>

On Tue, Feb 10, 2026 at 04:41:08PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 10, 2026 at 08:09:08AM -0700, Keith Busch wrote:
> > If you leave the queue quiesced, pending IO will form requests that are
> > entered and waiting in the block layer. You can't freeze a queue with
> > entered requests.
> > 
> > We unquiesce first to flush any pending IO that had entered during the
> > prior reset. It's not the best way to handle this situation. It would be
> > smarter to steal the bio's from all the entered requests, then end those
> > requests, then resubmit the bios after the hw queues are initialized. We
> > don't do that because no one's really complained, probably because the
> > queue counts don't usually change after a reset.
> 
> FYI, Daniel Wagner had been thinking about doing this reinsert for
> something (I forgot what exactly), and this kind of reinserting from
> kblockd would also finally make REQ_NOWAIT practically useful for
> file system initiated writes.  So I hope we can eventually get to it,
> and it should help to sort out various problems.

I took a moment to craft a test by modifying the poll_queues parameter
at runtime, say from 1 -> 0, then start a controller reset. Turns out
the driver is a bit broken here. A hipri job will poll a non-polled
queue after the reset, causing a double completion with the now irq
driven queue, and the entire blk-mq map is messed up, too. Oops!
