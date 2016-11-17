Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
 <c2e20890-16ce-a3bd-c696-c53ae14a583a@kernel.dk>
 <20161117125037.GB14814@infradead.org>
 <204d4a18-e5da-1806-433e-a3ff1b6ca575@kernel.dk>
 <87823f67-a2ec-e959-1a23-9ecf3d6fe6d4@kernel.dk>
 <20161117201749.GA15072@infradead.org>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <721c8908-ea89-a2f4-0bfd-7243a9aa4c03@kernel.dk>
Date: Thu, 17 Nov 2016 13:30:12 -0700
MIME-Version: 1.0
In-Reply-To: <20161117201749.GA15072@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/17/2016 01:17 PM, Christoph Hellwig wrote:
> Ok, the updated tree is here:
>
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio
>
> This moves your O_SYNC patch earlier and makes it not directly
> assign bi_opf.
>
> Then comes the main direct I/O path with the various folds, and
> a use after free fix ported from the iomap code in the completion
> handler.
>
> Last comes the I/O completion handler split - I don't think it's
> worth it, but if you prefer it that way go ahead and fold it in.

The last patch seems to have some issues:

+       bool is_sync = is_sync = is_sync_kiocb(iocb);

and it's reverting part of the dio->is_sync that was part of my union
waiter/iocb change. So I'll leave that out for now, for those reasons.

> I couldn't do the bio_kmalloc conversion as bio_kmalloc seems
> to not like the front pad.

Yeah, !bs/bio_kmalloc() doesn't use the front pad...

-- 
Jens Axboe
