Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKGAWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Nov 2018 19:22:41 -0500
MIME-Version: 1.0
References: <20181105102301.9752-1-jthumshirn@suse.de> <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de> <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
In-Reply-To: <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 6 Nov 2018 22:56:52 +0800
Message-ID: <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 6, 2018 at 8:35 PM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> On 05/11/2018 13:01, Ming Lei wrote:
> > If you mean the real huge page, this patch shouldn't have made a difference
> > because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
> > boundary as 4K - 1.
> >
> > However, things will change after multipage bvec is introduced.
>
>
> Hi Ming,
>
> I've received a blktrace from our customer showing the issue [1].
>
> In this example trace they've submitted (contiguous) 64K I/Os and
> without this patch, they're seeing a lot of splits as indicated by the
> trace.
>
> With the patch applied the I/O is directly issued to the LLDD without
> the splits.
>
> [1] http://beta.suse.com/private/jthumshirn/blktrace.txt

blktrace won't help on this issue because .bv_offset isn't recorded.

This patch makes sense on >4KB PAGE_SIZE. If your issue happens on
ARCH with 4K PAGE_SIZE, maybe you should root cause why it makes a
difference on iSer. And it is highly possible there is bug somewhere.

As I mentioned, the description of huge page part in the commit log is
misleading,
and it has to be fixed. Otherwise, the patch itself is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks
Ming Lei
