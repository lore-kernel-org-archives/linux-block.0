Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593A13AA3E
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686752; cv=none; b=h4lcUaFTJaW5qe6dAdUXf7qpeUrTiwOS1JGL8evaY1HFzW8CUmA6dUjENg+vMrzEU8kapuFvCEGIaZ3hV2vu+tph0p0RW3U/SrJC/ticXP6L/Widh6WE1kJ2Yy/j6xPBLEgJBnODP/1bLMM6QGYA6MRFTvwo2dKQAp+u0ffEfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686752; c=relaxed/simple;
	bh=lbj/tqFHC0rig6tQDZrK/8cQLVlN76bjDAHeQ4fQtpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lt3vB7oKoYdEscn9p8SPoyt4pZ4bp2ia1Cc+CSmXPjG2g5bS8kyNBEs8XmwleXTX+92B7ZEefp/l9kZLVt4EnouwmHw/vF323cNK2lY7RclC3eqUdzTpeRR3p4QudyegncjcRNYnxk9MjqcsDaPVVqy/CiPu29UteYuFzhApk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JkBB1ft1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkBB1ft1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LUk2v4Kgt6IfJvrY62PvE3Gvm9P9tXpkFTZyMPWY+M8=; b=JkBB1ft1C9RlzCuqlNxo+mUQdf
	gkqJNWxKR/PRkHdAq8kshn+TBdGVLxkYAQiqZJ4SLAv/6Xb5vdUvldHC5h1u+L1KqzutJu+l2/tvQ
	mlI8UlHmcqe7w0jaJ6T/0RfaJXnA0LS9LcvBHg1c54fvqyMbSRGDGo8r28ZCPnuHevY9IqcqJXZ82
	mHyhrFHPq1XYK1a4NUVnm+rx8dnXjMjMv/jIu1fNZDBGjAyTpypCF9Vzq7jQcDjHHAY+8vGArP1Sx
	Q0mLvXQKY7ehOqPu0RNET64Rx+BjNXJEVwFJVeNQQVKOzhGhtgf2uiuBdJRcqJQ3//CBvs8saJ5Ht
	/UdlZHEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCv0w-0000000HVN9-1Afy;
	Thu, 08 May 2025 06:45:50 +0000
Date: Wed, 7 May 2025 23:45:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: transferring bvecs over the network in drbd
Message-ID: <aBxTHl8UIwr9Ehuv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I recently went over code that directly access the bio_vec bv_page/
bv_offset members and the code in _drbd_send_bio/_drbd_send_zc_bio
came to my attention.

It iterates the bio to kmap all segments, and then either does a
sock_sendmsg on a newly created kvec iter, or one one a new bvec iter
for each segment.  The former can't work on highmem systems and both
versions are rather inefficient.

What is preventing drbd from doing a single sock_sendmsg with the
bvec payload?  nvme-tcp (nvme_tcp_init_iter0 is a good example for
doing that, or the sunrpc svcsock code using it's local bvec list
(svc_tcp_sendmsg).
