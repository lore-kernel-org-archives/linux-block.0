Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56039 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbcFANyB (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 1 Jun 2016 09:54:01 -0400
Subject: Re: [PATCH v6 0/8] block: prepare for multipage bvecs
To: Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
 <20160601134300.GA15656@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>,
	Jan Kara <jack@suse.cz>, Joe Thornber <ejt@redhat.com>,
	Keith Busch <keith.busch@intel.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.com>,
	Sagi Grimberg <sagig@mellanox.com>, Shaohua Li <shli@fb.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <574EE8F7.4050509@suse.de>
Date: Wed, 1 Jun 2016 15:53:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160601134300.GA15656@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/01/2016 03:43 PM, Christoph Hellwig wrote:
> These patches look good on their own.  They might be an easier sell
> just as bio cleanups :)

Fully agree. I've seen (some) improvements with those patches, so
I'd prefer to have them.

You can add:

Tested-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
