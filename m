Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50885 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755155AbcKOAtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 19:49:46 -0500
Date: Mon, 14 Nov 2016 16:49:22 -0800
From: Shaohua Li <shli@fb.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "axboe@fb.com" <axboe@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
Subject: Re: [PATCH V4 00/15] blk-throttle: add .high limit
Message-ID: <20161115004922.GA16173@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <986ada43-3217-3277-724a-5c76f8dad74e@sandisk.com>
 <20161115000529.GA15160@shli-mbp.local>
 <cac5ee16-1400-2fff-3948-fa1dea997702@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cac5ee16-1400-2fff-3948-fa1dea997702@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 14, 2016 at 04:41:33PM -0800, Bart Van Assche wrote:
> On 11/14/2016 04:05 PM, Shaohua Li wrote:
> > On Mon, Nov 14, 2016 at 02:46:22PM -0800, Bart Van Assche wrote:
> > > On 11/14/2016 02:22 PM, Shaohua Li wrote:
> > > > The background is we don't have an ioscheduler for blk-mq yet, so we can't
> > > > prioritize processes/cgroups. This patch set tries to add basic arbitration
> > > > between cgroups with blk-throttle. It adds a new limit io.high for
> > > > blk-throttle. It's only for cgroup2.
> > > 
> > > My understanding of this work is that a significant part of it will have to
> > > be reverted once blk-mq supports I/O scheduling, e.g. the code for detecting
> > > whether the I/O submitter is idle. Shouldn't this kind of infrastructure be
> > > added after support has been added in blk-mq for I/O scheduling?
> > 
> > Sure, if we have a CFQ-like io scheduler for blk-mq, this is largly not
> > required. But we don't have one yet and nothing is floating around either. The
> > conservative throttling is relatively easy to implement and achive similar
> > goal. The throttling could be still useful even with ioscheduler as throttling
> > is faster if we are talking about CFQ-like scheduler. I don't think this should
> > be blocked to wait for I/O scheduling. There was a long discussion in last
> > post, and we agreed the throttling and io scheduler aren't mutually exclusive.
> > http://marc.info/?l=linux-kernel&m=147552964708965&w=2
> 
> Hello Shaohua,
> 
> Thank you for pointing me to the discussion thread about v3 of this patch
> series. Did I see correctly that one of the conclusions was that for users
> this mechanism is hard to configure? Are we providing a good service to
> Linux users by providing a mechanism that is hard to configure?

Yes, this is a kind of low level knob and is expected to be configured by
experienced users. This sucks, but we really don't have good solutions. If
anybody has better ideas, I'm happy to try.

Thanks,
Shaohua
