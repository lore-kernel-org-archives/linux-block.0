Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] sbitmap: make sb_for_each_fn() return void
Date: Fri, 4 Aug 2017 19:49:08 +0000
Message-ID: <1501876147.2757.30.camel@wdc.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
	 <1501859062-11120-7-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-7-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
> @@ -211,7 +211,7 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb);
>   */
>  bool sbitmap_any_bit_clear(const struct sbitmap *sb);
> =20
> -typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
> +typedef void (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
> =20
>  /**
>   * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitm=
ap.
> @@ -241,9 +241,7 @@ static inline void sbitmap_for_each_set(struct sbitma=
p *sb, sb_for_each_fn fn,
>  			if (nr >=3D word->depth)
>  				break;
> =20
> -			if (!fn(sb, off + nr, data))
> -				return;
> -
> +			fn(sb, off + nr, data);
>  			nr++;
>  		}
>  	}

Hello Jens,

Are you aware that this change will break one of Ming Lei's patches? See
also https://www.mail-archive.com/linux-block@vger.kernel.org/msg11230.html=
.

Thanks,

Bart.=
