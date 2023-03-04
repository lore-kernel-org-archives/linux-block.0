Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA897C678D5
	for <linux-block@archiver.kernel.org>; Sat,  4 Mar 2023 07:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCDHep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Mar 2023 02:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCDHeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Mar 2023 02:34:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDF1A4AF;
        Fri,  3 Mar 2023 23:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cSluSmsGaLzDYhfoisEbRtp29cbXLVqMPsLxJj6jGno=; b=DEQSDa3sTTeaqwDXHmg4i2Bg4d
        Z6nzx312CvCszO5/LXypdlJePS7uQ8kTu6Jh+g9em1dAEL+aPG7aeclzfDAN3RfzG2pjWVbBQ4mOJ
        0OcYdnta/DrCTD5MhzAO0KbUnS5LjE4mVwFqg90P0/fzGd2L+HyN+RDmujl3pv7IHhwFA520/X7jS
        R0blBBqTkkcBq2x5ZP8xS9SgkF6YS5Q3JHQru8mjzqDnWkjnk6206J+MDVibpu+ZMp+jiWRIYOlGm
        1zMoOzx8YSYZeHqM8DwGN9Ne+ZW0ZKaZ71myX8Pac25mxzahgqY2R+yIct9UUjGYg8v40we4fbhrL
        7TYQysRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYMPZ-003ikI-Hl; Sat, 04 Mar 2023 07:34:33 +0000
Date:   Sat, 4 Mar 2023 07:34:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAL0ifa66TfMinCh@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 03, 2023 at 08:11:47AM -0500, James Bottomley wrote:
> On Fri, 2023-03-03 at 03:49 +0000, Matthew Wilcox wrote:
> > On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
> > > That said, I was hoping you were going to suggest supporting 16k
> > > logical block sizes. Not a problem on some arch's, but still
> > > problematic when PAGE_SIZE is 4k. :)
> > 
> > I was hoping Luis was going to propose a session on LBA size >
> > PAGE_SIZE. Funnily, while the pressure is coming from the storage
> > vendors, I don't think there's any work to be done in the storage
> > layers.  It's purely a FS+MM problem.
> 
> Heh, I can do the fools rush in bit, especially if what we're
> interested in the minimum it would take to support this ...
> 
> The FS problem could be solved simply by saying FS block size must
> equal device block size, then it becomes purely a MM issue.

Spoken like somebody who's never converted a filesystem to
supporting large folios.  There are a number of issues:

1. The obvious; use of PAGE_SIZE and/or PAGE_SHIFT
2. Use of kmap-family to access, eg directories.  You can't kmap
   an entire folio, only one page at a time.  And if a dentry is split
   across a page boundary ...
3. buffer_heads do not currently support large folios.  Working on it.

Probably a few other things I forget.  But look through the recent
patches to AFS, CIFS, NFS, XFS, iomap that do folio conversions.
A lot of it is pretty mechanical, but some of it takes hard thought.
And if you have ideas about how to handle ext2 directories, I'm all ears.

> The MM
> issue could be solved by adding a page order attribute to struct
> address_space and insisting that pagecache/filemap functions in
> mm/filemap.c all have to operate on objects that are an integer
> multiple of the address space order.  The base allocator is
> filemap_alloc_folio, which already has an apparently always zero order
> parameter (hmmm...) and it always seems to be called from sites that
> have the address_space, so it could simply be modified to always
> operate at the address_space order.

Oh, I have a patch for that.  That's the easy part.  The hard part is
plugging your ears to the screams of the MM people who are convinced
that fragmentation will make it impossible to mount your filesystem.

