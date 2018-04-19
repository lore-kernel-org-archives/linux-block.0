Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 19 Apr 2018 21:51:30 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180419205130.GL30522@ZenIV.linux.org.uk>
References: <20180419015508.GJ27893@dastard> <20180419143825.GA3519@redhat.com>
	<20180419144356.GC25406@bombadil.infradead.org>
	<20180419163036.GC3519@redhat.com>
	<1524157119.2943.6.camel@kernel.org>
	<20180419172609.GD3519@redhat.com>
	<1524162667.2943.22.camel@kernel.org>
	<20180419193108.GA4981@redhat.com>
	<20180419195637.GA14024@bombadil.infradead.org>
	<20180419201502.GA11372@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180419201502.GA11372@redhat.com>
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

On Thu, Apr 19, 2018 at 04:15:02PM -0400, Jerome Glisse wrote:

> Well like you pointed out what i really want is a 1:1 structure linking
> a device struct an a mm_struct. Given that this need to be cleanup when
> mm goes away hence tying this to mmu_notifier sounds like a better idea.
> 
> I am thinking of adding a hashtable to mmu_notifier_mm using file id for
> hash as this should be a good hash value for common cases. I only expect
> few drivers to need that (GPU drivers, RDMA). Today GPU drivers do have
> a hashtable inside their driver and they has on the mm struct pointer,
> i believe hash mmu_notifier_mm using file id will be better.

What _is_ "file id"?  If you are talking about file descriptors, you can
very well have several for the same opened file.  Moreover, you can
bloody well have it opened, then dup'ed, then original descriptor closed
and reused by another open...
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
