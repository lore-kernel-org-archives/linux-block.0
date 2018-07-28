Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] direct IO: respect backing device max IO size
To: stockhausen@collogia.de, linux-block@vger.kernel.org
References: <5b5cc132.ZRg3eYC3DaoOBtul%stockhausen@collogia.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5c01601-9a80-118a-0f40-e730b87ce390@kernel.dk>
Date: Sat, 28 Jul 2018 16:22:15 -0600
MIME-Version: 1.0
In-Reply-To: <5b5cc132.ZRg3eYC3DaoOBtul%stockhausen@collogia.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 7/28/18 1:17 PM, stockhausen@collogia.de wrote:
> Running older FusionIO cards with newer linux kernels turns out to be
> a headache. First of all their driver is a mix of open sources and
> proprietary object parts. Second we get only support for kernels up
> to ~4.0. Trying to get this to work with 4.9 longterm was successful
> but 4.14 renders the driver totally useless.
> 
> Searching the reason for lost data it turned out that the driver has 
> a hard 1024K or 257 page IO limit and silently drops any request that 
> is too large. Of course this might be a driver only problem but at 
> least it discloses the real source of a bad chain reaction.
> 
> blkdev_direct_IO() sets the maximum allowed IO size to BIO_MAX_PAGES.
> With 225311a4 ("mm: test code to write THP to swap device as a whole")
> its value changed from 256 to 512. Indepedant of its value the choice
> is arbitrary and can be driver agnostic as long as breakdown of bios
> happens later on.
> 
> We already have sufficent info about backing device properties and 
> can packetize the IO into sane values to avoid hassle later on. If
> bdi->io_pages is set and lower than BIO_MAX_PAGES reduce the package
> size appropriately.
> 
> Ths patch consists of two parts. The first is only a cosmetic change
> to avoid double coding in the second one.

Sounds to me like the fusion driver isn't calling split like it is
supposed to. That's what you get when it's unmaintained for years.
Add a:

	blk_queue_split(queue, &bio);

to kblock.c:kfio_make_request() and see if that helps.

-- 
Jens Axboe
