Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750955AbeAVMC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 07:02:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MC2AfN146605
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2018 07:02:57 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fne8juf4h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2018 07:02:56 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 12:02:54 -0000
Date: Mon, 22 Jan 2018 14:02:48 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ming Lei <tom.leiming@gmail.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] A high-performance userspace block driver
References: <20180116145240.GD30073@bombadil.infradead.org>
 <CACVXFVPqJ6xYq31Ve5tXCKiNne_S1ve8csA+j_wCPnnZCPahvg@mail.gmail.com>
 <20180117212144.GD25862@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117212144.GD25862@bombadil.infradead.org>
Message-Id: <20180122120248.GB7984@rapoport-lnx>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 17, 2018 at 01:21:44PM -0800, Matthew Wilcox wrote:
> On Wed, Jan 17, 2018 at 10:49:24AM +0800, Ming Lei wrote:
> > Userfaultfd might be another choice:
> > 
> > 1) map the block LBA space into a range of process vm space
> 
> That would limit the size of a block device to ~200TB (with my laptop's
> CPU).  That's probably OK for most users, but I suspect there are some
> who would chafe at such a restriction (before the 57-bit CPUs arrive).
> 
> > 2) when READ/WRITE req comes, convert it to page fault on the
> > mapped range, and let userland to take control of it, and meantime
> > kernel req context is slept
> 
> You don't want to sleep the request; you want it to be able to submit
> more I/O.  But we have infrastructure in place to inform the submitter
> when I/Os have completed.

It's possible to queue IO requests and have a kthread that will convert
those requests to page faults. The thread indeed will sleep on each page
fault, though.
 
> > 3) IO req context in kernel side is waken up after userspace completed
> > the IO request via userfaultfd
> > 
> > 4) kernel side continue to complete the IO, such as copying page from
> > storage range to req(bio) pages.
> > 
> > Seems READ should be fine since it is very similar with the use case
> > of QEMU postcopy live migration, WRITE can be a bit different, and
> > maybe need some change on userfaultfd.
> 
> I like this idea, and maybe extending UFFD is the way to solve this
> problem.  Perhaps I should explain a little more what the requirements
> are.  At the point the driver gets the I/O, pages to copy data into (for
> a read) or copy data from (for a write) have already been allocated.
> At all costs, we need to avoid playing VM tricks (because TLB flushes
> are expensive).  So one copy is probably OK, but we'd like to avoid it
> if reasonable.
> 
> Let's assume that the userspace program looks at the request metadata and
> decides that it needs to send a network request.  Ideally, it would find
> a way to have the data from the response land in the pre-allocated pages
> (for a read) or send the data straight from the pages in the request
> (for a write).  I'm not sure UFFD helps us with that part of the problem.

As of now it does not. UFFD allocates pages when userland asks to copy the
data into UFFD controlled VMA.
In your example, after the data had arrives from the network userland it
can be copied into a page UFFD will allocate.

Unrelated to block device, I've been thinking of implementing splice for
userfaultfd...

-- 
Sincerely yours,
Mike.
