Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615B17C96
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726688; cv=none; b=JDHHv8/I9giXN1XXNDBQADaz4ewLlbjt38E1wJmfA51gk3gG7l9Eg6ZmOCOxF3Kxc8uvveaqLK5iW6Tg4e12gPY6bE7gjz8tG6mOO5NoqeWLZvVbJhc7oE3llHnnG85jZUkQr7tVJVF4smkwGmT41AJbBRkFDx0wclMKOnqv32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726688; c=relaxed/simple;
	bh=FL5sm3BsYjiTuDB+fiY8/HuwU/szBO4QN0Zyt3UgeN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRhWhDZ92Z96Qw5SIbVoslFmcJMse1ggmz+pbu69WN6dqzmt+EM3kodnAyU0oxKoKHsVKvW2UxrRUMLDYtGh3YKcaAe7TYTuutsRZ6DB8pXsBPVnpKH7+2Mj5Qx+URYGvlMzIBigatyjaRV6aUDPEkq63AsfYtGs2hNI+COtBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JD2qxRHk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JD2qxRHk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4rVwfBtuisqajp018irnle1rkEI70v8cLXrmRIlVAHk=; b=JD2qxRHk1gOH4gjp4qfdNyarER
	DJQ+JIwVr5urxM2WPNKtPZVSLOfxjvWFYxoN8n/r0ZNLSH0DIFtJ9IZtVstJ2n+YwP62jfzDXj5ow
	XypqdapOHV8aa+IMy8ZQ1WkoKSPFsILoYvrJsnYdJXXgO3bmN68alB8FU1TJ/j77QFaVCEEiEaHAL
	3IdMTlHN/W9KxbYP8UrI7v+LWLZv4r1g33ZWDM2QqYGTnUcAw2acP5CJj9g5LH3YY1xNQgKDLJhVf
	+LiSKuJZxqIjaiSks3TmW661H12TJAKHYZb40bq3ACX+IHA+M7SY0q74clEa22I0qanS77JwfDtSF
	9FsKm88A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGLMd-0000000DhhA-0NpP;
	Wed, 27 Nov 2024 16:58:07 +0000
Date: Wed, 27 Nov 2024 08:58:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0dPn46YnLaYQcSP@infradead.org>
References: <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 08:31:43PM +0900, Damien Le Moal wrote:
> > We should not issue a report zones to a frozen queue, as that would
> > bypass the freezing protection.  I suspect the right thing is to
> > simply defer the error recovery action until after the queue is
> > unfrozen.
> 
> But that is the issue: if we defer the report zones, we cannot make progress
> with BIOs still plugged in the zone write plug BIO list. These hold a queue
> usage reference that the queue freeze wait is waiting for. We have to somehow
> allow that report zones to execute to make progress and empty the zone write
> plugs of all plugged BIOs.

Or just fail all the bios.

> Note that if we were talking about regular writes only, we would not need to
> care about error recovery as we would simply need to abort all these plugged
> BIOs (as we know they will fail anyway). But for a correct zone append
> emulation, we need to recover the zone write pointer to resume the
> execution of the plugged BIOs. Otherwise, the user would see failed zone
> append commands that are not suppose to fail unless the drive (or the
> zone) is dead...

Maybe I'm thick, but what error could we recover from here?

