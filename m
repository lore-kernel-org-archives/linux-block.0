Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FCA3CF1ED;
	Mon,  5 Oct 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189927; cv=none; b=frVvfnP8qGcHJY+sMNNKuOov6SwF9O9kAObIJzH0ECwQ1U8bLh3yxl2aV3gQcgo0LIh2WEP2KLgCudoJdcKsj3gRZM8Hxd8NOhoP5dYirUmNAl6Yt39MALlBoujWK3OjvgFh+wm72H56NysNAaJ+u+UHb+/zE6+ZyUDzRqRuGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189927; c=relaxed/simple;
	bh=686E5WSAPr757d6zxKAuCXXLt3xrkWdVpLk8MUETUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG8vmEZg2/vnZVdZG9mXB3JrMR7smZAHpzXrjEjXvz/mj1OYcMOhq5oNvB+ZUS2amdezB3bYEnP8y52pYasXuxu5J/Ct6ZC2ca2Rlf0lsK27bKHzWMCW7erZ4P0PKSnBDEbOa3pem96ZB/U/AspSaRbUt9nTsN6Ne/sO716GXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86E9768BFE; Mon,  5 Oct 2026 10:45:21 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:45:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hillf Danton <hdanton@sina.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
	Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
	rust-for-linux@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
Message-ID: <20261005084521.GA8879@lst.de>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp> <472c3bcd-45d4-477b-9e81-3c68601dc18f@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472c3bcd-45d4-477b-9e81-3c68601dc18f@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 28, 2026 at 10:29:42AM -0700, Bart Van Assche wrote:
> On 9/22/26 10:09 PM, Tetsuo Handa wrote:
>> Add post_release() block device operation which provides a hook for
>> performing synchronous cleanup without disk->open_mutex held, which is
>> needed by the loop devices.
>
> Hi Jens,
>
> This patch series fixes a longstanding race condition. I haven't seen
> any objections to this patch series. There is at least one other patch
> that conflicts with this patch series: "[PATCH v6] loop: defer the queue
> limits clear to a workqueue". Please consider merging this patch series.

No, adding magic out of lock extra ops is a no-go, and we've been
through that before.
