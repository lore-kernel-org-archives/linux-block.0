Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbeIJHTi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Sep 2018 03:19:38 -0400
Date: Mon, 10 Sep 2018 07:59:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180909235942.GA31391@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <1536518780.23536.3.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536518780.23536.3.camel@acm.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 09, 2018 at 11:46:20AM -0700, Bart Van Assche wrote:
> On Sun, 2018-09-09 at 20:58 +0800, Ming Lei wrote:
> > Now percpu_ref_reinit() can only be done on one percpu refcounter
> > when it drops zero. And the limit shouldn't be so strict, and it
> > is quite straightforward that percpu_ref_reinit() can be done when
> > this counter is at atomic mode.
> > 
> > This patch relaxes the limit, so we may avoid extra change[1] for NVMe
> > timeout's requirement.
> > 
> > [1] https://marc.info/?l=linux-kernel&m=153612052611020&w=2
> 
> Is the NVMe driver the only block driver that hangs if it is attempted to
> freeze its request queue when a request times out? If so, can this hang be
> fixed by modifying the NVMe driver instead of by modifying the percpu
> refcount implementation?

IMO, this patch is quite simple and it should be much simpler than
solving this issue in block layer or NVMe, could we focus on the
technical correctness of this patch first?

However if anyone has better/simpler solution for this issue on any
change, I am open to them too.

Thanks,
Ming
