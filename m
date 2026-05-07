Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0631A7EA
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141160; cv=none; b=A0NbBsqr7k+j8MwJ8cingdVZ8AsaPhenqyP+OveIs2sbHayxdQcapJYGVh/I4nblMGXIHd77LCfHLqFeqqfgCrZqC/qBnokvW4/4GPdKwMrdtaEUosQEcMqnc6RuPnNchTYu+iGKwuSP/yRaI+vqvTv8YQqaqqoNkxF/t10AuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141160; c=relaxed/simple;
	bh=mzo5hInL1GMeoZKQdJ0QsbZ5h1dsaidU5BwUTNW4xDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/SoeJSW/iuPrf6uOf20qqXIsJ3FcC2qYZs6I+tcDhZvN5m7N2PbnGHeel/OSW6FafyBfyY7pj2ZvMvNA2C/KcRlQaQNLWqQmBJAZvS1adeAdCbYYb0awPEBTcrc4e4fcNjT2kNKxELEBtjWsLZvtG+gUGBMwK09JyolcHpn0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU1l5guO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU1l5guO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A13C2BCB8;
	Thu,  7 May 2026 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778141159;
	bh=mzo5hInL1GMeoZKQdJ0QsbZ5h1dsaidU5BwUTNW4xDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tU1l5guOHozYQTJukgPDSQ2QDuPnBbrysovPftNfBsDpo/0ZS2J8/95Gw6hEXpVkP
	 sPzJe9aRk58BMYJ70OgzvJ8CpJ/PekGv56QPmgacBnB0zJskLWqHp0s2Mqjgy9tbNK
	 noAOrhRq49e30wkMxd4GPpYPYe0X2iViwktIYg4q/uPrxd9UPpYhXzbQi5hbeHBeNN
	 6zAtmIFNWo3VxSGAH5rtAs6fFxjdIYmkJiAxtRTNSw46qVoyeoiJkHR0ZKsBP3pPZg
	 H9cOkn4EP1gpr1P3opvgaLaec3GAxYdSmPqctmTdhOQLy2EVMqkvw/2NQqZ9PmYiE6
	 QhR6YNIQ15HAg==
Date: Thu, 7 May 2026 10:05:54 +0200
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 2/2] nvme: set integrity metadata size for EXT_LBAS
 non-PI namespace
Message-ID: <afxH4g52fRXOyBsP@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <20260427003457.1264511-2-coshi036@gmail.com>
 <20260507054944.GB19796@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507054944.GB19796@lst.de>

On Thu, May 07, 2026 at 07:49:44AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 26, 2026 at 08:34:57PM -0400, Chao Shi wrote:
> > +		/*
> > +		 * For PCIe EXT_LBAS non-PI namespaces the block layer sets
> > +		 * capacity to 0 (we return false) to prevent block I/O, but a
> > +		 * cached-rq bio may bypass bio_queue_enter freeze serialisation
> > +		 * and reach nvme_setup_rw() with head->ms != 0 and no
> > +		 * REQ_INTEGRITY set.  Populate bi->metadata_size so that
> > +		 * bio_integrity_action() returns non-zero and bio_integrity_prep()
> > +		 * sets REQ_INTEGRITY on any such bio, preventing the WARN_ON_ONCE
> > +		 * at nvme_setup_rw() (addressed by patch 1/2).
> 
> This sounds like the Bug Keith is trying to fix in the block layer
> ("blk-mq: check for stale cached request in blk_mq_submit_bio") ?

Both issues are dealing with cached request corner cases, but they're
not really related. My bug fix is specifically when those requests are
freed, while this one is just racing with them.

For this patch's issue, how is the host being triggered to rescan? If
you're sending a "Format NVM" command, the driver would have frozen the
queues first, which would have waited for any cached requests to flush
out and prevent new ones from being allocated until after the format has
been updated in the driver.

It's possible to format the namespace from a different controller the
host doesn't know about, so we've always had a race where the actual
format is different than what the host knows about. The rescan would
have to be triggered some other way in that case (either through AEN or
manual sysfs/ioctl trigger).

We always ensure the queue is frozen when we update the queue limits in
this path too, so the driver and block layer should always be in sync
even if it's not in sync with the device. That in itself can be pretty
nasty, but we'd need a new NVMe TP to define a way to fix that. But
specifically on the driver warning here, I'm not sure how it is getting
triggered due to the existing freeze semantics around the queue limits
update.
