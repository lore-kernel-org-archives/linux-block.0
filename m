Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 v2] cfq: High precision slice tuning
Date: Wed,  8 Jun 2016 15:11:36 +0200
Message-Id: <1465391499-27867-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hi,

since Jens didn't merge the patches yet, I'm sending v2 of the series. Since
v1 I have added Jeff's Reviewed-by tag and also fixed two 32-bit issues
(possible overflow when computing cfq_latency_target and 64-bit division using
'/' in choose_wl_class_and_type()). Jens, please merge these patches. Thanks!

								Honza
---

Intro to the series

This series contains patches which convert CFQ to internally use nanoseconds
instead of jiffies (based on patch from Jeff), use high resultion timers, and
provide interfaces to tune slice length in microseconds instead of miliseconds.
Currently, since CFQ uses jiffies interally, the precision of slice length is
in the order of microseconds (e.g., 4 ms for SUSE kernels). In some cases it
would be desirable to tune the slice length to 1 ms or even somewhat lower -
especially in cases where the idling is necessary only to avoid starving
processes doing dependent IO. There giving process 1 ms to submit more IO is
usually more than enough. 

I have been running some IO benchmarks (dbench, postmark, tiobench) with these
patches and didn't see any negative effect. I have also checked that tuning
slice lenght down to 0.5 ms basically removes negative performance effect of
isolating dbench process in a blkio cgroup in my setup. The optimal length
of timeslice obviously depends on the setup and workload and it is not goal
of this patch set to argue about the time slice lenght. Mostly I just wanted
to demonstrate that tuning the timeslice length down helps some workloads and
we don't want to disable idling completely.
