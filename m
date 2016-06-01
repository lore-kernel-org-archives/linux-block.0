Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750697AbcFAN51 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 1 Jun 2016 09:57:27 -0400
Date: Wed, 1 Jun 2016 09:57:25 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	Jan Kara <jack@suse.cz>, Joe Thornber <ejt@redhat.com>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.com>,
	Sagi Grimberg <sagig@mellanox.com>, Shaohua Li <shli@fb.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>
Subject: Re: [PATCH v6 0/8] block: prepare for multipage bvecs
Message-ID: <20160601135725.GB30759@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
 <20160601134300.GA15656@infradead.org>
 <574EE8F7.4050509@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <574EE8F7.4050509@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 01 2016 at  9:53am -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On 06/01/2016 03:43 PM, Christoph Hellwig wrote:
> > These patches look good on their own.  They might be an easier sell
> > just as bio cleanups :)
> 
> Fully agree. I've seen (some) improvements with those patches, so
> I'd prefer to have them.

Can you be more specific on what improvements you've seen?
