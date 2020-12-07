Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB7C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD052388B
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 17:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgLGRZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 12:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgLGRZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Dec 2020 12:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607361839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BtS2cKDkDZv/oMbkOdRs/6W97PMYcVRdzOtzlx86o4=;
        b=UlkA4Uv5kqQ9qCobXpK19fnwO3w9FtkL6skv5NU2yc2+9LqcdUuzmgJeq4KikhxkgMZa4A
        T57jeBXVb5B725y/GecKciwLtv3vO58Az84HI+bVnJPoKdXF5uSlAo0IjmVVYABI6d7/zg
        uxMwy3H5XTepNY0Pt304Z+bTQ2//QuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-zAfHikf4Ntq-SgsRwyOmbQ-1; Mon, 07 Dec 2020 12:23:57 -0500
X-MC-Unique: zAfHikf4Ntq-SgsRwyOmbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453CD107ACE3;
        Mon,  7 Dec 2020 17:23:56 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47C6F3CC9;
        Mon,  7 Dec 2020 17:23:51 +0000 (UTC)
Message-ID: <45420b24124b5b91bc0a80a4abad2e06acb8c2b3.camel@redhat.com>
Subject: Re: [PATCH 0/2] RFC: Issue with discards on raw block device
 without O_DIRECT
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>
Cc:     qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
        Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Date:   Mon, 07 Dec 2020 19:23:50 +0200
In-Reply-To: <20201112220838.GD9699@magnolia>
References: <20201111153913.41840-1-mlevitsk@redhat.com>
         <03b01c699c9fab64736d04891f1e835aef06c886.camel@redhat.com>
         <20201112111951.GB27697@quack2.suse.cz>
         <20201112120056.GC27697@quack2.suse.cz> <20201112220838.GD9699@magnolia>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2020-11-12 at 14:08 -0800, Darrick J. Wong wrote:
> On Thu, Nov 12, 2020 at 01:00:56PM +0100, Jan Kara wrote:
> > On Thu 12-11-20 12:19:51, Jan Kara wrote:
> > > [added some relevant people and lists to CC]
> > > 
> > > On Wed 11-11-20 17:44:05, Maxim Levitsky wrote:
> > > > On Wed, 2020-11-11 at 17:39 +0200, Maxim Levitsky wrote:
> > > > > clone of "starship_production"
> > > > 
> > > > The git-publish destroyed the cover letter:
> > > > 
> > > > For the reference this is for bz #1872633
> > > > 
> > > > The issue is that current kernel code that implements 'fallocate'
> > > > on kernel block devices roughly works like that:
> > > > 
> > > > 1. Flush the page cache on the range that is about to be discarded.
> > > > 2. Issue the discard and wait for it to finish.
> > > >    (as far as I can see the discard doesn't go through the
> > > >    page cache).
> > > > 
> > > > 3. Check if the page cache is dirty for this range,
> > > >    if it is dirty (meaning that someone wrote to it meanwhile)
> > > >    return -EBUSY.
> > > > 
> > > > This means that if qemu (or qemu-img) issues a write, and then
> > > > discard to the area that shares a page, -EBUSY can be returned by
> > > > the kernel.
> > > 
> > > Indeed, if you don't submit PAGE_SIZE aligned discards, you can get back
> > > EBUSY which seems wrong to me. IMO we should handle this gracefully in the
> > > kernel so we need to fix this.
> > > 
> > > > On the other hand, for example, the ext4 implementation of discard
> > > > doesn't seem to be affected. It does take a lock on the inode to avoid
> > > > concurrent IO and flushes O_DIRECT writers prior to doing discard thought.
> > > 
> > > Well, filesystem hole punching is somewhat different beast than block device
> > > discard (at least implementation wise).
> > > 
> > > > Doing fsync and retrying is seems to resolve this issue, but it might be
> > > > a too big hammer.  Just retrying doesn't work, indicating that maybe the
> > > > code that flushes the page cache in (1) doesn't do this correctly ?
> > > > 
> > > > It also can be racy unless special means are done to block IO from happening
> > > > from qemu during this fsync.
> > > > 
> > > > This patch series contains two patches:
> > > > 
> > > > First patch just lets the file-posix ignore the -EBUSY errors, which is
> > > > technically enough to fail back to plain write in this case, but seems wrong.
> > > > 
> > > > And the second patch adds an optimization to qemu-img to avoid such a
> > > > fragmented write/discard in the first place.
> > > > 
> > > > Both patches make the reproducer work for this particular bugzilla,
> > > > but I don't think they are enough.
> > > > 
> > > > What do you think?
> > > 
> > > So if the EBUSY error happens because something happened to the page cache
> > > outside of discarded range (like you describe above), that is a kernel bug
> > > than needs to get fixed. EBUSY should really mean - someone wrote to the
> > > discarded range while discard was running and userspace app has to deal
> > > with that depending on what it aims to do...
> > 
> > So I was looking what it would take to fix this inside the kernel. The
> > problem is that invalidate_inode_pages2_range() is working on page
> > granularity and it is non-trivial to extend it to work on byte granularity
> > since we don't support something like "try to reclaim part of a page". But
> > I'm also somewhat wondering why we use invalidate_inode_pages2_range() here
> > instead of truncate_inode_pages_range() again? I mean the EBUSY detection
> > cannot be reliable anyway and userspace has no way of knowing whether a
> > write happened before discard or after it so just discarding data is fine
> > from this point of view. Darrick?
> 
> Hmmm, I think I overlooked the fact that we can do buffered writes into
> a block device's pagecache without taking any of the usual locks that
> have to be held for filesystem files.  This is essentially a race
> between a not-page-aligned fallocate and a buffered write to a different
> sector that is mapped by a page that caches part of the fallocate range.
> 
> So yes, Jan is right that we need to use truncate_bdev_range instead of
> invalidate_inode_pages2_range because the former will zero the sub-page
> ranges on either end of the fallocate request instead of returning
> -EBUSY because someone dirtied a part of a page that wasn't involved in
> the fallocate operation.
> 
> I /probably/ just copy-pasta'd that invalidation call from directio
> without thinking hard enough about it, sorry about that. :(

Any update on this?
 
Today I took a look at both truncate_bdev_range,
and at invalidate_inode_pages2_range.
 
 
I see that the truncate_bdev_range can't really fail other 
than check for a mounted
filesystem.
 
It calls truncate_inode_pages_range which writes back all
dirty pages and waits for writeback to finish.
So it won't detect dirty pages as invalidate_inode_pages2_range does
 
 
Also AFAIK the
kernel page cache indeed 
only tracks the dirtiness of a whole page (e.g a 512 byte write, 
will cause the whole page to be written back, unless the 
write was done using O_DIRECT)
 
So if a page, part of
which is discarded, becomes dirty we can't really
know if someone wrote to the discarded region, or only near it.
 
I vote to keep the call to invalidate_inode_pages2_range but
exclude the non page
aligned areas from it.
 
This way we will still do a best effort detection of this case,
while not causing any false positives.
 
If you agree, I'll send a patch for this.


Best regards,
	Maxim Levitsky

> 
> --D
> 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR


