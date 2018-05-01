Return-Path: <prvs=652d33fe9=roger.pau@citrix.com>
Date: Tue, 1 May 2018 10:15:26 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
CC: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>, Jens
 Axboe <axboe@kernel.dk>, open list <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, "open list:BLOCK LAYER"
	<linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 6/6] xen-blkfront: prepare request locally,
 only then put it on the shared ring
Message-ID: <20180501091526.6b6j6h6rh62646fx@MacBook-Pro-de-Roger.local>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
 <20180501082231.dzdbcghtwvlbkoys@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180501082231.dzdbcghtwvlbkoys@MacBook-Pro-de-Roger.local>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Tue, May 01, 2018 at 09:22:31AM +0100, Roger Pau Monn� wrote:
> On Mon, Apr 30, 2018 at 11:01:50PM +0200, Marek Marczykowski-G�recki wrote:
> >  					    struct request *req,
> > -					    struct blkif_request **ring_req)
> > +					    struct blkif_request *ring_req)
> >  {
> >  	unsigned long id;
> >  
> > -	*ring_req = RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt);
> > -	rinfo->ring.req_prod_pvt++;
> > -
> >  	id = get_id_from_freelist(rinfo);
> >  	rinfo->shadow[id].request = req;
> >  	rinfo->shadow[id].status = REQ_WAITING;
> >  	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
> >  
> > -	(*ring_req)->u.rw.id = id;
> > +	ring_req->u.rw.id = id;
> >  
> >  	return id;
> >  }
> > @@ -545,23 +542,28 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
> >  static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_info *rinfo)
> >  {
> >  	struct blkfront_info *info = rinfo->dev_info;
> > -	struct blkif_request *ring_req;
> > +	struct blkif_request ring_req = { 0 };
> >  	unsigned long id;
> >  
> >  	/* Fill out a communications ring structure. */
> >  	id = blkif_ring_get_request(rinfo, req, &ring_req);
> 
> Maybe I'm missing something obvious here, but you are adding a struct
> allocated on the stack to the shadow ring copy, isn't this dangerous?

The above comment is wrong, you are storing a pointer to 'req' in the
shadow ring copy, which is fine and is not the ring request.

Roger.
