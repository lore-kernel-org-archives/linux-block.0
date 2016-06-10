Return-Path: <ming.lei@canonical.com>
MIME-Version: 1.0
In-Reply-To: <575993EA.3010005@kernel.dk>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com> <575993EA.3010005@kernel.dk>
From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 10 Jun 2016 10:44:34 +0800
Message-ID: <CACVXFVMbvqyEeX4NsuZLANCCQyxwr2_cjLrLT8tR9LUZkwejdg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] block: prepare for multipage bvecs
To: Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"open list:DRBD DRIVER" <drbd-dev@lists.linbit.com>, Jan Kara <jack@suse.cz>, Joe Thornber <ejt@redhat.com>,
	Keith Busch <keith.busch@intel.com>, Kent Overstreet <kent.overstreet@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Michal Hocko <mhocko@suse.com>,
	Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.com>, Sagi Grimberg <sagig@mellanox.com>,
	Shaohua Li <shli@fb.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>,
	"open list:XFS FILESYSTEM" <xfs@oss.sgi.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 10, 2016 at 12:06 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 05/30/2016 07:34 AM, Ming Lei wrote:
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
>
>
> Added patches 1-7, still waiting for an answer on my reply to #8.

Thanks for adding patches 1-7, and now I just found the added
BIO_MAX_SIZE usage in dm-crypt.c is droped from next, so it is
safe to kill it now.

I will send a new patch #8 against for-4.8/core.

Thanks,
Ming

>
> --
> Jens Axboe
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
