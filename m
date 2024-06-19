Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C178286
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784361; cv=none; b=eVTrX22hA6G6BG4VvH98KbER8u3ohZe4DPofIWb/eGblCzmzFt0iOJn3IQ7HuCZgfgxZZLXB3fQdtsyBX3JJQfM6DMQTjxB7bH5PvICrQwngfGtmzVdfBO71BnzAvPDTJqVgo+Qw++Qb2Ec1psSplAf85gNfzuznsbXE25FuOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784361; c=relaxed/simple;
	bh=6n5IMAcUTQ3fyqp7RxRsW7iXv039CvjuJ4Kg1jyGKec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxKDPcS1YIs9z+YnuuAADNYheiwtmD5ir2zXPDpR7AejkpN3WnWQkgxxL5M6zBUCiKc4a80Eq7tHaObldr2IxNxSs54IUCrWS2gMBEc7/sRh/X9AyeCc2rwjBA9eZDLzL2bsl7pToQl0PhXwsEoOwAEXauTP69t2hMSHzOeh1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L+As3yki; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+As3yki"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZW12kJaUbginCSpRUPKCHTnr3hQsJDSrz6O3WNga6t4=; b=L+As3ykiIDp4Jth0TilTUvZTLK
	qXWYnqHMn03NfdOT2H+HA/tWeyFmh/31MxXKAFzhvwToN81gF4HqYoO9oqEBY8HyY+WWAgvauLpYL
	2nFmU+UgJLshtmFfuQOKkGpAkCm0OoX8qveeZAPFF/duPk7KFo6ARnt66doyxhg5lmBvjyTpPNznv
	w8OOBF4c96Z1fUrROrasBebCIMV606qJKWAl8L+yrMoHP83cXQZyZx0Jz5zU4B4/YLXwsIjF6ZXLv
	FXeAwjoThBp9zvRPnIUhse0A/+1aenbucqXTgfGrO885AXsSvK5Pl2KvdW4Ajc7ZdR++GuJ4jSfFz
	oTr8Uqkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJqKM-00000000KEI-0dMW;
	Wed, 19 Jun 2024 08:05:58 +0000
Date: Wed, 19 Jun 2024 01:05:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKRZp6pR1xasStB@infradead.org>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
 <ZnKPO0qUfuHPOdEi@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKPO0qUfuHPOdEi@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 03:56:43PM +0800, Ming Lei wrote:
> If we add the check for all type of IO, it requires ->bi_sector to
> be meaningful for zero size bio. I am not sure if it is always true,
> such as RESET_ALL.

meaningful or initialized to zero.  Given that bio_init initializes it
to zero we should generally be fine (and are for BIO_OP_ZONE_RESET_ALL
for all callers in tree).

