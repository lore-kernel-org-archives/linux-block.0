Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31667 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932074AbcEKQuI (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 12:50:08 -0400
Date: Wed, 11 May 2016 09:49:56 -0700
From: Shaohua Li <shli@fb.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 3/3] blk-throttle: don't parse cgroup path if trace isn't
 enabled
Message-ID: <20160511164945.GA83519@devbig084.prn1.facebook.com>
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
 <b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
 <x49a8jx7vww.fsf@segfault.boston.devel.redhat.com>
 <20160511002004.GA2293701@devbig084.prn1.facebook.com>
 <x49a8jwogov.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <x49a8jwogov.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 11, 2016 at 09:41:20AM -0400, Jeff Moyer wrote:
> Shaohua Li <shli@fb.com> writes:
> 
> > On Tue, May 10, 2016 at 11:52:15AM -0400, Jeff Moyer wrote:
> >> Shaohua Li <shli@fb.com> writes:
> >> 
> >> > if trace isn't enabled, parsing cgroup path just wastes cpu
> >> >
> >> > Signed-off-by: Shaohua Li <shli@fb.com>
> >> > ---
> >> >  block/blk-throttle.c         | 5 ++---
> >> >  include/linux/blktrace_api.h | 9 +++++++++
> >> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> >> > index 2149a1d..47a3e54 100644
> >> > --- a/block/blk-throttle.c
> >> > +++ b/block/blk-throttle.c
> >> > @@ -211,15 +211,14 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
> >> >   *
> >> >   * The messages are prefixed with "throtl BLKG_NAME" if @sq belongs to a
> >> >   * throtl_grp; otherwise, just "throtl".
> >> > - *
> >> > - * TODO: this should be made a function and name formatting should happen
> >> > - * after testing whether blktrace is enabled.
> >> 
> >> You've only addressed the second part of the TODO, please don't remove
> >> the first part.
> >
> > alright, I'll send a patch to convert it to a function.
> 
> Heh.  I figured you'd just put that part of the TODO back in there.  But
> actually addressing it sounds better.  ;-)

Actually I'd like to give up. To convert it to a function, I need add a
var arg version of blk_add_trace_msg. And throtl_log adds new parameter
and change fmt, so I must allocate a new string to fit old fmt and new
parameter and new fmt string. It's not worthy the effort I think.

Thanks,
Shaohua
