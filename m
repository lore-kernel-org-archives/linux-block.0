Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730519AbeKFV7G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Nov 2018 16:59:06 -0500
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
Date: Tue, 6 Nov 2018 13:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181105120153.GD12367@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/11/2018 13:01, Ming Lei wrote:
> If you mean the real huge page, this patch shouldn't have made a difference
> because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
> boundary as 4K - 1.
> 
> However, things will change after multipage bvec is introduced.


Hi Ming,

I've received a blktrace from our customer showing the issue [1].

In this example trace they've submitted (contiguous) 64K I/Os and
without this patch, they're seeing a lot of splits as indicated by the
trace.

With the patch applied the I/O is directly issued to the LLDD without
the splits.

[1] http://beta.suse.com/private/jthumshirn/blktrace.txt

Byte,
	Johannes
-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
