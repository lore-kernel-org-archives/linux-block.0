Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF51184D
	for <linux-block@vger.kernel.org>; Sat, 16 Mar 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710554652; cv=none; b=OWme87wWziGy7RUtZiFTMVMWNAOMQeTm8ZUfB0lj3GiTwctE1CPiEqPy+N/FPs4xiA9RcVpkc5YmViHn3zNfqElKK9B2VzgeCRp1Onn2Xce1/AMqV9/scFDW3hz+Kkc5xm/Qei/RD6DwpxnzK/caqThxWUMX9ecKHqwD+TZNfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710554652; c=relaxed/simple;
	bh=wclcn6aCrptudrO4+gQSFMYr+ZIgYiH2sU7xpE1DSRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGukyQhgziZbvaNkYt5hJ58xqrbpy2EgVKTFXdYwfKD5xfBHdfXbMN1rcQtNBXpW65NIL0T8cTl0MC5a7rEIa8GWbIlQzV5KrB++EJeX5xfKwj+Nrr8Q/iy9BP1cIUF/edUIPOYiI/HP57hjZvoLk75r6SACB+0Jfmp8h90rEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3tRN65o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3tRN65o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710554648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u2or2hyp0Hal6BLdCahDbwD45I7L+n8jhCzFPZ29+2U=;
	b=Y3tRN65o4j435srs7RTAyVoFd42tp5FNnSkD3yl0LIAwIqXFTM7LN/S0aiJalnyYMN1rWx
	RJIcBEryTMeXV7rt6KgLE3fB6SxYQ4UcCEaZGNRCqq6FIlkD2K7FqTB80X87Alby/6LiCf
	+jSo7xEViUgpo0a/2hLlkNrIGkizqNo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-1XXAYskpMY2sgURoimacDg-1; Fri,
 15 Mar 2024 22:04:03 -0400
X-MC-Unique: 1XXAYskpMY2sgURoimacDg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615933802AE0;
	Sat, 16 Mar 2024 02:04:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 56CE3492BC6;
	Sat, 16 Mar 2024 02:03:59 +0000 (UTC)
Date: Sat, 16 Mar 2024 10:03:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
Message-ID: <ZfT+CDCl+07rlRIp@fedora>
References: <cover.1710514702.git.asml.silence@gmail.com>
 <171054320158.386037.13510354610893597382.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171054320158.386037.13510354610893597382.b4-ty@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Fri, Mar 15, 2024 at 04:53:21PM -0600, Jens Axboe wrote:
> 
> On Fri, 15 Mar 2024 15:29:50 +0000, Pavel Begunkov wrote:
> > Patch 1 is a fix.
> > 
> > Patches 2-7 are cleanups mainly dealing with issue_flags conversions,
> > misundertsandings of the flags and of the tw state. It'd be great to have
> > even without even w/o the rest.
> > 
> > 8-11 mandate ctx locking for task_work and finally removes the CQE
> > caches, instead we post directly into the CQ. Note that the cache is
> > used by multishot auxiliary completions.
> > 
> > [...]
> 
> Applied, thanks!

Hi Jens and Pavel,

Looks this patch causes hang when running './check ublk/002' in blktests.

Steps:

1) cargo install rublk

2) cd blktests

3) ./check ublk/002



Thanks,
Ming

