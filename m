Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BB380
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533469; cv=none; b=AJ8k0AVjZGuJpzZH5e34ToP1ptcIf9FzI8dlrtP+6aRYvluPLPjqPSgsTRpuSCnU/o+fev9ryoHzXiGqMt/S+UGybZAS2Erh13qZOT8V0/NNz/OLdxXKQV2jKx0ht4rOeAs0U5llqWRMabS+0oDXLWI8PgDEj982aR/DL/I+/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533469; c=relaxed/simple;
	bh=1DYap+uX4NAk+BawvdRMItCKN7jbrO/iuQKKjaEHnDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTweyLKuJXKCvtaDeuCA2mhTkV6Lt0l92ebAbE7RsMbARQPbfSQU/remQv9muShwpLJEBfsIa/2eZr7HLXBhmOncbJklXiD8VWwAl26QFkB9cmuj1EYt0mg0f61jF+DguhDI+Dr5w80sFhJNKEWc4Yf9avBZYYhZlvYIHvQ91Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SHSoDfGf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHSoDfGf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LtWDMRMfth5ZbskpiCxD1Enmn2arhzcfKaISGVl+ecM=; b=SHSoDfGfcjt2XQkLECD4YB75WJ
	dvktDvxP9eJaya4pJLvrGSPSXZXMvURktfjkStmc/QQJafqq325eyX7O0/3YCHRkUQYWgNIht8gxw
	tfpAWj/IAeXW3QOoqcs6YXbLdfZP3d13GacWogynNV5b1sE7b3D/XkM9lNGIGiGdul+B577BJ8vWf
	xpYnzYnG2JvGH9zBZ7JwJEEvChKQUek3MUnwTlWXKXoFzRfBsbm9dWOltsmQibH6n5lX17FjQQEjB
	AUEvLtrZMREbNBv6xCmpXmTJsSUE1irEzxc1V2Z313csLuu/Os1fiUk0bzffJJivZ18i5f6Y8qGeZ
	32TpIh3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrZf-00000005qHo-2A2l;
	Tue, 10 Jun 2025 05:31:03 +0000
Date: Mon, 9 Jun 2025 22:31:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEfDF6rxPlT9ie1L@infradead.org>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 10:02:19AM +0800, Yu Kuai wrote:
> Looks like this problem is related to nvme mpath, and it's using
> bio based disk IO accounting. I'm not familiar with this driver,
> however, can you try the following bpftrace script to check if
> start request and end request are balanced? From the log I guess
> it's related to mpath error handler, probably requeuing I/O.

nvme-mpath is a bio based driver.  It is a bit special in that
it passed down the bio it recived through to the lower-level
request based nvme transport driver, while most remapping drivers
always clone a bio.  I suspect that is messing up I/O accounting
here somehow.

