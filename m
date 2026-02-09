Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B002295DAC;
	Mon,  9 Feb 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651338; cv=none; b=bYWzO4i/oiVXHpTwhkOu6ubRhXm4i1lhBRbcnrvI8nnNwOxoIDPxQ++nZGfOGRA8eI+iNTxbuNvJSnIdIjUA0zfK+ob2//0MpQMU1eTZ8oLdg6xwsXn9wfrMW86a6hPZxMKO/PA8taLsGeJBJOJ85FVElcMD3xQ4lmMFmIh/BRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651338; c=relaxed/simple;
	bh=0fifQJtiYVqXic/pGE/HONsBR9WXkXWJmgdnGITt1fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2M7h6b9FarhkpX4QjaSw6RwVySuMiRrsjylgbC/W3MsTOPs6VBVURKP/eXxX1gmyw+yH3r8Dg3tM5XXOJbj6OTLwHCqUplax4VsQi4dLPKCvXxj7D1SPY0rg8x2RCJPACQzJZ0yy1kZLAtsepV0lQqOvWYOIyH8dIHEgIjlplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/i/ej0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/i/ej0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9F1C116C6;
	Mon,  9 Feb 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770651338;
	bh=0fifQJtiYVqXic/pGE/HONsBR9WXkXWJmgdnGITt1fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/i/ej0vQy4DsADNeeCeJA110Giu9VxKPNLcgVrsSDpbfOgtjJCtep8mv7PQDXyPt
	 WYVVbzL//HHhfvGSpA3NrkGjPagFP/C28J2wMtraTlUElp49ttSQYmwFWKkdG3CA+/
	 A4JR51GUlctcecXsRM4sf6Ecsvea2tVcc5JvlV074Uw+jGJx57rkBsvBfXIZzBhRHu
	 IsTYmrVRmzSbuaPN6qVoww3VPstRyrrJHX0nkhtk/3SX1Ijfl9H1/rY42WN0gAOYzi
	 0eOX7vPLacwa/ZxOEXh9rumO+HYRTGNOyOSB0XkjIqVl6IHlHBvge3bjq+HGc4MvlW
	 ZJEHkudjVKpTA==
Date: Mon, 9 Feb 2026 08:35:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYn-xwFHCpd7sITJ@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209145832.GC18315@lst.de>

On Mon, Feb 09, 2026 at 03:58:32PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 09, 2026 at 04:29:52PM +0800, Yu Kuai wrote:
> > blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> > When the queue is already frozen before this call (from nvme_start_freeze
> > in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
> > only decrements it to 1, leaving the queue still frozen when
> > debugfs_create_files() is called.
> > 
> > This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> > debugfs_create_files() and risks deadlock.
> > 
> > Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> > so the queue is unfrozen before the call, allowing the internal
> > freeze/unfreeze to work correctly.
> > 
> > Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> > ---
> >  drivers/nvme/host/apple.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> > index 15b3d07f8ccd..1835753ad91a 100644
> > --- a/drivers/nvme/host/apple.c
> > +++ b/drivers/nvme/host/apple.c
> > @@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
> >  
> >  	nvme_unquiesce_io_queues(&anv->ctrl);
> >  	nvme_wait_freeze(&anv->ctrl);
> > -	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
> >  	nvme_unfreeze(&anv->ctrl);
> > +	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
> 
> Looks good on it's own, but it would also good to align the
> apple driver with the PCI one here more.

I'm pretty sure this series would deadlock nvme-pci, as that driver
still leaves the queue frozen when calling blk_mq_update_nr_hw_queues.

We've left it frozen on purpose, though. The idea was to prevent new IO
from entering a hw context that's no longer backed by a hardware
resourse. Unfreezing prior opens that window up again. Maybe it's not a
big deal; I don't often encounter scenarios where the queue count
changes after a reset.
