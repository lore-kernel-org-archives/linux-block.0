Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Sat, 24 Dec 2016 10:49:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Chris Leech <cleech@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at
        iscsi_tcp_segment_done+0x20d/0x2e0
Message-ID: <20161224094905.GA16518@lst.de>
References: <20161222001303.nvrtm22szn3hgxar@straylight.hirudinean.org> <20161222051322.GF4758@dastard> <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com> <20161222065012.GI4758@dastard> <20161222185030.so4btkuzzkih3owz@straylight.hirudinean.org> <CACVXFVOGoh+AEGSSMsbxfdAjZQS5k_t+7uR-+qwusm0vfauHEA@mail.gmail.com> <20161223000356.dxwkgsei32w7hc4f@straylight.hirudinean.org> <20161223100014.GA29467@lst.de> <CA+55aFxA1LE+4jdR8YXZyRVJ-MpOCUVob=ESBsMPuW=Qb=px-A@mail.gmail.com> <fadbf3d2-23c1-f822-cf0f-50182227a2dc@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fadbf3d2-23c1-f822-cf0f-50182227a2dc@fb.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 23, 2016 at 07:45:45PM -0700, Jens Axboe wrote:
> It's not that it's technically hard to fix up, it's more that it's a
> pain in the ass to have to do it. For instance, for blk_execute_rq(), we
> either should enforce that the caller allocates it dynamically and then
> free it, or we need nasty hack where the caller needs to know he has to
> free it. Pretty obvious what I would prefer there.
> 
> And yes, there would be a good chunk of other places where this would
> nede to be fixed up...

My planned rework for the BLOCK_PC code (split all fields for them out
of struct request and move them into a separate, driver-allocate structure)
would fix this up as a side-effect.  I really wanted to get it into 4.10,
but I didn't manage to fix it up.  I'll try to get it into 4.11 early.
