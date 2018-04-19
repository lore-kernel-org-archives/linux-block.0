Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 19 Apr 2018 23:13:50 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180419221350.GN30522@ZenIV.linux.org.uk>
References: <20180419015508.GJ27893@dastard> <20180419143825.GA3519@redhat.com>
	<20180419144356.GC25406@bombadil.infradead.org>
	<20180419163036.GC3519@redhat.com>
	<1524157119.2943.6.camel@kernel.org>
	<20180419172609.GD3519@redhat.com>
	<20180419203307.GJ30522@ZenIV.linux.org.uk>
	<20180419205820.GB4981@redhat.com>
	<20180419212137.GM30522@ZenIV.linux.org.uk>
	<20180419214751.GD4981@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180419214751.GD4981@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM] schedule suggestion
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 19, 2018 at 05:47:51PM -0400, Jerome Glisse wrote:
> On Thu, Apr 19, 2018 at 10:21:37PM +0100, Al Viro wrote:
> > On Thu, Apr 19, 2018 at 04:58:20PM -0400, Jerome Glisse wrote:
> > 
> > > I need a struct to link part of device context with mm struct for a
> > > process. Most of device context is link to the struct file of the
> > > device file (ie process open has a file descriptor for the device
> > > file).
> > 
> > Er...  You do realize that
> > 	fd = open(...)
> > 	mmap(fd, ...)
> > 	close(fd)
> > is absolutely legitimate, right?  IOW, existence/stability/etc. of
> > a file descriptor is absolutely *not* guaranteed - in fact, there might
> > be not a single file descriptor referring to a given openen and mmaped
> > file.
> 
> Yes and that's fine, on close(fd) the device driver is tear down

No, it is not.  _NOTHING_ is done on that close(fd), other than removing
a reference from descriptor table.  In this case struct file is still
open and remains such until munmap().

That's why descriptor table is a very bad place for sticking that kind of
information.  Besides, as soon as your syscall (ioctl, write, whatever)
has looked struct file up, the mapping from descriptors to struct file
can change.  Literally before fdget() has returned to caller.  Another
thread could do dup() and close() of the original descriptor.  Or
just plain close(), for that matter - struct file will remain open until
fdput().

> and
> struct i want to store is tear down too and free.

So do a hash table indexed by pair (void *, struct mm_struct *) and
do lookups there...  And use radeon_device as the first half of the
key.  Or struct file *, or pointer to whatever private data you maintain
for an opened file...
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
