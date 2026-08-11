Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C5B330D2A;
	Tue, 11 Aug 2026 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480978; cv=none; b=dv6NyNfJiudlJRDCZi9lT9ifDy1LFGh+9cfM14q1DmfS0hKj6L7eiFcoaY8QQ/J7w6PDl7TkUnCK/7k5hxdGkbYfQJLlGTXKRXgrg7qJtuGRKxPvGppbcypUomTzspoHbMopjdMcvKAeykN0fa4IZFGCwhUbwwtMmfUN3ODtr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480978; c=relaxed/simple;
	bh=rGPztItlD7FpNWUP2rSJQo4uVTriv4EBJjLqbM2K2OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auzYFT7V8HWorWgGon+YHhEbciQOYW+/h0yHJCPSpKpsDUzg2OZ/aD1cX7eWS+aFe0E8FEL+U5rr1biTK1ir8baE0wg2jefrHdXAUOBgsjy4sefO7uB+LkeJucyRvaRIB75SKRh4Pdx2SWXNXSxs8W65LWazQlAKfYoyfSc4Vb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFbw3h+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFbw3h+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567121F000E9;
	Tue, 11 Aug 2026 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786480976;
	bh=Q2cmqbvAu79K9Kh5ZQbzK7San2QVikfsoxkJansBbyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YFbw3h+9VF05FaKzac6jPhVAB835l5JVJCUXwTuCJl9eBG9OxW5fKgFOyQF10rSIs
	 Rgq6rp9K/wNatLZMxgnw+8SQTYxaj5qCHkPCVPj8jXdsouEZl9VaZRvXBw0dMIBa6x
	 La/Vnqz6TyhYtdIgig7ILqO+Anbl8J7EAPvQoslguHUfQToKMag/6mr36B/Z5d5EFQ
	 7Ei32ZvBOy+CXDbLKzIFn/cV4a89TQgxbRXxT4CmVrMwMNVTb22vZ5YVO7r7r+vSAM
	 fnC6ojfziByZLUBR3ARp7EA9Ev2hTaKW9tHtHKRzruJ4TgVas53yW+1Vy++v8vy+cX
	 1xJyovjvpNzyw==
Date: Tue, 11 Aug 2026 14:42:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chris S <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
Message-ID: <anuJTi4sZiCBuMzb@kbusch-mbp>
References: <20260811192111.2058140-1-coshi036@gmail.com>
 <ant4bioGLl4B35n_@kbusch-mbp>
 <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com>

On Tue, Aug 11, 2026 at 04:29:51PM -0400, Chris S wrote:
> On Tue, Aug 11, 2026 at 01:30:54PM -0600, Keith Busch wrote:
> > Refusing to acknowledge the new format doesn't mean you get to continue
> > using the old format. You're going to corrupt memory and data this way.
> 
> You're right - the teardown is the problem, not the refusal.
> 
> nvme_ns_remove() never sets GD_DEAD, so del_gendisk() takes the
> non-surprise path and asks the filesystem to write back.  Those bios
> go through nvme_setup_rw() with the stale lba_shift.  set_capacity(0)
> doesn't catch them on a partition, which keeps its own bd_nr_sectors.
> 
> So it should mark the disk dead first and drop the cache instead:
> 
>         blk_mark_disk_dead(ns->disk);
>         ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
> 
> Multipath needs more than that - the openers are on head->disk, and
> only the path gets removed.
> 
> Is that the direction, or is refuse-and-remove wrong here to begin
> with?

You need a nvme spec level change for this to work. There's nothing we
can do today to close every race where the driver attempts to use a
stale LBA shift when the format was changed externally.

What I proposed in the past was that the device has to return a new
error code for all new IO until the host queries the appropriate
Namespace identification to acknowledge the new LBA format. Kind of like
a SCSI "Check Condition Parameters Changed". An enlightend host could
trigger a queue freeze and namespace rescan after seeing this status,
clearing the device's latch and resume IO after setting up the new queue
limits.
