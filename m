Return-Path: <linux-block-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:57393 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbcFOVYW (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 17:24:22 -0400
Date: Wed, 15 Jun 2016 22:24:14 +0100
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Shaohua Li <shli@fb.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, sitsofe@yahoo.com, snitzer@redhat.com,
	Kernel-team@fb.com
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160615212414.GA5410@sucs.org>
References: <20160606223357.GA52883@shli-mbp.local>
 <yq18tydiyuf.fsf@sermon.lab.mkp.net>
 <20160610025435.GA48899@shli-mbp.local>
 <yq1shwkfq9z.fsf@sermon.lab.mkp.net>
 <20160613082001.GA27508@infradead.org>
 <yq1bn33b3l1.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1bn33b3l1.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14, 2016 at 10:14:50PM -0400, Martin K. Petersen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
> 
> Christoph> And I'd much prefer to get this right now.  It's not like
> Christoph> this is recently introduced behavior.
> 
> Unfortunately there are quite a few callers of blkdev_issue_discard()
> these days. Some of them ignore the return value but not all of
> them. I'm concerned about causing all sorts of breakage if we suddenly
> start returning errors various places in the stable trees.

This is true. We have problematic behaviour in stable kernels today so
there needs to be a "least intrusive" workaround which changes the
behaviour as little as possible for those. I would say that means
maintaining the current -EOPNOTSUPP behaviour in those kernels
regardless of what goes into master.

-- 
Sitsofe | http://sucs.org/~sits/
