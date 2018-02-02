Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Fri, 2 Feb 2018 15:04:11 -0700
From: Liu Bo <bo.li.liu@oracle.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <20180202220411.GB23065@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
References: <20180125115727.slf6zj4zzevcskkn@quack2.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20180125115727.slf6zj4zzevcskkn@quack2.suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] get_user_pages() and filesystems
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: bo.li.liu@oracle.com
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

Hi Jan,

On Thu, Jan 25, 2018 at 12:57:27PM +0100, Jan Kara wrote:
> Hello,
> 
> this is about a problem I have identified last month and for which I still
> don't have good solution. Some discussion of the problem happened here [1]
> where also technical details are posted but culprit of the problem is
> relatively simple: Lots of places in kernel (fs code, writeback logic,
> stable-pages framework for DIF/DIX) assume that file pages in page cache
> can be modified either via write(2), truncate(2), fallocate(2) or similar
> code paths explicitely manipulating with file space or via a writeable
> mapping into page tables. In particular we assume that if we block all the
> above paths by taking proper locks, block page faults, and unmap (/ map
> read-only) the page, it cannot be modified. But this assumption is violated
> by get_user_pages() users (such as direct IO or RDMA drivers - and we've
> got reports from such users of weird things happening).
> 
> The problem with GUP users is that they acquire page reference (at that
> point page is writeably mapped into page tables) and some time in future
> (which can be quite far in case of RDMA) page contents gets modified and
> page marked dirty.

I got a question here, when you say 'page contents gets modified', do
you mean that GUP users modify the page content?

I have another story about GUP users who use direct-IO, qemu sometimes
doesn't work well with btrfs when checksum enabled and reports
checksum failures when guest OS doesn't use stable pages, where it is
not GUP users but the original file/mapping that may be changing the
page content in flight.

So looks like either way we kinda have problems.

Thanks,

-liubo

> 
> The question is how to properly solve this problem. One obvious way is to
> indicate page has a GUP reference and block its unmapping / remapping RO
> until that is dropped. But this has a technical problem (how to find space
> in struct page for such tracking) and a design problem (blocking e.g.
> writeback for hours because some RDMA app used a file mapping as a buffer
> simply is not acceptable). There are also various modifications to this
> solution like refuse to use file pages for RDMA
> (get_user_pages_longterm()) and block waiting for users like direct IO, or
> require that RDMA users provide a way to revoke access from GUPed pages.
> 
> Another obvious solution is to try to remove the assumption from all those
> places - i.e., use bounce buffers for DIF/DIX, make sure filesystems are
> prepared for dirty pages suddenly appearing in files and handle that as
> good as they can. They really need to sensibly handle only a case when
> underlying storage is already allocated / reserved, in all other cases I
> believe they are fine in just discarding the data. This would be very
> tedious but I believe it could be done. But overall long-term maintenance
> burden of this solution just doesn't seem worth it to me.
> 
> Another possible solution might be that GUP users (at least the long term
> ones) won't get references directly to page cache pages but only to some
> bounce pages (something like cow on private file mappings) and data would
> be just copied to the page cache pages at set_page_dirty_lock() time (we
> would probably have to move these users to a completely new API to keep our
> sanity). This would have userspace visible impacts (data won't be visible
> in the file until GUP user is done with it) but maybe it would be
> acceptable. Also how to keep association to the original pagecache page
> (and how it should be handled when underlying file just goes away) is
> unclear.
> 
> So clever ideas are needed and possibly some input from FS / MM / RDMA
> folks about what might be acceptable.
> 
> 								Honza
> 
> [1] https://www.spinics.net/lists/linux-xfs/msg14468.html
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
