Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 17 Nov 2016 07:16:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161117151636.GA13511@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87823f67-a2ec-e959-1a23-9ecf3d6fe6d4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 17, 2016 at 08:03:46AM -0700, Jens Axboe wrote:
> > Looks like I forgot to push out the latest changes, that is gone. We're
> > just using + 1 now to see if we should use the multibio function or not.
> 
> Just to clarify, the correct tip is:

Re-checking for-4.10/dio now everything ѕeems to be fine.  Not sure
how I managed to pick up an old head.
