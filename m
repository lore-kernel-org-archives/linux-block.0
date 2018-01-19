Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45989 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeASEXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 23:23:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180119035736.GL16421@dastard>
References: <20180119005741.32058-1-rgoldwyn@suse.de> <20180119005741.32058-2-rgoldwyn@suse.de>
 <20180119035736.GL16421@dastard>
From: Raphael Carvalho <raphael.scarv@gmail.com>
Date: Fri, 19 Jan 2018 02:23:16 -0200
Message-ID: <CACz=WefRiobqX4vfEif2BebQcWjHkeCKE26DFXoxZvGUJ3Hq1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: remove assert to check bytes returned
To: Dave Chinner <david@fromorbit.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 19, 2018 at 1:57 AM, Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Jan 18, 2018 at 06:57:41PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > Since we can return less than count in case of partial direct
> > writes, remove the ASSERT.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/xfs/xfs_file.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 8601275cc5e6..8fc4dbf66910 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -590,12 +590,6 @@ xfs_file_dio_aio_write(
> >       ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
> >  out:
> >       xfs_iunlock(ip, iolock);
> > -
> > -     /*
> > -      * No fallback to buffered IO on errors for XFS, direct IO will either
> > -      * complete fully or fail.
> > -      */
> > -     ASSERT(ret < 0 || ret == count);
> >       return ret;
> >  }
>
> Acked-by: Dave Chinner <dchinner@redhat.com>


Is this really correct? Isn't this check with regards to DIO
submission? The bytes written is returned in a different asynchronous
path due to AIO support, no?!

>
>
> --
> Dave Chinner
> david@fromorbit.com


Regards,
Raphael S. Carvalho
