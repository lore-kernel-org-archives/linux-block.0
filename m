Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59317 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeAPOwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 09:52:41 -0500
Date: Tue, 16 Jan 2018 06:52:40 -0800
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [LSF/MM TOPIC] A high-performance userspace block driver
Message-ID: <20180116145240.GD30073@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


I see the improvements that Facebook have been making to the nbd driver,
and I think that's a wonderful thing.  Maybe the outcome of this topic
is simply: "Shut up, Matthew, this is good enough".

It's clear that there's an appetite for userspace block devices; not for
swap devices or the root device, but for accessing data that's stored
in that silo over there, and I really don't want to bring that entire
mess of CORBA / Go / Rust / whatever into the kernel to get to it,
but it would be really handy to present it as a block device.

I've looked at a few block-driver-in-userspace projects that exist, and
they all seem pretty bad.  For example, one API maps a few gigabytes of
address space and plays games with vm_insert_page() to put page cache
pages into the address space of the client process.  Of course, the TLB
flush overhead of that solution is criminal.

I've looked at pipes, and they're not an awful solution.  We've almost
got enough syscalls to treat other objects as pipes.  The problem is
that they're not seekable.  So essentially you're looking at having one
pipe per outstanding command.  If yu want to make good use of a modern
NAND device, you want a few hundred outstanding commands, and that's a
bit of a shoddy interface.

Right now, I'm leaning towards combining these two approaches; adding
a VM_NOTLB flag so the mmaped bits of the page cache never make it into
the process's address space, so the TLB shootdown can be safely skipped.
Then check it in follow_page_mask() and return the appropriate struct
page.  As long as the userspace process does everything using O_DIRECT,
I think this will work.

It's either that or make pipes seekable ...
