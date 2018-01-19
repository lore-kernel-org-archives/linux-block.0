Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:65088 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750780AbeASEwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 23:52:15 -0500
Date: Fri, 19 Jan 2018 15:51:39 +1100
From: Dave Chinner <david@fromorbit.com>
To: Raphael Carvalho <raphael.scarv@gmail.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/2] xfs: remove assert to check bytes returned
Message-ID: <20180119045139.GN16421@dastard>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <20180119005741.32058-2-rgoldwyn@suse.de>
 <20180119035736.GL16421@dastard>
 <CACz=WefRiobqX4vfEif2BebQcWjHkeCKE26DFXoxZvGUJ3Hq1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACz=WefRiobqX4vfEif2BebQcWjHkeCKE26DFXoxZvGUJ3Hq1w@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 19, 2018 at 02:23:16AM -0200, Raphael Carvalho wrote:
> On Fri, Jan 19, 2018 at 1:57 AM, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Jan 18, 2018 at 06:57:41PM -0600, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > >
> > > Since we can return less than count in case of partial direct
> > > writes, remove the ASSERT.
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 8601275cc5e6..8fc4dbf66910 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -590,12 +590,6 @@ xfs_file_dio_aio_write(
> > >       ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
> > >  out:
> > >       xfs_iunlock(ip, iolock);
> > > -
> > > -     /*
> > > -      * No fallback to buffered IO on errors for XFS, direct IO will either
> > > -      * complete fully or fail.
> > > -      */
> > > -     ASSERT(ret < 0 || ret == count);
> > >       return ret;
> > >  }
> >
> > Acked-by: Dave Chinner <dchinner@redhat.com>
> 
> 
> Is this really correct?

Yes.

> Isn't this check with regards to DIO
> submission?

Yes, if there is an error during submission.

But it also checked synchronous IO completion (i.e. error or bytes
written), because iomap_dio_rw() waits for non-AIO DIO to complete
and returns the IO completion status in that case.

> The bytes written is returned in a different asynchronous
> path due to AIO support, no?!

That is correct. For AIO we'll get -EIOCBQUEUED here on successful
submission.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
