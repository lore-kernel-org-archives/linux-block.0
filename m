Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47114 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049AbcEKAUP (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:20:15 -0400
Date: Tue, 10 May 2016 17:20:04 -0700
From: Shaohua Li <shli@fb.com>
To: Jeff Moyer <jmoyer@redhat.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH 3/3] blk-throttle: don't parse cgroup path if trace isn't
 enabled
Message-ID: <20160511002004.GA2293701@devbig084.prn1.facebook.com>
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
 <b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
 <x49a8jx7vww.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <x49a8jx7vww.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 10, 2016 at 11:52:15AM -0400, Jeff Moyer wrote:
> Shaohua Li <shli@fb.com> writes:
> 
> > if trace isn't enabled, parsing cgroup path just wastes cpu
> >
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > ---
> >  block/blk-throttle.c         | 5 ++---
> >  include/linux/blktrace_api.h | 9 +++++++++
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index 2149a1d..47a3e54 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -211,15 +211,14 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
> >   *
> >   * The messages are prefixed with "throtl BLKG_NAME" if @sq belongs to a
> >   * throtl_grp; otherwise, just "throtl".
> > - *
> > - * TODO: this should be made a function and name formatting should happen
> > - * after testing whether blktrace is enabled.
> 
> You've only addressed the second part of the TODO, please don't remove
> the first part.

alright, I'll send a patch to convert it to a function.
