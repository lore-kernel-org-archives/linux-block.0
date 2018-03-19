Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:59:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 06/11] block: sed-opal: split generation of
	bytestring header and content
Message-ID: <20180319195945.GH3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <0f5fe62576e70de12515e323ca5c0a45ef92832d.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0f5fe62576e70de12515e323ca5c0a45ef92832d.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

> +static u8 *add_bytestring_header(int *err, struct opal_dev *cmd, size_t len)
>  {
>  	size_t header_len = 1;
>  	bool is_short_atom = true;
> -
> -	if (*err)
> -		return;
> +	char *start;

Shouldn't this also return early if we have a pending error?

Except for that this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
