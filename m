Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932231AbcKVXIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 18:08:55 -0500
Date: Tue, 22 Nov 2016 15:08:36 -0800
From: Shaohua Li <shli@fb.com>
To: Tejun Heo <tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>, <axboe@fb.com>, <vgoyal@redhat.com>
Subject: Re: [PATCH V4 02/15] blk-throttle: add .high interface
Message-ID: <20161122230836.GA14628@shli-mbp.local>
References: <cover.1479161136.git.shli@fb.com>
 <239e20c62e028b570f48403faea1419c4d84f2bd.1479161136.git.shli@fb.com>
 <20161122200253.GA17534@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20161122200253.GA17534@htj.duckdns.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 22, 2016 at 03:02:53PM -0500, Tejun Heo wrote:
> Hello, Shaohua.
> 
> Sorry about the delay.
> 
> On Mon, Nov 14, 2016 at 02:22:09PM -0800, Shaohua Li wrote:
> > @@ -1376,11 +1414,37 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
> >  			goto out_finish;
> >  	}
> >  
> > -	tg->bps[READ][LIMIT_MAX] = v[0];
> > -	tg->bps[WRITE][LIMIT_MAX] = v[1];
> > -	tg->iops[READ][LIMIT_MAX] = v[2];
> > -	tg->iops[WRITE][LIMIT_MAX] = v[3];
> > -
> > +	if (index == LIMIT_MAX) {
> > +		if ((v[0] < tg->bps[READ][LIMIT_HIGH] &&
> > +		       tg->bps[READ][LIMIT_HIGH] != -1) ||
> > +		    (v[1] < tg->bps[WRITE][LIMIT_HIGH] &&
> > +		       tg->bps[WRITE][LIMIT_HIGH] != -1) ||
> > +		    (v[2] < tg->iops[READ][LIMIT_HIGH] &&
> > +		       tg->iops[READ][LIMIT_HIGH] != -1) ||
> > +		    (v[3] < tg->iops[WRITE][LIMIT_HIGH] &&
> > +		       tg->iops[WRITE][LIMIT_HIGH] != -1)) {
> > +			ret = -EINVAL;
> > +			goto out_finish;
> 
> Is this necessary?  memcg doesn't put restrictions on input but just
> enforces whatever is configured.  I think it'd be better to follow the
> same model here too.  Hmm... is this because throtl will be able to
> choose either all high or max limits per cgroup?

Thanks for your time!

Yep, the limit could be high or max. It's doable moving the restrictions on
input, but will increase trouble using the limits. If high is bigger than max,
can I set high to max? if not, I'd prefer to keep the restrictions.
 
> And this isn't from your patches but can we please switch to
> UINT64_MAX instead of -1?

Sure, will fix this.

> > +		}
> > +	} else if (index == LIMIT_HIGH) {
> > +		if ((v[0] > tg->bps[READ][LIMIT_MAX] && v[0] != -1) ||
> > +		    (v[1] > tg->bps[WRITE][LIMIT_MAX] && v[1] != -1) ||
> > +		    (v[2] > tg->iops[READ][LIMIT_MAX] && v[2] != -1) ||
> > +		    (v[3] > tg->iops[WRITE][LIMIT_MAX] && v[3] != -1)) {
> 
> Ditto here.
> 
> > @@ -1412,6 +1484,7 @@ static struct blkcg_policy blkcg_policy_throtl = {
> >  	.pd_alloc_fn		= throtl_pd_alloc,
> >  	.pd_init_fn		= throtl_pd_init,
> >  	.pd_online_fn		= throtl_pd_online,
> > +	.pd_offline_fn		= throtl_pd_offline,
> >  	.pd_free_fn		= throtl_pd_free,
> >  };
> 
> I haven't read the whole thing yet but this looks a bit suspicious.  A
> css going offline indicates that the destruction of the css started.
> I don't get why that'd reset high limits.  There can be a lot of async
> IOs after offline.

Ok. We do want to reset the limits. Because if no cgroup has high limit, we
definitively should use max limit for all cgroups. The whole state machine
(switching between high and max limit) is meaningless in that case.

Is pd_free_fn a good place to guarantee anyc IOs finish?

Thanks,
Shaohua
