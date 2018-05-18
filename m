Return-Path: <BATV+77ddf8e9b1b344f28472+5381+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 18 May 2018 09:05:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	bcrl@kvack.org, mingo@kernel.org, peterz@infradead.org,
	pombredanne@nexb.com, gregkh@linuxfoundation.org,
	bigeasy@linutronix.de, rgoldwyn@suse.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 2/3] fs: Convert kiocb rw_hint from enum to u16
Message-ID: <20180518160512.GG22791@infradead.org>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-3-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517203803.2664-3-adam.manzanares@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +/* ki_hint changed from enum to u16, make sure rw_hint fits into u16 */

I don't think this comment is very useful.

> +static inline u16 ki_hint_valid(enum rw_hint hint)

I'd call this ki_hint_validate.

> +{
> +	if (hint > MAX_KI_HINT)
> +		return 0;
> +
> +	return hint;

Nit: kill the empty line.
