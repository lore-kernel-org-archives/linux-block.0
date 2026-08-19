Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678073624A9
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130836; cv=none; b=OumZPJoleLgvVS4lBVE6oxdhmZdZt8IMbVAF3q1q/3ne5WBxqosI+PrJKqxcVfTcwDHAyuvTBY/KO0W8wL+lq9fCepcRwrj+e5WBhvyxLwvlrKtIYN6xdXmr9uR90NGfSuonKUi2epRDFmOiG0MY97p9jMWJYqQVEUq4K6ak5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130836; c=relaxed/simple;
	bh=v91HmgPQYvsHDQTGsxjzxlgqKZGdWqqm0Jt7Q5gZ8AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/FTCG5iy4w1eI5sV7TRS5EredY6W+4xoxA9lTSUD66VVCUlAVYi5qW3WM0J2tc3b91yVCkkbaW163JN8xdcwpTMLTEsuFuIGF/5Wyr+bbOCUBtZfd4aeg/a4u6SauDDp3RR6SITL/kQkTXlNQIdMrdT5S/kJ2P52zWAtCmuFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 195DF68C7B; Wed, 19 Aug 2026 11:13:51 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:13:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC v2 1/2] block: scan partitions for hidden disks
Message-ID: <20260819091350.GA10298@lst.de>
References: <20260818120854.3151628-1-john.g.garry@oracle.com> <20260818120854.3151628-2-john.g.garry@oracle.com> <20260819090050.GA9267@lst.de> <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a967a7ef-02be-4dc4-9bc2-b11a242c7912@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 19, 2026 at 10:12:50AM +0100, John Garry wrote:
>> It also is used for giving a handle to NVMe devices that we can't support
>> as block devices and for which we only want a handle to issue passthrough
>> commands.  For those attempting a partition scan is rather suboptimal.
>
> We could set GENHD_FL_NO_PART in that case (as well as the hidden flag).

I guess we could do that.  It still feels wrong, though :

>> As is in general doing an extra scan per controller when we know it must
>> give the same results.  Wouldn't it make more sense to just propagate
>> the partition table from the ns_head to each individual path?
>
> So you mean that we would have something which can clone the head gendisk 
> partitions onto the per-path gendisk by itering  >part_tbl and calling 
> something like blk_add_partition(), right?

Yes.
