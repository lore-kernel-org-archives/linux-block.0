Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB87194A6C;
	Tue, 10 Feb 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736339; cv=none; b=Jr8ZkpXOepKpaqhNvC4kfLKSvN1t7LfKlLr5nCyXPAXC9T5/0Fs4Ysm9NZ1UDOAy8bwBRR3WEl8Aq9oP/CsPUyZWyTg+FgmqXACrymmrOG8FRPV9fFDvac/6KJAgHIE0+KV4dhIW0QohTEqdBW11qC2guZdabdLh/E8eauZyfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736339; c=relaxed/simple;
	bh=ucAfPzMxN1e5F5AUgDTJeXDDV21kxbElkGDjdxAewOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk8mO0K6eyHeXW2h0W17w5Gwz5YxyCEVHWv4YNKorXUfH6l5tN4SMe77LChPNDlrAv+Qaaj0K75auih6pwTWOozshHQm2a7+7efgNbGnGcIB2LYjV3y0QS4HkuGNNsL/6woRYpWbZJKVY2kDvX1I/Hh3bpies7eKmYOTglahHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz8+Vmiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz8+Vmiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43725C116C6;
	Tue, 10 Feb 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736338;
	bh=ucAfPzMxN1e5F5AUgDTJeXDDV21kxbElkGDjdxAewOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz8+Vmivd/r4Bjxh1a6/1kJGqd6SO7CXP3N1CSFpPVfx1CAZBAjb+x12eAwZqBk7O
	 Hmjcnt4rsYPHr0Vn3CMLrFDG5h1Tn7O2UqTvMo51fbHEahsNRoESLv9fSwXxESCRgX
	 SbFv8bVA2vRXBqOoA/8ikgak1sl6LxJGx03LVKa+lypxDT1dshnMXE7zKs16LKdiED
	 Qmx0u6raLbSF6ttYAdNQTj01lKOyrN0tqVvviOqRsnjeDyRvQozs3kK65rdLah1oeg
	 DtbPfDTJOjT50y06CQN/4pyQqSCeLwcXJnjhcFTWEEo5nJllJEMulKsjucrCeCtvbX
	 isR26yTnHWszQ==
Date: Tue, 10 Feb 2026 08:12:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fnnas.com>,
	axboe@kernel.dk, sagi@grimberg.me, sven@kernel.org, j@jannau.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	tj@kernel.org, ming.lei@redhat.com, neal@gompa.dev,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYtK0C7hxrtz3XfN@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <ac55db2a-ab90-460d-9efa-e13c5a3f498d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac55db2a-ab90-460d-9efa-e13c5a3f498d@linux.ibm.com>

On Tue, Feb 10, 2026 at 01:40:54PM +0530, Nilay Shroff wrote:
> On 2/9/26 9:05 PM, Keith Busch wrote:
> > 
> > We've left it frozen on purpose, though. The idea was to prevent new IO
> > from entering a hw context that's no longer backed by a hardware
> > resourse. Unfreezing prior opens that window up again. Maybe it's not a
> > big deal; I don't often encounter scenarios where the queue count
> > changes after a reset.
> 
> If an I/O were to slip through during the brief window between unfreeze
> and the subsequent freeze inside blk_mq_update_nr_hw_queues(), wouldn´t
> it still fail because the NVMe queues have already been suspended earlier
> in the reset path? My understanding is that when the controller reset
> reduces the number of online NVMe queues, the queues that are no longer
> backed by hardware remain in the suspended state. As a result, any I/O
> that reaches them before nr_hw_queues is updated should be rejected in
> nvme_queue_rq(). And if that´s the case, then allowing a small unfreeze
> window before updating the nr_hw_queue count shouldn´t result in a deadlock.
> What do you think?

Yeah, that wouldn't deadlock. It just increases the time for when you
may see IO failures if the queue count is reduced after the reset.
