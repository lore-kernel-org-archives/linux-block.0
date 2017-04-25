Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35305 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952554AbdDYWdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2017 18:33:40 -0400
Received: by mail-oi0-f52.google.com with SMTP id j201so189404202oih.2
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2017 15:33:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g+WEYD7RVAekDdBn0+-+GRdKiK1HOG8JrVBAT4h5-CvQ@mail.gmail.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4g+WEYD7RVAekDdBn0+-+GRdKiK1HOG8JrVBAT4h5-CvQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Apr 2017 15:33:38 -0700
Message-ID: <CAPcyv4iZ7A6mOK-p5gVqOgiq9_B0tfV9q0-ouLk5oECZRo4x0A@mail.gmail.com>
Subject: Re: [resend PATCH v2 00/33] dax: introduce dax_operations
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc: Tony Luck <tony.luck@intel.com>, Jan Kara <jack@suse.cz>,
        Mike Snitzer <snitzer@redhat.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        X86 ML <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        dm-devel@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 21, 2017 at 6:06 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> [ adding akpm, sfr, and jens ]
>
> I applied this series and pushed it out for the nvdimm.git branch that
> gets auto pulled into -next. The set is still awaiting acks from
> device-mapper, ext4, xfs, and vfs (for the copy_from_iter_ops, patch
> 29/33). If those come next week perhaps this can be merged for 4.12,
> but if not this will need to wait until 4.13.
>
> There are some minor collisions with Al's copy_from_user rework, the
> new dax tracepoints, and the removal of discard support from the brd
> driver. A sample merge is available here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=libnvdimm-for-4.12-merge
>
> If it causes any other problems just drop and I'll retry for 4.13.

Al has nak'd the uaccess related changes, and I'll need to rework
those patches to move the pmem routines into lib/iov_iter.c directly.
That doesn't affect the dax_device and dax_operations work, so I'm
still looking to move forward with that change.  That reduces the set
targeting 4.12 to just the first 18 patches from this series:

Dan Williams (18):
      device-dax: rename 'dax_dev' to 'dev_dax'
      dax: refactor dax-fs into a generic provider of 'struct
dax_device' instances
      dax: add a facility to lookup a dax device by 'host' device name
      dax: introduce dax_operations
      pmem: add dax_operations support
      axon_ram: add dax_operations support
      brd: add dax_operations support
      dcssblk: add dax_operations support
      block: kill bdev_dax_capable()
      dax: introduce dax_direct_access()
      dm: add dax_device and dax_operations support
      dm: teach dm-targets to use a dax_device + dax_operations
      ext2, ext4, xfs: retrieve dax_device for iomap operations
      Revert "block: use DAX for partition table reads"
      filesystem-dax: convert to dax_direct_access()
      block, dax: convert bdev_dax_supported() to dax_direct_access()
      block: remove block_device_operations ->direct_access()
      x86, dax, pmem: remove indirection around memcpy_from_pmem()
