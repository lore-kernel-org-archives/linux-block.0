Return-Path: <jack@suse.cz>
Date: Tue, 8 Nov 2016 14:42:33 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 8/8] block: hook up writeback throttling
Message-ID: <20161108134233.GR32353@quack2.suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-9-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-9-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue 01-11-16 15:08:51, Jens Axboe wrote:
> Enable throttling of buffered writeback to make it a lot
> more smooth, and has way less impact on other system activity.
> Background writeback should be, by definition, background
> activity. The fact that we flush huge bundles of it at the time
> means that it potentially has heavy impacts on foreground workloads,
> which isn't ideal. We can't easily limit the sizes of writes that
> we do, since that would impact file system layout in the presence
> of delayed allocation. So just throttle back buffered writeback,
> unless someone is waiting for it.
> 
> The algorithm for when to throttle takes its inspiration in the
> CoDel networking scheduling algorithm. Like CoDel, blk-wb monitors
> the minimum latencies of requests over a window of time. In that
> window of time, if the minimum latency of any request exceeds a
> given target, then a scale count is incremented and the queue depth
> is shrunk. The next monitoring window is shrunk accordingly. Unlike
> CoDel, if we hit a window that exhibits good behavior, then we
> simply increment the scale count and re-calculate the limits for that
> scale value. This prevents us from oscillating between a
> close-to-ideal value and max all the time, instead remaining in the
> windows where we get good behavior.
> 
> Unlike CoDel, blk-wb allows the scale count to to negative. This
> happens if we primarily have writes going on. Unlike positive
> scale counts, this doesn't change the size of the monitoring window.
> When the heavy writers finish, blk-bw quickly snaps back to it's
> stable state of a zero scale count.
> 
> The patch registers two sysfs entries. The first one, 'wb_window_usec',
> defines the window of monitoring. The second one, 'wb_lat_usec',
> sets the latency target for the window. It defaults to 2 msec for
> non-rotational storage, and 75 msec for rotational storage. Setting
> this value to '0' disables blk-wb. Generally, a user would not have
> to touch these settings.
> 
> We don't enable WBT on devices that are managed with CFQ, and have
> a non-root block cgroup attached. If we have a proportional share setup
> on this particular disk, then the wbt throttling will interfere with
> that. We don't have a strong need for wbt for that case, since we will
> rely on CFQ doing that for us.

Just one nit: Don't you miss wbt_exit() call for legacy block layer? I
don't see where that happens.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
