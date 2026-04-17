Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF935DA67;
	Fri, 17 Apr 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412617; cv=none; b=sWG4mEdUXB7aQZBxJFydNgzJIwGG1jLB/6SpYxJn6y/Uxk647cKOPuIJucDR8UOvKrOWj+CNBMLibICDlkQ8PWPM9uAAK1/ImbNCRLJxPwMwaPEb//tEDx8mRmTtYb/qExU/wQSn/i0oUPdQ9tricexTz3OUEFnA8JCvpaPgnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412617; c=relaxed/simple;
	bh=A8ziK+qsemynhD1kTnUEzTLOi5oAwdVlPXv5NP4Z2TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRSXmDa4D+2uajFVruyFpacAOtJdPbqjOPfMj67bDUtO6LBhCA6T4LTr02TfQdmW2xzFDWTiAkdl9GYQZoaD5YXqFjS/t4yZPPq48OFWz/h4r4sTadymfvf9ucBhFEbsHtl63A2aoJdHZhZgMvNqqcGYdIAXepWgPzHqyR1ik9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ldz7IcAM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ldz7IcAM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gdKdo6SJ0M9vWrO0nCbv64XTILja2MjM0qSRXND2XuQ=; b=ldz7IcAMooHjJik7zEpBMu+8+3
	LxDOsQFA3xqEpU0N7p5qCc5oUDt5XftpfrDkYsgnLuOm27n3LjStL+UN0IFukRrSvbc2A+vchcFTR
	U++yuKE0LIlt2JgJcnUvFuiOHp4mOLliMr8VnwiNZQAXOxkDwR4uPGQHwCGgKp5+261wewW0980Tr
	zQWlj4pLEbEIyUFeUnLYMUqcXqS6t7mGJF8rityK32Qx8sM+t02ShEidYO/DRhU/ZRaHudEJ8M2wu
	OQgBye3TfFaDCuklt3/h0SRioI8aYWKPyvuDmwIyRKC7hVQ9wfz7IZYTRTlaRhk1hzj8HbRVtDszb
	N8O+kdSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDe4N-00000003di2-08WL;
	Fri, 17 Apr 2026 07:56:55 +0000
Date: Fri, 17 Apr 2026 00:56:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] t10-pi: reduce ref tag code duplication
Message-ID: <aeHnx2GcBmutcsBW@infradead.org>
References: <20260415210847.1730016-1-csander@purestorage.com>
 <aeBxOVmQ2bLli78f@infradead.org>
 <CADUfDZpcNG_GPpZYh9tWKEBjKHD53DVCmQGTrXKQvBpP7PCqsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpcNG_GPpZYh9tWKEBjKHD53DVCmQGTrXKQvBpP7PCqsg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 16, 2026 at 08:38:07AM -0700, Caleb Sander Mateos wrote:
> On Wed, Apr 15, 2026 at 10:18 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Apr 15, 2026 at 03:08:47PM -0600, Caleb Sander Mateos wrote:
> > >  #ifndef _LINUX_T10_PI_H
> > >  #define _LINUX_T10_PI_H
> > >
> > >  #include <linux/types.h>
> > >  #include <linux/blk-mq.h>
> > > +#include <linux/wordpart.h>
> >
> > We must have already gotten this implicitly given that the code
> > already uses lower_48_bits.
> 
> lower_48_bits() is defined (and only used) in this header. Yes,
> wordpart.h is already transitively included by the other headers, but
> I think it's good practice for each file to explicitly include the
> headers defining all the items it uses. It reduces the risk that
> refactoring the other header files in the future will result in a
> compilation error here by dropping the transitive include.

In general pulling in a new header when no new user of it shows up is a
bit weird.  I don't want to hold the patch up on this, but there are
folks out there actually dropping not needed includes from headers as
it can significantly reduce compile time.  Now this is not a heavily
included header so it's unlikely to make a difference anyway.

