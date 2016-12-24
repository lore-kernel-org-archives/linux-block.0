Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60769 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbcLXNRa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2016 08:17:30 -0500
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at
 iscsi_tcp_segment_done+0x20d/0x2e0
To: Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CA+55aFyb1jcdpavyZgZ4nedA0=6tLognyWcJXfOJjMPFTm5GWA@mail.gmail.com>
 <20161222001303.nvrtm22szn3hgxar@straylight.hirudinean.org>
 <20161222051322.GF4758@dastard>
 <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com>
 <20161222065012.GI4758@dastard>
 <20161222185030.so4btkuzzkih3owz@straylight.hirudinean.org>
 <CACVXFVOGoh+AEGSSMsbxfdAjZQS5k_t+7uR-+qwusm0vfauHEA@mail.gmail.com>
 <20161223000356.dxwkgsei32w7hc4f@straylight.hirudinean.org>
 <20161223100014.GA29467@lst.de>
 <CA+55aFxA1LE+4jdR8YXZyRVJ-MpOCUVob=ESBsMPuW=Qb=px-A@mail.gmail.com>
 <20161224100756.GA16741@lst.de>
Cc: Chris Leech <cleech@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a9fc4c0b-8521-84cc-66f6-48396c095539@suse.de>
Date: Sat, 24 Dec 2016 14:17:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161224100756.GA16741@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/24/2016 11:07 AM, Christoph Hellwig wrote:
> On Fri, Dec 23, 2016 at 11:42:45AM -0800, Linus Torvalds wrote:
>> Ugh. This patch is nasty.
>
> It's the same SCSI has done for ages - except that is uses a separate
> kmalloc for the sense buffer.
>
>> I think we should just fix blk_execute_rq() instead.
>
> As you found out below it's not just blk_execute_rq, it's the whole
> architecture of the BLOCK_PC code, which expects a caller provided
> sense buffer.  But with the way blk-mq allocates request structures
> we can actually fix it, but I first need to extent the way it allows
> drivers to allocate private data to the old request code.  I've
> actually already implemented that for SCSI long time ago, and have
> started to life it to the block layer.
>
Would be cool to have a generic sense buffer.
I always found it slightly odd, pretending that 'struct request' is 
protocol-agnostic and refusing to add a sense data pointer, but at the 
same time having a field 'sense_len' (which gives the length of what 
exactly?).

Christoph, do you have a pointer to your patchset?
Not that I'll be able to do any meaningful work until next year, but 
having a look would be nice. Just to get a feeling where you want to 
head to; I might be able to work on this start of January.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
