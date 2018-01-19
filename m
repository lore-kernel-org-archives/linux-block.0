Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:39784 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754836AbeASEAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 23:00:24 -0500
Date: Fri, 19 Jan 2018 14:59:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Message-ID: <20180119035951.GM16421@dastard>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <20180119021352.GE13338@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119021352.GE13338@ZenIV.linux.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 19, 2018 at 02:13:53AM +0000, Al Viro wrote:
> On Thu, Jan 18, 2018 at 06:57:40PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > In case direct I/O encounters an error midway, it returns the error.
> > Instead it should be returning the number of bytes transferred so far.
> > 
> > Test case for filesystems (with ENOSPC):
> > 1. Create an almost full filesystem
> > 2. Create a file, say /mnt/lastfile, until the filesystem is full.
> > 3. Direct write() with count > sizeof /mnt/lastfile.
> > 
> > Result: write() returns -ENOSPC. However, file content has data written
> > in step 3.
> > 
> > This fixes fstest generic/472.
> 
> OK...  I can live with that.  What about the XFS side?  It should be
> a prereq, to avoid bisection hazard; I can throw both into vfs.git,
> if XFS folks are OK with that.  Objections?

Going through the VFS tree seesm the best approach to me - it's a
trivial change. I'm sure Darrick will shout if it's going to be a
problem, though.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
