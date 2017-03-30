Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:48215 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934660AbdC3Xp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 19:45:58 -0400
Date: Fri, 31 Mar 2017 08:45:54 +0900
From: Minchan Kim <minchan@kernel.org>
To: Jens Axboe <axboe@fb.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <yizhan@redhat.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
Message-ID: <20170330234554.GC5807@bbox>
References: <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
 <CAEwNFnAb4x+sm6=vWd1W4Xj7Snp1V_LtRRx9ORFKpm1b-58kyw@mail.gmail.com>
 <ed4d83a1-9bdd-9e24-7768-ba5e85429110@suse.de>
 <20170307085545.GA538@bbox>
 <10a2335c-0ed0-43de-1cbd-625845301aef@suse.de>
 <20170308051118.GA11206@bbox>
 <1073055f-e71b-bb07-389a-53b60ccdee20@suse.de>
 <20170309052829.GA854@bbox>
 <CAEwNFnBnEObVdjqNdvh_-Dc0ryDjeW3c1qVdfOCbbyQREaDdqA@mail.gmail.com>
 <d5ad0aeb-0a8f-5ebd-f788-c6f6d92b76cf@fb.com>
MIME-Version: 1.0
In-Reply-To: <d5ad0aeb-0a8f-5ebd-f788-c6f6d92b76cf@fb.com>
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 30, 2017 at 09:35:56AM -0600, Jens Axboe wrote:
> On 03/30/2017 09:08 AM, Minchan Kim wrote:
> > Hi Jens,
> > 
> > It seems you miss this.
> > Could you handle this?
> 
> I can, but I'm a little confused. The comment talks about replacing
> the one I merged with this one, I can't do that. I'm assuming you
> are talking about this commit:

Right.

> 
> commit 0bc315381fe9ed9fb91db8b0e82171b645ac008f
> Author: Johannes Thumshirn <jthumshirn@suse.de>
> Date:   Mon Mar 6 11:23:35 2017 +0100
> 
>     zram: set physical queue limits to avoid array out of bounds accesses
> 
> which is in mainline. The patch still applies, though.

You mean it's already in mainline so you cannot replace but can revert.
Right?
If so, please revert it and merge this one.

> 
> Do we really REALLY need this for 4.11, or can we queue for 4.12 and
> mark it stable?

Not urgent because one in mainline fixes the problem so I'm okay
with 4.12 but I don't want mark it as -stable.

Thanks!
