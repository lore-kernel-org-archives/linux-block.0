Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48014 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbcEHJ3S (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Sun, 8 May 2016 05:29:18 -0400
Date: Sun, 8 May 2016 02:29:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@fb.com>, Milosz Tanski <milosz@adfin.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/6] vfs: vfs: Define new syscalls preadv2,pwritev2
Message-ID: <20160508092914.GA30173@infradead.org>
References: <1457017443-17662-1-git-send-email-hch@lst.de>
 <1457017443-17662-3-git-send-email-hch@lst.de>
 <56E1B9A8.3070904@gmail.com>
 <20160311095357.GA29350@lst.de>
 <5714E676.4090007@gmail.com>
 <20160425084715.GA29255@infradead.org>
 <CAKgNAki1ph1fV9EB9aARR1n8f6k=_KvHRiaPCAvetwigdKSpmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgNAki1ph1fV9EB9aARR1n8f6k=_KvHRiaPCAvetwigdKSpmw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 25, 2016 at 07:35:36PM +0200, Michael Kerrisk (man-pages) wrote:
> > I'd rather update the man page - EOPNOTSUPP is a much more descriptive
> > error code for this case.  I'll send you a patch.
> 
> Unless I'm misunderstanding something here, you're proposing something
> very inconsistent. The standard error for unknown flag bits is EINVAL.
> This is so for dozens of systems calls (check the man pages; you might
> find a rare exception, but that's the point, they are exceptions). It
> seems to me here that it's really the implementation that needs
> fixing, not the man page!

For new filesystem calls we try to use EOPNOTSUPP as much as possible,
e.g. fallocate.
