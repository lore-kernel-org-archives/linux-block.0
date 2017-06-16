Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 16 Jun 2017 08:52:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andreas Dilger <adilger@dilger.ca>,
	Martin Petersen <martin.petersen@oracle.com>,
	fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCHSET v2] Add support for write life time hints
Message-ID: <20170616155246.GC27209@infradead.org>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com>
 <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org>
 <yq1shj2tv1z.fsf@oracle.com>
 <20382261-3180-41F0-B959-9181C2FF4BAA@dilger.ca>
 <9e152ed7-ed49-bb62-902c-0daac7646a86@kernel.dk>
 <20170616135803.GA808@infradead.org>
 <7007ef51-660a-29da-86d3-e7308d4ad08c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7007ef51-660a-29da-86d3-e7308d4ad08c@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 16, 2017 at 08:40:11AM -0600, Jens Axboe wrote:
> On 06/16/2017 07:58 AM, Christoph Hellwig wrote:
> >> >From my perspective, all I really care about is the 4 hints. It's a
> >> simple enough interface that applications can understand and use it, and
> >> we don't need any management of actual stream IDs. I think that has the
> >> highest chance of success. Modifying an application to use it is
> >> trivial, even something like RocksDB (if you havehad to make changes
> >> to RocksDB, you'll get this).
> > 
> > Btw, are your current RocksDB patches available somewhere?
> 
> Yep, it's on Mark Callaghan's github:
> 
> https://github.com/mdcallag/rocksdb
> 
> This is using mostly the v1 I posted, the only difference is that I just
> named the four flags RWF_S[1-4].

That commits look a bit like mess, but I guess I shouldn't expect
kernel-style changelogs and patch separation on github :)
