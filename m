Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 21:01:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 11/11] block: sed-opal: check size of shadow mbr
Message-ID: <20180319200151.GK3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <72e19ec70ffac23fff658c60eaae0db850150ca1.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <72e19ec70ffac23fff658c60eaae0db850150ca1.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:53PM +0100, Jonas Rabenstein wrote:
> Check whether the shadow mbr does fit in the provided space on the
> target. Also a proper firmware should handle this case and return an
> error we may prevent problems or even damage with crappy firmwares.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 51f8034edbf7..9c73bd24c55f 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1545,6 +1545,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
>  	u64 len;
>  	int err = 0;
>  
> +	/* do we fit in the available shadow mbr space? */
> +	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROWS);

And here it gets used.  So this should be merged with the previous patch.
