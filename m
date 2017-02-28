Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdB1IOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 03:14:24 -0500
Date: Tue, 28 Feb 2017 08:48:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@fb.com>,
        LKP <lkp@01.org>
Subject: Re: [blk_mq_register_hctx] 29dee3c03a WARNING: CPU: 0 PID: 5 at
 lib/refcount.c:114 refcount_inc
Message-ID: <20170228074802.GC6500@twins.programming.kicks-ass.net>
References: <20170228041117.hbqqyczf5bnypqmc@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228041117.hbqqyczf5bnypqmc@wfg-t540p.sh.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 28, 2017 at 12:11:17PM +0800, Fengguang Wu wrote:
> Hello,
> 
> FYI, an old blk_mq bug triggers new warnings on this commit. It's very
> reproducible and you may try the attached reproduce-* script.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> commit 29dee3c03abce04cd527878ef5f9e5f91b7b83f4
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Fri Feb 10 16:27:52 2017 +0100
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri Feb 24 09:02:10 2017 +0100
> 
>      locking/refcounts: Out-of-line everything
>      
>      Linus asked to please make this real C code.
>      
>      And since size then isn't an issue what so ever anymore, remove the
>      debug knob and make all WARN()s unconditional.
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I suspect that if you revert, but enable CONFIG_DEBUG_REFCOUNT you'd
have gotten the same splats..


I'll go have a look though, something looks buggered.
