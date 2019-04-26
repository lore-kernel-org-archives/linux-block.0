Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D0C4321A
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 06:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D01A206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 06:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDZG2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:28:23 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33994 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbfDZG2X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 02:28:23 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8E06D43C0BA;
        Fri, 26 Apr 2019 16:28:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hJuLJ-0006GU-0F; Fri, 26 Apr 2019 16:28:17 +1000
Date:   Fri, 26 Apr 2019 16:28:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190426062816.GG1454@dread.disaster.area>
References: <20190426013814.GB3350@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426013814.GB3350@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=oexKYjalfGEA:10
        a=7-415B0cAAAA:8 a=VUkQmcHZEWhioDgAkr4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 09:38:14PM -0400, Jerome Glisse wrote:
> I see that they are still empty spot in LSF/MM schedule so i would like to
> have a discussion on allowing direct block mapping of file for devices (nic,
> gpu, fpga, ...). This is mm, fs and block discussion, thought the mm side
> is pretty light ie only adding 2 callback to vm_operations_struct:

The filesystem already has infrastructure for the bits it needs to
provide. They are called file layout leases (how many times do I
have to keep telling people this!), and what you do with the lease
for the LBA range the filesystem maps for you is then something you
can negotiate with the underlying block device.

i.e. go look at how xfs_pnfs.c works to hand out block mappings to
remote pNFS clients so they can directly access the underlying
storage. Basically, anyone wanting to map blocks needs a file layout
lease and then to manage the filesystem state over that range via
these methods in the struct export_operations:

        int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
        int (*map_blocks)(struct inode *inode, loff_t offset,
                          u64 len, struct iomap *iomap,
                          bool write, u32 *device_generation);
        int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
                             int nr_iomaps, struct iattr *iattr);

Basically, before you read/write data, you map the blocks. if you've
written data, then you need to commit the blocks (i.e. tell the fs
they've been written to).

The iomap will give you a contiguous LBA range and the block device
they belong to, and you can then use that to whatever smart DMA stuff
you need to do through the block device directly.

If the filesystem wants the space back (e.g. because truncate) then
the lease will be revoked. The client then must finish off it's
outstanding operations, commit them and release the lease. To access
the file range again, it must renew the lease and remap the file
through ->map_blocks....

> So i would like to gather people feedback on general approach and few things
> like:
>     - Do block device need to be able to invalidate such mapping too ?
> 
>       It is easy for fs the to invalidate as it can walk file mappings
>       but block device do not know about file.

If you are needing the block device to invalidate filesystem level
information, then your model is all wrong.

>     - Do we want to provide some generic implementation to share accross
>       fs ?

We already have a generic interface, filesystems other than XFS will
need to implement them.

>     - Maybe some share helpers for block devices that could track file
>       corresponding to peer mapping ?

If the application hasn't supplied the peer with the file it needs
to access, get a lease from and then map an LBA range out of, then
you are doing it all wrong.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
