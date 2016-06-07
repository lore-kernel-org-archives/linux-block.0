Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43339 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbcFGGip (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2016 02:38:45 -0400
Date: Mon, 6 Jun 2016 23:38:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, sitsofe@yahoo.com, axboe@fb.com,
	Kernel-team@fb.com
Subject: Re: block: correctly fallback for zeroout
Message-ID: <20160607063842.GA21032@infradead.org>
References: <20160526180813.GA49039@shli-mbp.local>
 <20160529064728.GA14383@infradead.org>
 <yq1h9dbrmwf.fsf@sermon.lab.mkp.net>
 <20160603035415.GA8236@redhat.com>
 <yq1mvmxohix.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1mvmxohix.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 06, 2016 at 10:32:38PM -0400, Martin K. Petersen wrote:
> >>>>> "Mike" == Mike Snitzer <snitzer@redhat.com> writes:
> 
> Mike> But hch was originally in favor of _always_ dropping EOPNOTSUPP on
> Mike> the floor (that is what his commit 38f25255330 did).  Then he said
> Mike> he disagrees with these interfaces playing games with masking
> Mike> EOPNOTSUPP -- to which you seemingly really don't agree.  Unless
> Mike> I'm completely misreading you.
> 
> Userland apps rely on EOPNOTSUPP, we can't break that.

Rely on what exactly?  Current we return EOPNOTSUPP if the device
doesn't claim to support discards, but it returns 0 if the device first
claims to support it but then fails the I/O.
