Return-Path: <ming.lei@redhat.com>
Date: Wed, 7 Nov 2018 08:55:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, stable@vger.kernel.org,
	snitzer@redhat.com, hch@lst.de, xni@redhat.com,
	mariusz.dabrowski@intel.com
Subject: Re: [PATCH V2 0/3] block: make sure discard/writesame bio is aligned
 with logical block size
Message-ID: <20181107005509.GA3531@ming.t460p>
References: <20181029125719.4998-1-ming.lei@redhat.com>
 <20181105034143.GE13699@ming.t460p>
 <CALjTZvbe_bJA8=rOa8k12XmorwGAed_2HcwBEhXKWqgyrXYK7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALjTZvbe_bJA8=rOa8k12XmorwGAed_2HcwBEhXKWqgyrXYK7Q@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 06, 2018 at 04:48:13PM +0000, Rui Salvaterra wrote:
> On Mon, 5 Nov 2018 at 03:41, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > V2 addresses Christoph's comment by introducing bio_allowed_max_sectors().
> >
> > Ping...
> >
> > Thanks,
> > Ming
> 
> Hi, Ming,
> 
> Sorry for the delay. I tested your V2 against Linux 4.20-rc1 and
> everything seems fine. FWIW, V2 is also
> 
> Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Rui, thanks for your test on V2.

Jens, what do you think about this patchset?

Thanks,
Ming
