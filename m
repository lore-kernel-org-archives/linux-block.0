Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205750094C
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972827; cv=none; b=ehl1V/mOpXpBkkuAsTf2Y+khktGf3DM5CBjDDEXI3p3t/0hVadnqQ56+l0BS5RuTSrSC+xyRDui+/p0txqFEhE3Uee+LsmZs1HByH4FGBZfGCdVUDVzXXiz5+h/TmYRt+bBi6mnZ6Rg4MB53PGBzX++w6U9Un4HslZ3+yJc8f2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972827; c=relaxed/simple;
	bh=QHLBGu5sCTDobpmn4bW60EnUk5ac3NfPaqbo5TRh37M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1MAq07zqHe5YZLDL0LUSGfNEAjl4Yr7S/I1p5sO4H+njP3V5qCVdfRfz9UhiGAW7hpPKldnxv1D5cCWO9MZkOfZys99bRPzIT5DAFjj30A5O5HZpbuWJW5lfJVpb7XaECSY2OPjT5n4qW2n9XByYFDlmHMh/4boFuwtVwfPGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x7xNuEcZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x7xNuEcZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JySEjUQOJjuhQtfNyvA+PDOAxbByeZy8mAH8ciBb4HU=; b=x7xNuEcZ+jm5VoRwNdrbR0vZJp
	UtoE33SWsZhFXuxZijnZdtjpkCNPtVzhAUvsjYEIos2PgCsaZH42uO9KV4OoIg3khQGRPO0jdVzAL
	lKzazemHxo+KFwnITcW6Pwra4E/SZemxUccsWshUh/wIwJmSIxfNfRzaZWNigPW+t9Msa0mn3ofUr
	o3CKXKO5rv1e8g5wG4DNND5dcHWSv+fSsjpdEozdKBA1GHPoEr5bb44Py6CqWWRZCXTPb8DuW1egy
	fmVbIIgfTpIDNhKC6ls7oDiFxLDDU/+dW+sCEey/EOMY1UlJaafVaxcbvmk1+FAf7ou6TM+hQZeDT
	pPcKFBXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veEUi-00000002Vm8-0il9;
	Fri, 09 Jan 2026 15:33:44 +0000
Date: Fri, 9 Jan 2026 07:33:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ruikai Peng <ruikai@pwno.io>
Subject: Re: [PATCH] ublk: fix use-after-free in ublk_partition_scan_work
Message-ID: <aWEf2M2msafGR_4k@infradead.org>
References: <20260109121454.278336-1-ming.lei@redhat.com>
 <aWEaOFuhRPvtnkRO@infradead.org>
 <aWEfQ148Qu0axKfp@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWEfQ148Qu0axKfp@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 09, 2026 at 11:31:15PM +0800, Ming Lei wrote:
> On Fri, Jan 09, 2026 at 07:09:44AM -0800, Christoph Hellwig wrote:
> > Why does ublk have it's own partition scan code anyway?
> 
> It is for improving error handling and avoiding deadlock.
> 
> ub->mutex is held when calling add_disk(), when IO error or timeout is
> triggered, error handling code path requires ub->mutex.
> 
> So it takes nvme mpath's approach to scan partition from wq context.

Ok.  I have to say I hate both instance of it, we really need to find
a way to do better than that :(

