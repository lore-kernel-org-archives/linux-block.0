Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10723BE164;
	Tue, 31 Mar 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941741; cv=none; b=ZnvPIfYSQLqfDfPPfwjnwwDOmw0Xrdq76myPhRvBHds8SaOK8rGc2yo91Ccy9zQw8/4A9kJroHv8D4QzdIesOZEEf8KMZAQ+RsgET3rKelGcJsnjsleBOdByVHTr4d0MzwNTLtKXxGBYQe0ogxcSWl+Ych+NAO4Bknwb/UXAOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941741; c=relaxed/simple;
	bh=zTh4XjHfKWL7ba0b9Sqw4lC8D6/IJW57Qewykt/JDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/AMaUcGG73cCBl/dKmQS5CQMdlwRe7JwntcQWFswoHIyOeiseZ7OmfWt+TrHv8vsF9VXwO2s0yeqNbUOC0Zf5NTuzIWkiICTd2zWUXdkhCYGn/w5o0PymiPdW9lgoxrzXQoJoUppJxHIlE02PXYoHtPLMrRpV/nP77yBjdKtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bZPQHvnU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZPQHvnU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wOq9u+YEnP2L13BOaUj5IPbaOeet7/3oUdvcT9/aWCc=; b=bZPQHvnUrDtWA+gMJPs4cWWiiA
	01YI0a8SV44oNVZtQM9AzNXqjjrbGGZAZt8zZrYy8MkebdywN/oEGIJvewwA/6Rb5US8WAN2JGzfS
	y1nfG3Z8eJbrGi5hZsOEU4ZVamR082WPu6273ctBRrAbxGa+qluQ0t7SjbqjdlMZNdGSWvrfPlMQl
	9nKHwA+dAA2x1tEDTwpy+MAMLY8DsBtAJJZZ34qUjNi9LVMmrYG1EQWfm08bU4WOx5bHPZpyBf4AN
	Ekz8saZ+/YqikimWR0TOD53omrKha9TRqTlexX88w3LElCfYkBaUzCaIP3AqMSFazxLQgVsl9aQ3X
	n88D63nQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7TQY-0000000CTBn-1kjl;
	Tue, 31 Mar 2026 07:22:18 +0000
Date: Tue, 31 Mar 2026 00:22:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: axboe@kernel.dk, tytso@mit.edu, hch@infradead.org, dvyukov@google.com,
	adilger.kernel@dilger.ca, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] loop: block changing lo_offset/lo_sizelimit on
 mounted device
Message-ID: <act2Kh8u2I5HPVlv@infradead.org>
References: <20260331054648.4548-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331054648.4548-1-kartikey406@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 31, 2026 at 11:16:48AM +0530, Deepanshu Kartikey wrote:
> LOOP_SET_STATUS{64} allows changing lo_offset and shrinking
> lo_sizelimit while a filesystem is mounted on the loop device.
> This effectively mutates the data visible to the mounted filesystem,
> which is equivalent to writing directly to the block device.
> 
> When CONFIG_BLK_DEV_WRITE_MOUNTED is disabled, direct writes to a
> mounted block device are blocked. However, LOOP_SET_STATUS{64}
> bypasses this protection because it modifies the loop configuration
> through an ioctl rather than opening the block device for writing.
> 
> Fix this by checking bdev_writes_blocked() before allowing changes
> to lo_offset or shrinking lo_sizelimit. If the loop device has
> writes blocked, return -EBUSY. Increasing lo_sizelimit is still
> allowed since growing the device is harmless and has legitimate
> use cases such as online resize.
> 
> Move bdev_writes_blocked() from block/bdev.c to
> include/linux/blk_types.h as a static inline function so it can
> be used from the loop driver without exporting a symbol.

I still think this is a very bad idea for the reasons explained before.

And I would not be surprised if this breaks something in blktests or
xfstests as they heavily rely on resizing block devices.  Did you
do full runs of those?  Especially with xfs and btrfs for xfstests
as they do a lot more loop based tests?

