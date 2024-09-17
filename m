Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3E20323
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578896; cv=none; b=lJVkBzLpz5RExWLR5dZn62VeBTOQVXngH9c9Q5bry5B4p7tqj/BvkkAK1warYwkBHrl/7hmtnfLDTWk75O9RsDWIk4/Xr/SabkpwAa4xTfuNPRN01fAv6JcePVrDcSiSgfmNN1rhWBCpZutmiuVlG+7w9nwpNa4VetUOLPblCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578896; c=relaxed/simple;
	bh=Xu4hIrgay6OqHq3o6dcZ5y9mrP6Rfx8XRGCoG0THjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPVM+6zzivtisZ5fT080MXTNM8soXcj0//W/siy7xNPMB8h7aLwnYtn3c+7eNHwpBVDmw1Rvsg7ytSVO6BCdBiHUH8JfCkNC5GsNwvAaphqKdjJItD33iAJHrgkURixzHM0VzJU78ULPwD3YEbqMhjNZJ+sa6X4hpb9MfA3Yi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71BFE227ACC; Tue, 17 Sep 2024 15:14:50 +0200 (CEST)
Date: Tue, 17 Sep 2024 15:14:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
Message-ID: <20240917131450.GA367@lst.de>
References: <20240917053258.128827-1-dlemoal@kernel.org> <20240917055331.GA2432@lst.de> <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com> <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org> <Zul97FvBsVuC1_h3@fedora> <20240917130518.GA32184@lst.de> <274ec9f3-b8b2-4a0a-bb13-f3705ddc349f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274ec9f3-b8b2-4a0a-bb13-f3705ddc349f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 17, 2024 at 07:11:22AM -0600, Jens Axboe wrote:
> Whatever reshuffling people have in mind, that needs to happen AFTER
> this bug is sorted out.

Yes.  The fix from Damien will work, but reverting to the old behavior
of ignoring the request_module return value feel much better.  I can
prepare a patch, but I didn't want to steal the credits from Damien.

