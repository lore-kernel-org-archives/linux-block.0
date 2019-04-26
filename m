Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E74C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926F0206E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfDZPUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDZPUu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 11:20:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E21368AE4C;
        Fri, 26 Apr 2019 15:20:49 +0000 (UTC)
Received: from redhat.com (ovpn-123-254.rdu2.redhat.com [10.10.123.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 107CE277C2;
        Fri, 26 Apr 2019 15:20:48 +0000 (UTC)
Date:   Fri, 26 Apr 2019 11:20:45 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190426152044.GB13360@redhat.com>
References: <20190426013814.GB3350@redhat.com>
 <20190426062816.GG1454@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426062816.GG1454@dread.disaster.area>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 26 Apr 2019 15:20:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 04:28:16PM +1000, Dave Chinner wrote:
> On Thu, Apr 25, 2019 at 09:38:14PM -0400, Jerome Glisse wrote:
> > I see that they are still empty spot in LSF/MM schedule so i would like to
> > have a discussion on allowing direct block mapping of file for devices (nic,
> > gpu, fpga, ...). This is mm, fs and block discussion, thought the mm side
> > is pretty light ie only adding 2 callback to vm_operations_struct:
> 
> The filesystem already has infrastructure for the bits it needs to
> provide. They are called file layout leases (how many times do I
> have to keep telling people this!), and what you do with the lease
> for the LBA range the filesystem maps for you is then something you
> can negotiate with the underlying block device.
> 
> i.e. go look at how xfs_pnfs.c works to hand out block mappings to
> remote pNFS clients so they can directly access the underlying
> storage. Basically, anyone wanting to map blocks needs a file layout
> lease and then to manage the filesystem state over that range via
> these methods in the struct export_operations:
> 
>         int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
>         int (*map_blocks)(struct inode *inode, loff_t offset,
>                           u64 len, struct iomap *iomap,
>                           bool write, u32 *device_generation);
>         int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>                              int nr_iomaps, struct iattr *iattr);
> 
> Basically, before you read/write data, you map the blocks. if you've
> written data, then you need to commit the blocks (i.e. tell the fs
> they've been written to).
> 
> The iomap will give you a contiguous LBA range and the block device
> they belong to, and you can then use that to whatever smart DMA stuff
> you need to do through the block device directly.
> 
> If the filesystem wants the space back (e.g. because truncate) then
> the lease will be revoked. The client then must finish off it's
> outstanding operations, commit them and release the lease. To access
> the file range again, it must renew the lease and remap the file
> through ->map_blocks....

Sorry i should have explain why lease do not work. Here are list of
lease shortcoming AFAIK:
    - only one process
    - program ie userspace is responsible for doing the right thing
      so heavy burden on userspace program
    - lease break time induce latency
    - lease may require privileges for the applications
    - work on file descriptor not virtual addresses

While what i am trying to achieve is:
    - support any number of process
    - work on virtual addresses
    - is an optimization ie falling back to page cache is _always_
      acceptable
    - no changes to userspace program ie existing program can
      benefit from this by just running on a kernel with the
      feature on the system with hardware that support this.
    - allow multiple different devices to map the block (can be
      read only if the fabric between devices is not cache coherent)
    - it is an optimization ie avoiding to waste main memory if file
      is only accessed by device
    - there is _no pin_ and it can be revoke at _any_ time from within
      the kernel ie there is no need to rely on application to do the
      right thing
    - not only support filesystem but also vma that comes from device
      file

I do not think i can achieve those objectives with file lease.


The motivation is coming from new storage technology (NVMe with CMB for
instance) where block device can offer byte addressable access to block.
It can be read only or read and write. When you couple this with gpu,
fgpa, tpu that can crunch massive data set (in the tera bytes ranges)
then avoiding going through main memory becomes an appealing prospect.

If we can achieve that with no disruption to the application programming
model the better it is. By allowing to mediate direct block access through
vma we can achieve that. With no update to the application we can provide
speed-up (right now storage device are still a bit slower than main memory
but PCIE can be the bottleneck) or at the very least save main memory for
other thing.


This is why i am believe something at the vma level is better suited to
make such thing as easy and transparent as possible. Note that unlike
GUP there is _no pinning_ so filesystem is always in total control and
can revoke at _any_ time. Also because it is all kernel side we should
achieve much better latency (flushing device page table is usualy faster
then switching to userspace and having userspace calling back into the
driver).


> 
> > So i would like to gather people feedback on general approach and few things
> > like:
> >     - Do block device need to be able to invalidate such mapping too ?
> > 
> >       It is easy for fs the to invalidate as it can walk file mappings
> >       but block device do not know about file.
> 
> If you are needing the block device to invalidate filesystem level
> information, then your model is all wrong.

It is _not_ a requirement. It is a feature and it does not need to be
implemented right away the motivation comes from block device that can
manage their PCIE BAR address space dynamicly and they might want to
unmap some block to make room for other block. For this they would need
to make sure that they can revoke access from device or CPU they might
have mapped the block they want to evict.


> >     - Do we want to provide some generic implementation to share accross
> >       fs ?
> 
> We already have a generic interface, filesystems other than XFS will
> need to implement them.
> 
> >     - Maybe some share helpers for block devices that could track file
> >       corresponding to peer mapping ?
> 
> If the application hasn't supplied the peer with the file it needs
> to access, get a lease from and then map an LBA range out of, then
> you are doing it all wrong.

I do not have the same programming model than one you have in mind, i
want to allow existing application which mmap files and access that
mapping through a device or CPU to directly access those blocks through
the virtual address.

Cheers,
Jérôme
