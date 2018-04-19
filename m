Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 19 Apr 2018 12:56:37 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180419195637.GA14024@bombadil.infradead.org>
References: <20180418211939.GD3476@redhat.com> <20180419015508.GJ27893@dastard>
	<20180419143825.GA3519@redhat.com>
	<20180419144356.GC25406@bombadil.infradead.org>
	<20180419163036.GC3519@redhat.com>
	<1524157119.2943.6.camel@kernel.org>
	<20180419172609.GD3519@redhat.com>
	<1524162667.2943.22.camel@kernel.org>
	<20180419193108.GA4981@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180419193108.GA4981@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>,
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

On Thu, Apr 19, 2018 at 03:31:08PM -0400, Jerome Glisse wrote:
> > > Basicly i want a callback in __fd_install(), do_dup2(), dup_fd() and
> > > add void * *private_data; to struct fdtable (also a default array to
> > > struct files_struct). The callback would be part of struct file_operations.
> > > and only call if it exist (os overhead is only for device driver that
> > > care).
> > > 
> > > Did i miss something fundamental ? copy_files() call dup_fd() so i
> > > should be all set here.
> > > 
> > > I will work on patches i was hoping this would not be too much work.
> 
> Well scratch that whole idea, i would need to add a new array to task
> struct which make it a lot less appealing. Hence a better solution is
> to instead have this as part of mm (well indirectly).

It shouldn't be too bad to add a struct radix_tree to the fdtable.

I'm sure we could just not support weird cases like sharing the fdtable
without sharing the mm.  Does anyone actually do that?
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
