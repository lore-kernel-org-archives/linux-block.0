Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeISIpG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 04:45:06 -0400
Date: Wed, 19 Sep 2018 11:09:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
Message-ID: <20180919030909.GC20560@ming.t460p>
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
 <20180918125021.GB902964@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918125021.GB902964@devbig004.ftw2.facebook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 18, 2018 at 05:50:21AM -0700, Tejun Heo wrote:
> On Tue, Sep 18, 2018 at 06:19:44PM +0800, Ming Lei wrote:
> > Now percpu_ref_reinit() can only be done on one percpu refcounter when it
> > drops zero. And the limit shouldn't be so strict, and it is quite
> > straightforward that we can do it when the refcount doesn't drop zero
> > because it is at atomic mode.
> > 
> > This patch introduces percpu_ref_resurge() in which the above limit is
> > relaxed, so we may avoid extra change[1] for NVMe timeout's requirement.
> 
> For now,
> 
> Nacked-by: Tejun Heo <tj@kernel.org>
> 
> Please see the original discussion thread.

Your comment in that thread supposes that synchronize_rcu() is used for
avoiding race with .release().

But this patchset doesn't use that approach at all for avoiding this
race.

Thanks,
Ming
