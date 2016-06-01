Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52377 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbcFAMio (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2016 08:38:44 -0400
MIME-Version: 1.0
In-Reply-To: <20160531155348.GA24840@redhat.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<20160531155348.GA24840@redhat.com>
Date: Wed, 1 Jun 2016 20:38:41 +0800
Message-ID: <CACVXFVM9FqZFkMat_4ysJ8_vFd1FFnf6Bd9sHDDoCK=v93wViQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] block: prepare for multipage bvecs
From: Ming Lei <ming.lei@canonical.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 31, 2016 at 11:53 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Mon, May 30 2016 at  9:34am -0400,
> Ming Lei <ming.lei@canonical.com> wrote:
>
>>
>> Hi,
>>
>> Interests[1] have been shown in multipage bvecs, so this patchset
>> try to prepare for the support and do two things:
>>
>> 1) the 1st 4 patches use bvec iterator to implement iterate_bvec(),
>> then we can drop the non-standard way for iterating bvec, which
>> can be thought as a good cleanup for lib/iov_iter.c
>>
>> 2) remove BIO_MAX_SECTORS and makre BIO_MAX_SIZE as obsolete, and
>> now there is only one user for each. Once multipage bvecs is introduced,
>> one bio may hold lots of sectors, and we should always use sort of
>> BIO_MAX_VECS which should be introduced in future and is similiar
>> with current BIO_MAX_PAGES.
>>
>> The only functional change is iterate_bvec():lib/iov_iter.c
>>
>> xfstests(-a auto) over loop aio is run for ext4/xfs to verify
>> the change and no regression found with this patchset.
>>
>> V6:
>>       - rebased on v4.7-rc1
>>       - add reviewed-by tag
>>       - mark BIO_MAX_SIZE as obsolete instead of removing because
>>       dm-tree adds one usage now
>
> Not sure what you're referring to here with "dm-tree" (since "dm-tree"
> doesn't exist).  But only direct user of "BIO_MAX_SIZE" in DM appears to

Looks it is from crypto tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6

> be dm-crypt.c.  Maybe you've identified some indirect use of
> BIO_MAX_SIZE?

I mean the recently introduced BIO_MAX_SIZE in -next tree:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/md/dm-crypt.c?id=4ed89c97b0706477b822ea2182827640c0cec486

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
