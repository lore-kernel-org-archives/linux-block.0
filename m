Return-Path: <xzhou@redhat.com>
Date: Tue, 7 Jun 2016 18:26:51 +0800
From: Xiong Zhou <xzhou@redhat.com>
To: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Cc: David Drysdale <drysdale@google.com>, Xiong Zhou <xzhou@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, axboe@fb.com,
        linux-next@vger.kernel.org, linux-nvdimm@ml01.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next/linux memleak after IO on dax mountpoint
Message-ID: <20160607102651.GA6480@dhcp12-144.nay.redhat.com>
References: <20160527084617.GD2933@dhcp12-144.nay.redhat.com>
 <20160528040554.GA23685@dhcp12-144.nay.redhat.com>
 <CAHse=S-H_yMhZKNmMZpb41M+o+2tMRyxiUG9wQoemewBXXYTPw@mail.gmail.com>
 <f1595b85-8fdc-fc8a-4ac5-e379837d61d9@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1595b85-8fdc-fc8a-4ac5-e379837d61d9@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

adding block-list

On Fri, Jun 03, 2016 at 09:48:27AM -0700, Bart Van Assche wrote:
> On 06/02/2016 08:22 AM, David Drysdale wrote:
> > FWIW, I'm also seeing kmemleak report a leak with v4.7-rc1, in
> > a different scenario (just normal desktop use).  Not done much
> > digging so far, but this commit (9082e87bf) looks like it might be
> > relevant -- lots of the following:
> > 
> > unreferenced object 0xffff8800c288e900 (size 256):
> >   comm "dconf-service", pid 1461, jiffies 4294895636 (age 48.028s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 c0 a4 c0 c6 00 88 ff ff  ................
> >     02 20 00 20 00 00 00 00 11 00 00 00 00 00 00 00  . . ............
> >   backtrace:
> >     [<ffffffff81955228>] kmemleak_alloc+0x28/0x50
> >     [<ffffffff81268bdc>] kmem_cache_alloc+0xfc/0x360
> >     [<ffffffff81203275>] mempool_alloc_slab+0x15/0x20
> >     [<ffffffff812030de>] mempool_alloc+0x6e/0x170
> >     [<ffffffff815014e8>] bio_alloc_bioset+0xb8/0x230
> >     [<ffffffff81514174>] next_bio+0x24/0x50
> >     [<ffffffff815145ef>] blkdev_issue_zeroout+0xdf/0x1d0
> >     [<ffffffff8132ce79>] ext4_issue_zeroout+0x39/0x50
> >     [<ffffffff81357abf>] ext4_ext_zeroout+0x2f/0x40
> >     [<ffffffff8135ece0>] ext4_ext_map_blocks+0x1870/0x2190
> >     [<ffffffff8132cfa1>] ext4_map_blocks+0x111/0x620
> >     [<ffffffff81330dc8>] ext4_writepages+0x7c8/0x10a0
> >     [<ffffffff81211851>] do_writepages+0x21/0x30
> >     [<ffffffff812012ba>] __filemap_fdatawrite_range+0xaa/0xf0
> >     [<ffffffff812013fd>] filemap_write_and_wait_range+0x2d/0x70
> >     [<ffffffff81326f6d>] ext4_sync_file+0x18d/0x500
> 
> (+Christoph)
> 
> With kernel v4.7-rc1 and XFS I see that the blkdev_issue_zeroout() calls
> triggered by xfstests make kmemleak complain. I hadn't seen this with any
> previous kernel version.
> 
> Bart.


unreferenced object 0xffff880c4bce2800 (size 2048):
  comm "dbench", pid 11389, jiffies 4294884573 (age 193.194s)
  hex dump (first 32 bytes):
    c0 1d 09 00 00 ea ff ff 00 10 00 00 00 00 00 00  ................
    c0 1d 09 00 00 ea ff ff 00 10 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816d178e>] kmemleak_alloc+0x4e/0xb0
    [<ffffffff811f6fc3>] kmem_cache_alloc+0xc3/0x200
    [<ffffffff813197ec>] bvec_alloc+0x5c/0xf0
    [<ffffffff81319a4e>] bio_alloc_bioset+0x1ce/0x2d0
    [<ffffffff8132a574>] next_bio+0x24/0x50
    [<ffffffff8132aa00>] blkdev_issue_zeroout+0xe0/0x1d0
    [<ffffffffa08ebcc8>] ext4_issue_zeroout+0x38/0x50 [ext4]
    [<ffffffffa08ec07e>] ext4_map_blocks+0x39e/0x640 [ext4]
    [<ffffffffa08ec3b3>] _ext4_get_block+0x93/0xf0 [ext4]
    [<ffffffffa08eca6f>] ext4_get_block_trans+0xbf/0x110 [ext4]
    [<ffffffffa08eccc5>] ext4_dax_get_block+0x25/0x70 [ext4]
    [<ffffffff81270c96>] dax_do_io+0x446/0x610
    [<ffffffffa08f1d04>] ext4_direct_IO+0x494/0x750 [ext4]
    [<ffffffff81195590>] generic_file_direct_write+0xb0/0x180
    [<ffffffff8119571d>] __generic_file_write_iter+0xbd/0x1e0
    [<ffffffffa08e5e77>] ext4_file_write_iter+0xf7/0x330 [ext4]
