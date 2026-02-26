Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C8429800
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122312; cv=none; b=kHceQp6B9C37DRUbDkoX7JWjqvj7voQfNtxFOScQgxjBXtdSh8rU7SeE6GAKMjJ28Q+OEyGTf4FwtviJozz8+ydm001EPrf2vnr751jPrUJn+JKKBlTVOy42FHK0WCo6EKppLDMxJfrJ78jqwm/ZIVXebTsiAwlLrXKIUEhHuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122312; c=relaxed/simple;
	bh=wkpYAUQKH5n9pdzIfbXlIzOynlF3g4FePwosXsydQLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzZxwHV+yNGDNslPxmagJ/vIszDy2s3JCogVG5vU2jRwUvIfjQB7uljK3ehH5nUo/bctfDvEfBHL2Tw+5Q6gIf31W+AtscH+AmI+yQQjBnud3DCm9I+mvDPc5ISTsiHrehzGsUaGLTgFncE61EWHFUE2BXrCKbhgOYrRbemJFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z8nrVFNR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8nrVFNR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GSaH/wh5fD1xP+1MPs8PgXtK6jY/TFkJW85tjCUzyNU=; b=Z8nrVFNRozBMypzTDLwlw5hJ/O
	Jrj1l5FYa4vSWf+Gp8QxA3ipWVrEEw4Uz9IhFS/iEabyAW9hZYzaI/OwdcSWeZP3Uo+1JSjDvS4Io
	mlM7ySzigVGanAvJqS3MNf/GVojXtBc9XXTGOGcOdSzsL0WPZ/QPW23ofa8W81odqu46nQPBAiNf8
	TgygpYyLNPmKrARyYzAxZB62BUGfAJ4VmWCCv3NcubZHomjguiMAZZ9gLUhPfRnqb91uh8wfvtadg
	O4gJjQHmg47JinJWcaunW4IOaZNWsCK8aMEusJN5ONn8GyaPvMw4dvCSjBOlYWREsW7D+UmjME1bm
	zJOHSUqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdxp-00000006hWQ-44vS;
	Thu, 26 Feb 2026 16:11:45 +0000
Date: Thu, 26 Feb 2026 08:11:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/7] block: fix zone write plugs refcount handling in
 disk_zone_wplug_schedule_bio_work()
Message-ID: <aaBwwbDQPAcyNtmN@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good.  And while this is a bit more ineffient than just
incrementing the counter after the queue_work for the relatively
rare case of an already running work item, I think it is much
easier to follow and thus better.

Reviewed-by: Christoph Hellwig <hch@lst.de>

