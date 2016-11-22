Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33681 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933900AbcKVXLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 18:11:37 -0500
Date: Tue, 22 Nov 2016 15:11:21 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 03/15] blk-throttle: configure bps/iops limit for
 cgroup in high limit
Message-ID: <20161122231120.GB14628@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <7a4f1b1b0f67bb02d0caadae808c1a89413c202d.1479161136.git.shli@fb.com>
 <20161122201643.GB17534@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161122201643.GB17534@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 22, 2016 at 03:16:43PM -0500, Tejun Heo wrote:
> On Mon, Nov 14, 2016 at 02:22:10PM -0800, Shaohua Li wrote:
> > each queue will have a state machine. Initially queue is in LIMIT_HIGH
> > state, which means all cgroups will be throttled according to their high
> > limit. After all cgroups with high limit cross the limit, the queue state
> > gets upgraded to LIMIT_MAX state.
> > cgroups without high limit will use max limit for their high limit.
> 
> Haven't looked at the actual mechanism yet so please correct me if I'm
> getting it wrong but at least the above explanation reads incorrect.
> Shouldn't max limits applied regardless of whether other cgroups are
> above high or not?

That's true. Since the max limit is higher than high limit (the interface patch
2 has the check), if cgroup is throttled according to high limit, max limit is
respected too.

Thanks,
Shaohua
