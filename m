Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbeIKNSq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 09:18:46 -0400
Date: Tue, 11 Sep 2018 16:20:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911082023.GA5360@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 11, 2018 at 12:40:36PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/11/2018 12:03 PM, Ming Lei wrote:
> > After the refcount is switched to atomic mode, the whole counting is
> > done on the atomic part. Then if the refcount need to switch to percpu mode
> > again, all percpu part of the counter is re-initialized as zero simply. This
> > is invariant with/without this patch.
> 
> Does the "whole counting" here means ?
> 
> (long)(sum (every cpu's refcounter)) + atomic refcounter

No.

We only check the 'whole counting' at atomic mode, so it is the atomic
part('ref->count'), please see percpu_ref_put_many(), in which ref->release()
is only called at atomic mode.

At percpu mode, the ref-count is only decreased/increased on the local CPU.

> 
> and when switch to atomic mode, there could be value left in atomic refcounter.
> then the unsigned long percpu refcounter cound be decreased from 0.
> 	
> From another angle, one request could be ended on a different cpu from the one where
> it is issued.

Right.

But,

In the fast path(either completion or issue path), the .q_usage_counter is only
increased/decreased, which can be done in either atomic or percpu mode.

And when we want to check the queued/inflight requests, the .q_usage_counter has
to be killed first by switching to atomic mode, such as in all kinds of
uses of blk_freeze_queue_start().


Thanks,
Ming
