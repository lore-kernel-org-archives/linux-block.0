Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170421113408.GJ12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266673048.27388.6882396367486800999.stgit@noble> <20170421113408.GJ12523@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 21 Apr 2017 23:48:59 +0800
Message-ID: <CACVXFVMkX6X36=3mU7cXmbLA6HLASvk402DWL772=d7ihWNhMw@mail.gmail.com>
Subject: Re: [PATCH 11/11] block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neilb@suse.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 21, 2017 at 7:34 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Apr 20, 2017 at 03:38:50PM +1000, NeilBrown wrote:
>> blk_bio_segment_split() makes sure bios have no more than
>> BIO_MAX_PAGES entries in the bi_io_vec.
>> This was done because bio_clone_bioset() (when given a
>> mempool bioset) could not handle larger io_vecs.
>>
>> No driver uses bio_clone_bioset() any more, they all
>> use bio_clone_fast() if anything, and bio_clone_fast()
>> doesn't clone the bi_io_vec.
>
> Hmm.  From Jens tree:
>
> drivers/lightnvm/pblk-read.c:           int_bio = bio_clone_bioset(bio, GFP_KERNEL, fs_bio_set);
> drivers/md/raid1.c:                             mbio = bio_clone_bioset_partial(bio, GFP_NOIO,
> drivers/md/raid1.c:                             mbio = bio_clone_bioset_partial(bio, GFP_NOIO,

Btrfs use bio_clone_bioset() too:

     fs/btrfs/extent_io.c:2703:      new = bio_clone_bioset(bio,
gfp_mask, btrfs_bioset);

Thanks,
Ming Lei
