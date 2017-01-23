Return-Path: <jthumshirn@suse.de>
Date: Mon, 23 Jan 2017 12:47:20 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-throttle: Move three assignments for the
 variable "ret" in tg_set_max()
Message-ID: <20170123114609.GA8200@linux-x5ow.site>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <75495d45-cfc4-9740-39e4-bd4c3e71232b@users.sourceforge.net>
 <20170123091510.GA3517@linux-x5ow.site>
 <130ce081-e9a2-4744-c74b-b73bea5ae98c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <130ce081-e9a2-4744-c74b-b73bea5ae98c@users.sourceforge.net>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 23, 2017 at 11:00:15AM +0100, SF Markus Elfring wrote:
> >> @@ -1327,27 +1327,30 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
> >>  			break;
> >>  		ctx.body += len;
> >>  
> >> -		ret = -EINVAL;
> >>  		p = tok;
> >>  		strsep(&p, "=");
> >> -		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max")))
> >> +		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max"))) {
> >> +			ret = -EINVAL;
> >>  			goto out_finish;
> >> +		}
> > 
> > Sorry, I don't like this patch. We know the next error if we encounter one
> > will be EINVAL until we change it.
> 
> Thanks for your constructive feedback.
> 
> 
> > Your patch doesn't introduce a functual change and doesn't improve readability,
> > so I don't really see a point for it.
> 
> We have got different preferences for the placement of error code settings.
Yes we do, so what's the point? Both are OK. Please don't go down that road it
opens so much potential for needless bikeshedding and waste all of our
(including your) time.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
