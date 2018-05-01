Return-Path: <prvs=652d33fe9=roger.pau@citrix.com>
Date: Tue, 1 May 2018 09:22:31 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>
CC: <xen-devel@lists.xenproject.org>, <stable@vger.kernel.org>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Jens Axboe
	<axboe@kernel.dk>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] xen-blkfront: prepare request locally, only then put
 it on the shared ring
Message-ID: <20180501082231.dzdbcghtwvlbkoys@MacBook-Pro-de-Roger.local>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 30, 2018 at 11:01:50PM +0200, Marek Marczykowski-G�recki wrote:
> Do not reuse data which theoretically might be already modified by the
> backend. This is mostly about private copy of the request
> (info->shadow[id].req) - make sure the request saved there is really the
> one just filled.
>
> This is complementary to XSA155.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Marczykowski-G�recki <marmarek@invisiblethingslab.com>
> ---
>  drivers/block/xen-blkfront.c | 76 +++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 3926811..b100b55 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -525,19 +525,16 @@ static int blkif_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,

The name of this function should be changed IMO, since you are no
longer getting a request from the ring, but just initializing a
request struct.

>  					    struct request *req,
> -					    struct blkif_request **ring_req)
> +					    struct blkif_request *ring_req)
>  {
>  	unsigned long id;
>  
> -	*ring_req = RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt);
> -	rinfo->ring.req_prod_pvt++;
> -
>  	id = get_id_from_freelist(rinfo);
>  	rinfo->shadow[id].request = req;
>  	rinfo->shadow[id].status = REQ_WAITING;
>  	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
>  
> -	(*ring_req)->u.rw.id = id;
> +	ring_req->u.rw.id = id;
>  
>  	return id;
>  }
> @@ -545,23 +542,28 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
>  static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_info *rinfo)
>  {
>  	struct blkfront_info *info = rinfo->dev_info;
> -	struct blkif_request *ring_req;
> +	struct blkif_request ring_req = { 0 };
>  	unsigned long id;
>  
>  	/* Fill out a communications ring structure. */
>  	id = blkif_ring_get_request(rinfo, req, &ring_req);

Maybe I'm missing something obvious here, but you are adding a struct
allocated on the stack to the shadow ring copy, isn't this dangerous?

The pointer stored in the shadow ring copy is going to be invalid
after returning from this function.

The same comment applies to the other calls to blkif_ring_get_request
below that pass a ring_reg allocated on the stack.

Thanks, Roger.
