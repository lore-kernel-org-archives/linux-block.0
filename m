Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47868 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbcDYIrT (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 25 Apr 2016 04:47:19 -0400
Date: Mon, 25 Apr 2016 01:47:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	axboe@fb.com, milosz@adfin.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/6] vfs: vfs: Define new syscalls preadv2,pwritev2
Message-ID: <20160425084715.GA29255@infradead.org>
References: <1457017443-17662-1-git-send-email-hch@lst.de>
 <1457017443-17662-3-git-send-email-hch@lst.de>
 <56E1B9A8.3070904@gmail.com>
 <20160311095357.GA29350@lst.de>
 <5714E676.4090007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5714E676.4090007@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 18, 2016 at 02:51:50PM +0100, Michael Kerrisk (man-pages) wrote:
> Thanks. I applied the patch, but I see one point where the doc
> and code differ, and I suspect that the code needs to be fixed.
> See below.

> >  .TP
> >  .B EINVAL
> >  The vector count \fIiovcnt\fP is less than zero or greater than the
> > -permitted maximum.
> > +permitted maximum. Or, an unknown flag is specified in \fIflags\fP.
> 
> In the case described in the last sentence, the code currently appears
> to be returning EOPNOTSUPP. EINVAL is more usual here, so I think the
> code needs adjusting. Your thoughts?

I'd rather update the man page - EOPNOTSUPP is a much more descriptive
error code for this case.  I'll send you a patch.
