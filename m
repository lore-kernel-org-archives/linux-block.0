Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74529E101;
	Fri,  5 Dec 2025 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958287; cv=none; b=TEPhqztKe0zerYOweHnPcv5GMdsyo7TuzLlEsH9GHCbbRddLcnz4UlJAHmCCDmwWw77I7tof1VzlV3wvs2XU9eM/odvo9jTHdzYBrKYez/MRWhGIyVMNOwPUmnTMXiy0uLyRU9XA36ufkfZR8IdA5l1+Ij5WZdwwLo9MOEIDcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958287; c=relaxed/simple;
	bh=xvJiMqYzv2lBABxfbmsAKWvxtjq41CSjpip/GdWHMHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phBXiKAo91K9/lSOB1DRLk7CGUB2rZzoUkbU46CPemHkqkGXWxpQ9YWkM+/Jpo8dCWFDurseA6AU7XihZ7IAJGXDIkYUUKpJbJmZnyeRr3g75xe7FCFPk4Bk89+mhKBIWBJE87EZJaNVVSnXhCPwbGZn2PkqRbaY85ObGCH3gHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLkGoCdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLkGoCdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE33C4CEF1;
	Fri,  5 Dec 2025 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764958287;
	bh=xvJiMqYzv2lBABxfbmsAKWvxtjq41CSjpip/GdWHMHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLkGoCdUM+QqS7cLYuIjhmYVYVk64SMe3tUmgVbdaJsHW8T0AvuwaowVlbCRFLb31
	 Ko5npbaonrnhBIj6xPlWQapkWtbqWT74SbYsLU4FzfGQkw3Yryr60UT+nMZ/txJnTm
	 u07qpC8AHNqR9wy/jcVSgw1xbf7aGUwjZphmOEWm2hQHjV4X+L6rv+RDhVKX9hCgZ5
	 JhpXMiGh2yMitaqb35JmAZaKZ+5/qo05Up4/JfSiOEH8Ez8G38tfyagTUsYHaRygqK
	 UoqgOkdT6RIQtl8yuAGagMUt9xi7NWLCRmZGKgr27I+AJIZPQFKdAslz7YMmkkY/MM
	 9zgJbLPVsTRhA==
Date: Fri, 5 Dec 2025 11:11:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
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
Message-ID: <aTMgS0njg-R-T0pT@kbusch-mbp>
References: <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
 <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>
 <aTI2L6j50VWjp7aW@kbusch-mbp>
 <20251205163926.GI2376676-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205163926.GI2376676-mkhalfella@purestorage.com>

On Fri, Dec 05, 2025 at 08:39:26AM -0800, Mohamed Khalfella wrote:
> Why sychronize_rcu() is intolerable in this blk_mq_del_queue_tag_set()?
> This code is not performance sensitive, right?

synchronize_rcu() gets expensive on servers with many CPUs. While this
is not a fast path, I think adding it here would still be harmful, if
only just to testing when devices are frequently created and deleted.

> Looking at the code again, I _think_ synchronize_rcu() along with 
> INIT_LIST_HEAD(&q->tag_set_list) can be deleted. I do not see usecase
> where "q" is re-added to a tagset after it is deleted from one.
> Also, "q" is freed in blk_free_queue() after end of RCU grace period.

I think you could skip the synchronize since the queue's memory free is
done in blk_free_queue_rcu from a call_rcu() callback.
