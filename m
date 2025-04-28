Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC392AD04;
	Mon, 28 Apr 2025 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850378; cv=none; b=uQSLeblyypMqsjoeYub4IMWlC5XqzrS4/pH9iSmR/IQsBphLhEE8JFDbibSQKZzqR/OWWxyNrdWHvLMjoVBR3fFBKCYEQRa5BmmbBinjFimdz0aS88xl4nj0aHFf8h0dqUk7Cx4pB9K8YW1ZYea5glGRhpMALwNRPfR2rx4NFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850378; c=relaxed/simple;
	bh=M5jhyk8OZfFi0e7dOmDS8y73QuDIvDKgRT6GWdirDns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsBxvGOg0ALSqDR1X9vjj1HZUGoGaPSkHeTYDEMkCswoeF2u/W9tA+Imc0FR2ZfNaJUZycngHYlHD6s2/Ipsh2flvFFRI5UtrEzhmq28ap86H/obsLU96LqIurOl/rAljbk2iRDlnNB7az7avQy0vqKgvT2oo93mi+R0R5z9O9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Fi/GhwFl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fi/GhwFl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kxbJqAzVqokVubs/URCncLC3hU3iVwX70RG3BUsaee8=; b=Fi/GhwFlB9DwJVBZ9ZhVoee+MC
	3CaJaJn48L+/jzo0ITrK6ENtoGBt1gy7DzCJXso8oWEr6stsHDn2am++e2YNVoR+gCHbWVvFAe7OT
	QfoVdUbZkuBZzHyPRtZ10gC0QvRXSu1CxAoK6paTdnr5O5l7kcLr/qhlUYr3XQpcxD5G782mpkHnH
	FsqhfNU47C+mPyHQVSh5PlW7Jp4S9vfq55zBeA1x0MNp8GzesLyJ7C7KCe33t/Ac6V2MslQ1P8U3C
	Mht9wrbuCx+0kr4Jx6aB4jNQhZo5eo7QvZGctuXJ8QTTsEg8GTkwyFMR7+QjrZVG7tLGT8NiL8h3v
	RDrvhUsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PR1-00000006dAN-0Ckc;
	Mon, 28 Apr 2025 14:26:15 +0000
Date: Mon, 28 Apr 2025 07:26:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V4] loop: Add sanity check for read/write_iter
Message-ID: <aA-QB7Iu6u9PdgHg@infradead.org>
References: <aA-HSxKfbM6WCgek@infradead.org>
 <20250428141544.3279719-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428141544.3279719-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 10:15:44PM +0800, Lizhi Xu wrote:
> +	if ((file->f_mode & FMODE_WRITE) && (!file->f_op->write_iter))

No need for the braces around !file->f_op->write_iter.

> +	if ((mode & BLK_OPEN_WRITE) && (!file->f_op->write_iter))

Same here.  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
