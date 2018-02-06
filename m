Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38329 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbeBFQ3y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Feb 2018 11:29:54 -0500
Date: Tue, 6 Feb 2018 17:29:52 +0100
From: Jan Kara <jack@suse.cz>
To: Liu Bo <bo.li.liu@oracle.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] get_user_pages() and filesystems
Message-ID: <20180206162952.krndup6lmbqpriga@quack2.suse.cz>
References: <20180125115727.slf6zj4zzevcskkn@quack2.suse.cz>
 <20180202220411.GB23065@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180202220411.GB23065@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Fri 02-02-18 15:04:11, Liu Bo wrote:
> On Thu, Jan 25, 2018 at 12:57:27PM +0100, Jan Kara wrote:
> > Hello,
> > 
> > this is about a problem I have identified last month and for which I still
> > don't have good solution. Some discussion of the problem happened here [1]
> > where also technical details are posted but culprit of the problem is
> > relatively simple: Lots of places in kernel (fs code, writeback logic,
> > stable-pages framework for DIF/DIX) assume that file pages in page cache
> > can be modified either via write(2), truncate(2), fallocate(2) or similar
> > code paths explicitely manipulating with file space or via a writeable
> > mapping into page tables. In particular we assume that if we block all the
> > above paths by taking proper locks, block page faults, and unmap (/ map
> > read-only) the page, it cannot be modified. But this assumption is violated
> > by get_user_pages() users (such as direct IO or RDMA drivers - and we've
> > got reports from such users of weird things happening).
> > 
> > The problem with GUP users is that they acquire page reference (at that
> > point page is writeably mapped into page tables) and some time in future
> > (which can be quite far in case of RDMA) page contents gets modified and
> > page marked dirty.
> 
> I got a question here, when you say 'page contents gets modified', do
> you mean that GUP users modify the page content?

Yes.

> I have another story about GUP users who use direct-IO, qemu sometimes
> doesn't work well with btrfs when checksum enabled and reports
> checksum failures when guest OS doesn't use stable pages, where it is
> not GUP users but the original file/mapping that may be changing the
> page content in flight.

OK, but that is kind of expected, isn't it? The whole purpose of 'stable
pages' is exactly to modifying pages while IO is in flight. So if a device
image is backed by a storage (filesystem in this case) which checksums
data, qemu should present it to the guest as a block device supporting
DIF/DIX and thus requiring stable pages...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
