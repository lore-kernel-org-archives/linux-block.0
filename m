Return-Path: <rsalvaterra@gmail.com>
MIME-Version: 1.0
References: <20181029125719.4998-1-ming.lei@redhat.com> <20181105034143.GE13699@ming.t460p>
In-Reply-To: <20181105034143.GE13699@ming.t460p>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Tue, 6 Nov 2018 16:48:13 +0000
Message-ID: <CALjTZvbe_bJA8=rOa8k12XmorwGAed_2HcwBEhXKWqgyrXYK7Q@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] block: make sure discard/writesame bio is aligned
 with logical block size
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, stable@vger.kernel.org,
	snitzer@redhat.com, hch@lst.de, xni@redhat.com, mariusz.dabrowski@intel.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, 5 Nov 2018 at 03:41, Ming Lei <ming.lei@redhat.com> wrote:
>
> V2 addresses Christoph's comment by introducing bio_allowed_max_sectors().
>
> Ping...
>
> Thanks,
> Ming

Hi, Ming,

Sorry for the delay. I tested your V2 against Linux 4.20-rc1 and
everything seems fine. FWIW, V2 is also

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks again,

Rui
