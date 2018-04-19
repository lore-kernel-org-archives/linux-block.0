Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 19 Apr 2018 22:21:37 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180419212137.GM30522@ZenIV.linux.org.uk>
References: <20180418211939.GD3476@redhat.com> <20180419015508.GJ27893@dastard>
	<20180419143825.GA3519@redhat.com>
	<20180419144356.GC25406@bombadil.infradead.org>
	<20180419163036.GC3519@redhat.com>
	<1524157119.2943.6.camel@kernel.org>
	<20180419172609.GD3519@redhat.com>
	<20180419203307.GJ30522@ZenIV.linux.org.uk>
	<20180419205820.GB4981@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180419205820.GB4981@redhat.com>
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

On Thu, Apr 19, 2018 at 04:58:20PM -0400, Jerome Glisse wrote:

> I need a struct to link part of device context with mm struct for a
> process. Most of device context is link to the struct file of the
> device file (ie process open has a file descriptor for the device
> file).

Er...  You do realize that
	fd = open(...)
	mmap(fd, ...)
	close(fd)
is absolutely legitimate, right?  IOW, existence/stability/etc. of
a file descriptor is absolutely *not* guaranteed - in fact, there might
be not a single file descriptor referring to a given openen and mmaped
file.

> Device driver for GPU have some part of their process context tied to
> the process mm (accessing process address space directly from the GPU).
> However we can not store this context information in the struct file
> private data because of clone (same struct file accross different mm).
> 
> So today driver have an hashtable in their global device structure to
> lookup context information for a given mm. This is sub-optimal and
> duplicate a lot of code among different drivers.

Umm...  Examples?

> Hence why i want something generic that allow a device driver to store
> context structure that is specific to a mm. I thought that adding a
> new array on the side of struct file array would be a good idea but it
> has too many kludges.
> 
> So i will do something inside mmu_notifier and there will be no tie to
> any fs aspect. I expect only a handful of driver to care about this and
> for a given platform you won't see that many devices hence you won't
> have that many pointer to deal with.

Let's step back for a second - lookups by _what_?  If you are associating
somethin with a mapping, vm_area_struct would be a natural candidate for
storing such data, wouldn't it?

What do you have and what do you want to find?
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
