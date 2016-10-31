Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161031153915.GL30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-29-git-send-email-tom.leiming@gmail.com> <20161031153915.GL30919@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 07:56:39 +0800
Message-ID: <CACVXFVPiMReCTo7VdNXVADhPCLiiV0fts-a6KBD+tk-kR_b2Wg@mail.gmail.com>
Subject: Re: [PATCH 28/60] block: introduce QUEUE_FLAG_SPLIT_MP
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>, Mike Christie <mchristi@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hpe.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 31, 2016 at 11:39 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Oct 29, 2016 at 04:08:27PM +0800, Ming Lei wrote:
>> Some drivers(such as dm) should be capable of dealing with multipage
>> bvec, but the incoming bio may be too big, such as, a new singlepage bvec
>> bio can't be cloned from the bio, or can't be allocated to singlepage
>> bvec with same size.
>>
>> At least crypt dm, log writes and bcache have this kind of issue.
>
> We already have the segment_size limitation for request based drivers.
> I'd rather extent it to bio drivers if really needed.

Yeah, just found dm actually don't need the flag, and it has its own way
for limitting bio size. For bcache, there is only place which need the
flag, so we can use max sectors limit to address it or use multiple bio
to read & check ony by one.

>
> But then again we should look into not having this limitation.  E.g.
> for bcache I'd be really surprised if it's that limited, given that
> Kent came up with this whole multipage bvec scheme.

As far as I find, the only one which need the flag is bch_data_verify().


Thanks,
Ming Lei
