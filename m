Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40271 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeIKUt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 16:49:56 -0400
Date: Tue, 11 Sep 2018 08:49:59 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911154540.GA10082@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 11, 2018 at 11:45:41PM +0800, Ming Lei wrote:
> > So, this part seems wrong.  The function is called percpu_ref_reinit()
> > - the refcnt is expected to be in its initial state with just the base
> > ref once this function returns.  If you're removing the restriction on
> 
> But the comment says that 'Re-initialize @ref so that it's in the same
> state as when it finished', and this invariant isn't changed with this
> patch.

The comment goes "when perpcu_ref_init() finished".  The function is
called re _init_.  It should put the ref in the initial state, right?

Thanks.

-- 
tejun
