Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60260 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbcFBCNV (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2016 22:13:21 -0400
MIME-Version: 1.0
In-Reply-To: <20160601135150.GA30759@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160531155348.GA24840@redhat.com>
	<CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
	<20160601134427.GA15888@infradead.org>
	<20160601135150.GA30759@redhat.com>
Date: Thu, 2 Jun 2016 10:13:18 +0800
Message-ID: <CACVXFVNFH7zYOG+RsCNEXuxLE+ybq1qbLk6h=keN19LWsKT2mw@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] block: prepare for multipage bvecs
From: Ming Lei <ming.lei@canonical.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 1, 2016 at 9:51 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Wed, Jun 01 2016 at  9:44am -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
>
>> On Wed, Jun 01, 2016 at 08:38:41PM +0800, Ming Lei wrote:
>> > > be dm-crypt.c.  Maybe you've identified some indirect use of
>> > > BIO_MAX_SIZE?
>> >
>> > I mean the recently introduced BIO_MAX_SIZE in -next tree:
>> >
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/md/dm-crypt.c?id=4ed89c97b0706477b822ea2182827640c0cec486
>>
>> The crazy bcache bios striking back once again.  I really think it's
>> harmful having a _MAX value and then having a minor driver
>> reinterpreting it and sending larger ones.  Until we can lift the
>> maximum limit in general nad have common code exercise it we really need
>> to stop bcache from sending these instead of littering the tree with
>> workarounds.
>
> So should I not push this type of fix to Linus now?  I was going to send
> the above commit and this one to him this week:
> https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.7&id=57b3001b240629ecc5266d28c845e23ca5f11719

I don't suggest this kind of fix.

That fix should be in bcache or blk-core instead of other places.
Last time, I sent out the following fix([PATCH v1] block: make sure big bio is
splitted into at most 256 bvecs):

     https://lkml.org/lkml/2016/4/5/1046

But forget to clear the flag of REQ_NOMERGE for this case.

If Jens doesn't mind doing such thing in block-core, I can post v2
for this issue.

>
> Instead, should bcache be made to not do what it is doing?

It depends on if bcache is the only user of this kind of usage.
In theory, any driver can use external bvec table.

Thanks,
Ming
