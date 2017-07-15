Return-Path: <dsterba@suse.cz>
Date: Sat, 15 Jul 2017 02:28:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>, Liu Bo <bo.li.liu@oracle.com>,
	Filipe Manana <FdManana@suse.com>,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: note about cloned bios and
 bio_for_each_segment_all
Message-ID: <20170715002822.GL2866@suse.cz>
Reply-To: dsterba@suse.cz
References: <20170714134051.22756-1-dsterba@suse.com>
 <CACVXFVP_a5kofmW-Wfx1FT_kyqFKdatf57RfKLrh+Jte1J8ZmA@mail.gmail.com>
 <06376146-e4c3-efd6-8893-155052b14034@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06376146-e4c3-efd6-8893-155052b14034@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 14, 2017 at 08:22:31AM -0600, Jens Axboe wrote:
>  /*
>   * drivers should _never_ use the all version - the bio may have been split
> - * before it got to the driver and the driver won't own all of it
> + * before it got to the driver and the driver won't own all of it.
> + *
> + * Don't use this on cloned bio's.
>   */
>  #define bio_for_each_segment_all(bvl, bio, i)				\
> +	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));			\
>  	for (i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)

This needs a multiline statement protection, otherwise

if (...)
	bio_for_each_segment_all(...) {
		...
	}

would expand to

if (...)
	WARN_ON_ONCE(...);

bio_for_each_segment_all(...) { ... }

However "do { ... } while(0)" cannot be used here, so WARN_ON_ONCE could
be moved to the initialization block of for:

#define bio_for_each_segment_all(bvl, bio, i)				\
	for (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)),		\
	     i = 0, bvl = (bio)->bi_io_vec; i < (bio)->bi_vcnt; i++, bvl++)

I haven't found any code using the exact broken pattern. So this does
not explain the crash Liu Bo reports.
