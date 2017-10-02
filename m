Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:28224 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbdJBRSo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Oct 2017 13:18:44 -0400
Date: Mon, 2 Oct 2017 20:18:42 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] lightnvm: pblk: free up mempool allocation for
 erases correctly
Message-ID: <20171002171842.GA6008@hercules.tuxera.com>
References: <20171001132555.GA5763@hercules.tuxera.com>
 <5E8B439C-5971-49DF-BDC4-3B53268F8FF4@lightnvm.io>
 <20171002122510.GA3946@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20171002122510.GA3946@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 02, 2017 at 03:25:10PM +0300, Rakesh Pandit wrote:
> On Mon, Oct 02, 2017 at 02:09:35PM +0200, Javier Gonz�lez wrote:
> > > On 1 Oct 2017, at 15.25, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > > 
> > > While separating read and erase mempools in 22da65a1b pblk_g_rq_cache
> > > was used two times to set aside memory both for erase and read
> > > requests.  Because same kmem cache is used repeatedly a single call to
> > > kmem_cache_destroy wouldn't deallocate everything.  Repeatedly doing
> > > loading and unloading of pblk modules would eventually result in some
> > > leak.
> > > 
> > > The fix is to really use separate kmem cache and track it
> > > appropriately.
> > > 
> > > Fixes: 22da65a1b ("lightnvm: pblk: decouple read/erase mempools")
> > > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > > 
> > 
> > I'm not sure I follow this logic. I assume that you're thinking of the
> > refcount on kmem_cache. During cache creation, all is good; if a
> > different cache creation fails, destruction is guaranteed, since the
> > refcount is 0. On tear down (pblk_core_free), we destroy the mempools
> > associated to the caches. In this case, the refcount goes to 0 too, as
> > we destroy the 2 mempools. So I don't see where the leak can happen. Am
> > I missing something?
> > 
> > In any case, Jens reported some bugs on the mempools, where we did not
> > guarantee forward progress. Here you can find the original discussion
> > and the mempool audit [1]. Would be good if you reviewed these.
> > 
> > [1] https://www.spinics.net/lists/kernel/msg2602274.html
> > 
> 
> Thanks, yes makes sense to follow up in patch thread.  I will respond
> to above questions there later today.
>

I wasn't thinking it right in addition to looking at test results from
a incorrectly instrumented debugged version.

I went through the series you pointed and all seem okay to me now.

Please drop this patch.

Regards,
