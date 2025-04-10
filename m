Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E02571C4;
	Thu, 10 Apr 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277090; cv=none; b=NHpgym3B+nS36uFYsxeym2pkbicx7oE8oamQgeKKLJGus0B3CraRnBBIGe8v2fsWcYMOQ4oVuho5N4J88TB3X1io9HGJOoKItCDUUew925Hqf38sr0SangEY4IEpw7xx4eUiOhszzepVfUrXtmz7iA7RDuI8f0Z7/0jTtdH+t/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277090; c=relaxed/simple;
	bh=Fau/kAiTbyGwGpO+NIYPda5JvoXJAT5WKGkFJ0250vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li5pOPtZmKHwqferkeeamTLwF74w63GSIuRa0KxlKUFCc3TKu3TvP6E8ztzmHwwFgc8wiVipOQMh/QlkgBFmKAI7r4r+IPPUmTfuq3LChGzyEpFt1QF2oB3bv91jW2lcqo5gv+cpHxAcaoNjI5wybIxxVzUqLYqQcCOWjy49EaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ss6Y/uvn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ss6Y/uvn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YCyam3MeYKSW2wRMpKixBoxFry3Jmba2LiJsdJTIL88=; b=Ss6Y/uvnSSk45Oqy0FCg60u+cc
	ea8FD+2dhy0s23DRtx7Gp/YI+CKHmAqVb62kS4N0arOUHu94fI6yrpDyR3tPyGWqdaV5dTSi1wRTk
	GidBobISVOtDOmtNShNptY9TMS0Fc0qGhgzrd5/5JZm155SVWuSky/AXSLPnlHXrMNF5+eFOtB/o4
	1trfjOAl7SpM3JNHo0ZfgxfiibYl+5kqiCpreWpAqRmKI7vPvHBk3oWLYmrTrUkmo0fmyHEF+A3SL
	2GORQuDKRrtIw0oe7+k48hc4X90eduJkK/OjZ3KziEp1Fa9nj1lT1o9pZQG8ogVkhZItgSrfc9K+F
	ONIQpL/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2o9P-00000009vm9-45pJ;
	Thu, 10 Apr 2025 09:24:47 +0000
Date: Thu, 10 Apr 2025 02:24:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: skip blk_mq_tag_to_rq() bounds check
Message-ID: <Z_eOX-8QHxsq21Rz@infradead.org>
References: <20250409024955.3626275-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409024955.3626275-1-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 08, 2025 at 08:49:54PM -0600, Caleb Sander Mateos wrote:
> The ublk driver calls blk_mq_tag_to_rq() in several places.
> blk_mq_tag_to_rq() tolerates an invalid tag for the tagset, checking it
> against the number of tags and returning NULL if it is out of bounds.
> But all the calls from the ublk driver have already verified the tag
> against the ublk queue's queue depth. In ublk_commit_completion(),
> ublk_handle_need_get_data(), and case UBLK_IO_COMMIT_AND_FETCH_REQ, the
> tag has already been checked in __ublk_ch_uring_cmd(). In
> ublk_abort_queue(), the loop bounds the tag by the queue depth. In
> __ublk_check_and_get_req(), the tag has already been checked in
> __ublk_ch_uring_cmd(), in the case of ublk_register_io_buf(), or in
> ublk_check_and_get_req().
> 
> So just index the tagset's rqs array directly in the ublk driver.
> Convert the tags to unsigned, as blk_mq_tag_to_rq() does.

Poking directly into block layer internals feels like a really bad
idea.  If this is important enough we'll need a non-checking helper
in the core code, but as with all these kinds of micro-optimizations
it better have a really good justification.

