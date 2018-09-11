Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44231 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKVaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 17:30:39 -0400
Date: Tue, 11 Sep 2018 09:30:32 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911160532.GB10082@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 12, 2018 at 12:05:33AM +0800, Ming Lei wrote:
> On Tue, Sep 11, 2018 at 08:49:59AM -0700, Tejun Heo wrote:
> > On Tue, Sep 11, 2018 at 11:45:41PM +0800, Ming Lei wrote:
> > > > So, this part seems wrong.  The function is called percpu_ref_reinit()
> > > > - the refcnt is expected to be in its initial state with just the base
> > > > ref once this function returns.  If you're removing the restriction on
> > > 
> > > But the comment says that 'Re-initialize @ref so that it's in the same
> > > state as when it finished', and this invariant isn't changed with this
> > > patch.
> > 
> > The comment goes "when perpcu_ref_init() finished".  The function is
> > called re _init_.  It should put the ref in the initial state, right?
> 
> OK, I am fine to keep the behaviour for this API, will introduce a new helper
> for NVMe.

Why aren't switch_to_atomic/percpu enough?

> However, it is doable to switch to percpu mode from atomic mode when it
> doesn't drop to zero, looks like sort of perpcu_ref_reinit(inherit_old_refcount).

Isn't that way more contorted than just switching operating modes?

Thanks.

-- 
tejun
