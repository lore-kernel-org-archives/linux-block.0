Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1154FC388F7
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 10:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDF32224B
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 10:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgKMKHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 05:07:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:35562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgKMKHa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 05:07:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AF00AE42;
        Fri, 13 Nov 2020 10:07:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 030FD1E1312; Fri, 13 Nov 2020 11:07:28 +0100 (CET)
Date:   Fri, 13 Nov 2020 11:07:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, qemu-devel@nongnu.org,
        Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Max Reitz <mreitz@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        qemu-block@nongnu.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] RFC: Issue with discards on raw block device without
 O_DIRECT
Message-ID: <20201113100728.GA8919@quack2.suse.cz>
References: <20201111153913.41840-1-mlevitsk@redhat.com>
 <03b01c699c9fab64736d04891f1e835aef06c886.camel@redhat.com>
 <20201112111951.GB27697@quack2.suse.cz>
 <fbe9f98d6fa9ecd5f53fd284216c740d2d4a723a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe9f98d6fa9ecd5f53fd284216c740d2d4a723a.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 12-11-20 17:38:36, Maxim Levitsky wrote:
> On Thu, 2020-11-12 at 12:19 +0100, Jan Kara wrote:
> > [added some relevant people and lists to CC]
> > 
> > On Wed 11-11-20 17:44:05, Maxim Levitsky wrote:
> > > On Wed, 2020-11-11 at 17:39 +0200, Maxim Levitsky wrote:
> > > > clone of "starship_production"
> > > 
> > > The git-publish destroyed the cover letter:
> > > 
> > > For the reference this is for bz #1872633
> > > 
> > > The issue is that current kernel code that implements 'fallocate'
> > > on kernel block devices roughly works like that:
> > > 
> > > 1. Flush the page cache on the range that is about to be discarded.
> > > 2. Issue the discard and wait for it to finish.
> > >    (as far as I can see the discard doesn't go through the
> > >    page cache).
> > > 
> > > 3. Check if the page cache is dirty for this range,
> > >    if it is dirty (meaning that someone wrote to it meanwhile)
> > >    return -EBUSY.
> > > 
> > > This means that if qemu (or qemu-img) issues a write, and then
> > > discard to the area that shares a page, -EBUSY can be returned by
> > > the kernel.
> > 
> > Indeed, if you don't submit PAGE_SIZE aligned discards, you can get back
> > EBUSY which seems wrong to me. IMO we should handle this gracefully in the
> > kernel so we need to fix this.
> > 
> > > On the other hand, for example, the ext4 implementation of discard
> > > doesn't seem to be affected. It does take a lock on the inode to avoid
> > > concurrent IO and flushes O_DIRECT writers prior to doing discard thought.
> > 
> > Well, filesystem hole punching is somewhat different beast than block device
> > discard (at least implementation wise).
> > 
> > > Doing fsync and retrying is seems to resolve this issue, but it might be
> > > a too big hammer.  Just retrying doesn't work, indicating that maybe the
> > > code that flushes the page cache in (1) doesn't do this correctly ?
> > > 
> > > It also can be racy unless special means are done to block IO from happening
> > > from qemu during this fsync.
> > > 
> > > This patch series contains two patches:
> > > 
> > > First patch just lets the file-posix ignore the -EBUSY errors, which is
> > > technically enough to fail back to plain write in this case, but seems wrong.
> > > 
> > > And the second patch adds an optimization to qemu-img to avoid such a
> > > fragmented write/discard in the first place.
> > > 
> > > Both patches make the reproducer work for this particular bugzilla,
> > > but I don't think they are enough.
> > > 
> > > What do you think?
> > 
> > So if the EBUSY error happens because something happened to the page cache
> > outside of discarded range (like you describe above), that is a kernel bug
> > than needs to get fixed. EBUSY should really mean - someone wrote to the
> > discarded range while discard was running and userspace app has to deal
> > with that depending on what it aims to do...
> I double checked this, those are the writes/discards according to my debug
> prints (I print start and then start+len-1 for each request)
> I have attached the patch for this for reference.
> 
> ZERO: 0x00007fe00000 00007fffefff (len:0x1ff000)
>        fallocate 00007fe00000 00007fffefff

Yeah, the end at 7ffff000 is indeed not 4k aligned...

> WRITE: 0x00007ffff000 00007ffffdff (len:0xe00)
>        write 00007ffff000 00007ffffdff

.. and this write is following discarded area in the same page
(7ffff000..7ffffdff).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
