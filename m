Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47584 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbcEHJ2A (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Sun, 8 May 2016 05:28:00 -0400
Date: Sun, 8 May 2016 02:27:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	Jan Kara <jack@suse.cz>, Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mike Snitzer <snitzer@redhat.com>, Shaohua Li <shli@fb.com>,
	Tejun Heo <tj@kernel.org>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>
Subject: Re: [PATCH v5 0/8] block: prepare for multipage bvecs
Message-ID: <20160508092758.GA29621@infradead.org>
References: <1460928615-20894-1-git-send-email-ming.lei@canonical.com>
 <CACVXFVOw2dnO0tw5n2dPXUQh_tkGLCo742AXpJ8mMQG6LQZVUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOw2dnO0tw5n2dPXUQh_tkGLCo742AXpJ8mMQG6LQZVUA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 03, 2016 at 09:03:58AM +0800, Ming Lei wrote:
> Any possibility to make v5 into v4.7 so that we can move on about
> multipage bvecs?
> 
> BTW, even though not considering mp bvecs, this patchset is still a
> good cleanup.

Agreed.  I'm fine with the series and it looks harmless enough for
4.7.
