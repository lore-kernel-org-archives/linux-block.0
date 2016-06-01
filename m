Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45200 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750697AbcFAOF0 (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2016 10:05:26 -0400
Date: Wed, 1 Jun 2016 07:05:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20160601140522.GA16228@infradead.org>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
 <20160531155348.GA24840@redhat.com>
 <CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
 <20160601134427.GA15888@infradead.org>
 <20160601135150.GA30759@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160601135150.GA30759@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 01, 2016 at 09:51:51AM -0400, Mike Snitzer wrote:
> So should I not push this type of fix to Linus now?  I was going to send
> the above commit and this one to him this week:
> https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.7&id=57b3001b240629ecc5266d28c845e23ca5f11719
> 
> Instead, should bcache be made to not do what it is doing?

I think that's much preferably.  Otherwise we'll get a constant trickles
of patches like that whenever someone tries bcache on top of another
stacking driver.
