Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BC37E5DE;
	Mon,  7 Sep 2026 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764938; cv=none; b=mqppKWbMasd0y19dvh4uo+9dR4CwtKqVsiwDZL48aynqqMy6Zs2U0Jzqh5nMI/RuHbdeiYH8Bf3jgCotYQ0QSTG14VBp4hufY1x9RMecRxN77jAgIQ3+o0gSpQcqigHNyDXqUSsovRRk3P0wPuUYBwyigEQx1R+uNQLBWfJ5pF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764938; c=relaxed/simple;
	bh=mNTW/DmtkOnKwxCWGBb4HXLzjivP5nrDKi2g99DzSGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhsOVl7Kp4I4Fhrfh/W76RbrNF/N8vEeUPSfmK3ff+Tg9u2Vqz4RJ62PfHusC2GhWknUfVQn+1SOUeb0iyhi511HSx4VZV6VIhbsNE2NTbcP2Zmyg4xoHMSrWwKD5s2UDRY52EihxhdATY135mLWaTXxJk6whazJdlEGH2BR3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C6C568BFE; Mon,  7 Sep 2026 09:08:52 +0200 (CEST)
Date: Mon, 7 Sep 2026 09:08:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 2/7] block: take i_rwsem for the direct I/O write
 fallback
Message-ID: <20260907070851.GA934@lst.de>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu> <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 28, 2026 at 09:49:51AM -0400, Tal Zussman wrote:
> The reproducer used was written by an LLM, and is available at [1].
> 
> [1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74

Can your submit this to blktests?

The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

