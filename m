Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758385AbcFANvx (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 1 Jun 2016 09:51:53 -0400
Date: Wed, 1 Jun 2016 09:51:51 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
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
Message-ID: <20160601135150.GA30759@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
 <20160531155348.GA24840@redhat.com>
 <CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
 <20160601134427.GA15888@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160601134427.GA15888@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 01 2016 at  9:44am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 01, 2016 at 08:38:41PM +0800, Ming Lei wrote:
> > > be dm-crypt.c.  Maybe you've identified some indirect use of
> > > BIO_MAX_SIZE?
> > 
> > I mean the recently introduced BIO_MAX_SIZE in -next tree:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/md/dm-crypt.c?id=4ed89c97b0706477b822ea2182827640c0cec486
> 
> The crazy bcache bios striking back once again.  I really think it's
> harmful having a _MAX value and then having a minor driver
> reinterpreting it and sending larger ones.  Until we can lift the
> maximum limit in general nad have common code exercise it we really need
> to stop bcache from sending these instead of littering the tree with
> workarounds.

So should I not push this type of fix to Linus now?  I was going to send
the above commit and this one to him this week:
https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.7&id=57b3001b240629ecc5266d28c845e23ca5f11719

Instead, should bcache be made to not do what it is doing?
