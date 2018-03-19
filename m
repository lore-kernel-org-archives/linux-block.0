Return-Path: <scott.bauer@intel.com>
Date: Mon, 19 Mar 2018 13:41:26 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] block: sed-opal: split generation of bytestring
 header and content
Message-ID: <20180319194126.ldamexpmw4ji7qi6@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <0f5fe62576e70de12515e323ca5c0a45ef92832d.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195945.GH3380@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319195945.GH3380@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 08:59:45PM +0100, Christoph Hellwig wrote:
> > +static u8 *add_bytestring_header(int *err, struct opal_dev *cmd, size_t len)
> >  {
> >  	size_t header_len = 1;
> >  	bool is_short_atom = true;
> > -
> > -	if (*err)
> > -		return;
> > +	char *start;
> 
> Shouldn't this also return early if we have a pending error?

It will short circuit and bail out via can_add failing. So even though
you have to go dig to see if the following functions handle the erorr
I think it's slightly cleaner to have a single if (*err) in the deeper functions.
This lest the error back out the call chain instead of having multiple if (*err)
checks earlier in the call chains.
