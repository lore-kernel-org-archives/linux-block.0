Return-Path: <mpatocka@redhat.com>
Date: Wed, 21 Mar 2018 13:00:43 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Mike Snitzer <msnitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: use 32-bit blk_status_t on Alpha
In-Reply-To: <502b7c1e-a95c-ff8d-64cd-9cbdd275fa1d@kernel.dk>
Message-ID: <alpine.LRH.2.02.1803211253410.26409@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1803211239490.23314@file01.intranet.prod.int.rdu2.redhat.com> <502b7c1e-a95c-ff8d-64cd-9cbdd275fa1d@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>



On Wed, 21 Mar 2018, Jens Axboe wrote:

> On 3/21/18 10:42 AM, Mikulas Patocka wrote:
> > Early alpha processors cannot write a single byte or word; they read 8
> > bytes, modify the value in registers and write back 8 bytes.
> > 
> > The type blk_status_t is defined as one byte, it is often written
> > asynchronously by I/O completion routines, this asynchronous modification
> > can corrupt content of nearby bytes if these nearby bytes can be written
> > simultaneously by another CPU.
> > 
> > - one example of such corruption is the structure dm_io where
> >   "blk_status_t status" is written by an asynchronous completion routine
> >   and "atomic_t io_count" is modified synchronously
> > - another example is the structure dm_buffer where "unsigned hold_count"
> >   is modified synchronously from process context and "blk_status_t
> >   write_error" is modified asynchronously from bio completion routine
> > 
> > This patch fixes the bug by changing the type blk_status_t to 32 bits if
> > we are on Alpha and if we are compiling for a processor that doesn't have
> > the byte-word-extension.
> 
> That's nasty. Is alpha the only problematic arch here?

Yes. All the other architectures supported by Linux have byte writes.

> As to the patch in question, normally I'd just say we should make it
> unconditionally u32. But we pack so nicely in the bio, and I don't think
> the bio itself has this issue as the rest of the members that share this
> word are all set before the bio is submitted. But callers embedding
> the status var in other structures don't necessarily have that
> guarantee, as your dm examples show.
> 
> -- 
> Jens Axboe

Keeping blk_status_t 8-bit for most architectures will save a few bytes in 
some of device mapper structures.

Mikulas
