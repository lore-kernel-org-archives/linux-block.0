Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7951DA60D
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157612; cv=none; b=qyYDsiTMiR74u1/y4T2z3niPrrL03/m/S79F/LC7R1+GJwQzOSmRwsfZRppfmCD1uw90BZlouzCKdWKTO5ctj72emfyiXky+JraHbwluCa/Lz+8OBOun770GRW8oLjYgNXbOZOgQdQY4/AncDY39pla7XC8bgs53/1rGzmRGiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157612; c=relaxed/simple;
	bh=TBOa3jtjw6o8r0ebY72lZHoS05QVgpeUFsaHsIZ8HAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKFWhzvF1iCleu7cpKHvNPNf/nGaAg0CoXUz/efKx/FaHHAMjVvkvYCJ2NDLu6SJj15h+IoBI0r2+4KD47v3hksrXcB3PX0JLQJOVJ5wmG3kpozwMAC9PGZWuQPdvsjWxRA5xww8TOxI7KyU+XMF9MJ9LDjJkvqT/Ve8tQ283JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 605C167373; Mon,  6 Jan 2025 11:00:03 +0100 (CET)
Date: Mon, 6 Jan 2025 11:00:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue
 freeze and limits lock order
Message-ID: <20250106100002.GA20647@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-3-dlemoal@kernel.org> <20250106083014.GD18408@lst.de> <30064337-9fe1-47c7-b4ec-c999b06a1b47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30064337-9fe1-47c7-b4ec-c999b06a1b47@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 06, 2025 at 06:58:00PM +0900, Damien Le Moal wrote:
> Ah, yes, that would potentially be an issue... Hmmm... Maybe a better solution
> would be to move the start update out of the main loop and do it first, before
> the freeze. What I do not fully understand with the code of this function is
> that it does freeze and limit update for each tag list of the tag set, but
> there is only a single request queue for all of them. So I am confused. Why
> does the blk_mq_freeze_queue and poll limit setting have to be done in the loop
> multiple times for each tag list ? I do not see it... If we can move these out
> of the tag list loops, then correcting the ordering becomes easy.

I've come up with a version that simply never updates the flag. About
to send it out.

