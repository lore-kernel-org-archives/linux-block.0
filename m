Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51920D4E7
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680603; cv=none; b=pDRMQo7cxcQAaqSm/Fibr6fMcs2kDAZH9p2DRkXmyobWNq/iwBANUvWH8NCocFhgu7MCdB985h584+y891bANeA5RlKZg95suLAK3357JYi+anewBgSlBfoNb5ZLYyJnI4KCOgHF8YS5lwvhtuxuxDO2zy6ICDr096jVUGRqhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680603; c=relaxed/simple;
	bh=y1vn9yvGbUfKSrz4tNruLknyxamFp9S/Bmg3gEckFr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjSTKj0CF9OGko57IBjjW8GX7j+S+y7Pr4KuETebDWv4CluFnvmNbnjzw24OQHm8j1CA8AKvGBFKVXnJZ11P3Z9luhwC51acpoTr0nKqJ4PS/MkHz0f4s58CCfQOTr6xLPR6+ledd3jkdwWDQl38Ns8CJA2L18wwFDY70rOVxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0D7768BFE; Thu,  8 May 2025 07:03:17 +0200 (CEST)
Date: Thu, 8 May 2025 07:03:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
Message-ID: <20250508050317.GA27049@lst.de>
References: <20250507120406.3028670-1-ming.lei@redhat.com> <20250507120406.3028670-2-ming.lei@redhat.com> <20250507135349.GA1019@lst.de> <aBtuCDKTQK1PReDg@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtuCDKTQK1PReDg@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 07, 2025 at 10:28:24PM +0800, Ming Lei wrote:
> On Wed, May 07, 2025 at 03:53:49PM +0200, Christoph Hellwig wrote:
> > On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
> > > blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> > > never return if there is any queued requests.
> > > 
> > > Fix it by moving queue quiesce int elevator_change() by adding one flag to
> > > 'struct elv_change_ctx' for controlling this behavior.
> > 
> > Why do we even need to quiesce the queue here, and not anywhere else?
> 
> Quiesce is for draining the in-progress critical area, which can't be
> covered by queue freeze.

I know.  But why do we care about that for removing a scheduler, but
not for changing it?

