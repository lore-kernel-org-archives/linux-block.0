Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 19 Apr 2018 11:55:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180419015508.GJ27893@dastard>
References: <20180418211939.GD3476@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180418211939.GD3476@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-block@vger.kernel.org,
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

On Wed, Apr 18, 2018 at 05:19:39PM -0400, Jerome Glisse wrote:
> Just wanted to suggest to push HMM status down one slot in the
> agenda to avoid having FS and MM first going into their own
> room and then merging back for GUP and DAX, and re-splitting
> after. More over HMM and NUMA talks will be good to have back
> to back as they deal with same kind of thing mostly.

So while we are talking about schedule suggestions, we see that
there's lots of empty slots in the FS track. We (xfs guys) were just
chatting on #xfs about whether we'd have time to have a "XFS devel
meeting" at some point during LSF/MM as we are rarely in the same
place at the same time.

I'd like to propose that we compact the fs sessions so that we get a
3-slot session reserved for "Individual filesystem discussions" one
afternoon. That way we've got time in the schedule for the all the
ext4/btrfs/XFS/NFS/CIFS devs to get together with each other and
talk about things of interest only to their own fileystems.

That means we all don't have to find time outside the schedule to do
this, and think this wold be time very well spent for most fs people
at the conf....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
