Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:40940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933407AbeCHRj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Mar 2018 12:39:57 -0500
Date: Thu, 8 Mar 2018 09:29:49 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v7 2/2] Return bytes transferred for partial direct I/O
Message-ID: <20180308172949.GC19297@magnolia>
References: <20180208185948.26827-1-rgoldwyn@suse.de>
 <20180208185948.26827-2-rgoldwyn@suse.de>
 <20180308005329.GB19297@magnolia>
 <322f07ad-2dad-8725-00d0-126eef4853bf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <322f07ad-2dad-8725-00d0-126eef4853bf@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 08, 2018 at 09:35:48AM -0600, Goldwyn Rodrigues wrote:
> 
> 
> On 03/07/2018 06:53 PM, Darrick J. Wong wrote:
> > On Thu, Feb 08, 2018 at 12:59:48PM -0600, Goldwyn Rodrigues wrote:
> >> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >>
> >> In case direct I/O encounters an error midway, it returns the error.
> >> Instead it should be returning the number of bytes transferred so far.
> >>
> >> Test case for filesystems (with ENOSPC):
> >> 1. Create an almost full filesystem
> >> 2. Create a file, say /mnt/lastfile, until the filesystem is full.
> >> 3. Direct write() with count > sizeof /mnt/lastfile.
> >>
> >> Result: write() returns -ENOSPC. However, file content has data written
> >> in step 3.
> >>
> >> Added a sysctl entry: dio_short_writes which is on by default. This is
> >> to support applications which expect either and error or the bytes submitted
> >> as a return value for the write calls.
> >>
> >> This fixes fstest generic/472.
> >>
> >> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >> ---
> >>  Documentation/sysctl/fs.txt | 14 ++++++++++++++
> >>  fs/block_dev.c              |  2 +-
> >>  fs/direct-io.c              |  7 +++++--
> >>  fs/iomap.c                  | 23 ++++++++++++-----------
> >>  include/linux/fs.h          |  1 +
> >>  kernel/sysctl.c             |  9 +++++++++
> >>  6 files changed, 42 insertions(+), 14 deletions(-)
> >>
> >> Changes since v1:
> >>  - incorporated iomap and block devices
> >>
> >> Changes since v2:
> >>  - realized that file size was not increasing when performing a (partial)
> >>    direct I/O because end_io function was receiving the error instead of
> >>    size. Fixed.
> >>
> >> Changes since v3:
> >>  - [hch] initialize transferred with dio->size and use transferred instead
> >>    of dio->size.
> >>
> >> Changes since v4:
> >>  - Refreshed to v4.14
> >>
> >> Changes since v5:
> >>  - Added /proc/sys/fs/dio_short_writes (default 1) to guard older applications
> >>    which expect write(fd, buf, count) returns either count or error.
> >>
> >> Changes since v6:
> >>  - Corrected documentation
> >>  - Re-ordered patch
> >>
> >> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
> >> index 6c00c1e2743f..21582f675985 100644
> >> --- a/Documentation/sysctl/fs.txt
> >> +++ b/Documentation/sysctl/fs.txt
> >> @@ -22,6 +22,7 @@ Currently, these files are in /proc/sys/fs:
> >>  - aio-max-nr
> >>  - aio-nr
> >>  - dentry-state
> >> +- dio_short_writes
> >>  - dquot-max
> >>  - dquot-nr
> >>  - file-max
> >> @@ -76,6 +77,19 @@ dcache isn't pruned yet.
> >>  
> >>  ==============================================================
> >>  
> >> +dio_short_writes:
> >> +
> >> +In case Direct I/O encounters a transient error, it returns
> >> +the error code, even if it has performed part of the write.
> >> +This flag, if on (default), will return the number of bytes written
> >> +so far, as the write(2) semantics are. However, some older applications
> >> +still consider a direct write as an error if all of the I/O
> >> +submitted is not complete. I.e. write(file, count, buf) != count.
> >> +This option can be disabled on systems in order to support
> >> +existing applications which do not expect short writes.
> >> +
> >> +==============================================================
> >> +
> >>  dquot-max & dquot-nr:
> >>  
> >>  The file dquot-max shows the maximum number of cached disk
> >> diff --git a/fs/block_dev.c b/fs/block_dev.c
> >> index 4a181fcb5175..49d94360bb51 100644
> >> --- a/fs/block_dev.c
> >> +++ b/fs/block_dev.c
> >> @@ -409,7 +409,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
> >>  
> >>  	if (!ret)
> >>  		ret = blk_status_to_errno(dio->bio.bi_status);
> >> -	if (likely(!ret))
> >> +	if (likely(dio->size))
> >>  		ret = dio->size;
> >>  
> >>  	bio_put(&dio->bio);
> >> diff --git a/fs/direct-io.c b/fs/direct-io.c
> >> index 3aafb3343a65..9bd15be64c25 100644
> >> --- a/fs/direct-io.c
> >> +++ b/fs/direct-io.c
> >> @@ -151,6 +151,7 @@ struct dio {
> >>  } ____cacheline_aligned_in_smp;
> >>  
> >>  static struct kmem_cache *dio_cache __read_mostly;
> >> +unsigned int sysctl_dio_short_writes = 1;
> >>  
> >>  /*
> >>   * How many pages are in the queue?
> >> @@ -262,7 +263,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
> >>  		ret = dio->page_errors;
> >>  	if (ret == 0)
> >>  		ret = dio->io_error;
> >> -	if (ret == 0)
> >> +	if (!sysctl_dio_short_writes && (ret == 0))
> >>  		ret = transferred;
> >>  
> >>  	if (dio->end_io) {
> >> @@ -310,7 +311,9 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
> >>  	}
> >>  
> >>  	kmem_cache_free(dio_cache, dio);
> >> -	return ret;
> >> +	if (!sysctl_dio_short_writes)
> >> +		return ret;
> >> +	return transferred ? transferred : ret;
> >>  }
> >>  
> >>  static void dio_aio_complete_work(struct work_struct *work)
> >> diff --git a/fs/iomap.c b/fs/iomap.c
> >> index 47d29ccffaef..a8d6908dc0de 100644
> >> --- a/fs/iomap.c
> >> +++ b/fs/iomap.c
> >> @@ -716,23 +716,24 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >>  	struct kiocb *iocb = dio->iocb;
> >>  	struct inode *inode = file_inode(iocb->ki_filp);
> >>  	loff_t offset = iocb->ki_pos;
> >> -	ssize_t ret;
> >> +	ssize_t err;
> >> +	ssize_t transferred = dio->size;
> > 
> > I'm sorry to bring this up again, but there's something not quite right
> > with this.  Every time iomap_dio_actor create a bio, it increments
> > dio->size by bio->bi_iter.bi_size before calling submit_bio.  dio->size is
> > the 'partial' size returned to the caller if there's an error, which
> > means that if we write a single 2MB bio and it fails, we still get a
> > partial result of 2MB, not zero.
> > 
> > Analysis of generic/250 bears this out:
> > 
> > total 40960
> > drwxr-xr-x 2 root root       19 Mar  7 15:59 .
> > drwxr-xr-x 3 root root       22 Mar  7 15:59 ..
> > -rw------- 1 root root 41943040 Mar  7 15:59 file2
> > Filesystem type is: 58465342
> > File size of /opt/test-250/file2 is 41943040 (10240 blocks of 4096
> > ytes)
> >  ext:     logical_offset:        physical_offset: length:   expected:
> > lags:
> >    0:        0..     511:         24..       535:    512:
> >    1:      512..    2047:        536..      2071:   1536: unwritten
> >    2:     2048..    2048:       2072..      2072:      1:
> >    3:     2049..    6249:       2073..      6273:   4201: unwritten
> >    4:     6250..   10239:       6416..     10405:   3990:       6274:
> > last,unwritten,eof
> > /opt/test-250/file2: 2 extents found
> > 0000000  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
> >          \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
> > *
> > 0032768  69  69  69  69  69  69  69  69  69  69  69  69  69  69  69  69
> >           i   i   i   i   i   i   i   i   i   i   i   i   i   i   i   i
> >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Note that we wrote 0x69 to the disk prior to mkfs so that if any
> > unwritten extents were incorrectly converted to real extents we'd detect
> > it immediately.  This is evidence that we're exposing stale disk
> > contents.
> > 
> > *
> > 2097152  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
> >          \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
> > *
> > 8388608  63  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
> >           c  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
> > 8388624  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
> >          \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
> > *
> > 41943040
> > 
> > I think there's a more serious problem here too.  Let's say userspace
> > asks for a 4MB dio write and the dio write itself splits into four 1MB
> > write bios.  bio 0, 2, and 3 return quickly, but bio 1 fails slowly,
> > which means we successfully wrote 0-1M and 2M-3M, but since we can't
> > communicate a vector back to userspace the best we can do is return
> > 1048576.
> 
> Yes, this is a known problem and the only solution I have been told is
> to document it.

<nod> I think I'm comfortable returning the offset of the first failing
io as a lower bound for "bytes written".  Presumably the file pointer
will be advanced by that amount and the operation retried from there, if
the program cares to do so.

> But it the light of what you have expressed earlier, yes
> this patch does not make sense. An error in the direct I/O means that
> the data in the range may be inconsistent/garbage.
> 
> > 
> > I think this is going to need better state tracking of exactly /what/
> > succeeded before we can return partial writes to userspace.  This could
> > be as simple as recording the iomap offset with each bio issued and
> > reducing dio->size to min(dio->size, bio->iomap->offset) if
> > bio->bi_status is set in iomap_dio_bio_end_io.
> > 
> What about the rest of the data? Should the user assume that the *rest*
> of the data (count - ret) is inconsistent in case of a short write?

Well, a narrow reading of the spec would be that we only made a
statement about the range (offset, offset + ret), so who cares what
happened past that? :P  But it does break the model that "write says it
wrote X bytes, so everything past X remains as it was before"... but
this is directio where everything is upside down. :P

--D

> 
> -- 
> Goldwyn
