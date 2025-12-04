Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD8303A0B;
	Thu,  4 Dec 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883622; cv=none; b=VzsPTgqeM4S5OH6WT939qs1nraiO/0UpW7LQ/UrNzEBnV2iJ2fskrE6QOK2M7GGDF75T61yQa8M3hGumH8TwXg3WVbo7u2JzDAGQGs5vgpiG71H36XDtdTBvR9lWXwomkyJd3Z2WFwTgAve+WJSeaf3668HDI9B+1qogUg+7Aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883622; c=relaxed/simple;
	bh=AWIxMj3gEkNRjjY5m4Py2eu04uIx7dxKAjYDcD0/NIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6S9S87RVY4laJi2xMsf2IALiIAQvgJC1trGDx8SyqfLYhOIXKKWzJwxhYNw4ogtH4C5TUcB0+4k0iG7YXMxqMFETP2tGkh5+QulMAM7VkIpFRxHnT8nO1K92r+xObb4eIG7lCM0qISzlQtZI9JLdVeoebkszTYpNDiO13a+/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGOcy4bm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGOcy4bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00006C4CEFB;
	Thu,  4 Dec 2025 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883621;
	bh=AWIxMj3gEkNRjjY5m4Py2eu04uIx7dxKAjYDcD0/NIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGOcy4bmct46NJepvzzypwOyLe2XtWAR6slSN9G/+gt0kDqMe09NThoCkBFszSgEI
	 3uD7H1OC+eZSfHfN8Um1VID6E5FUqs9Vtv8ecoh1ThvOkVcD9TS9RVOFDVZtQWuwCS
	 iCWg7C1/e54GM4z4/G3XFJKkqAAklbvoP4LNtX+DZ/nPVXR39IiA6LAaIAfbPnmt1L
	 NA91XypZChOLQsWAfDwnzx5x1ItbkeXrtRXZsRcTVc13eXtso6WKbcLojcUk+IHFhD
	 ZXHekos1H1krE8TRTIHoTdmyWw8iZZaNS466ETrI7sRKLx4TrPrA/xJBAOXypjYZ2T
	 XREJDjDZ8ibMQ==
Date: Thu, 4 Dec 2025 14:26:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <aTH8opTiwJxH2PMA@kbusch-mbp>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>

On Thu, Dec 04, 2025 at 10:24:03AM -1000, Bart Van Assche wrote:
> 
> On 12/4/25 9:57 AM, Mohamed Khalfella wrote:
> > I do not see how running this code in another thread will solve the
> > problem.
> blk_mq_freeze_queue_wait() waits forever because nvme_timeout() waits
> for blk_mq_freeze_queue_wait() to finish. 

No, nvme_timeout does NOT wait for freeze to finish. It wants freeze to
finish, but it proceeds anyway whether it finished or not. If the freeze
didn't completele, anything outstanding after that will be forcefully
reclaimed and requeued once we ensure the device is disabled.

> Hence, the deadlock can be
> solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
> and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
> I/O and does not call blk_mq_quiesce_tagset() then the
> blk_mq_freeze_queue_wait() call will finish instead of triggering a
> deadlock. However, I do not know whether this proposal seems acceptable
> to the NVMe maintainers.

You periodically make this suggestion, but there's never a reason
offered to introduce yet another work queue for the driver to
synchronize with at various points. The whole point of making blk-mq
timeout handler in a work queue (it used to be a timer) was so that we
could do blocking actions like this.
