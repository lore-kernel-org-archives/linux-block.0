Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177233938B;
	Fri, 14 Aug 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689036; cv=none; b=IpFCPFLp/fzvIXvXyqYLb/twDhBeGTQEPiiw+A+P0VDQlV8xCjCvW2Co35BZm1wsfabsBahwUVNsGZLj+QCQKYZIrv5IYYr+nkotCxHy+3EjB8MYKAcoWyZrTc28/b5dBI2b8h8f/+zQURKGa12miXii68VH1UcIedCAdVJzJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689036; c=relaxed/simple;
	bh=00WqtERUtnYBEUzQd0/SsEG+LWqmr6egKXeBQhrAo2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t028Cac6kVHo1GIfHFe3j4mnRMcmtslVwvR9zYQypMCz6184HTKEL/ddOynpnD++Z59cevY8gdVAkf7EU7Qs7ltRy69tEGK7c8Z8zP2KeCp+0ToMhhb8rPO213ek8sReFDlOkUv2F3PmjXgqq34WC5M9Jo88zTwv3OUmRXbkrMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WsNtQ8Tn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WsNtQ8Tn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=00WqtERUtnYBEUzQd0/SsEG+LWqmr6egKXeBQhrAo2I=; b=WsNtQ8TniakQxZNdnuggvJh74C
	OE+4sgkHXEZuda9o7TCIN8ZpLZKayt5lMhfPBdi9qDc9BllPvmwc41LE3Qr0O6NB/jVAV2LwQuFig
	FlIYI5FxGw1AG6pjRP5HOMuYO5WfUr8kHRcZ5XmnhP5l608QVpHTXsW/QRiOF9QYwFUb+EdK34tUE
	XdU8zGpWXJQx8aCNuUFimFxp5McV/biDcAuI44NAc+pepbC7nfgSfQjLeLxMmXbAsHtq7BhOwpN9J
	r7MJ/rT1jha6cCGI6WlKmC2yAcqtpZJ5m7y8EPyTIiQMCzeTMqJ9JXrKo+i+hgy46uCKXsdA/qzEI
	gu1YioiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulR0-000000022L3-2Xh4;
	Fri, 14 Aug 2026 06:30:31 +0000
Date: Thu, 13 Aug 2026 23:30:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
	Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system
 suspend using PM notifier
Message-ID: <an62BorNrc-IX228@infradead.org>
References: <20260806170108.2100312-1-daeho43@gmail.com>
 <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
 <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 10, 2026 at 09:53:14AM -0700, Daeho Jeong wrote:
> On Mon, Aug 10, 2026 at 9:34 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > This information was shared earlier with Daeho
> > (https://b.corp.google.com/issues/515470309#comment45): [ ... ]

This does not seem to be information available to the public.

> f2fs threads are already freezable: f2fs_gc and f2fs_discard are
> already registered with set_freezable() and call try_to_freeze().
> However, a race window exists: a thread checks freezing() (false),
> calls submit_bio(), and gets trapped inside __bio_queue_enter().
> Because it gets blocked before reaching try_to_freeze(), it triggers a
> PM freezer timeout.

This does sound very much like a block layer freezing issue.

> Point taken. Aside from this f2fs patch, I agree that addressing this
> at the block layer or PM subsystem level would be a much cleaner,
> system-wide solution.
> I’ll give more thought to how we can properly solve this race
> condition for the entire system, and I'll loop in the relevant
> PM/block maintainers if a viable generic approach emerges.

Thanks, it would be great to fix this properly.

