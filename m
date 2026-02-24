Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644201EBFE0
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945703; cv=none; b=RCZprSMa2PIDECXvaSu7SUmWzs4MfiRFaWR6q1QSZis1ov0/NvJncnQ5MzAzExH7Nxwfn7pDoQqdeNn7p24hWiYjiRqcJkQs8kEYQL5HIL5OiPU4XyQVjdQ+VUw49YiEmV2crT8fj9yMYMa3kX0gWoVSwyOZZwxlA5egtVqY/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945703; c=relaxed/simple;
	bh=CRChCPHd6lfEGsrWBqpAYNd1sbKo+BY7S1VRAs+SP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7QexOHlH7Js3TDMo23rXgD8lhTCLbEek2C2ppCli1PCzWWOOye55J/eNOVyCEf9tbka3jbNjnHQXICm5sUwak6U+56gU+bkGkbI6+7Rybz3CMJ/DHp2KQkgd0QnpM476QF2TWUKhKDcyXxqLulcPyu22WiGqgjX8ogkxcjFvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=16XCC+Xt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="16XCC+Xt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wuOQvbkG0n7KPAOmFFR/vPOie4WlQx6KjC3QILfyhuM=; b=16XCC+XtmQU0wuE8xA7qBn0Gyc
	9BAZG/Up6NugW2QxFIMkavlv2hZMxAKJJcrdPI0Ui7w1BtHkeGEG6vvwlPpbVxO2YBEmmb176zC2g
	ie3oQufaQpfekUhyqsAzPtrZmFZKFvxSECfG6kafJNhkoDKydpB79GOytc54f6uoTckwb2sYa5jIw
	vTFL1XgXvxhgRgjlyPZvLprpuftrkathRGsAh8qeKlnSdPbhjr0KS6pCXWluWJD7CRwCtM2DMnXdl
	DOcIxKqCnfmdlhtQAuRXy7Ciw889vFsbLk/e1pf+dWb4Z9nQHYcQ/HpS7e4oGev731mdAuLg06rkT
	3XrQMtWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuu1N-00000002I1S-3fLb;
	Tue, 24 Feb 2026 15:08:21 +0000
Date: Tue, 24 Feb 2026 07:08:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
Message-ID: <aZ2-5axIKqUVAc4A@infradead.org>
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-5-dlemoal@kernel.org>
 <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
 <1ce157d7-31fe-4a32-8acf-ed337dc1a52f@kernel.org>
 <f52cc220-5a31-473d-b255-3320be90766e@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52cc220-5a31-473d-b255-3320be90766e@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 24, 2026 at 04:00:17PM +0100, Hannes Reinecke wrote:
> But then we deadlock.
> If a lock is held when calling queue_work() and the workqueue function
> is calling spin_lock() on the _same_ lock _and_ we are scheduled on
> the _same_ CPU (remember single-core systems ?) we deadlock.

You very obviously can't context switch to a separate thread when
holding a spinlock.

Note that I particularly like this pattern.  I'd much rather just
increment the reference and drop it when we did not schedule the
work, this is not a super hot path that needs crazy optimizations,
and that would have avoided this bike shedding discussion.
