Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC66C224AEE;
	Tue, 11 Mar 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680784; cv=none; b=Kt8oI6il4jH7hNvBUNHyYezvWGSG0WoUMy16sNonnR+hAGHVKJUHQ1dKosBwCkQvj25HH+4j8pdSxdoDlaAnbWlMAjjwdPCBsVkBWz6m40t47UIQMxdPKzRUWxsgXm2tuuIykeBm788W6O5TBTe62ku2roojkGotrSbxIRdaMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680784; c=relaxed/simple;
	bh=o8yyNn+wYTJ63B5bFpJEkTYYe0CWeutWiNUeSPgdq14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMRUjikUZ9wLj/LeMJw2J/NBLaBS1QVGYAfbK29uOut0T4riWYAclQKQINe4Yley6/A6E285xG+xDRq7dtuSdHDDK5he+R7tai42VjMe4L10piVwcIGO36t+4zj0Po1PGMyw70FZDgwh5KimUvl3oqiHTLpDf+tXgqTRKAsoneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0URGRsOz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0URGRsOz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1kZVljBVvsXxXbMsud/oOo6ecmq2RS1CrhGptHL+sfk=; b=0URGRsOzU5eTxOObjhgWQM9YEB
	wyMcRJpW1y5h6zqvGWm1lRxs4139wRRviAPcULYJqL/O8Bzl62BTd1sZMOVVYSPrkdP3qHL18KgqT
	0m02NPjJWQ7Um9qaH9ftreUlc94Jfj/xGrFnUABU77ejOEMAqbo2qJlsoSbTuNPbDVaoE4Sokb5w4
	Z5tuujfYr/Sude8kJcSKYKR7i35A24m49DR9Xzdn/hfwuR/qY6qmNp/B4+/TWurIAQPrOp46q4wKD
	fyEqhELu23yIx87818D6U8pAj+uPOhW1CHdCY2SmgQk3RDM3NlpV9MyCqnVnMCfIJZic+m5a71fdy
	OhoJJVFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trujV-00000004y8R-2zab;
	Tue, 11 Mar 2025 08:13:01 +0000
Date: Tue, 11 Mar 2025 01:13:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	virtualization@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
Message-ID: <Z8_wjZUNvM7JAWAQ@infradead.org>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
 <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 11:41:44AM +0900, Shin'ichiro Kawasaki wrote:
> However, blk_mq_add_to_batch() callers do not pass negative error
> values. Instead, they pass status codes defined in various ways:
> 
> - NVMe PCI and Apple drivers pass NVMe status code
> - virtio_blk driver passes the virtblk request header status byte
> - null_blk driver passes blk_status_t

The __force cast in null_blk should have been a big fat warning..

> To correct the ioerror check within blk_mq_add_to_batch(), make all
> callers to uniformly pass the argument as blk_status_t. Modify the
> callers to translate their specific status codes into blk_status_t. For
> this translation, export the helper function nvme_error_status(). Adjust
> blk_mq_add_to_batch() to translate blk_status_t back into the error
> number for the appropriate check.

This still looks a bit ugly because of all the conversions to a
blk_status_t just to convert it back to a errno just to check for
a non-zero value (blk_status_to_errno can't return a positive value).

I suspect simply passing a "bool is_error" might actually be cleaner
than that, combined with a proper kerneldoc comment for
blk_mq_add_to_batch explaining how to set it?

