Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1731A545;
	Tue, 10 Feb 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736151; cv=none; b=mVhiRO03he8Ep49FfMJmp/J3brLYIJDu8gYIP6MUZc9mAyUIIX547OSEbg7kJEwjhaRJO23GHSBvrm5Y8pZ/Hawt28VRZSH6joO36WmVB2IPch4hsw9GgE0Q4kglesno7UQ37PP+RdaA2lVpu61Y9zwoFu0m8bZWE9Ocqy86oBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736151; c=relaxed/simple;
	bh=RWc0XQYaUIo9h9keSuMMl5oEGWchnZKzGDRh6J7qez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/ZWzjfh8UiCXJ5d2wZHQmQEvcumASxp6aEEgtI+S+wQy5j/6bzLzMfekUj5ZfRKsnfjRll0pAyi9pEDt6CdJBB8Rb0v9ndpwbnTKL1sANX6s8giF1MgUdAQBWahULBUwgHyyuLlkhIMNmucfd5nxYOhuV34TjhOH4GFfvQ9e/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfI9Cgwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfI9Cgwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE3C116C6;
	Tue, 10 Feb 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736150;
	bh=RWc0XQYaUIo9h9keSuMMl5oEGWchnZKzGDRh6J7qez0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfI9CgwoIEKjF2S02bOBQh2GUZQtuetZc0hE9pMIo7pjUuilqn+tHDsIeiJNtozre
	 88TjRSfzBIxzL9RAviHOwF6F2Ra+M7hjx2k/11L+jhQdrBIfpqsFC3CREAz7VH83i8
	 otyELKTu4ItG+QFWv9oQON6WHi18QKPfGKlywix0Whto+yv4j/4JDjq/i0R4onh3Um
	 xlqYFkrNghmPv6HBh9zT935kP3hQeO7i0E6mFwkRU4OYxVcyImp1N3kq/YQNys77NY
	 RoM68TSCEPHi3RaG0zYi3hHcjOIFAXUjF9X5cBhowYE5EmwonEk5uIl6lRLrgkpPis
	 XJMHoPqNHIpmQ==
Date: Tue, 10 Feb 2026 08:09:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYtKFNm-wRKn6l66@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>

On Tue, Feb 10, 2026 at 02:47:00PM +0800, Yu Kuai wrote:
> 在 2026/2/9 23:35, Keith Busch 写道:
> > We've left it frozen on purpose, though. The idea was to prevent new IO
> > from entering a hw context that's no longer backed by a hardware
> > resourse. Unfreezing prior opens that window up again. Maybe it's not a
> > big deal; I don't often encounter scenarios where the queue count
> > changes after a reset.
> 
> Do you think if there are new IO coming between nvme_unfreeze() and
> blk_mq_update_nr_hw_queues(), will be any race problems? If so, will it
> be helpful to move nvme_unquiesce_io_queues() after
> blk_mq_update_nr_hw_queues() so that new IO won't be issued to driver
> during the race window.

If you leave the queue quiesced, pending IO will form requests that are
entered and waiting in the block layer. You can't freeze a queue with
entered requests.

We unquiesce first to flush any pending IO that had entered during the
prior reset. It's not the best way to handle this situation. It would be
smarter to steal the bio's from all the entered requests, then end those
requests, then resubmit the bios after the hw queues are initialized. We
don't do that because no one's really complained, probably because the
queue counts don't usually change after a reset. But if the queue count
did change, we'd potentially see unexpected IO errors with the current
way we're handling resets.
